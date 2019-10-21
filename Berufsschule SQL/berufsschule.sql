-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema berufsschule
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `berufsschule` ;

-- -----------------------------------------------------
-- Schema berufsschule
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `berufsschule` ;
USE `berufsschule` ;

-- -----------------------------------------------------
-- Table `berufsschule`.`lehrberuf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`lehrberuf` (
  `lb_id` INT NOT NULL AUTO_INCREMENT,
  `lb_bezeichnung` VARCHAR(45) NOT NULL,
  `lb_kurz` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`lb_id`),
  UNIQUE INDEX `bezeichnung_UNIQUE` (`lb_bezeichnung` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `berufsschule`.`JOB`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`JOB` (
  `job_id` INT NOT NULL AUTO_INCREMENT,
  `job_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`job_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `berufsschule`.`PERSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`PERSON` (
  `pe_id` INT NOT NULL AUTO_INCREMENT,
  `pe_vname` VARCHAR(45) NOT NULL,
  `pe_nname` VARCHAR(45) NOT NULL,
  `job_id` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`pe_id`),
  INDEX `fk_PERSON_JOB1_idx` (`job_id` ASC),
  CONSTRAINT `fk_PERSON_JOB1`
    FOREIGN KEY (`job_id`)
    REFERENCES `berufsschule`.`JOB` (`job_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `berufsschule`.`bs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`bs` (
  `bs_id` INT NOT NULL AUTO_INCREMENT,
  `bs_ort` VARCHAR(45) NOT NULL,
  `bs_zusatz` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`bs_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `berufsschule`.`bs_lehrberuf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`bs_lehrberuf` (
  `bs_id` INT NOT NULL,
  `lb_id` INT NOT NULL,
  PRIMARY KEY (`bs_id`, `lb_id`),
  INDEX `fk_bs_has_lehrberuf_lehrberuf1_idx` (`lb_id` ASC),
  INDEX `fk_bs_has_lehrberuf_bs_idx` (`bs_id` ASC),
  CONSTRAINT `fk_bs_has_lehrberuf_bs`
    FOREIGN KEY (`bs_id`)
    REFERENCES `berufsschule`.`bs` (`bs_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bs_has_lehrberuf_lehrberuf1`
    FOREIGN KEY (`lb_id`)
    REFERENCES `berufsschule`.`lehrberuf` (`lb_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `berufsschule`.`person_lehrberuf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `berufsschule`.`person_lehrberuf` (
  `pe_id` INT NOT NULL,
  `bs_id` INT NOT NULL,
  `lb_id` INT NOT NULL,
  `pele_von` DATE NOT NULL,
  `pele_bis` DATE NOT NULL,
  INDEX `fk_person_has_bs_has_lehrberuf_bs_has_lehrberuf1_idx` (`bs_id` ASC, `lb_id` ASC),
  INDEX `fk_person_has_bs_has_lehrberuf_person1_idx` (`pe_id` ASC),
  PRIMARY KEY (`pe_id`, `bs_id`, `lb_id`),
  CONSTRAINT `fk_person_has_bs_has_lehrberuf_person1`
    FOREIGN KEY (`pe_id`)
    REFERENCES `berufsschule`.`PERSON` (`pe_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_person_has_bs_has_lehrberuf_bs_has_lehrberuf1`
    FOREIGN KEY (`bs_id` , `lb_id`)
    REFERENCES `berufsschule`.`bs_lehrberuf` (`bs_id` , `lb_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `berufsschule`.`lehrberuf`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`lehrberuf` (`lb_id`, `lb_bezeichnung`, `lb_kurz`) VALUES (NULL, 'Informationstechnologie Informatik', 'ITI');
INSERT INTO `berufsschule`.`lehrberuf` (`lb_id`, `lb_bezeichnung`, `lb_kurz`) VALUES (NULL, 'Informationstechnologie Technik', 'ITT');
INSERT INTO `berufsschule`.`lehrberuf` (`lb_id`, `lb_bezeichnung`, `lb_kurz`) VALUES (NULL, 'Hafner', 'HAF');
INSERT INTO `berufsschule`.`lehrberuf` (`lb_id`, `lb_bezeichnung`, `lb_kurz`) VALUES (NULL, 'Rauchfangkehrer', 'RFK');
INSERT INTO `berufsschule`.`lehrberuf` (`lb_id`, `lb_bezeichnung`, `lb_kurz`) VALUES (NULL, 'Lackierer', 'LAC');

COMMIT;


-- -----------------------------------------------------
-- Data for table `berufsschule`.`JOB`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`JOB` (`job_id`, `job_name`) VALUES (NULL, 'Schüler');
INSERT INTO `berufsschule`.`JOB` (`job_id`, `job_name`) VALUES (NULL, 'Lehrer');
INSERT INTO `berufsschule`.`JOB` (`job_id`, `job_name`) VALUES (NULL, 'Direktor');

COMMIT;


-- -----------------------------------------------------
-- Data for table `berufsschule`.`PERSON`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`PERSON` (`pe_id`, `pe_vname`, `pe_nname`, `job_id`) VALUES (NULL, 'Martha', 'Klein', 1);
INSERT INTO `berufsschule`.`PERSON` (`pe_id`, `pe_vname`, `pe_nname`, `job_id`) VALUES (NULL, 'Franz', 'Huber', 1);
INSERT INTO `berufsschule`.`PERSON` (`pe_id`, `pe_vname`, `pe_nname`, `job_id`) VALUES (NULL, 'Martin', 'Eilig', 1);
INSERT INTO `berufsschule`.`PERSON` (`pe_id`, `pe_vname`, `pe_nname`, `job_id`) VALUES (NULL, 'Irene', 'Stabil', 1);
INSERT INTO `berufsschule`.`PERSON` (`pe_id`, `pe_vname`, `pe_nname`, `job_id`) VALUES (NULL, 'Thomas', 'Klar', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `berufsschule`.`bs`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`bs` (`bs_id`, `bs_ort`, `bs_zusatz`) VALUES (NULL, 'Linz', 'BS 2');
INSERT INTO `berufsschule`.`bs` (`bs_id`, `bs_ort`, `bs_zusatz`) VALUES (NULL, 'Wels', 'BS 1');
INSERT INTO `berufsschule`.`bs` (`bs_id`, `bs_ort`, `bs_zusatz`) VALUES (NULL, 'Wels', 'BS 2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `berufsschule`.`bs_lehrberuf`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`bs_lehrberuf` (`bs_id`, `lb_id`) VALUES (1, 1);
INSERT INTO `berufsschule`.`bs_lehrberuf` (`bs_id`, `lb_id`) VALUES (1, 2);
INSERT INTO `berufsschule`.`bs_lehrberuf` (`bs_id`, `lb_id`) VALUES (1, 3);
INSERT INTO `berufsschule`.`bs_lehrberuf` (`bs_id`, `lb_id`) VALUES (2, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `berufsschule`.`person_lehrberuf`
-- -----------------------------------------------------
START TRANSACTION;
USE `berufsschule`;
INSERT INTO `berufsschule`.`person_lehrberuf` (`pe_id`, `bs_id`, `lb_id`, `pele_von`, `pele_bis`) VALUES (1, 1, 1, '2007-09-01', '2011-06-30');
INSERT INTO `berufsschule`.`person_lehrberuf` (`pe_id`, `bs_id`, `lb_id`, `pele_von`, `pele_bis`) VALUES (2, 1, 3, '2007-09-01', '2011-06-30');
INSERT INTO `berufsschule`.`person_lehrberuf` (`pe_id`, `bs_id`, `lb_id`, `pele_von`, `pele_bis`) VALUES (3, 1, 1, '2007-09-01', '2011-06-30');

COMMIT;

