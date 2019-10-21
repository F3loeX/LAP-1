-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema PRAXIS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `PRAXIS` ;

-- -----------------------------------------------------
-- Schema PRAXIS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `PRAXIS` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `PRAXIS` ;

-- -----------------------------------------------------
-- Table `PRAXIS`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRAXIS`.`patient` (
  `pat_id` INT NOT NULL AUTO_INCREMENT,
  `pat_svn_4` CHAR(4) NOT NULL,
  `pat_gebDatum` DATE NOT NULL,
  `pat_vName` VARCHAR(45) NOT NULL,
  `pat_nName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pat_id`),
  UNIQUE (`pat_svn_4`,`pat_gebDatum`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PRAXIS`.`krankheit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRAXIS`.`krankheit` (
  `kra_id` INT NOT NULL AUTO_INCREMENT,
  `kra_name1` VARCHAR(45) NOT NULL,
  `kra_name2` VARCHAR(45) NULL,
  PRIMARY KEY (`kra_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PRAXIS`.`patient_krankheit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRAXIS`.`patient_krankheit` (
  `paka_id` INT NOT NULL AUTO_INCREMENT,
  `pat_id` INT NOT NULL,
  `kra_id` INT NOT NULL,
  `pakr_diagnose_datum` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  INDEX `fk_patient_has_krankheit_krankheit1_idx` (`kra_id` ASC),
  INDEX `fk_patient_has_krankheit_patient_idx` (`pat_id` ASC),
  PRIMARY KEY (`paka_id`),
  CONSTRAINT `fk_patient_has_krankheit_patient`
    FOREIGN KEY (`pat_id`)
    REFERENCES `PRAXIS`.`patient` (`pat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_patient_has_krankheit_krankheit1`
    FOREIGN KEY (`kra_id`)
    REFERENCES `PRAXIS`.`krankheit` (`kra_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `PRAXIS`.`patient`
-- -----------------------------------------------------
START TRANSACTION;
USE `PRAXIS`;
INSERT INTO `PRAXIS`.`patient` (`pat_id`, `pat_svn_4`, `pat_gebDatum`, `pat_vName`, `pat_nName`) VALUES (NULL, '1919', '2000-01-01', 'Karla', 'Neubaum');
INSERT INTO `PRAXIS`.`patient` (`pat_id`, `pat_svn_4`, `pat_gebDatum`, `pat_vName`, `pat_nName`) VALUES (NULL, '3523', '1990-05-30', 'Marvin', 'Kline');
INSERT INTO `PRAXIS`.`patient` (`pat_id`, `pat_svn_4`, `pat_gebDatum`, `pat_vName`, `pat_nName`) VALUES (NULL, '4564', '1995-08-22', 'Martha', 'Baum');
INSERT INTO `PRAXIS`.`patient` (`pat_id`, `pat_svn_4`, `pat_gebDatum`, `pat_vName`, `pat_nName`) VALUES (NULL, '9673', '1985-10-05', 'Max', 'Mustermann');
INSERT INTO `PRAXIS`.`patient` (`pat_id`, `pat_svn_4`, `pat_gebDatum`, `pat_vName`, `pat_nName`) VALUES (NULL, '9934', '1985-04-05', 'Gustav', 'Gustav');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PRAXIS`.`krankheit`
-- -----------------------------------------------------
START TRANSACTION;
USE `PRAXIS`;
INSERT INTO `PRAXIS`.`krankheit` (`kra_id`, `kra_name1`, `kra_name2`) VALUES (NULL, 'Asthma', 'bronchiale');
INSERT INTO `PRAXIS`.`krankheit` (`kra_id`, `kra_name1`, `kra_name2`) VALUES (NULL, 'Grippe', 'Influenza');

COMMIT;


-- -----------------------------------------------------
-- Data for table `PRAXIS`.`patient_krankheit`
-- -----------------------------------------------------
START TRANSACTION;
USE `PRAXIS`;
INSERT INTO `PRAXIS`.`patient_krankheit` (`paka_id`, `pat_id`, `kra_id`, `pakr_diagnose_datum`) VALUES (NULL, 1, 2, NULL);
INSERT INTO `PRAXIS`.`patient_krankheit` (`paka_id`, `pat_id`, `kra_id`, `pakr_diagnose_datum`) VALUES (NULL, 2, 1, NULL);
INSERT INTO `PRAXIS`.`patient_krankheit` (`paka_id`, `pat_id`, `kra_id`, `pakr_diagnose_datum`) VALUES (NULL, 3, 1, NULL);

COMMIT;

