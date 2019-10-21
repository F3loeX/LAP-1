use fahrzeugverwaltung;

-- 2.
select count(*) AS "Anzahl der Zulassungen" from zulassung;

-- 3.
select * from zulassung where zul_motornr like 'D%' and zul_fahrgestellnr not like 'D%';

-- 4.
select zul_motornr AS "Motornummer", her_marke AS "Marke"
from	h_type inner join (hersteller, zulassung) using (her_id, hty_id)
where	zul_id != 1 
and		her_id <= 30;

-- 5. Geben Sie mit einem SQL-Befehl alle Datensätze aus, mit einem KFZ-Kennzeichen für Linz (L) und Urfahr (UU), 
-- die in der Tabelle ZULASSUNG enthalten sind:
select	* from kennzeichen
where ken_nr like 'L%'
or	ken_nr like 'UU%';

-- 6. Geben Sie jeweils mit INNER und OUTER JOIN die Attribute MARKE und MOTORNUMMER aus – nur jener Fahrzeuge, 
-- für die bereits Fahrzeuge zugelassen sind (Verknüpfung in der Tabelle ZULASSUNG durch HTID).
-- | Herstellermarke | Motornummer |
-- a) INNER JOIN
select h.her_marke as "Herstellermarke", k.ken_nr AS "Kennzeichen", zul_motornr AS "Motornummer"
from	zulassung z inner join (h_type, kennzeichen k) using (hty_id, ken_id) inner join hersteller h using(her_id);

-- b) OUTER JOIN
select h.her_marke as "Herstellermarke", k.ken_nr AS "Kennzeichen", zul_motornr AS "Motornummer"
from	zulassung z left outer join (h_type, kennzeichen k) using (hty_id, ken_id) left outer join hersteller h using(her_id);

-- 7. Führen Sie alle Hersteller an und falls vorhanden auch die zugelassenen aktiven Kennzeichen.
select h.her_marke AS "Marke", k.ken_nr AS "Kennzeichen"
from	hersteller h left outer join h_type ht using (her_id) left outer join zulassung using(hty_id) 
left outer join kennzeichen k using (ken_id)
where zul_aktiv = 1 or zul_aktiv is null;

-- b) Anzahl je Marke
select h.her_marke AS "Marke", count(k.ken_nr) AS "Anzahl"
from	hersteller h left outer join h_type ht using (her_id) left outer join zulassung using(hty_id) 
left outer join kennzeichen k using (ken_id)
group by Marke
having anzahl > 0;







