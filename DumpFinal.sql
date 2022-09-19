CREATE DATABASE  IF NOT EXISTS `Auctions` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `Auctions`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: Auctions
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

CREATE DATABASE IF NOT EXISTS Auctions;
USE Auctions;



DROP TABLE IF EXISTS `account`;
CREATE TABLE account(
`name` varchar(30) NOT NULL,
`UserID` varchar(30) NOT NULL,
`password` varchar(30) NOT NULL,
`email` varchar(100) NOT NULL,
`account_type` varchar(30) default NULL,
primary key(`UserID`));

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `UserID` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `account` (`UserID`)
);






INSERT INTO admin (UserID, password)
VALUES ('Admin', 'Admin129');




DROP TABLE IF EXISTS `customerrep`;
CREATE TABLE `customerrep` (
  `UserID` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`UserID`),
  CONSTRAINT `customerrep_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `account` (`UserID`)
);

INSERT INTO customerrep (UserID, password)
VALUES ('rep1', 'rep129');


DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(50) DEFAULT NULL,
  `brand` varchar(25) DEFAULT NULL,
  `color` varchar(20) DEFAULT NULL,
  `year` varchar(20) DEFAULT NULL,
  `seller` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `seller` (`seller`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`seller`) REFERENCES `account` (`UserID`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `alerts`;
CREATE TABLE `alerts` (
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `UserID` varchar(50) DEFAULT NULL,
  `alert_message` varchar(1000) DEFAULT NULL,
  `product_id` int DEFAULT '0',
  `auction_id` int DEFAULT '0',
  PRIMARY KEY (`alert_id`),
  KEY `UserID` (`UserID`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `account` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `alerts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `UserID` varchar(50) DEFAULT NULL,
  `customerrep_username` varchar(50) DEFAULT NULL,
  `question` varchar(250) DEFAULT NULL,
  `answer` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `UserID` (`UserID`),
  KEY `customerrep_username` (`customerrep_username`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `account` (`UserID`) ON DELETE CASCADE,
  CONSTRAINT `questions_ibfk_2` FOREIGN KEY (`customerrep_username`) REFERENCES `customerrep` (`UserID`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `bid`;
CREATE TABLE `bid` (
  `bid_id` int NOT NULL AUTO_INCREMENT,
  `buyer` varchar(50) DEFAULT NULL,
  `upper_limit` float DEFAULT '0',
  `is_autobid` tinyint(1) DEFAULT '0',
  `bid_increment` float DEFAULT '0',
  `amount` float DEFAULT '0',
  `auction_id` int DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `buyer` (`buyer`),
  KEY `auction_id` (`auction_id`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`buyer`) REFERENCES `account` (`UserID`),
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`auction_id`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `auction`;
CREATE TABLE `auction` (
  `auction_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `seller` varchar(50) DEFAULT NULL,
  `new_bid_increment` float DEFAULT '1',
  `min_price` float DEFAULT '0',
  `price` float DEFAULT '0',
  `status` varchar(10) DEFAULT NULL,
  `start_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `end_date` datetime DEFAULT NULL,
  `winner` varchar(20) DEFAULT NULL,
  `current_bid` float DEFAULT '0',
  PRIMARY KEY (`auction_id`),
  KEY `seller` (`seller`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`seller`) REFERENCES `product` (`seller`) ON DELETE CASCADE,
  CONSTRAINT `auction_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Dump completed on 2022-05-09  0:21:53
