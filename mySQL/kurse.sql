-- P. Lang, 21.09.2018
-- Kursverwaltung Abfragen + ERM
-- DB kurse
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema kurse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kurse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kurse` DEFAULT CHARACTER SET utf8 ;
USE `kurse` ;

-- -----------------------------------------------------
-- Table `kurse`.`bezeichnung`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`bezeichnung` ;

CREATE TABLE IF NOT EXISTS `kurse`.`bezeichnung` (
  `bez_id` INT NOT NULL AUTO_INCREMENT,
  `bez_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bez_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`kurse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`kurse` ;

CREATE TABLE IF NOT EXISTS `kurse`.`kurse` (
  `kur_id` INT NOT NULL AUTO_INCREMENT,
  `kur_preis` DECIMAL(12,2) NOT NULL,
  `kur_start` DATETIME NOT NULL,
  `kur_ende` DATETIME NOT NULL,
  `kur_set` TIMESTAMP NULL,
  `bez_id` INT NOT NULL,
  PRIMARY KEY (`kur_id`),
  INDEX `fk_kurse_bezeichnung1_idx` (`bez_id` ASC),
  CONSTRAINT `fk_kurse_bezeichnung1`
    FOREIGN KEY (`bez_id`)
    REFERENCES `kurse`.`bezeichnung` (`bez_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`personenart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`personenart` ;

CREATE TABLE IF NOT EXISTS `kurse`.`personenart` (
  `pea_id` INT NOT NULL AUTO_INCREMENT,
  `pea_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pea_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`personen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`personen` ;

CREATE TABLE IF NOT EXISTS `kurse`.`personen` (
  `per_id` INT NOT NULL AUTO_INCREMENT,
  `per_vorname` VARCHAR(45) NOT NULL,
  `per_nachname` VARCHAR(45) NOT NULL,
  `pea_id` INT NOT NULL,
  `per_street` VARCHAR(45) NOT NULL,
  `per_plz` VARCHAR(45) NOT NULL,
  `per_ort` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`per_id`),
  INDEX `fk_personen_personenart1_idx` (`pea_id` ASC),
  CONSTRAINT `fk_personen_personenart1`
    FOREIGN KEY (`pea_id`)
    REFERENCES `kurse`.`personenart` (`pea_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`firma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`firma` ;

CREATE TABLE IF NOT EXISTS `kurse`.`firma` (
  `fir_id` INT NOT NULL AUTO_INCREMENT,
  `fir_name` VARCHAR(45) NOT NULL,
  `fir_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`fir_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`kurse_personen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`kurse_personen` ;

CREATE TABLE IF NOT EXISTS `kurse`.`kurse_personen` (
  `kupe_id` INT NOT NULL AUTO_INCREMENT,
  `kur_id` INT NOT NULL,
  `per_id` INT NOT NULL,
  `kupe_isLeader` TINYINT(1) NOT NULL,
  PRIMARY KEY (`kupe_id`),
  INDEX `fk_kurse_has_personen_personen1_idx` (`per_id` ASC),
  INDEX `fk_kurse_has_personen_kurse_idx` (`kur_id` ASC),
  CONSTRAINT `fk_kurse_has_personen_kurse`
    FOREIGN KEY (`kur_id`)
    REFERENCES `kurse`.`kurse` (`kur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kurse_has_personen_personen1`
    FOREIGN KEY (`per_id`)
    REFERENCES `kurse`.`personen` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `kurse`.`personen_firma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kurse`.`personen_firma` ;

CREATE TABLE IF NOT EXISTS `kurse`.`personen_firma` (
  `pefi_id` INT NOT NULL AUTO_INCREMENT,
  `per_id` INT NOT NULL,
  `fir_id` INT NOT NULL,
  INDEX `fk_personen_has_Firma_Firma1_idx` (`fir_id` ASC),
  INDEX `fk_personen_has_Firma_personen1_idx` (`per_id` ASC),
  PRIMARY KEY (`pefi_id`),
  CONSTRAINT `fk_personen_has_Firma_personen1`
    FOREIGN KEY (`per_id`)
    REFERENCES `kurse`.`personen` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personen_has_Firma_Firma1`
    FOREIGN KEY (`fir_id`)
    REFERENCES `kurse`.`firma` (`fir_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `kurse`.`bezeichnung`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`bezeichnung` (`bez_id`, `bez_bezeichnung`) VALUES (DEFAULT, 'SQL Start');
INSERT INTO `kurse`.`bezeichnung` (`bez_id`, `bez_bezeichnung`) VALUES (DEFAULT, 'SQL Advanced');
INSERT INTO `kurse`.`bezeichnung` (`bez_id`, `bez_bezeichnung`) VALUES (DEFAULT, 'PHP Beginner');

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`kurse`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`kurse` (`kur_id`, `kur_preis`, `kur_start`, `kur_ende`, `kur_set`, `bez_id`) VALUES (DEFAULT, 199.12, '2018-09-21', '2018-11-21', NULL, 1);
INSERT INTO `kurse`.`kurse` (`kur_id`, `kur_preis`, `kur_start`, `kur_ende`, `kur_set`, `bez_id`) VALUES (DEFAULT, 112, '2018-11-11', '2018-11-04', NULL, 2);
INSERT INTO `kurse`.`kurse` (`kur_id`, `kur_preis`, `kur_start`, `kur_ende`, `kur_set`, `bez_id`) VALUES (DEFAULT, 299, '2018-03-30', '2018-05-30', NULL, 1);
INSERT INTO `kurse`.`kurse` (`kur_id`, `kur_preis`, `kur_start`, `kur_ende`, `kur_set`, `bez_id`) VALUES (DEFAULT, 12, '2018-07-29', '2018-09-29', NULL, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`personenart`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`personenart` (`pea_id`, `pea_bezeichnung`) VALUES (DEFAULT, 'Privatkunde');
INSERT INTO `kurse`.`personenart` (`pea_id`, `pea_bezeichnung`) VALUES (DEFAULT, 'Firmenkunde');

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`personen`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Robert', 'Salchegger', 1, 'Teststrasse 1', '4020', 'Linz');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Philipp', 'Lang', 2, 'Teststrasse 2', '4030', 'Wien');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Max', 'Mustermann', 1, 'Teststrasse 3', '4020', 'Freistadt');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Susi', 'Musterfrau', 1, 'Teststrasse 4', '4021', 'Linz');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Lisa', 'Duck', 2, 'Teststrasse 5', '4030', 'Linz');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Donald', 'Trump', 2, 'Teststrasse 6', '1010', 'Wien');
INSERT INTO `kurse`.`personen` (`per_id`, `per_vorname`, `per_nachname`, `pea_id`, `per_street`, `per_plz`, `per_ort`) VALUES (DEFAULT, 'Gustav', 'Trumpi', 1, 'Teststrasse 7', '2010', 'Salzburg');

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`firma`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`firma` (`fir_id`, `fir_name`, `fir_email`) VALUES (DEFAULT, 'CIC', 'office@cic.at');
INSERT INTO `kurse`.`firma` (`fir_id`, `fir_name`, `fir_email`) VALUES (DEFAULT, 'has-to-be', 'office@has-to-be.at');

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`kurse_personen`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 1, 1, 1);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 1, 2, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 1, 3, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 1, 4, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 2, 5, 1);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 2, 6, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 3, 1, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 3, 2, 1);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 3, 6, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 4, 5, 0);
INSERT INTO `kurse`.`kurse_personen` (`kupe_id`, `kur_id`, `per_id`, `kupe_isLeader`) VALUES (DEFAULT, 4, 4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `kurse`.`personen_firma`
-- -----------------------------------------------------
START TRANSACTION;
USE `kurse`;
INSERT INTO `kurse`.`personen_firma` (`pefi_id`, `per_id`, `fir_id`) VALUES (DEFAULT, 1, 1);
INSERT INTO `kurse`.`personen_firma` (`pefi_id`, `per_id`, `fir_id`) VALUES (DEFAULT, 1, 2);

COMMIT;






/*

Abfragen:

*/
-- a

select per.per_nachname as 'Nachname', per.per_vorname as 'Vorname' from personen per
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
where kur_id = 1;


-- b
select kur.kur_bezeichnung as 'Kurs', count(*) as 'Anzahl' from personen per
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
group by kur_id
order by kur_bezeichnung;


-- c
select concat_ws(' ', per.per_vorname, per.per_nachname) as 'Kursleiter', kur.kur_bezeichnung as 'Kurse', concat_ws('-', kur.kur_start, kur.kur_ende) as 'Datum' from personen per
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
where kupe.kupe_isLeader = 1;


-- d
select per.per_nachname as 'Nachname', per.per_vorname as 'Vorname' from personenart pea
left outer join personen per
using (pea_id)
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
where pea.pea_id = 1 and kur.kur_id = 1;

-- e
select per.per_nachname as 'Nachname', per.per_vorname as 'Vorname' from personenart pea
left outer join personen per
using (pea_id)
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
where pea.pea_id = 2 and kur.kur_id = 1;


-- f 
select pea.pea_bezeichnung as 'Art', count(pea.pea_id) as 'Anzahl' from personenart pea
left outer join personen per
using (pea_id)
left outer join kurse_personen kupe
using (per_id)
left outer join kurse kur
using (kur_id)
where kur.kur_id = 1
group by pea.pea_id;

-- g
-- desc personen;
-- alter table personen drop per_id;
-- sollte als primary key geadded werden
alter table personen add newID int after per_nachname;

-- h
update personen set newID = 1234 where per_id = 1;
select * from personen;

-- i 
alter table personen drop newID;
desc personen;

-- j 
alter table personen rename Customer;
show tables;
alter table Customer rename personen;
show tables;


-- k
desc personen;
alter table personen change per_nachname per_lastname varchar(45);
desc personen;
alter table personen change per_lastname per_nachname varchar(45);
desc personen;

-- l
select sum(kur.kur_preis) as 'Summe'
from kurse kur 
where date_format(kur.kur_start, '%d-%m-%Y') > date_format(SYSDATE(), '%d-%m-%Y');

-- select date_format(kur.kur_start, '%d-%m-%Y'), kur.kur_bezeichnung, kur.kur_preis from kurse kur;
-- select date_format(sysdate(), '%d-%m-%Y');

-- m
select * from personen per
left outer join kurse_personen kupe
using (per_id)
where kupe.kur_id is null;


-- n
select kur.kur_bezeichnung as 'Kurs', concat_ws(' ', per.per_vorname, per.per_nachname) as 'Person' from kurse kur
left outer join kurse_personen kupe
using (kur_id)
left outer join personen per
using (per_id)
where kur.kur_id != 1
order by kur.kur_bezeichnung, per.per_nachname;



/*
Arbeiten mit Datum

*/

-- o 
select * from kurse order by kur_start;

-- p
 select * from kurse where kur_start > '2018-10-1' and kur_ende < '2019-02-01';

 -- q
 update kurse set kur_preis = (kur_preis - 10) where kur_start > '2019-01-01' and kur_id = 4;
 
-- r
select kur_bezeichnung, kur_preis, date_format(kur_start, '%D-%M-%y'), date_format(kur_ende, '%D.%mm.%Y') from kurse;

select kur_bezeichnung, kur_preis, date_format(kur_start, '%a %j %b %Y'), date_format(kur_ende, '%a %d %b %y') from kurse;

select kur_bezeichnung, kur_preis, date_format(kur_start, '%dd %mm %yy'), date_format(kur_ende, '%D %M %Y') from kurse;


select kur.kur_id, be.bez_bezeichnung, date_format(kur.kur_start, "%Y-%m-%d") from kurse kur
left join bezeichnung be
using (bez_id)
left join kurse_personen kupe
using (kur_id)
left join personen per 
using (per_id)
where per.per_id = 2;


select kur.kur_id as "Kurs_ID", be.bez_bezeichnung as "Bezeichnung", date_format(kur.kur_start, '%Y-%m-%d') as "Startdatum", concat_ws(' ', per.per_vorname, per.per_nachname) as "Vortragender" from kurse_personen kupe
left outer join kurse kur
using (kur_id)
left outer join personen per
using (per_id)
left outer join bezeichnung be
using (bez_id);

select kur.kur_id, be.bez_bezeichnung, date_format(kur.kur_start, "%Y-%m-%d") from kurse kur
left join bezeichnung be
using (bez_id);