-- P. Lang, 14.09.2018
-- 1 + 2. Aufgabe
-- ERM DB business 1 + 2

-- a
show databases;


-- b
drop database if exists business;

-- c
-- DB erstellen
create database business;

-- d
-- DB auswählen
use business;

-- e
-- Tabelle producer erstellen
create table producer(pro_id int primary key auto_increment,
	pro_name varchar(45) not null
);
-- Tabelle articel erstellen
create table article(art_id int primary key auto_increment,
	art_name varchar(45) not null,
	art_price decimal(10,2) not null
);

-- Zwischentabelle mit FK erstellen
create table article_producer(
	art_id int not null,
	pro_id int not null, 
	foreign key (art_id) references article (art_id) on update cascade on delete restrict,
	foreign key (pro_id) references producer (pro_id) on update cascade on delete restrict
);


-- f
show tables;

-- g
-- DS einfügen 
insert into producer values(null, 'Cloudy'),
(null, 'Huber'),
(null, 'Freud GmbH');

insert into article values(null, 'HB40', '100'),
(null, 'XY10', '250.99'),
(null, 'ABC', '141.29'),
(null, 'UMD56', '99.99');

insert into article_producer values(1,3), (2,3), (3,3), (4,2);

-- h
-- alle Attribute und DS anzeigen von producer tabelle
select * from producer;

-- i
describe producer;

-- j
show create table article_producer;

-- k
select * from producer order by pro_name;

-- l
select pro.pro_name, art.art_name from producer pro inner join article_producer using (pro_id)
	inner join article art using(art_id)
	order by pro.pro_name DESC, art.art_name ASC;
	
-- m
select pro_name, art_name from article_producer natural join (producer, article)
	order by pro_name DESC, art_name ASC;
	
-- n
select pro.pro_name, art.art_name from producer pro, article art, article_producer art_pro
where pro.pro_id = art_pro.pro_id 
and art.art_id = art_pro.art_id
order by pro.pro_name DESC, art.art_name ASC;

-- o
select pro.pro_name as 'Hersteller', art.art_name as 'Artikel', art.art_price as 'Preis' 
from producer pro, article art, article_producer art_pro
where pro.pro_id = art_pro.pro_id 
and art.art_id = art_pro.art_id;

-- p
select pro.pro_name as 'Hersteller', art.art_name as 'Artikel', art.art_price as 'Preis' 
from producer pro, article art, article_producer art_pro
where pro.pro_id = art_pro.pro_id 
and art.art_id = art_pro.art_id
limit 2,1;


-- q
select pro.pro_name as 'Hersteller', art.art_name as 'Artikel'
from article art left outer join article_producer ap
on art.art_id = ap.art_id
left outer join producer pro 
on ap.pro_id = pro.pro_id
order by pro.pro_name desc, art.art_name asc;

-- r
select pro.pro_name as 'Hersteller', count(ap.pro_id) as "Anzahl"
from article art left outer join article_producer ap
on art.art_id = ap.art_id
left outer join producer pro 
on ap.pro_id = pro.pro_id
group by pro.pro_name;


-- s
select pro.pro_name as 'Hersteller', count(ap.art_id) as "Anzahl"
from producer pro left outer join article_producer ap
using (pro_id)
group by ap.pro_id
order by count(ap.art_id) DESC;

-- t
select distinct pro.pro_name as 'Hersteller'
from article art left outer join article_producer ap
on art.art_id = ap.art_id
left outer join producer pro 
on ap.pro_id = pro.pro_id;

-- u 
select count(*) as "Anzahl aller Artikel" from article;


-- v
select count(*) as "Anzahl aller Hersteller" from producer;


-- w
select pro.pro_name as 'Hersteller' from producer pro left outer join article_producer ap
using (pro_id)
where ap.art_id is null;

-- x
select pro.pro_name as 'Hersteller', count(ap.art_id) as "Anzahl"
from producer pro left outer join article_producer ap
using (pro_id)
group by ap.pro_id
having count(ap.art_id) > 0;



