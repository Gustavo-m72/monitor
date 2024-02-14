-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`system`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`system` (
  `IP` VARCHAR(30) NOT NULL,
  `ram` VARCHAR(45) NOT NULL,
  `cpu` VARCHAR(45) NOT NULL,
  `disco` VARCHAR(45) NOT NULL,
  `systemdate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`process`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`process` (
  `process` VARCHAR(40) NOT NULL,
  `system_IP` VARCHAR(30) NOT NULL,
  `systemdate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`process`),
  INDEX `fk_process_system_idx` (`system_IP` ASC) VISIBLE,
  CONSTRAINT `fk_process_system`
    FOREIGN KEY (`system_IP`)
    REFERENCES `mydb`.`system` (`IP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
