-- P. Lang, 11.09.2018
-- Übung zu MySQL
-- 04_join_bank.sql
use bank;

-- cross-join
select * from person, bankkonto, person_bankkonto;

-- inner join
select * from person inner join person_bankkonto using (per_id)
	inner join bankkonto using(ban_id);
	
	
-- alternative Schreibweise
select * from person_bankkonto inner join (person, bankkonto)
		using (per_id, ban_id);
		
		
-- natural join
select * from person_bankkonto natural join (person, bankkonto);
/*
natural join vergleicht ALLE Attribute(Attributwerte) mit gleicher Bezeichnung
*/


-- Equi-Join ... Join mit WHERE-Klausel 
select * from person, bankkonto, person_bankkonto 
where person.per_id = person_bankkonto.per_id 
AND bankkonto.ban_id = person_bankkonto.ban_id;


/*
Aufgabe: Alias verwenden (Tabellen und Attribute)
		 Person | Kto-Nr
		 ... Person enthält Vor- und Nachname
		 ... Kto-Nr ban_nr
		 
		 sortiet nach Kto-Nr
*/

select concat_ws(' ', per.per_vn, per.per_nn) as "Person", pk.ban_nr as "Kto-Nr" 
from person per, bankkonto pk, person_bankkonto perbk
where per.per_id = perbk.per_id 
AND pk.ban_id = perbk.ban_id
order by pk.ban_nr;


-- *******************************************
-- OUTER JOINS
-- *******************************************


-- left [outer] join
/* 
	a) alle Bankkonto-Nr und falls vorhanden die per_id

*/
select ban_nr, per_id
from bankkonto left outer join person_bankkonto
on bankkonto.ban_id = person_bankkonto.ban_id;

-- right [outer] join
select ban_nr, per_id
from person_bankkonto right outer join bankkonto
on person_bankkonto.ban_id = bankkonto.ban_id;
-- using(ban_id);

/*
Aufgabe: nur jene Bankkonto-Nr di enoch keiner Person zugeordnet wurden
	ban_id | ban_nr

*/

select bankkonto.*
from bankkonto left outer join person_bankkonto
on bankkonto.ban_id = person_bankkonto.ban_id
where per_id is null;

/*
Aufgabe: Person | Kto-Nr
	alle Bankkonto-Nr und falls vorhanden auch Personen Vor- u. Nachname (in einer Spalte)
*/

select concat_ws(' ', p.per_vn, p.per_nn) as 'Person', b.ban_nr as 'Kto-Nr'
from person p left outer join person_bankkonto pb 
on p.per_id = pb.per_id left outer join bankkonto b on pb.ban_id = b.ban_id;

/*
GROUP BY and HAVING
*/

-- Aufgabe a) Anzahl der Personen je Bankknot - ban_id reicht aus
select ban_id,  count(per_id) as 'Anzahl Personen' 
from person_bankkonto
group by ban_id;


-- Aufgabe: wie a) aber je Kontonummer (ban_nr)
select k.ban_nr,  count(per_id) as 'Anzahl Personen' 
from person_bankkonto bk
left outer join bankkonto k
on k.ban_id = bk.ban_id
group by k.ban_id;


/*
-- wie a) aber nur ban_id ausgeben, wenn mehr als einer Person dem Konto zugeordnet ist
*/
select ban_id,  count(per_id) as 'Anzahl Personen' 
from person_bankkonto
group by ban_id
having count(per_id) > 1;




