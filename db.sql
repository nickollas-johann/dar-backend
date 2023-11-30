CREATE SCHEMA IF NOT EXISTS `farm_db` DEFAULT CHARACTER SET utf8;
USE `farm_db`;

CREATE TABLE `user_table` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `user_type` varchar(255) NOT NULL,
  `user_cel` varchar(255) NOT NULL,
  `user_crea` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB;

CREATE TABLE `lands_table` (
  `lands_id` int NOT NULL AUTO_INCREMENT,
  `lands_size` decimal(4,2) NOT NULL,
  `location` varchar(255) NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`lands_id`),
  KEY `user_fk` (`user_id`)
) ENGINE=InnoDB;

CREATE TABLE `culture_table` (
  `culture_id` int NOT NULL AUTO_INCREMENT,
  `culture_name` varchar(255) NOT NULL,
  `culture_start` datetime NOT NULL,
  `estimated_time` datetime NOT NULL,
  `lands_id` int DEFAULT NULL,
  `culture_discription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`culture_id`),
  KEY `land_fk` (`lands_id`),
  CONSTRAINT `land_fk` FOREIGN KEY (`lands_id`) REFERENCES `lands_table` (`lands_id`)
) ENGINE=InnoDB;

CREATE TABLE `orders_table` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `order_done` tinyint NOT NULL,
  `user_id` int NOT NULL,
  `professional_id` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_fk_order` (`user_id`),
  CONSTRAINT `user_fk_order` FOREIGN KEY (`user_id`) REFERENCES `user_table` (`user_id`),
  CONSTRAINT `user_fk_orders` FOREIGN KEY (`user_id`) REFERENCES `user_table` (`user_id`)
) ENGINE=InnoDB;