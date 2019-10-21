-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema spiele
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `spiele` ;

-- -----------------------------------------------------
-- Schema spiele
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spiele` DEFAULT CHARACTER SET utf8 ;
USE `spiele` ;

-- -----------------------------------------------------
-- Table `spiele`.`altersfreigabe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`altersfreigabe` (
  `alt_id` INT NOT NULL AUTO_INCREMENT,
  `alt_fsk` INT NOT NULL,
  PRIMARY KEY (`alt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spielkosten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spielkosten` (
  `spn_id` INT NOT NULL AUTO_INCREMENT,
  `spn_preis` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`spn_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spiele`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spiele` (
  `spi_id` INT NOT NULL AUTO_INCREMENT,
  `spi_erscheinungsdatum` DATE NOT NULL,
  `alt_id` INT NOT NULL,
  `spn_id` INT NOT NULL,
  PRIMARY KEY (`spi_id`),
  INDEX `fk_spiele_altersfreigabe_idx` (`alt_id` ASC),
  INDEX `fk_spiele_spielkosten1_idx` (`spn_id` ASC),
  CONSTRAINT `fk_spiele_altersfreigabe`
    FOREIGN KEY (`alt_id`)
    REFERENCES `spiele`.`altersfreigabe` (`alt_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spiele_spielkosten1`
    FOREIGN KEY (`spn_id`)
    REFERENCES `spiele`.`spielkosten` (`spn_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spielkategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spielkategorie` (
  `spk_id` INT NOT NULL AUTO_INCREMENT,
  `spk_bezeichnung` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`spk_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spielversion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spielversion` (
  `spv_id` INT NOT NULL AUTO_INCREMENT,
  `spv_art` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`spv_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`land`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`land` (
  `lan_id` INT NOT NULL AUTO_INCREMENT,
  `lan_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lan_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`benutzer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`benutzer` (
  `ben_id` INT NOT NULL AUTO_INCREMENT,
  `ben_vorname` VARCHAR(45) NOT NULL,
  `ben_nachname` VARCHAR(45) NOT NULL,
  `ben_geburtsdatum` DATE NOT NULL,
  `ben_email` VARCHAR(45) NOT NULL,
  `ben_registrierdatum` DATE NOT NULL,
  `lan_id` INT NOT NULL,
  PRIMARY KEY (`ben_id`),
  INDEX `fk_benutzer_land1_idx` (`lan_id` ASC),
  CONSTRAINT `fk_benutzer_land1`
    FOREIGN KEY (`lan_id`)
    REFERENCES `spiele`.`land` (`lan_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`zahlmoeglichkeiten`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`zahlmoeglichkeiten` (
  `zam_id` INT NOT NULL AUTO_INCREMENT,
  `zam_art` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`zam_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spielekauf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spielekauf` (
  `spf_id` INT NOT NULL AUTO_INCREMENT,
  `zam_id` INT NOT NULL,
  PRIMARY KEY (`spf_id`),
  INDEX `fk_spielekauf_zahlmoeglichkeiten1_idx` (`zam_id` ASC),
  CONSTRAINT `fk_spielekauf_zahlmoeglichkeiten1`
    FOREIGN KEY (`zam_id`)
    REFERENCES `spiele`.`zahlmoeglichkeiten` (`zam_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`gutschriften`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`gutschriften` (
  `gut_id` INT NOT NULL AUTO_INCREMENT,
  `gut_art` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gut_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spiele_spielkategorie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spiele_spielkategorie` (
  `ssp_id` INT NOT NULL AUTO_INCREMENT,
  `spi_id` INT NOT NULL,
  `spk_id` INT NOT NULL,
  PRIMARY KEY (`ssp_id`),
  INDEX `fk_spiele_has_spielkategorie_spielkategorie1_idx` (`spk_id` ASC),
  INDEX `fk_spiele_has_spielkategorie_spiele1_idx` (`spi_id` ASC),
  CONSTRAINT `fk_spiele_has_spielkategorie_spiele1`
    FOREIGN KEY (`spi_id`)
    REFERENCES `spiele`.`spiele` (`spi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spiele_has_spielkategorie_spielkategorie1`
    FOREIGN KEY (`spk_id`)
    REFERENCES `spiele`.`spielkategorie` (`spk_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spiele_spielversion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spiele_spielversion` (
  `ssi_id` INT NOT NULL AUTO_INCREMENT,
  `spi_id` INT NOT NULL,
  `spv_id` INT NOT NULL,
  PRIMARY KEY (`ssi_id`),
  INDEX `fk_spiele_has_spielversion_spielversion1_idx` (`spv_id` ASC),
  INDEX `fk_spiele_has_spielversion_spiele1_idx` (`spi_id` ASC),
  CONSTRAINT `fk_spiele_has_spielversion_spiele1`
    FOREIGN KEY (`spi_id`)
    REFERENCES `spiele`.`spiele` (`spi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spiele_has_spielversion_spielversion1`
    FOREIGN KEY (`spv_id`)
    REFERENCES `spiele`.`spielversion` (`spv_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`benutzer_gutschriften`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`benutzer_gutschriften` (
  `beg_id` INT NOT NULL AUTO_INCREMENT,
  `ben_id` INT NOT NULL,
  `gut_id` INT NOT NULL,
  PRIMARY KEY (`beg_id`),
  INDEX `fk_benutzer_has_gutschriften_gutschriften1_idx` (`gut_id` ASC),
  INDEX `fk_benutzer_has_gutschriften_benutzer1_idx` (`ben_id` ASC),
  CONSTRAINT `fk_benutzer_has_gutschriften_benutzer1`
    FOREIGN KEY (`ben_id`)
    REFERENCES `spiele`.`benutzer` (`ben_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benutzer_has_gutschriften_gutschriften1`
    FOREIGN KEY (`gut_id`)
    REFERENCES `spiele`.`gutschriften` (`gut_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`spiele_spielekauf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`spiele_spielekauf` (
  `spsp_id` INT NOT NULL AUTO_INCREMENT,
  `spi_id` INT NOT NULL,
  `spf_id` INT NOT NULL,
  PRIMARY KEY (`spsp_id`),
  INDEX `fk_spiele_has_spielekauf_spielekauf1_idx` (`spf_id` ASC),
  INDEX `fk_spiele_has_spielekauf_spiele1_idx` (`spi_id` ASC),
  CONSTRAINT `fk_spiele_has_spielekauf_spiele1`
    FOREIGN KEY (`spi_id`)
    REFERENCES `spiele`.`spiele` (`spi_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_spiele_has_spielekauf_spielekauf1`
    FOREIGN KEY (`spf_id`)
    REFERENCES `spiele`.`spielekauf` (`spf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spiele`.`benutzer_spielekauf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spiele`.`benutzer_spielekauf` (
  `bes_id` INT NOT NULL AUTO_INCREMENT,
  `ben_id` INT NOT NULL,
  `spf_id` INT NOT NULL,
  PRIMARY KEY (`bes_id`),
  INDEX `fk_benutzer_has_spielekauf_spielekauf1_idx` (`spf_id` ASC),
  INDEX `fk_benutzer_has_spielekauf_benutzer1_idx` (`ben_id` ASC),
  CONSTRAINT `fk_benutzer_has_spielekauf_benutzer1`
    FOREIGN KEY (`ben_id`)
    REFERENCES `spiele`.`benutzer` (`ben_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_benutzer_has_spielekauf_spielekauf1`
    FOREIGN KEY (`spf_id`)
    REFERENCES `spiele`.`spielekauf` (`spf_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `spiele`.`altersfreigabe`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`altersfreigabe` (`alt_id`, `alt_fsk`) VALUES (DEFAULT, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spielkosten`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spielkosten` (`spn_id`, `spn_preis`) VALUES (DEFAULT, 13.99);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spiele`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spiele` (`spi_id`, `spi_erscheinungsdatum`, `alt_id`, `spn_id`) VALUES (DEFAULT, '2002-01-01', 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spielkategorie`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spielkategorie` (`spk_id`, `spk_bezeichnung`) VALUES (DEFAULT, 'Arkade');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spielversion`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spielversion` (`spv_id`, `spv_art`) VALUES (1, 'Online');
INSERT INTO `spiele`.`spielversion` (`spv_id`, `spv_art`) VALUES (2, 'Download');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`land`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`land` (`lan_id`, `lan_name`) VALUES (DEFAULT, 'Austria');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`benutzer`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`benutzer` (`ben_id`, `ben_vorname`, `ben_nachname`, `ben_geburtsdatum`, `ben_email`, `ben_registrierdatum`, `lan_id`) VALUES (DEFAULT, 'Philipp', 'Lang', '1994-11-06', 'philipp.lang@gmx.at', '2018-10-08', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`zahlmoeglichkeiten`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`zahlmoeglichkeiten` (`zam_id`, `zam_art`) VALUES (DEFAULT, 'PayPal');

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spielekauf`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spielekauf` (`spf_id`, `zam_id`) VALUES (DEFAULT, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spiele_spielkategorie`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spiele_spielkategorie` (`ssp_id`, `spi_id`, `spk_id`) VALUES (DEFAULT, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spiele_spielversion`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spiele_spielversion` (`ssi_id`, `spi_id`, `spv_id`) VALUES (DEFAULT, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`spiele_spielekauf`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`spiele_spielekauf` (`spsp_id`, `spi_id`, `spf_id`) VALUES (DEFAULT, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `spiele`.`benutzer_spielekauf`
-- -----------------------------------------------------
START TRANSACTION;
USE `spiele`;
INSERT INTO `spiele`.`benutzer_spielekauf` (`bes_id`, `ben_id`, `spf_id`) VALUES (DEFAULT, 1, 1);

COMMIT;

select *  from benutzer ben 
left outer join benutzer_spielekauf beka 
using (ben_id)
left outer join spielekauf
using (spf_id)
left outer join spiele_spielekauf
using (spf_id)
left outer join spiele spi 
using (spi_id)
left outer join spiele_spielkategorie
using (spi_id)
left outer join spielkategorie skat
using (spk_id);