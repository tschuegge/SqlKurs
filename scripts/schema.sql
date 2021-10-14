-- Drop old schema
DROP TABLE IF EXISTS kunde;
DROP TABLE IF EXISTS bestellungkopf;
DROP TABLE IF EXISTS bestellungposition;
DROP TABLE IF EXISTS hersteller;
DROP TABLE IF EXISTS mwstsatz;
DROP TABLE IF EXISTS artikel;
DROP TABLE IF EXISTS artikelkategorie;
DROP TABLE IF EXISTS abteilung;
DROP TABLE IF EXISTS mitarbeiter;

-- Create schema
CREATE TABLE kunde (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  kundennr INTEGER NOT NULL UNIQUE,
  name TEXT NOT NULL,
  vorname TEXT,
  strasse TEXT,
  plz TEXT,
  ort TEXT,
  telefongeschaeft TEXT,
  telefonprivat TEXT,
  email TEXT,
  zahlungsart TEXT NOT NULL CHECK (zahlungsart IN ('R', 'B', 'N', 'V', 'K'))
);

CREATE TABLE hersteller (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL
);

CREATE TABLE mwstsatz (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  bezeichnung TEXT NOT NULL,
  satz REAL NOT NULL UNIQUE
);

CREATE TABLE artikelkategorie (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  bezeichnung TEXT NOT NULL UNIQUE
);

CREATE TABLE artikel (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  artikelnr TEXT NOT NULL UNIQUE,
  bezeichnung TEXT NOT NULL,
  herstellerid INTEGER NOT NULL REFERENCES hersteller(id),
  nettopreis REAL NOT NULL,
  mwstid INTEGER NOT NULL REFERENCES mwstsatz(id),
  bestand INTEGER,
  mindestbestand INTEGER CHECK (bestand >= mindestbestand),
  artikelkategorieid INTEGER NOT NULL REFERENCES artikelkategorie(id),
  bestellvorschlag INTEGER
);

CREATE TABLE abteilung (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  bezeichnung TEXT NOT NULL UNIQUE
);

CREATE TABLE mitarbeiter (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  mitarbeiternr INTEGER NOT NULL UNIQUE,
  name TEXT NOT NULL,
  vorname TEXT,
  strasse TEXT,
  plz TEXT,
  ort TEXT,
  gehalt REAL NOT NULL,
  abteilung INTEGER NOT NULL REFERENCES abteilung(id),
  telefon TEXT,
  email TEXT
);

CREATE TABLE bestellungkopf (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  kundeid INTEGER NOT NULL REFERENCES kunde(id),
  verkaeuferid INTEGER NOT NULL REFERENCES mitarbeiter(id),
  sachbearbeiterid INTEGER NOT NULL REFERENCES mitarbeiter(id),
  bestelldatum TEXT NOT NULL,
  lieferdatum TEXT,
  rechnungsbetrag REAL
);

CREATE TABLE bestellungposition (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  bestellid INTEGER NOT NULL REFERENCES bestellungkopf(id),
  artikelid INTEGER NOT NULL REFERENCES artikel(id),
  bestellmenge INTEGER NOT NULL,
  liefermenge INTEGER NOT NULL
);

-- Optimize database
VACUUM;