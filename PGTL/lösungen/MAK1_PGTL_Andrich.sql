-- P.Andrich, 28.9.2018
-- 1.MAK.sql
-- version 1.0

use fahrzeugverwaltung;

-- 2.)

select count(*) from fahrzeugverwaltung.zulassung;
/*
+----------+
| count(*) |
+----------+
|        4 |
+----------+
1 row in set (0.00 sec)
*/
-- 3.)

select * from fahrzeugverwaltung.zulassung
where zul_motornr like "D%" and zul_fahrgestellnr not like "D%";

/*
+--------+--------+--------+-------------+-------------------+-----------+
| zul_id | hty_id | ken_id | zul_motornr | zul_fahrgestellnr | zul_aktiv |
+--------+--------+--------+-------------+-------------------+-----------+
|      5 |    100 |      4 | D8DFJDKDUE  | KLEJDNE5          |         1 |
+--------+--------+--------+-------------+-------------------+-----------+
*/

-- 4.)

select zul_motornr as Motornummer, her_marke as Marke
from Zulassung
inner join h_type using(hty_id)
inner join hersteller using(her_id)
where zul_id != 1 and her_id <= 30;

/*
+-------------+-------+
| Motornummer | Marke |
+-------------+-------+
| DUEJMNED5   | Fiat  |
| KDIEN7789D  | Fiat  |
| 88DDDFJEDD  | BMW   |
| D8DFJDKDUE  | Fiat  |
+-------------+-------+
4 rows in set (0.00 sec)
*/
-- 5.)
select * from Kennzeichen
where ken_nr like "L%" or ken_nr like "UU%";
/*
+--------+---------+
| ken_id | ken_nr  |
+--------+---------+
|      1 | L-2BNCJ |
|      2 | L-BDJEK |
|      3 | UU-55GZ |
|      5 | L-2BNCK |
+--------+---------+
*/

-- 6.)
-- a)
select her_marke as Herstellermarke, ken_nr as Kennzeichen,zul_motornr as Motornummer
from Zulassung
inner join h_type using(hty_id)
inner join hersteller using(her_id)
inner join kennzeichen using(ken_id)
where zul_aktiv =0 or zul_aktiv = 1;
/*
+-----------------+-------------+-------------+
| Herstellermarke | Kennzeichen | Motornummer |
+-----------------+-------------+-------------+
| Fiat            | L-2BNCJ     | DUEJMNED5   |
| Fiat            | L-BDJEK     | KDIEN7789D  |
| BMW             | UU-55GZ     | 88DDDFJEDD  |
| Fiat            | GM-IDZS     | D8DFJDKDUE  |
+-----------------+-------------+-------------+
4 rows in set (0.00 sec)
*/
-- b)
select her_marke as Herstellermarke, ken_nr as Kennzeichen,zul_motornr as "Motornummer" from zulassung
left join h_type on Zulassung.hty_id = h_type.hty_id
left join hersteller using(her_id)
left join kennzeichen using(ken_id)
where zul_aktiv =0 or zul_aktiv = 1;

/*
+-----------------+-------------+-------------+
| Herstellermarke | Kennzeichen | Motornummer |
+-----------------+-------------+-------------+
| Fiat            | L-2BNCJ     | DUEJMNED5   |
| Fiat            | L-BDJEK     | KDIEN7789D  |
| BMW             | UU-55GZ     | 88DDDFJEDD  |
| Fiat            | GM-IDZS     | D8DFJDKDUE  |
+-----------------+-------------+-------------+
*/

-- 7.)
select her_marke as Marke, ken_nr as Kennzeichen from Hersteller a
left join h_type b using(her_id)
left join Zulassung c using(hty_id)
left join kennzeichen d using(ken_id)
where zul_aktiv is null or zul_aktiv !=0;
/*
+----------+-------------+
| Marke    | Kennzeichen |
+----------+-------------+
| BMW      | UU-55GZ     |
| Fiat     | GM-IDZS     |
| Renault  | NULL        |
| Mercedes | NULL        |
| Peugeot  | NULL        |
| Jaguar   | NULL        |
+----------+-------------+
*/
-- 8.)
select her_marke as Marke,count(hty_id)as Anzahl from hersteller
left join h_type using(her_id)
left join zulassung using(hty_id)
group by hty_id
having Anzahl > 1;
/*
+-------+--------+
| Marke | Anzahl |
+-------+--------+
| Fiat  |      3 |
+-------+--------+
1 row in set (0.00 sec)
*/
