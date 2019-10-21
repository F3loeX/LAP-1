/*
P. Lang 7.9.2018
1. Übung zu MySQL
(Mehrzeiliger Kommentar)
*/
-- Alle DBen anzeigen (einzeiliger Kommentar)
show databases;

/*
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| phpmyadmin         |
| test               |
+--------------------+
5 rows in set (0.00 sec)
*/

-- SQL-Skript auf Konsole ausführen:
-- source G:\3Klasse\INF\mySQL\01_ue.sql

-- Schema (Datenbank) testen auswählen
use test;

-- Alle Tabellen anzeigen
show tables;

/*
+----------------+
| Tables_in_test |
+----------------+
| meine          |
+----------------+
1 row in set (0.00 sec)
*/

