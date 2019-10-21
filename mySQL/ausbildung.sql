-- Philipp Lang, 17.09.2018
-- uebung ERM Ausbildung - Abfragen und create script

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema education
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema education
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `education` DEFAULT CHARACTER SET utf8 ;
USE `education` ;

-- -----------------------------------------------------
-- Table `education`.`personen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`personen` ;

CREATE TABLE IF NOT EXISTS `education`.`personen` (
  `per_id` INT NOT NULL AUTO_INCREMENT,
  `per_vname` VARCHAR(45) NOT NULL,
  `per_nname` VARCHAR(45) NOT NULL,
  `per_geburtsdatum` VARCHAR(45) NOT NULL,
  `per_svnr` INT NOT NULL,
  `per_wohnort` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`per_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`schulformen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`schulformen` ;

CREATE TABLE IF NOT EXISTS `education`.`schulformen` (
  `sfo_id` INT NOT NULL AUTO_INCREMENT,
  `sfo_art` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sfo_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`bundesland`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`bundesland` ;

CREATE TABLE IF NOT EXISTS `education`.`bundesland` (
  `bdl_id` INT NOT NULL AUTO_INCREMENT,
  `bdl_bezeichnung` VARCHAR(45) NOT NULL,
  `bdl_abk` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`bdl_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`schulen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`schulen` ;

CREATE TABLE IF NOT EXISTS `education`.`schulen` (
  `sch_id` INT NOT NULL AUTO_INCREMENT,
  `sch_bezeichnung` VARCHAR(45) NOT NULL,
  `sch_adresse` VARCHAR(45) NOT NULL,
  `sfo_id` INT NOT NULL,
  `bundesland_bdl_id` INT NOT NULL,
  PRIMARY KEY (`sch_id`),
  INDEX `fk_schulen_schulformen1_idx` (`sfo_id` ASC),
  INDEX `fk_schulen_bundesland1_idx` (`bundesland_bdl_id` ASC),
  CONSTRAINT `fk_schulen_schulformen1`
    FOREIGN KEY (`sfo_id`)
    REFERENCES `education`.`schulformen` (`sfo_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schulen_bundesland1`
    FOREIGN KEY (`bundesland_bdl_id`)
    REFERENCES `education`.`bundesland` (`bdl_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`schulzweige`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`schulzweige` ;

CREATE TABLE IF NOT EXISTS `education`.`schulzweige` (
  `szw_id` INT NOT NULL AUTO_INCREMENT,
  `szw_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`szw_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`schulen_schulzweige`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`schulen_schulzweige` ;

CREATE TABLE IF NOT EXISTS `education`.`schulen_schulzweige` (
  `scsc_id` INT NOT NULL AUTO_INCREMENT,
  `sch_id` INT NOT NULL,
  `szw_id` INT NOT NULL,
  INDEX `fk_schulen_has_schulzweige_schulzweige1_idx` (`szw_id` ASC),
  INDEX `fk_schulen_has_schulzweige_schulen1_idx` (`sch_id` ASC),
  PRIMARY KEY (`scsc_id`),
  CONSTRAINT `fk_schulen_has_schulzweige_schulen1`
    FOREIGN KEY (`sch_id`)
    REFERENCES `education`.`schulen` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schulen_has_schulzweige_schulzweige1`
    FOREIGN KEY (`szw_id`)
    REFERENCES `education`.`schulzweige` (`szw_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`personen_schulen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`personen_schulen` ;

CREATE TABLE IF NOT EXISTS `education`.`personen_schulen` (
  `pesc_id` INT NOT NULL AUTO_INCREMENT,
  `per_id` INT NOT NULL,
  `sch_id` INT NOT NULL,
  PRIMARY KEY (`pesc_id`),
  INDEX `fk_personen_has_schulen_schulen1_idx` (`sch_id` ASC),
  INDEX `fk_personen_has_schulen_personen1_idx` (`per_id` ASC),
  CONSTRAINT `fk_personen_has_schulen_personen1`
    FOREIGN KEY (`per_id`)
    REFERENCES `education`.`personen` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personen_has_schulen_schulen1`
    FOREIGN KEY (`sch_id`)
    REFERENCES `education`.`schulen` (`sch_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `education`.`personen_schulen_schulzweige`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `education`.`personen_schulen_schulzweige` ;

CREATE TABLE IF NOT EXISTS `education`.`personen_schulen_schulzweige` (
  `pssw_id` INT NOT NULL AUTO_INCREMENT,
  `per_id` INT NOT NULL,
  `scsc_id` INT NOT NULL,
  PRIMARY KEY (`pssw_id`),
  INDEX `fk_personen_has_schulen_schulzweige_schulen_schulzweige1_idx` (`scsc_id` ASC),
  INDEX `fk_personen_has_schulen_schulzweige_personen1_idx` (`per_id` ASC),
  CONSTRAINT `fk_personen_has_schulen_schulzweige_personen1`
    FOREIGN KEY (`per_id`)
    REFERENCES `education`.`personen` (`per_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personen_has_schulen_schulzweige_schulen_schulzweige1`
    FOREIGN KEY (`scsc_id`)
    REFERENCES `education`.`schulen_schulzweige` (`scsc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `education`.`personen`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Philipp', 'Lang', '06.11.1994', 123061194, 'Kreiskystrasse 65 4020 Linz');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Max', 'Mustermann', '11.02.2000', 123110200, 'Kreiskystrasse 2');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Sepp', 'Wagner', '25.05.1997', 123250597, 'Wienerstrasse 12');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Hubert', 'Winkler', '19.07.1998', 123190798, 'Schoergenhubstrasse 1');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Ralf', 'Gruber', '04.02.2001', 123040201, 'Waldeggstrasse 1');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Kevin', 'Weber', '09.09.2002', 123090902, 'Freistaedterstrasse 12');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Josef', 'Huber', '06.05.1996', 123060596, 'Linzerstrasse 12');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Gustav', 'Bauer', '17.02.1995', 123170295, 'Leonding 123');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Kurt', 'Wimmer', '01.01.1992', 123010192, 'Entenhausen 1');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Franz', 'Mueller', '12.07.1999', 123120799, 'Entenhausen 12');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Susi', 'Musterfrau', '09.08.1992', 123090892, 'Beispielstrasse 1');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Susane', 'Kurz', '11.06.1994', 123110694, 'Beispielstrasse 2');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Lisa', 'Froehlich', '29.12.1996', 123291296, 'Hafnerstrasse 12');
INSERT INTO `education`.`personen` (`per_id`, `per_vname`, `per_nname`, `per_geburtsdatum`, `per_svnr`, `per_wohnort`) VALUES (DEFAULT, 'Michaela', 'Traurig', '16.12.1995', 123161295, 'Markt 1');

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`schulformen`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'VS');
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'HS');
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'Poly');
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'BS');
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'AHS');
INSERT INTO `education`.`schulformen` (`sfo_id`, `sfo_art`) VALUES (DEFAULT, 'HTL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`bundesland`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Oberoesterreich', 'Ooe');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Niederoesterreich', 'Noe');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Wien', 'W');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Burgenland', 'B');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Steiermark', 'S');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Kaernten', 'K');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Salzburg', 'S');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Tirol', 'T');
INSERT INTO `education`.`bundesland` (`bdl_id`, `bdl_bezeichnung`, `bdl_abk`) VALUES (DEFAULT, 'Vorarlberg', 'V');

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`schulen`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Volksschule Leopoldschlag', '4262 Leopoldschlag', 1, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Neue Mittelschule Rainbach', '4261 Rainbach im Muehlkreis', 2, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Polytechnische Schule Freistadt', '4240 Freistadt', 3, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Priv. Neue Mittelschule Marianum Freistadt ', '4240 Freistadt', 2, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Volksschule St. Oswald', '4271 St. Oswald b. Freistadt', 1, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Berufsschule 2', '4020 Linz', 4, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Bundesgymnasium Freistadt', '4240 Freistadt', 5, 1);
INSERT INTO `education`.`schulen` (`sch_id`, `sch_bezeichnung`, `sch_adresse`, `sfo_id`, `bundesland_bdl_id`) VALUES (DEFAULT, 'Hoehere Technische Bundeslehranstalt Leonding', '4060 Leonding', 6, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`schulzweige`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'ITI');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'ITT');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'RFK');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'ZIM');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'MZX');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'ZOX');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'ZFX');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'Technik');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'Musik');
INSERT INTO `education`.`schulzweige` (`szw_id`, `szw_bezeichnung`) VALUES (DEFAULT, 'Kunst');

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`schulen_schulzweige`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 1);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 2);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 3);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 4);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 5);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 6);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 6, 7);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 8, 8);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 1, 9);
INSERT INTO `education`.`schulen_schulzweige` (`scsc_id`, `sch_id`, `szw_id`) VALUES (DEFAULT, 2, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`personen_schulen`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 1, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 1, 7);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 1, 8);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 2, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 2, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 2, 4);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 3, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 3, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 4, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 4, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 4, 8);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 3, 8);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 5, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 5, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 5, 6);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 6, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 6, 7);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 6, 6);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 7, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 7, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 7, 6);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 8, 5);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 8, 7);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 8, 6);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 9, 2);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 9, 6);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 10, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 11, 7);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 12, 8);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 13, 8);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 14, 1);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 14, 7);
INSERT INTO `education`.`personen_schulen` (`pesc_id`, `per_id`, `sch_id`) VALUES (DEFAULT, 14, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `education`.`personen_schulen_schulzweige`
-- -----------------------------------------------------
START TRANSACTION;
USE `education`;
INSERT INTO `education`.`personen_schulen_schulzweige` (`pssw_id`, `per_id`, `scsc_id`) VALUES (DEFAULT, 1, 1);
INSERT INTO `education`.`personen_schulen_schulzweige` (`pssw_id`, `per_id`, `scsc_id`) VALUES (DEFAULT, 2, 1);
INSERT INTO `education`.`personen_schulen_schulzweige` (`pssw_id`, `per_id`, `scsc_id`) VALUES (DEFAULT, 3, 1);
INSERT INTO `education`.`personen_schulen_schulzweige` (`pssw_id`, `per_id`, `scsc_id`) VALUES (DEFAULT, 4, 2);
INSERT INTO `education`.`personen_schulen_schulzweige` (`pssw_id`, `per_id`, `scsc_id`) VALUES (DEFAULT, 3, 10);

COMMIT;





/*
ERM Ausbildung - 2
*/
-- nr 1
select concat_ws(' ', per_vname, per_nname) as 'Person', per_svnr as 'SVNR' from personen;

-- nr 2
select sfo.sfo_art as 'Ausbildungsart', concat_ws(' ', sch.sch_bezeichnung, sch.sch_adresse) as 'Schule' 
from schulen sch 
left outer join schulformen sfo 
on sfo.sfo_id = sch.sfo_id
group by sch_id
order by sfo_art;

-- nr 3
select szw.szw_bezeichnung as 'Berufszweig' from schulzweige szw 
left outer join schulen_schulzweige scsc
on scsc.szw_id = szw.szw_id
left outer join schulen sch
on scsc.sch_id = sch.sch_id
where sch.sch_id = 6
order by szw.szw_bezeichnung DESC;

-- nr 4

select sfo.sfo_art as 'Schulform', per.per_nname as 'Nachname' from personen per
left outer join personen_schulen pesc
on per.per_id = pesc.per_id
left outer join schulen sch
on pesc.sch_id = sch.sch_id
left outer join schulformen sfo
on sch.sfo_id = sfo.sfo_id
where sfo.sfo_art like 'HS' OR sfo.sfo_art like 'BS'
group by per.per_id
order by sfo.sfo_art, per.per_nname;


/*
select per.per_id, sfo.sfo_art as 'Schulform', per.per_nname as 'Nachname' from personen per
left outer join personen_schulen pesc
on per.per_id = pesc.per_id
left outer join schulen sch
on pesc.sch_id = sch.sch_id
left outer join schulformen sfo
on sch.sfo_id = sfo.sfo_id
order by per.per_nname;
*/



-- nr 5
select per.per_nname as 'Nachname', per.per_vname as 'Vorname', sfo.sfo_art as 'Schulform', sch.sch_bezeichnung as 'Schulbezeichnung', szw.szw_bezeichnung as 'Berufszweig'
from schulzweige szw
left outer join schulen_schulzweige scsc
on szw.szw_id = scsc.szw_id
left outer join personen_schulen_schulzweige pssw
on scsc.scsc_id = pssw.scsc_id
left outer join personen per
on pssw.per_id = per.per_id
left outer join personen_schulen pesc
on per.per_id = pesc.per_id
left outer join schulen sch
on pesc.sch_id = sch.sch_id
left outer join schulformen sfo
on sch.sfo_id = sfo.sfo_id
order by sfo.sfo_art, szw.szw_bezeichnung, per.per_nname;

-- nr 6 
select count(*) as 'Anzahl der Personen die die BS2 Linz besucht haben' from personen per 
left outer join personen_schulen pesc
using (per_id)
left outer join schulen sch
using (sch_id)
left outer join bundesland bdl 
on sch.bundesland_bdl_id = bdl.bdl_id
where sch.sch_bezeichnung like '%Berufsschule%' and sch.sch_adresse like '%Linz%' and bdl.bdl_abk like 'OOE';

-- nr 7

