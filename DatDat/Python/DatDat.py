import sqlite3

# Koble til databasen
conn = sqlite3.connect("Database DP1.db")
cursor = conn.cursor()

def get_flights(airport_id, weekday, departure=True):
    conn = sqlite3.connect("Database DP1.db")
    cursor = conn.cursor()

    if departure:
        query = """
        SELECT f.flight_id, f.departure_time, a.airport_name 
        FROM flight f
        JOIN airport a ON f.arrival_airport_id = a.airport_id
        WHERE f.departure_airport_id = ? 
        AND f.weekday = ?;
        """
    else:
        query = """
        SELECT f.flight_id, f.arrival_time, a.airport_name 
        FROM flight f
        JOIN airport a ON f.departure_airport_id = a.airport_id
        WHERE f.arrival_airport_id = ? 
        AND f.weekday = ?;
        """

    cursor.execute(query, (airport_id, weekday))
    results = cursor.fetchall()

    conn.close()
    return results

# Interaktivt program
airport_id = input("Velg flyplass-ID: ")
weekday = input("Velg ukedag (1=Mandag, ..., 7=Søndag): ")
departure = input("Søk etter avganger? (ja/nei): ").lower() == "ja"

flights = get_flights(airport_id, weekday, departure)

for flight in flights:
    print(f"Flynummer: {flight[0]}, Tid: {flight[1]}, Destinasjon/Opprinnelse: {flight[2]}")