-- P.Andrich, 17.9.2018
-- 02_Aufgabe_AndrichPatrick.sql
-- version 1.0

drop database if exists mydb;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Schulzweig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schulzweig` (
  `szweig_id` INT NOT NULL AUTO_INCREMENT,
  `szweig_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`szweig_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bundesland`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bundesland` (
  `bLand_id` INT NOT NULL,
  `bLand_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bLand_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Adressen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Adressen` (
  `adr_id` INT NOT NULL AUTO_INCREMENT,
  `adr_ort` VARCHAR(45) NOT NULL,
  `adr_plz` VARCHAR(45) NOT NULL,
  `adr_str` VARCHAR(45) NOT NULL,
  `adr_strNr` INT NOT NULL,
  `bLand_id` INT NOT NULL,
  PRIMARY KEY (`adr_id`),
  INDEX `fk_Adressen_Bundesland1_idx` (`bLand_id` ASC),
  CONSTRAINT `fk_Adressen_Bundesland1`
    FOREIGN KEY (`bLand_id`)
    REFERENCES `mydb`.`Bundesland` (`bLand_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schulform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schulform` (
  `sform_id` INT NOT NULL AUTO_INCREMENT,
  `sform_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sform_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schulen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schulen` (
  `schulen_id` INT NOT NULL AUTO_INCREMENT,
  `schulen_name` VARCHAR(45) NOT NULL,
  `Adressen_adr_id` INT NOT NULL,
  `Schulform_idSchulform` INT NOT NULL,
  PRIMARY KEY (`schulen_id`),
  INDEX `fk_Schulen_Adressen_idx` (`Adressen_adr_id` ASC),
  INDEX `fk_Schulen_Schulform1_idx` (`Schulform_idSchulform` ASC),
  CONSTRAINT `fk_Schulen_Adressen`
    FOREIGN KEY (`Adressen_adr_id`)
    REFERENCES `mydb`.`Adressen` (`adr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schulen_Schulform1`
    FOREIGN KEY (`Schulform_idSchulform`)
    REFERENCES `mydb`.`Schulform` (`sform_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schueler`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schueler` (
  `schueler_id` INT NOT NULL AUTO_INCREMENT,
  `schueler_vname` VARCHAR(45) NOT NULL,
  `schueler_nname` VARCHAR(45) NOT NULL,
  `schueler_SVNR` INT(10) NOT NULL,
  `schueler_gebDat` DATE NOT NULL,
  `schulen_id` INT NOT NULL,
  `adr_id` INT NOT NULL,
  `szweig_id` INT NULL,
  PRIMARY KEY (`schueler_id`),
  INDEX `fk_Schueler_Schulen1_idx` (`schulen_id` ASC),
  INDEX `fk_Schueler_Adressen1_idx` (`adr_id` ASC),
  INDEX `fk_Schueler_Schulzweig1_idx` (`szweig_id` ASC),
  CONSTRAINT `fk_Schueler_Schulen1`
    FOREIGN KEY (`schulen_id`)
    REFERENCES `mydb`.`Schulen` (`schulen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schueler_Adressen1`
    FOREIGN KEY (`adr_id`)
    REFERENCES `mydb`.`Adressen` (`adr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schueler_Schulzweig1`
    FOREIGN KEY (`szweig_id`)
    REFERENCES `mydb`.`Schulzweig` (`szweig_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Schulen_has_Schulzweig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Schulen_has_Schulzweig` (
  `Schulen_schulen_id` INT NOT NULL,
  `Schulzweig_szweig_id` INT NOT NULL,
  INDEX `fk_Schulen_has_Schulzweig_Schulzweig1_idx` (`Schulzweig_szweig_id` ASC),
  INDEX `fk_Schulen_has_Schulzweig_Schulen1_idx` (`Schulen_schulen_id` ASC),
  CONSTRAINT `fk_Schulen_has_Schulzweig_Schulen1`
    FOREIGN KEY (`Schulen_schulen_id`)
    REFERENCES `mydb`.`Schulen` (`schulen_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Schulen_has_Schulzweig_Schulzweig1`
    FOREIGN KEY (`Schulzweig_szweig_id`)
    REFERENCES `mydb`.`Schulzweig` (`szweig_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`History`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`History` (
  `schueler_id` INT NOT NULL,
  `hist_schulen` VARCHAR(45) NOT NULL,
  `hist_zweig` VARCHAR(45) NOT NULL,
  `hist_jahr` VARCHAR(45) NOT NULL,
  INDEX `fk_History_Schueler1_idx` (`schueler_id` ASC),
  PRIMARY KEY (`schueler_id`, `hist_schulen`, `hist_jahr`),
  CONSTRAINT `fk_History_Schueler1`
    FOREIGN KEY (`schueler_id`)
    REFERENCES `mydb`.`Schueler` (`schueler_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Schulzweig`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schulzweig` (`szweig_id`, `szweig_name`) VALUES (1, 'Informationstechnologie/Technik');
INSERT INTO `mydb`.`Schulzweig` (`szweig_id`, `szweig_name`) VALUES (2, 'Informationstechnologie/Informatik');
INSERT INTO `mydb`.`Schulzweig` (`szweig_id`, `szweig_name`) VALUES (3, 'Zimmerer');
INSERT INTO `mydb`.`Schulzweig` (`szweig_id`, `szweig_name`) VALUES (4, 'Tischler');
INSERT INTO `mydb`.`Schulzweig` (`szweig_id`, `szweig_name`) VALUES (5, 'Hafner');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Bundesland`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Bundesland` (`bLand_id`, `bLand_name`) VALUES (1, 'Oberoesterreich');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Adressen`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Adressen` (`adr_id`, `adr_ort`, `adr_plz`, `adr_str`, `adr_strNr`, `bLand_id`) VALUES (1, 'Linz', '4020', 'Bahnstrasse', 16, 1);
INSERT INTO `mydb`.`Adressen` (`adr_id`, `adr_ort`, `adr_plz`, `adr_str`, `adr_strNr`, `bLand_id`) VALUES (2, 'Steyr', '4400', 'Wasserberg', 4, 1);
INSERT INTO `mydb`.`Adressen` (`adr_id`, `adr_ort`, `adr_plz`, `adr_str`, `adr_strNr`, `bLand_id`) VALUES (3, 'Gampert', '4851', 'Bierbaum', 57, 1);
INSERT INTO `mydb`.`Adressen` (`adr_id`, `adr_ort`, `adr_plz`, `adr_str`, `adr_strNr`, `bLand_id`) VALUES (4, 'Marchtrenk', '4614', 'Lindenstrasse', 45, 1);
INSERT INTO `mydb`.`Adressen` (`adr_id`, `adr_ort`, `adr_plz`, `adr_str`, `adr_strNr`, `bLand_id`) VALUES (5, 'Wels', '4600', 'Jasminstrasse', 14, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Schulform`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schulform` (`sform_id`, `sform_name`) VALUES (1, 'AHS');
INSERT INTO `mydb`.`Schulform` (`sform_id`, `sform_name`) VALUES (2, 'BS');
INSERT INTO `mydb`.`Schulform` (`sform_id`, `sform_name`) VALUES (3, 'HTL');
INSERT INTO `mydb`.`Schulform` (`sform_id`, `sform_name`) VALUES (4, 'Hasch');
INSERT INTO `mydb`.`Schulform` (`sform_id`, `sform_name`) VALUES (5, 'BaKip');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Schulen`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schulen` (`schulen_id`, `schulen_name`, `Adressen_adr_id`, `Schulform_idSchulform`) VALUES (1, 'Linz2', 1, 2);
INSERT INTO `mydb`.`Schulen` (`schulen_id`, `schulen_name`, `Adressen_adr_id`, `Schulform_idSchulform`) VALUES (2, 'Wackelgasse', 2, 1);
INSERT INTO `mydb`.`Schulen` (`schulen_id`, `schulen_name`, `Adressen_adr_id`, `Schulform_idSchulform`) VALUES (3, 'Hasi-Mittelschule', 3, 5);
INSERT INTO `mydb`.`Schulen` (`schulen_id`, `schulen_name`, `Adressen_adr_id`, `Schulform_idSchulform`) VALUES (4, 'Auzi-Gesamtschule', 4, 3);
INSERT INTO `mydb`.`Schulen` (`schulen_id`, `schulen_name`, `Adressen_adr_id`, `Schulform_idSchulform`) VALUES (5, 'Veigl-Dichtgasse', 5, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Schueler`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schueler` (`schueler_id`, `schueler_vname`, `schueler_nname`, `schueler_SVNR`, `schueler_gebDat`, `schulen_id`, `adr_id`, `szweig_id`) VALUES (DEFAULT, 'Thomas', 'Kastner', 1234050516, '1900-01-01', 3, 5, NULL);
INSERT INTO `mydb`.`Schueler` (`schueler_id`, `schueler_vname`, `schueler_nname`, `schueler_SVNR`, `schueler_gebDat`, `schulen_id`, `adr_id`, `szweig_id`) VALUES (DEFAULT, 'Franz', 'Ferdinand', 1234050517, '1901-02-02', 1, 4, 1);
INSERT INTO `mydb`.`Schueler` (`schueler_id`, `schueler_vname`, `schueler_nname`, `schueler_SVNR`, `schueler_gebDat`, `schulen_id`, `adr_id`, `szweig_id`) VALUES (DEFAULT, 'Gunther', 'Jauch', 1234060699, '1801-03-03', 2, 3, NULL);
INSERT INTO `mydb`.`Schueler` (`schueler_id`, `schueler_vname`, `schueler_nname`, `schueler_SVNR`, `schueler_gebDat`, `schulen_id`, `adr_id`, `szweig_id`) VALUES (DEFAULT, 'Arthur', 'Grabmair', 5697070786, '1999-07-08', 4, 2, NULL);
INSERT INTO `mydb`.`Schueler` (`schueler_id`, `schueler_vname`, `schueler_nname`, `schueler_SVNR`, `schueler_gebDat`, `schulen_id`, `adr_id`, `szweig_id`) VALUES (DEFAULT, 'Stefan', 'Hiptmaier', 3265050920, '1756-06-07', 5, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Schulen_has_Schulzweig`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Schulen_has_Schulzweig` (`Schulen_schulen_id`, `Schulzweig_szweig_id`) VALUES (1, 1);
INSERT INTO `mydb`.`Schulen_has_Schulzweig` (`Schulen_schulen_id`, `Schulzweig_szweig_id`) VALUES (1, 2);
INSERT INTO `mydb`.`Schulen_has_Schulzweig` (`Schulen_schulen_id`, `Schulzweig_szweig_id`) VALUES (1, 3);
INSERT INTO `mydb`.`Schulen_has_Schulzweig` (`Schulen_schulen_id`, `Schulzweig_szweig_id`) VALUES (1, 4);
INSERT INTO `mydb`.`Schulen_has_Schulzweig` (`Schulen_schulen_id`, `Schulzweig_szweig_id`) VALUES (1, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`History`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (1, '3', DEFAULT, '2012/13');
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (1, '2', '5', '2011/12');
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (1, '1', DEFAULT, '2013/14');
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (2, '1', DEFAULT, '2013/14');
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (3, '1', DEFAULT, '2013/14');
INSERT INTO `mydb`.`History` (`schueler_id`, `hist_schulen`, `hist_zweig`, `hist_jahr`) VALUES (4, '1', DEFAULT, '2013/14');

COMMIT;













use mydb;

select concat_ws(' ',schueler_vname,schueler_nname) as "Person", schueler_SVNR as "SVNR" from Schueler;

select concat_ws(" ",schulen_name,adr_ort) as Schule,sform_name as Ausbildungsart from Schulen
left join Adressen on Schulen.Adressen_adr_id = Adressen.adr_id
left join Schulform on Schulen.Schulform_idSchulform = sform_id
order by Ausbildungsart;

select szweig_name as "Schulzweig" from Schulzweig
left join Schulen_has_Schulzweig on szweig_id = Schulzweig_szweig_id
left join Schulen on schulen_id = Schulen_schulen_id
where schulen_id = 1
order by Schulzweig DESC;

select sform_name as Schulform,schueler_nname as Nachname from Schueler
left join Schulen using(schulen_id)
left join Schulform on Schulform_idSchulform = sform_id
left join history using(schueler_id)
where hist_schulen = 2 or hist_schulen = 1
order by Schulform,Nachname;

select schueler_vname as Vorname, schueler_nname as Nachname, sform_name as Schulform,schulen_name as Schulbezeichnung,szweig_name as Berufszweig
from Schueler
left join Schulen using(schulen_id)
left join Schulzweig using(szweig_id)
left join Schulform on Schulform_idSchulform = sform_id
;

select count(hist_schulen) from History
where hist_schulen = 1;

select count(schulen_name) from schulen
left join Adressen on Adressen_adr_id = adr_id
left join Bundesland using(bLand_id)
where bLand_name like "Oberoesterreich";

select count(schulen_name) from schulen
left join Adressen on Adressen_adr_id = adr_id
left join Bundesland using(bLand_id)
left join Schulform on Schulform_idSchulform = sform_id
where sform_name like "HTL";

select distinct(schulen_name) as Schule, count(history.schueler_id) as Personen from schulen
left join Adressen on Adressen_adr_id = adr_id
left join Bundesland using(bLand_id)
left join history on hist_schulen = schulen_id
group by Schule;


select * from history 
left join schulform on hist_schulen = sform_id
where hist_schulen = 1 or hist_schulen = 2
;