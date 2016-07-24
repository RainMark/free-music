-- MySQL Script generated by MySQL Workbench
-- Monday, May 23, 2016 PM09:18:06 HKT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema free_music
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `free_music` ;

-- -----------------------------------------------------
-- Schema free_music
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `free_music` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `free_music` ;

-- -----------------------------------------------------
-- Table `free_music`.`singer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `free_music`.`singer` ;

CREATE TABLE IF NOT EXISTS `free_music`.`singer` (
  `singer_id` CHAR(10) NOT NULL,
  `singer_name` VARCHAR(512) NOT NULL,
  `singer_national` VARCHAR(128) NULL,
  `singer_age` INT NULL,
  `singer_height` FLOAT NULL,
  `singer_weight` FLOAT NULL,
  PRIMARY KEY (`singer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `free_music`.`song`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `free_music`.`song` ;

CREATE TABLE IF NOT EXISTS `free_music`.`song` (
  `song_id` CHAR(10) NULL,
  `song_name` VARCHAR(512) NOT NULL,
  `song_path` VARCHAR(512) NULL,
  `song_ftype` VARCHAR(45) NULL,
  `song_style` VARCHAR(45) NULL,
  `song_singer` CHAR(10) NULL,
  PRIMARY KEY (`song_id`),
  INDEX `song_singer_idx` (`song_singer` ASC),
  CONSTRAINT `song_singer`
    FOREIGN KEY (`song_singer`)
    REFERENCES `free_music`.`singer` (`singer_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `free_music`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `free_music`.`user` ;

CREATE TABLE IF NOT EXISTS `free_music`.`user` (
  `user_id` CHAR(10) NOT NULL,
  `user_passwd` VARCHAR(128) NOT NULL,
  `user_nick` VARCHAR(512) NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `free_music`.`list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `free_music`.`list` ;

CREATE TABLE IF NOT EXISTS `free_music`.`list` (
  `list_id` CHAR(10) NOT NULL,
  `list_name` VARCHAR(512) NOT NULL,
  `owner_id` CHAR(10) NULL,
  PRIMARY KEY (`list_id`),
  INDEX `ower_id_idx` (`owner_id` ASC),
  CONSTRAINT `ower_id`
    FOREIGN KEY (`owner_id`)
    REFERENCES `free_music`.`user` (`user_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `free_music`.`songs_of_lists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `free_music`.`songs_of_lists` ;

CREATE TABLE IF NOT EXISTS `free_music`.`songs_of_lists` (
  `list_id` CHAR(10) NOT NULL,
  `song_id` CHAR(10) NOT NULL,
  PRIMARY KEY (`list_id`, `song_id`),
  INDEX `song_id_idx` (`song_id` ASC),
  CONSTRAINT `list_id`
    FOREIGN KEY (`list_id`)
    REFERENCES `free_music`.`list` (`list_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `song_id`
    FOREIGN KEY (`song_id`)
    REFERENCES `free_music`.`song` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
