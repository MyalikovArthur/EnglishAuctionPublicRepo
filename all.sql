SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Auction
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Auction` DEFAULT CHARACTER SET utf8 ;
USE `Auction` ;

-- -----------------------------------------------------
-- Table `Auction`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`users` (
  `u_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID участника аукциона.',
  `u_name` VARCHAR(45) NULL COMMENT 'Имя участника аукциона.',
  `u_level` ENUM('user', 'administrator') NULL DEFAULT 'user' COMMENT 'Уровень полномочий участника аукциона(user/administrator).',
  PRIMARY KEY (`u_id`))
ENGINE = InnoDB
COMMENT = 'Участники аукциона.';


-- -----------------------------------------------------
-- Table `Auction`.`lots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`lots` (
  `l_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID лота.',
  `l_ownerId` INT UNSIGNED NOT NULL COMMENT 'ID владельца лота.',
  `l_name` VARCHAR(45) NULL COMMENT 'Наименование лота.',
  `l_description` VARCHAR(255) NULL DEFAULT 'N/A' COMMENT 'Описание лота.',
  `l_start_time` DATETIME NULL COMMENT 'Время начала аукциона.',
  `l_step` INT NULL COMMENT 'Шаг аукциона — установленный интервал, на который Участник может увеличить ставку.',
  `l_start_price` INT NULL COMMENT 'Начальная цена — цена лота, с которой начнутся аукционные торги между Участниками аукциона.',
  PRIMARY KEY (`l_id`),
  INDEX `fk_lots_users_idx` (`l_ownerId` ASC),
  CONSTRAINT `fk_lots_users`
    FOREIGN KEY (`l_ownerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Лоты аукциона.';


-- -----------------------------------------------------
-- Table `Auction`.`bids`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`bids` (
  `b_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID ставки.',
  `b_lotId` INT UNSIGNED NOT NULL COMMENT 'ID лота на который сделана ставка.',
  `b_userId` INT UNSIGNED NOT NULL COMMENT 'ID участника сделавшего ставку.',
  `b_price` INT NULL COMMENT 'Сумма ставки.',
  PRIMARY KEY (`b_id`),
  INDEX `fk_bids_lots1_idx` (`b_lotId` ASC),
  INDEX `fk_bids_users1_idx` (`b_userId` ASC),
  CONSTRAINT `fk_bids_lots1`
    FOREIGN KEY (`b_lotId`)
    REFERENCES `Auction`.`lots` (`l_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bids_users1`
    FOREIGN KEY (`b_userId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Ставки от участников аукциона.';


-- -----------------------------------------------------
-- Table `Auction`.`lots_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`lots_archive` (
  `la_id` INT UNSIGNED NOT NULL COMMENT 'ID лота.',
  `la_ownerId` INT UNSIGNED NOT NULL COMMENT 'ID бывшего владельца лота.',
  `la_buyerId` INT UNSIGNED NOT NULL COMMENT 'ID победтеля аукциона, которому достался лот.',
  `la_name` VARCHAR(45) NULL COMMENT 'Наименование лота.',
  `la_description` VARCHAR(255) NULL DEFAULT 'N/A' COMMENT 'Описание лота.',
  `la_start_time` DATETIME NULL COMMENT 'Время начала аукциона.',
  `la_end_time` DATETIME NULL COMMENT 'Время окончания аукциона.',
  `la_step` INT NULL COMMENT 'Шаг аукциона — установленный интервал, на который Участник может увеличить ставку.',
  `la_start_price` INT NULL COMMENT 'Начальная цена — цена лота, с которой начнутся аукционные торги между Участниками аукциона.',
  `la_end_price` INT NULL COMMENT 'Конечная цена — цена, за которую был приобретен лот.',
  PRIMARY KEY (`la_id`),
  INDEX `fk_lots_users_idx` (`la_ownerId` ASC),
  INDEX `fk_lots_archive_users1_idx` (`la_buyerId` ASC),
  CONSTRAINT `fk_lots_users0`
    FOREIGN KEY (`la_ownerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lots_archive_users1`
    FOREIGN KEY (`la_buyerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Архив лотов учавстововавших в аукционе.';


-- -----------------------------------------------------
-- Table `Auction`.`reversed_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`reversed_order` (
  `ro_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID заказа.',
  `ro_buyerId` INT UNSIGNED NOT NULL COMMENT 'ID клиента сделавшего заказ.',
  `ro_name` VARCHAR(45) NULL COMMENT 'Наименование лота, на который был сделан заказ.',
  `ro_start_time` DATETIME NULL COMMENT 'Время начала аукциона.',
  `ro_step` INT NULL COMMENT 'Шаг аукциона — установленный интервал, на который Участник может увеличить ставку.',
  `ro_start_price` INT NULL COMMENT 'Начальная цена — цена лота, с которой начнутся аукционные торги между участниками аукциона.',
  INDEX `fk_lots_users_idx` (`ro_buyerId` ASC),
  CONSTRAINT `fk_lots_users1`
    FOREIGN KEY (`ro_buyerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Заказ покупателя на определенное наименование лота.';


-- -----------------------------------------------------
-- Table `Auction`.`reversed_lots`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`reversed_lots` (
  `rl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID ставки обратного аукциона.',
  `rl_orderId` INT UNSIGNED NOT NULL COMMENT 'ID заказа покупателя.',
  `rl_ownerId` INT UNSIGNED NOT NULL COMMENT 'ID владельца лота.',
  `rl_name` VARCHAR(45) NULL COMMENT 'Наименование лота.',
  `rl_descripion` VARCHAR(255) NULL COMMENT 'Описание лота.',
  PRIMARY KEY (`rl_id`),
  INDEX `fk_lots_users_idx` (`rl_ownerId` ASC),
  INDEX `fk_reversed_lots_reversed_order1_idx` (`rl_orderId` ASC),
  CONSTRAINT `fk_lots_users2`
    FOREIGN KEY (`rl_ownerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reversed_lots_reversed_order1`
    FOREIGN KEY (`rl_orderId`)
    REFERENCES `Auction`.`reversed_order` (`ro_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Лоты обратного аукциона для конкретого заказа покупателя.';


-- -----------------------------------------------------
-- Table `Auction`.`reversed_lots_archive`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Auction`.`reversed_lots_archive` (
  `rla_id` INT UNSIGNED NOT NULL COMMENT 'ID лота.',
  `rla_buyerId` INT UNSIGNED NOT NULL COMMENT 'ID клиента сделавшего заказ на лот.',
  `rla_ownerId` INT UNSIGNED NOT NULL COMMENT 'ID бывшего владельца лота.',
  `rla_name` VARCHAR(45) NULL COMMENT 'Наименование лота.',
  `rla_start_time` DATETIME NULL COMMENT 'Время начала аукциона.',
  `rla_end_time` DATETIME NULL COMMENT 'Время окончания аукциона.',
  `rla_step` INT NULL COMMENT 'Шаг аукциона — установленный интервал, на который Участник может увеличить ставку.',
  `rla_start_price` INT NULL COMMENT 'Начальная цена — цена лота, с которой начнутся аукционные торги между участниками аукциона.',
  `rla_end_price` INT NULL COMMENT 'Конечная цена — цена, за которую был приобретен лот.',
  PRIMARY KEY (`rla_id`),
  INDEX `fk_lots_users_idx` (`rla_buyerId` ASC),
  INDEX `fk_reversed_lots_archive_users1_idx` (`rla_ownerId` ASC),
  CONSTRAINT `fk_lots_users10`
    FOREIGN KEY (`rla_buyerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reversed_lots_archive_users1`
    FOREIGN KEY (`rla_ownerId`)
    REFERENCES `Auction`.`users` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Архив проданных лотов в обратном аукционе.';


--
-- Dumping data for table `users`
--
LOCK TABLES `users` WRITE;
INSERT INTO `users` VALUES 
(0,'mao_admin','administrator','Myalikov','Arthur','artur.mialikau@gmail.com','$2a$17$hykWGwCoamsuW27dl.B2zeFd4X2UNI7gxQNfCNOsJx3ethLNDqc3C',375004698821),
(1,'NanniePoole2008','user','Poole','Nannie','NanniePoole2008@gmail.com','$2a$17$U41amXycEzF9WaNU3vEtf.hfah0LKBjV3j4Y7/5A/u1GEitPEgVsy',375001115589),
(2,'Lucky18','user','McCormick','Cynthia','Lucky18@gmail.com','$2a$17$GL9tvPCiYlJxVxHwpzEhM.Uxs3NmUsflghwGKdt8hFpw/b4FpW34K',375009975551),
(3,'ErrrWilll','user','Williams','Erik','ErrrWilll@gmail.com','$2a$17$Xk0JFEKJb0C8f5.HqFgHeeFsyJd//RD0a2TGLmaT6N.Coypec.8hS',375001235870),
(4,'Cameron123','user','Barton','Cameron','Cameron123@yandex.ru','$2a$17$esDvtQxZ/mMKcYQtfdS8W.8pOzNBBfGTEubVv52zHPO.m3DblVz9e',375004589512),
(5,'LilTeresa','user','Moore','Teresa','LilTeresa@gmail.com','$2a$17$ArIeD5zwdIt8tFdKGIu8Xu5JXzAZKzUvGFvsBX8j1r9gK6haUoGyq',375004564954),
(6,'PalmerA','user','Amelia','Palmer','PalmerA@vivaldi.net','$2a$17$172FqTq5.N4rNQgkWNP8c.PYKeSERgtE3S0oW3LC2zr6CNNsiJAmu',375002546823),
(7,'Lewis12','user','Lewis','Ronald','Lewis12@gmail.com','$2a$17$tn/IJ2QjJhn.BpU.5trje.Xz3yYa37WPTVhSmcm.FvdhFAJVx.P2q',375005454664),
(8,'CastroBaseball2012','administrator','Castro','Michael','CastroBaseball2012@gmail.com','$2a$17$90OPIQMUf2ez9QmmDVdszuYsrHd5HUrcxPRcvuVnjjmYYT59sIM6O',375004291034),
(9,'CraigTheWinder','user','Bowen','Craig','CraigTheWinder@gmail.com','$2a$17$GL1OOraXQ.ljxUC3qyJSGu2HUhNiQjhyiKXAwLuqkzYiiFuL8.0MG',375005468792),
(10,'Perturbator','user','Drake','Clifford','Perturbator@yandex.ru','$2a$17$.sj2NRZnf1bTvV.laoo6Uuc7Te1uKbUaFJn.LAXRb9ZHypCSD3TjW',375001125533),
(11,'Schrodinger','user','Holmes','Bernard','Schrodinger@vivaldi.net','$2a$17$CNBZAbyezhbCWObXn3qYJezdLf.XL4Bom5sCfmlJ/UGJZk1/SgJXe',375001234567),
(12,'Hanson228','user','Hanson','Christian','Hanson228@mail.ru','$2a$17$e430PPFiUXNEvhMtfjwiWeuK/De4qmlA1q61xg43Pfv/bk3RwF.Mm',375002424579),
(13,'Skywalker2002','user','McCarthy','Derek','Skywalker2002@gmail.com','$2a$17$IyKhmEA8jne0jFzi7.uR6eSfz1807bX3xzpFaNTtMGTIYMyiQZ6D6',375002223548),
(14,'Ozzy13','user','Osborne','Melvin','Ozzy13@gmail.com','$2a$17$DeQyfNFa9hylKJYOPNMBiuEOPC/PEUbdWn6Kr9yfarS2CsW9orjGq',375001295554),
(15,'Beylor007','user','Taylor','Bessie','Beylor007@yandex.by','$2a$17$8RzA/8TIP3LrRmbn/JgiR.Q6aCHEkrPj59cI2hnb/UyasuzXMdWma',375005466897),
(16,'Einstein69','user','Wallace','Carrie','Einstein69@gmail.com','$2a$17$any437W2jTJjRPJlV2M6g.BDVoBAWIAL06j6tCok34Tmuy5NIQt8O',375002424796),
(17,'Google100','user','McCoy','Carlos','Google100@yandex.ru','$2a$17$2xVT/uSr3Fhu7pNRNJvxTOdehSaoSSqO3227gf0MLDgt7oTc4a442',375003864546),
(18,'LightFighter2018','user','Chambers','Alexander','LightFighter2018@vivaldi.net','$2a$17$.WGLnlBSfsbDVGw875afsO6dhSQRwn5dX70ZZHsDyc3y.smhmxhaa',375001321321),
(19,'Pinky8','user','Floyd','Alex','Pinky8@gmail.com','$2a$17$rk2n2rmhB1W5mCKBtTagDuTil3R8UchiJpUCuErL2tX9N7GAYrOwe',375005895891),
(20,'iNowDeWei','user','Jefferson','Max','iNowDeWei@hotmail.com','$2a$17$QfDXnEqW/dTBLAeRGnwUDuhmwRN7x5Rm5tOPhWFAif3ZTjL.ieGYi',375009243451);
UNLOCK TABLES;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
