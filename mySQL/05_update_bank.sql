-- P. Lang, 18.09.2018
-- Übung zu MySQL
-- DB bank
-- update, delete, alter ...

use bank;
/*
insert into person values(null, 'Hauser', 'Karin'), (null, 'Weiters', 'Manfred');

insert into bankkonto values(null, 5555), (null, 5553);

insert into person_bankkonto values(4,1), (5,1);

*/

-- DS ändern update
/*
Person mit der per_id 4 auf ban_id 4 ändern
*/
update person_bankkonto set ban_id = 4 where per_id = 4;

-- Aufgabe: alle Personen mit ban_id 4 ausgeben
-- Person |

select concat_ws(' ', per.per_vn, per.per_nn) as 'Person' from person per
left outer join person_bankkonto pk
using (per_id) 
left outer join bankkonto bk
using (ban_id)
where ban_id = 4;


/*
Aufgabe: ändern Sie bei der Person mit der ID 5 den Nachname auf 'Zeilinger' und den Vornamen auf 'Martha'
*/
update person set per_vn = 'Martha', per_nn = 'Zeilinger' where per_id = 5;

-- DS löschen - DELETE
/*
Alle DS mit per_id 5 aus der Tabelle person_bankkonto löschen
*/
delete from person_bankkonto where per_id = 5;

-- ********************************************************
-- DROP u. Alter
-- für die Übung eigene Tabelle erstellen
create table testen(tid int primary key auto_increment,
zahl int);

show tables;


-- tabelle löschen inkl. Struktur
drop table testen;


-- ALTER TABLE .... Struktur der Tabelle bearbeiten

-- ADD ... Spalte hinzufügen
alter table testen add wort varchar(25);
describe testen;

-- Attribt nach einem bestehenden einfügen
alter table testen add buchstabe char(1) after tid;
describe testen;

-- Attribut als erstes einfügen
alter table testen add test int first;
describe testen;

-- -MODIFY ... bestehende Attributeigenschaften ändern
alter table testen modify test int after wort;
describe testen;


alter table testen modify test varchar(10);
describe testen;


-- CHANGE ... Attributbezeichnung ändern
alter table testen change test ziffer int;
describe testen;

-- ALTER ... Default-Wert setzen
alter table testen alter ziffer set default 1;
describe testen;


-- Drop ... Attribute löschen
alter table testen drop buchstabe;
describe testen;


-- RENAME ... Tabelle umbenennen
alter table testen rename test;
show tables;


/*

Übung: DS einfügen und löschen ... auto_increment zurücksetzen

*/
insert into test (zahl, wort, ziffer) values(88, 'ABC', 0), (99, 'XYZ', 7);
select * from test;

-- DS mit tid 2 löschen
delete from test where tid = 2;
select * from test;
-- neuen DS einfügen 66, 'AEIOU', 4
-- welche tid hat dieser DS?
insert into test (zahl, wort, ziffer) values(66, 'AEIOU', 4);

-- DS tid 3 löschen
delete from test where tid = 3;
select * from test;


-- auto_increment zurücksetzen
alter table test auto_increment = 2;














