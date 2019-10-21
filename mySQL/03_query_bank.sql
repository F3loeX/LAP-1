-- P. Lang, 11.09.2018
-- Übung zu MySQL
-- 03_query_bank.sql

-- Select-Statements

-- alle DS u Attribute ausgeben
select * from person;

-- nur bestimmte Attribute 
select per_nn, per_vn from person;

-- Alias für Spalte/Attribute
select per_nn as "Nachname", per_vn as "Vorname" from person;

/*
+----------+---------+
| Nachname | Vorname |
+----------+---------+
| Huber    | Franz   |
| Schmidt  | karl    |
| Baum     | NULL    |
+----------+---------+
*/

-- Alias für Tabelle 
select p.per_nn as "Nachname" from person p;

-- where-Klausel - nur bestimmte Datensätze
select * from person where per_vn is null;

select * from person where per_vn is not null;

-- die Person mit PK 1 ausgeben
select * from person where per_id = 1;


-- Person deren Nachname mit s beginnt
select * from person where per_nn like 'S%';

-- % Platzhalter für eine beliebige Anzahl beliebiger alphanumerischer Zeichen
--   _ Platzhalter für EIN beliebiges alphanumerisches Zeichen
-- like ist nicht case sensitive

-- alle Personen mit e im Wortverlauf (Nachname)
Select * from person where per_nn like '%e%';

-- alle Personen mit r an zweiter Stelle im Vornamen
select * from person where per_vn like '_r%';



-- Übung 
/*
a) alle Perosnen deren Vorname auf L enden
*/
select * from person where per_vn like '%l';


/*
b) nur die Nachname jener personen, deren Vornamen an vorletzter Stelle ein A hat
*/
select per_nn from person where per_vn like '%a_';


-- Aufgabe: alle Personen deren Nach- oder Vorname ein A enthält
select * from person where per_nn like '%A%' OR per_vn like '%A%';

-- Aufgabe: alle Personen deren Vorname ein A und Nachname ein u enthält
select * from person where per_vn like '%A%' AND per_nn like '%u%';

-- Aufgabe: alle personen deren Nachname kein u enthält

select * from person where per_nn not like '%u%';


-- Ergänzung: DB Name der Tabelle voranstellen
select * from bank.person;

-- MySQL Funktionen: 
-- Anzahl der Personen
select count(*) from person;


/*
Aufgabe: verweden Sie Alias, geben Sie die Anzahl der Perosnen mit Anfangsbuchstaben S im 
Familienname aus.
Anzahl

*/

select count(*) as "Anzahl mit S" from person where per_nn like 's%';


-- Summe der PKs in person

select sum(per_id) as "Summe" from person;

-- Durchschnitt

select avg(per_id) as "Durchschnitt" from person;


-- Zwei Attribute in einer Spalte ausgeben
-- Vor- und Nachname in Spalte "Person" ausgeben
select concat_ws(' ', per_vn, per_nn) as "Person" from person;

-- oder(theoretisch)
select concat(per_nn, ' ', per_vn) as "Name" from person;


-- LIMIT
-- beginnend bei ienem bestimmten DS (z.B. 3 DS)
-- eine bestimmte Anzahl von DSe ausgeben
select * from person limit 0, 1;

-- sortieren von Datensätzen 
-- Personen nach Namen aufsteigend sortiert ausgeben
select * from person order by per_nn ASC; -- ASC Default / DESC absteigend

-- absteigend: 
select * from person order by per_nn DESC;



-- *****************************************************************
-- Tabellenstruktur ausgeben
describe person;
-- describe kann mit desc abgekürzt werden
desc bankkonto;
desc person_bankkonto;











