--oppretter tabeller ut i fra ER-diagrammet--

CREATE TABLE "Bagasje" (
	"Regnummer"	INTEGER NOT NULL UNIQUE,
	"Vekt"	INTEGER NOT NULL,
	"InnleveringsTidspunkt"	TEXT NOT NULL,
	PRIMARY KEY("Regnummer")
);

CREATE TABLE "Billettkjøp" (
	"ReferanseNr"	INTEGER NOT NULL UNIQUE,
	"Startflyplass"	TEXT,
	"Endeflyplass"	TEXT,
	"SamledePris"	INTEGER,
	"Utreise"	TEXT,
	"Hjemreise"	TEXT,
	"Økonomi"	INTEGER NOT NULL,
	"Budsjett"	INTEGER NOT NULL,
	"Premium"	INTEGER NOT NULL,
	PRIMARY KEY("ReferanseNr")
);

CREATE TABLE "Fly" (
	"Registeringsnummer"	INTEGER,
	"Navn"	TEXT,
	"Serienummer"	INTEGER,
	"Seteoppbygning"	TEXT,
	"Flytype"	TEXT,
	"Driftår"	TEXT,
	PRIMARY KEY("Registeringsnummer")
);

CREATE TABLE "Flyplass" (
	"Flyplasskode"	INTEGER NOT NULL UNIQUE,
	"Flyplassnavn"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("Flyplasskode")
);

CREATE TABLE "Flyprodusent" (
	"Navn"	TEXT NOT NULL UNIQUE,
	"Stiftelsesår"	INTEGER NOT NULL,
	"Seteoppbygning"	TEXT NOT NULL,
	"Nasjonalitet"	INTEGER NOT NULL,
	PRIMARY KEY("Navn")
);

CREATE TABLE "Flyrute" (
	"FlightNumber"	INTEGER UNIQUE,
	"Ukedagskode"	INTEGER NOT NULL,
	"Avgangstid"	TEXT NOT NULL,
	"Ankomsttid"	TEXT NOT NULL,
	PRIMARY KEY("FlightNumber")
);

CREATE TABLE "Flyselskap" (
	"Flyselskapskode"	INTEGER NOT NULL UNIQUE,
	"Navn"	TEXT NOT NULL UNIQUE,
	"Fordelsprogram"	TEXT NOT NULL,
	PRIMARY KEY("Flyselskapskode")
);

CREATE TABLE "Flytype" (
	"Navn"	TEXT NOT NULL UNIQUE,
	"FOM.årstall"	INTEGER NOT NULL,
	"TOM.årstall"	INTEGER,
	"Serienummer"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("Navn")
);

CREATE TABLE "Flyvningen" (
	"Løpenummer"	TEXT NOT NULL UNIQUE,
	"Status"	TEXT NOT NULL,
	"FaktiskAvgangstid"	TEXT NOT NULL,
	"FaktiskAnkomsttid"	TEXT NOT NULL,
	"FlightNumber"	INTEGER NOT NULL,
	PRIMARY KEY("Løpenummer"),
	FOREIGN KEY("FlightNumber") REFERENCES "Flyrute"("FlightNumber")
);

CREATE TABLE "Innsjekking" (
	"Tidspunkt"	TEXT NOT NULL,
	"Referansenummer"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("Tidspunkt","Referansenummer"),
	FOREIGN KEY("Referansenummer") REFERENCES "Billettkjøp"("ReferanseNr")
);

CREATE TABLE "Kunde" (
	"KundeNr"	INTEGER NOT NULL UNIQUE,
	"Navn"	TEXT NOT NULL,
	"TelefonNr"	INTEGER NOT NULL UNIQUE,
	"E-post"	INTEGER NOT NULL UNIQUE,
	"Nasjonalitet"	TEXT NOT NULL,
	PRIMARY KEY("KundeNr")
);

CREATE TABLE "Mellomlandinger" (
	"Flyplasskode"	TEXT NOT NULL UNIQUE,
	"FlightNumber"	INTEGER NOT NULL,
	"Avgangstid"	TEXT NOT NULL,
	"Ankomsttid"	TEXT NOT NULL,
	"MellomlandingsNr"	INTEGER NOT NULL,
	PRIMARY KEY("FlightNumber","Flyplasskode"),
	FOREIGN KEY("FlightNumber") REFERENCES "Flyrute"("FlightNumber"),
	FOREIGN KEY("Flyplasskode") REFERENCES "Flyplass"("Flyplasskode")
);

