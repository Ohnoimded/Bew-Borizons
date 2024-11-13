CREATE DATABASE  IF NOT EXISTS `waib` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `waib`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: waib
-- ------------------------------------------------------
-- Server version	8.1.0

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

--
-- Table structure for table `entitiesmaster`
--

DROP TABLE IF EXISTS `entitiesmaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entitiesmaster` (
  `id` int NOT NULL AUTO_INCREMENT,
  `concert_title` varchar(255) NOT NULL,
  `concert_info` json NOT NULL DEFAULT (_utf8mb3'{}'),
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `EntitiesMaster_url_d0e2fedd_uniq` (`url`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entitiesmaster`
--

LOCK TABLES `entitiesmaster` WRITE;
/*!40000 ALTER TABLE `entitiesmaster` DISABLE KEYS */;
INSERT INTO `entitiesmaster` VALUES (1,' Salonen Conducts Brahms 4','{\"artists\": [{\"name\": \"Esa-Pekka Salonen\", \"role\": \"Conductor\"}, {\"name\": \"Sayaka Shoji\", \"role\": \"Violin\"}, {\"name\": \"San Francisco Symphony\", \"role\": \"\"}], \"programs\": [{\"piece\": \"Violin Concerto No. 1\", \"composer\": \"Dmitri Shostakovich\"}, {\"piece\": \"Symphony No. 4\", \"composer\": \"Johannes Brahms\"}], \"performances\": [{\"dow\": \"Friday\", \"date\": \"04/10/2024\", \"time\": \"7:30PM\", \"venue\": \"Davies Symphony Hall\"}, {\"dow\": \"Saturday\", \"date\": \"05/10/2024\", \"time\": \"7:30PM\", \"venue\": \"Davies Symphony Hall\"}, {\"dow\": \"Sunday\", \"date\": \"06/10/2024\", \"time\": \"2:00PM\", \"venue\": \"Davies Symphony Hall\"}]}','https://www.sfsymphony.org/Buy-Tickets/2024-25/salonen-brahms4'),(3,' Wilkins Conducts Rhapsody In Blue','{\"artists\": [{\"name\": \"Thomas Wilkins\", \"role\": \"Conductor\"}, {\"name\": \"Michelle Cann\", \"role\": \"Piano\"}, {\"name\": \"San Francisco Symphony\", \"role\": \"\"}], \"programs\": [{\"piece\": \"Suite from Candide \", \"composer\": \"Leonard Bernstein\"}, {\"piece\": \"Rhapsody in Blue\", \"composer\": \"George Gershwin\"}, {\"piece\": \"Wood Notes [First SF Symphony Performances]\", \"composer\": \"William Grant Still\"}, {\"piece\": \"Porgy and Bess, A Symphonic Picture\", \"composer\": \"George Gershwin\"}], \"performances\": [{\"dow\": \"Friday\", \"date\": \"25/10/2024\", \"time\": \"7:30PM\", \"venue\": \"Davies Symphony Hall\"}, {\"dow\": \"Saturday\", \"date\": \"26/10/2024\", \"time\": \"7:30PM\", \"venue\": \"Davies Symphony Hall\"}]}','https://www.sfsymphony.org/Buy-Tickets/2024-25/Rhapsody-in-Blue');
/*!40000 ALTER TABLE `entitiesmaster` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-27 10:20:02
