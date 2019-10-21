-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema solarium
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `solarium` ;

-- -----------------------------------------------------
-- Schema solarium
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `solarium` DEFAULT CHARACTER SET utf8 ;
USE `solarium` ;

-- -----------------------------------------------------
-- Table `solarium`.`solarium`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`solarium` (
  `sol_id` INT NOT NULL AUTO_INCREMENT,
  `sol_standort_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`sol_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`kabine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`kabine` (
  `kab_id` INT NOT NULL AUTO_INCREMENT,
  `kab_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`kab_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`solarium_kabine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`solarium_kabine` (
  `soka_id` INT NOT NULL AUTO_INCREMENT,
  `sol_id` INT NOT NULL,
  `kab_id` INT NOT NULL,
  INDEX `fk_solarium_has_kabine_kabine1_idx` (`kab_id` ASC),
  INDEX `fk_solarium_has_kabine_solarium_idx` (`sol_id` ASC),
  PRIMARY KEY (`soka_id`),
  CONSTRAINT `fk_solarium_has_kabine_solarium`
    FOREIGN KEY (`sol_id`)
    REFERENCES `solarium`.`solarium` (`sol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solarium_has_kabine_kabine1`
    FOREIGN KEY (`kab_id`)
    REFERENCES `solarium`.`kabine` (`kab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`modell`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`modell` (
  `mod_id` INT NOT NULL AUTO_INCREMENT,
  `mod_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mod_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`solariumbank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`solariumbank` (
  `soba_id` INT NOT NULL AUTO_INCREMENT,
  `mod_id` INT NOT NULL,
  PRIMARY KEY (`soba_id`),
  INDEX `fk_solariumbank_modell1_idx` (`mod_id` ASC),
  CONSTRAINT `fk_solariumbank_modell1`
    FOREIGN KEY (`mod_id`)
    REFERENCES `solarium`.`modell` (`mod_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`solariumbank_kabine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`solariumbank_kabine` (
  `soka_id` INT NOT NULL,
  `soba_id` INT NOT NULL,
  `kab_id` INT NOT NULL DEFAULT 1,
  `soka_datum` DATETIME NOT NULL,
  INDEX `fk_solariumbank_has_kabine_kabine1_idx` (`kab_id` ASC),
  INDEX `fk_solariumbank_has_kabine_solariumbank1_idx` (`soba_id` ASC),
  PRIMARY KEY (`soka_id`),
  CONSTRAINT `fk_solariumbank_has_kabine_solariumbank1`
    FOREIGN KEY (`soba_id`)
    REFERENCES `solarium`.`solariumbank` (`soba_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solariumbank_has_kabine_kabine1`
    FOREIGN KEY (`kab_id`)
    REFERENCES `solarium`.`kabine` (`kab_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`kunde` (
  `kun_id` INT NOT NULL AUTO_INCREMENT,
  `kun_nname` VARCHAR(45) NOT NULL,
  `kun_vname` VARCHAR(45) NULL,
  `kun_geb` DATE NOT NULL,
  `kunde_guthaben` DOUBLE NULL,
  PRIMARY KEY (`kun_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`adresse` (
  `adr_id` INT NOT NULL,
  `adr_plz` VARCHAR(45) NULL,
  `adr_ort` VARCHAR(45) NULL,
  `adr_str` VARCHAR(45) NULL,
  PRIMARY KEY (`adr_id`))
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `solarium`.`kunde_adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`kunde_adresse` (
  `kuad_id` INT NOT NULL,
  `kun_id` INT NOT NULL,
  `adr_id` INT NOT NULL,
  `kuad_hausnr` VARCHAR(5) NOT NULL,
  INDEX `fk_kunde_has_adresse_adresse1_idx` (`adr_id` ASC),
  INDEX `fk_kunde_has_adresse_kunde1_idx` (`kun_id` ASC),
  PRIMARY KEY (`kuad_id`),
  CONSTRAINT `fk_kunde_has_adresse_kunde1`
    FOREIGN KEY (`kun_id`)
    REFERENCES `solarium`.`kunde` (`kun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kunde_has_adresse_adresse1`
    FOREIGN KEY (`adr_id`)
    REFERENCES `solarium`.`adresse` (`adr_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`solarium_kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`solarium_kunde` (
  `soku_id` INT NOT NULL AUTO_INCREMENT,
  `sol_id` INT NOT NULL DEFAULT 1,
  `kun_id` INT NOT NULL,
  `soku_datum` DATE NOT NULL,
  INDEX `fk_solarium_has_kunde_kunde1_idx` (`kun_id` ASC),
  INDEX `fk_solarium_has_kunde_solarium1_idx` (`sol_id` ASC),
  PRIMARY KEY (`soku_id`),
  CONSTRAINT `fk_solarium_has_kunde_solarium1`
    FOREIGN KEY (`sol_id`)
    REFERENCES `solarium`.`solarium` (`sol_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solarium_has_kunde_kunde1`
    FOREIGN KEY (`kun_id`)
    REFERENCES `solarium`.`kunde` (`kun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`Saison`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`Saison` (
  `saison_id` INT NOT NULL AUTO_INCREMENT,
  `saison_name` VARCHAR(45) NOT NULL,
  `saison_endbetrag` DOUBLE NOT NULL,
  `saison_bezahlbetrag` DOUBLE NOT NULL,
  `saison_start` DATE NOT NULL,
  `saison_end` DATE NOT NULL,
  PRIMARY KEY (`saison_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`Solariumblock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`Solariumblock` (
  `solariumblock_id` INT NOT NULL AUTO_INCREMENT,
  `kun_id` INT NOT NULL,
  `saison_id` INT NOT NULL,
  `block_kaufdatum` DATE NOT NULL,
  PRIMARY KEY (`solariumblock_id`),
  INDEX `fk_Solariumblock_kunde1_idx` (`kun_id` ASC),
  INDEX `fk_Solariumblock_Saison1_idx` (`saison_id` ASC),
  CONSTRAINT `fk_Solariumblock_kunde1`
    FOREIGN KEY (`kun_id`)
    REFERENCES `solarium`.`kunde` (`kun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Solariumblock_Saison1`
    FOREIGN KEY (`saison_id`)
    REFERENCES `solarium`.`Saison` (`saison_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solarium`.`kunde_solariumbank_kabine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `solarium`.`kunde_solariumbank_kabine` (
  `kun_id` INT NOT NULL,
  `soka_id` INT NOT NULL,
  `ksk_id` INT NOT NULL AUTO_INCREMENT,
  `ksk_start` DATETIME NOT NULL,
  `ksk_end` DATETIME NOT NULL,
  INDEX `fk_kunde_has_solariumbank_kabine_solariumbank_kabine1_idx` (`soka_id` ASC),
  INDEX `fk_kunde_has_solariumbank_kabine_kunde1_idx` (`kun_id` ASC),
  PRIMARY KEY (`ksk_id`),
  CONSTRAINT `fk_kunde_has_solariumbank_kabine_kunde1`
    FOREIGN KEY (`kun_id`)
    REFERENCES `solarium`.`kunde` (`kun_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kunde_has_solariumbank_kabine_solariumbank_kabine1`
    FOREIGN KEY (`soka_id`)
    REFERENCES `solarium`.`solariumbank_kabine` (`soka_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `solarium`.`solarium`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`solarium` (`sol_id`, `sol_standort_name`) VALUES (DEFAULT, 'Zentrale');

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`kabine`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`kabine` (`kab_id`, `kab_name`) VALUES (DEFAULT, 'Lager');
INSERT INTO `solarium`.`kabine` (`kab_id`, `kab_name`) VALUES (DEFAULT, 'Sibirien');
INSERT INTO `solarium`.`kabine` (`kab_id`, `kab_name`) VALUES (DEFAULT, 'Vienna');
INSERT INTO `solarium`.`kabine` (`kab_id`, `kab_name`) VALUES (DEFAULT, 'Miami');

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`modell`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`modell` (`mod_id`, `mod_name`) VALUES (DEFAULT, 'Energy 3000');
INSERT INTO `solarium`.`modell` (`mod_id`, `mod_name`) VALUES (DEFAULT, 'Power 780');

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`solariumbank`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`solariumbank` (`soba_id`, `mod_id`) VALUES (DEFAULT, 1);
INSERT INTO `solarium`.`solariumbank` (`soba_id`, `mod_id`) VALUES (DEFAULT, 2);
INSERT INTO `solarium`.`solariumbank` (`soba_id`, `mod_id`) VALUES (DEFAULT, 1);
INSERT INTO `solarium`.`solariumbank` (`soba_id`, `mod_id`) VALUES (DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`solariumbank_kabine`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`solariumbank_kabine` (`soka_id`, `soba_id`, `kab_id`, `soka_datum`) VALUES (DEFAULT, 1, 1, '2018-09-11 09:06');
INSERT INTO `solarium`.`solariumbank_kabine` (`soka_id`, `soba_id`, `kab_id`, `soka_datum`) VALUES (DEFAULT, 2, DEFAULT, '2018-09-10 10:00');
INSERT INTO `solarium`.`solariumbank_kabine` (`soka_id`, `soba_id`, `kab_id`, `soka_datum`) VALUES (DEFAULT, 3, 2, '2018-09-12 ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`kunde`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`kunde` (`kun_id`, `kun_nname`, `kun_vname`, `kun_geb`, `kunde_guthaben`) VALUES (DEFAULT, 'Huber', 'Franz', '1992-10-01', 235);

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`Saison`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`Saison` (`saison_id`, `saison_name`, `saison_endbetrag`, `saison_bezahlbetrag`, `saison_start`, `saison_end`) VALUES (DEFAULT, 'Sommer 2018', 125, 100, DEFAULT, DEFAULT);
INSERT INTO `solarium`.`Saison` (`saison_id`, `saison_name`, `saison_endbetrag`, `saison_bezahlbetrag`, `saison_start`, `saison_end`) VALUES (DEFAULT, 'Herbst 2018', 110, 100, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `solarium`.`Solariumblock`
-- -----------------------------------------------------
START TRANSACTION;
USE `solarium`;
INSERT INTO `solarium`.`Solariumblock` (`solariumblock_id`, `kun_id`, `saison_id`, `block_kaufdatum`) VALUES (DEFAULT, 1, 1, DEFAULT);
INSERT INTO `solarium`.`Solariumblock` (`solariumblock_id`, `kun_id`, `saison_id`, `block_kaufdatum`) VALUES (DEFAULT, 1, 2, DEFAULT);

COMMIT;

