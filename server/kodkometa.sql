-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: kodkometa
-- ------------------------------------------------------
-- Server version	9.7.0

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '656a15e3-49f7-11f1-be39-d8bbc100dace:1-364';

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,'HTML'),(2,'CSS'),(3,'JavaScript'),(4,'TypeScript'),(5,'React'),(6,'Vue.js'),(7,'Angular');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `topics`
--

DROP TABLE IF EXISTS `topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `topics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `topic_order` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `topics`
--

LOCK TABLES `topics` WRITE;
/*!40000 ALTER TABLE `topics` DISABLE KEYS */;
INSERT INTO `topics` VALUES (1,1,'Основы',1),(2,1,'Метаинформация',2),(3,1,'Семантика',3),(4,1,'Формы и ввод данных',4),(5,1,'Медиаконтент',5),(6,1,'Таблицы',6),(7,1,'Списки',7),(8,1,'Ссылки',8),(9,1,'Доступность',9),(10,1,'Оптимизация и SEO',10),(11,1,'Расширенные возможности',11),(12,1,'Инструменты и валидация',12),(13,1,'Совместимость и стандарты',13);
/*!40000 ALTER TABLE `topics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_progress`
--

DROP TABLE IF EXISTS `user_progress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `topic_id` int NOT NULL,
  `completed` tinyint(1) DEFAULT '0',
  `unlocked` tinyint(1) DEFAULT '0',
  `completed_at` timestamp NULL DEFAULT NULL,
  `course` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `topic_id` (`topic_id`),
  CONSTRAINT `user_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_progress_ibfk_2` FOREIGN KEY (`topic_id`) REFERENCES `topics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_progress`
--

LOCK TABLES `user_progress` WRITE;
/*!40000 ALTER TABLE `user_progress` DISABLE KEYS */;
INSERT INTO `user_progress` VALUES (1,1,1,1,1,'2026-05-08 06:59:44','html'),(2,1,2,0,1,NULL,'html'),(3,1,1,1,1,'2026-05-08 07:23:10','html'),(4,1,2,0,1,NULL,'html'),(5,1,1,1,1,'2026-05-08 07:23:23','html'),(6,1,2,0,1,NULL,'html'),(19,1,8,0,1,NULL,'html'),(20,1,9,0,1,NULL,'html'),(21,1,10,0,1,NULL,'html'),(22,1,11,0,1,NULL,'html'),(23,1,12,0,1,NULL,'html'),(24,2,1,0,1,NULL,'html'),(25,2,2,0,0,NULL,'html'),(26,2,3,0,0,NULL,'html'),(27,2,4,0,0,NULL,'html'),(28,2,5,0,0,NULL,'html'),(29,2,6,0,0,NULL,'html'),(30,2,7,0,0,NULL,'html'),(31,2,8,0,0,NULL,'html'),(32,2,9,0,0,NULL,'html'),(33,2,10,0,0,NULL,'html'),(34,2,11,0,0,NULL,'html'),(35,2,12,0,0,NULL,'html'),(36,2,13,0,0,NULL,'html'),(37,3,1,1,1,NULL,'html'),(38,3,2,1,1,NULL,'html'),(39,3,3,1,1,NULL,'html'),(40,3,4,0,1,NULL,'html'),(41,3,5,0,0,NULL,'html'),(42,3,6,0,0,NULL,'html'),(43,3,7,0,0,NULL,'html'),(44,3,8,0,0,NULL,'html'),(45,3,9,0,0,NULL,'html'),(46,3,10,0,0,NULL,'html'),(47,3,11,0,0,NULL,'html'),(48,3,12,0,0,NULL,'html'),(49,3,13,0,0,NULL,'html'),(50,1,1,0,1,NULL,'css'),(51,1,2,0,0,NULL,'css'),(52,1,3,0,0,NULL,'css'),(53,1,4,0,0,NULL,'css'),(54,1,5,0,0,NULL,'css'),(55,1,6,0,0,NULL,'css'),(56,1,7,0,0,NULL,'css'),(57,1,8,0,0,NULL,'css'),(58,1,9,0,0,NULL,'css'),(59,1,10,0,0,NULL,'css'),(60,1,11,0,0,NULL,'css'),(61,1,12,0,0,NULL,'css'),(62,1,13,0,0,NULL,'css'),(63,3,1,1,1,'2026-05-12 06:39:35','css'),(64,3,2,0,1,NULL,'css'),(65,3,3,0,0,NULL,'css'),(66,3,4,0,0,NULL,'css'),(67,3,5,0,0,NULL,'css'),(68,3,6,0,0,NULL,'css'),(69,3,7,0,0,NULL,'css'),(70,3,8,0,0,NULL,'css'),(71,3,9,0,0,NULL,'css'),(72,3,10,0,0,NULL,'css'),(73,3,11,0,0,NULL,'css'),(74,3,12,0,0,NULL,'css'),(75,3,13,0,0,NULL,'css'),(76,3,1,1,1,'2026-05-12 06:39:23','js'),(77,3,2,0,1,NULL,'js'),(78,3,3,0,1,NULL,'js'),(79,3,4,0,0,NULL,'js'),(80,3,5,0,0,NULL,'js'),(81,3,6,0,0,NULL,'js'),(82,3,7,0,0,NULL,'js'),(83,3,8,0,0,NULL,'js'),(84,3,9,0,0,NULL,'js'),(85,3,10,0,0,NULL,'js'),(86,3,11,0,0,NULL,'js'),(87,3,12,0,0,NULL,'js'),(88,3,13,0,0,NULL,'js'),(89,3,1,1,1,'2026-05-12 06:39:23','js'),(90,3,2,0,1,NULL,'js'),(91,3,3,0,1,NULL,'js'),(92,3,4,0,0,NULL,'js'),(93,3,5,0,0,NULL,'js'),(94,3,6,0,0,NULL,'js'),(95,3,7,0,0,NULL,'js'),(96,3,8,0,0,NULL,'js'),(97,3,9,0,0,NULL,'js'),(98,3,10,0,0,NULL,'js'),(99,3,11,0,0,NULL,'js'),(100,3,12,0,0,NULL,'js'),(101,3,13,0,0,NULL,'js'),(102,3,1,1,1,'2026-05-12 06:39:23','js'),(103,3,2,0,1,NULL,'js'),(104,3,3,0,1,NULL,'js'),(105,3,4,0,0,NULL,'js'),(106,3,5,0,0,NULL,'js'),(107,3,6,0,0,NULL,'js'),(108,3,7,0,0,NULL,'js'),(109,3,8,0,0,NULL,'js'),(110,3,9,0,0,NULL,'js'),(111,3,10,0,0,NULL,'js'),(112,3,11,0,0,NULL,'js'),(113,3,12,0,0,NULL,'js'),(114,3,13,0,0,NULL,'js'),(115,3,1,1,1,'2026-05-12 06:39:23','js'),(116,3,2,0,1,NULL,'js'),(117,3,3,0,1,NULL,'js'),(118,3,4,0,0,NULL,'js'),(119,3,5,0,0,NULL,'js'),(120,3,6,0,0,NULL,'js'),(121,3,7,0,0,NULL,'js'),(122,3,8,0,0,NULL,'js'),(123,3,9,0,0,NULL,'js'),(124,3,10,0,0,NULL,'js'),(125,3,11,0,0,NULL,'js'),(126,3,12,0,0,NULL,'js'),(127,3,13,0,0,NULL,'js'),(128,3,1,1,1,'2026-05-12 08:51:38','ts'),(129,3,2,0,1,NULL,'ts'),(130,3,3,0,0,NULL,'ts'),(131,3,4,0,0,NULL,'ts'),(132,3,5,0,0,NULL,'ts'),(133,3,6,0,0,NULL,'ts'),(134,3,7,0,0,NULL,'ts'),(135,3,8,0,0,NULL,'ts'),(136,3,9,0,0,NULL,'ts'),(137,3,10,0,0,NULL,'ts'),(138,3,11,0,0,NULL,'ts'),(139,3,12,0,0,NULL,'ts'),(140,3,13,0,0,NULL,'ts'),(141,3,1,0,1,NULL,'react'),(142,3,2,0,0,NULL,'react'),(143,3,3,0,0,NULL,'react'),(144,3,4,0,0,NULL,'react'),(145,3,5,0,0,NULL,'react'),(146,3,6,0,0,NULL,'react'),(147,3,7,0,0,NULL,'react'),(148,3,8,0,0,NULL,'react'),(149,3,9,0,0,NULL,'react'),(150,3,10,0,0,NULL,'react'),(151,3,11,0,0,NULL,'react'),(152,3,12,0,0,NULL,'react'),(153,3,13,0,0,NULL,'react'),(154,3,1,0,1,NULL,'vue'),(155,3,2,0,0,NULL,'vue'),(156,3,3,0,0,NULL,'vue'),(157,3,4,0,0,NULL,'vue'),(158,3,5,0,0,NULL,'vue'),(159,3,6,0,0,NULL,'vue'),(160,3,7,0,0,NULL,'vue'),(161,3,8,0,0,NULL,'vue'),(162,3,9,0,0,NULL,'vue'),(163,3,10,0,0,NULL,'vue'),(164,3,11,0,0,NULL,'vue'),(165,3,12,0,0,NULL,'vue'),(166,3,13,0,0,NULL,'vue'),(167,3,1,0,1,NULL,'angular'),(168,3,2,0,0,NULL,'angular'),(169,3,3,0,0,NULL,'angular'),(170,3,4,0,0,NULL,'angular'),(171,3,5,0,0,NULL,'angular'),(172,3,6,0,0,NULL,'angular'),(173,3,7,0,0,NULL,'angular'),(174,3,8,0,0,NULL,'angular'),(175,3,9,0,0,NULL,'angular'),(176,3,10,0,0,NULL,'angular'),(177,3,11,0,0,NULL,'angular'),(178,3,12,0,0,NULL,'angular'),(179,3,13,0,0,NULL,'angular'),(180,4,1,0,1,NULL,NULL),(181,4,2,0,0,NULL,NULL),(182,4,3,0,0,NULL,NULL),(183,4,4,0,0,NULL,NULL),(184,4,5,0,0,NULL,NULL),(185,4,6,0,0,NULL,NULL),(186,4,7,0,0,NULL,NULL),(187,4,8,0,0,NULL,NULL),(188,4,9,0,0,NULL,NULL),(189,4,10,0,0,NULL,NULL),(190,4,11,0,0,NULL,NULL),(191,4,12,0,0,NULL,NULL),(192,4,13,0,0,NULL,NULL),(206,6,1,0,1,NULL,'html'),(207,6,2,0,0,NULL,'html'),(208,6,3,0,0,NULL,'html'),(209,6,4,0,0,NULL,'html'),(210,6,5,0,0,NULL,'html'),(211,6,6,0,0,NULL,'html'),(212,6,7,0,0,NULL,'html'),(213,6,8,0,0,NULL,'html'),(214,6,9,0,0,NULL,'html'),(215,6,10,0,0,NULL,'html'),(216,6,11,0,0,NULL,'html'),(217,6,12,0,0,NULL,'html'),(218,6,13,0,0,NULL,'html'),(219,6,1,0,1,NULL,'css'),(220,6,2,0,0,NULL,'css'),(221,6,3,0,0,NULL,'css'),(222,6,4,0,0,NULL,'css'),(223,6,5,0,0,NULL,'css'),(224,6,6,0,0,NULL,'css'),(225,6,7,0,0,NULL,'css'),(226,6,8,0,0,NULL,'css'),(227,6,9,0,0,NULL,'css'),(228,6,10,0,0,NULL,'css'),(229,6,11,0,0,NULL,'css'),(230,6,12,0,0,NULL,'css'),(231,6,13,0,0,NULL,'css'),(232,6,1,0,1,NULL,'js'),(233,6,2,0,0,NULL,'js'),(234,6,3,0,0,NULL,'js'),(235,6,4,0,0,NULL,'js'),(236,6,5,0,0,NULL,'js'),(237,6,6,0,0,NULL,'js'),(238,6,7,0,0,NULL,'js'),(239,6,8,0,0,NULL,'js'),(240,6,9,0,0,NULL,'js'),(241,6,10,0,0,NULL,'js'),(242,6,11,0,0,NULL,'js'),(243,6,12,0,0,NULL,'js'),(244,6,13,0,0,NULL,'js'),(245,6,1,0,1,NULL,'ts'),(246,6,2,0,0,NULL,'ts'),(247,6,3,0,0,NULL,'ts'),(248,6,4,0,0,NULL,'ts'),(249,6,5,0,0,NULL,'ts'),(250,6,6,0,0,NULL,'ts'),(251,6,7,0,0,NULL,'ts'),(252,6,8,0,0,NULL,'ts'),(253,6,9,0,0,NULL,'ts'),(254,6,10,0,0,NULL,'ts'),(255,6,11,0,0,NULL,'ts'),(256,6,12,0,0,NULL,'ts'),(257,6,13,0,0,NULL,'ts'),(258,6,1,0,1,NULL,'react'),(259,6,2,0,0,NULL,'react'),(260,6,3,0,0,NULL,'react'),(261,6,4,0,0,NULL,'react'),(262,6,5,0,0,NULL,'react'),(263,6,6,0,0,NULL,'react'),(264,6,7,0,0,NULL,'react'),(265,6,8,0,0,NULL,'react'),(266,6,9,0,0,NULL,'react'),(267,6,10,0,0,NULL,'react'),(268,6,11,0,0,NULL,'react'),(269,6,12,0,0,NULL,'react'),(270,6,13,0,0,NULL,'react'),(271,6,1,0,1,NULL,'vue'),(272,6,2,0,0,NULL,'vue'),(273,6,3,0,0,NULL,'vue'),(274,6,4,0,0,NULL,'vue'),(275,6,5,0,0,NULL,'vue'),(276,6,6,0,0,NULL,'vue'),(277,6,7,0,0,NULL,'vue'),(278,6,8,0,0,NULL,'vue'),(279,6,9,0,0,NULL,'vue'),(280,6,10,0,0,NULL,'vue'),(281,6,11,0,0,NULL,'vue'),(282,6,12,0,0,NULL,'vue'),(283,6,13,0,0,NULL,'vue'),(284,6,1,0,1,NULL,'angular'),(285,6,2,0,0,NULL,'angular'),(286,6,3,0,0,NULL,'angular'),(287,6,4,0,0,NULL,'angular'),(288,6,5,0,0,NULL,'angular'),(289,6,6,0,0,NULL,'angular'),(290,6,7,0,0,NULL,'angular'),(291,6,8,0,0,NULL,'angular'),(292,6,9,0,0,NULL,'angular'),(293,6,10,0,0,NULL,'angular'),(294,6,11,0,0,NULL,'angular'),(295,6,12,0,0,NULL,'angular'),(296,6,13,0,0,NULL,'angular'),(297,7,1,1,1,'2026-05-12 14:12:07','html'),(298,7,2,1,1,'2026-05-12 14:13:15','html'),(299,7,3,1,1,'2026-05-12 14:13:57','html'),(300,7,4,1,1,'2026-05-12 14:14:17','html'),(301,7,5,1,1,'2026-05-12 14:14:35','html'),(302,7,6,1,1,'2026-05-12 14:15:10','html'),(303,7,7,1,1,'2026-05-12 14:15:35','html'),(304,7,8,1,1,'2026-05-12 14:15:58','html'),(305,7,9,1,1,'2026-05-12 14:16:20','html'),(306,7,10,1,1,'2026-05-12 14:16:44','html'),(307,7,11,1,1,'2026-05-12 14:17:03','html'),(308,7,12,1,1,'2026-05-12 14:17:22','html'),(309,7,13,1,1,'2026-05-12 14:17:43','html'),(310,7,1,1,1,'2026-05-12 14:18:12','css'),(311,7,2,1,1,'2026-05-13 07:32:20','css'),(312,7,3,1,1,'2026-05-13 07:37:56','css'),(313,7,4,1,1,'2026-05-13 07:42:18','css'),(314,7,5,1,1,'2026-05-13 07:53:51','css'),(315,7,6,1,1,'2026-05-13 07:54:19','css'),(316,7,7,1,1,'2026-05-13 07:54:37','css'),(317,7,8,1,1,'2026-05-13 07:54:56','css'),(318,7,9,1,1,'2026-05-13 07:55:13','css'),(319,7,10,1,1,'2026-05-13 07:55:30','css'),(320,7,11,1,1,'2026-05-13 07:55:46','css'),(321,7,12,1,1,'2026-05-13 07:55:59','css'),(322,7,13,1,1,'2026-05-13 07:56:15','css'),(323,7,1,1,1,'2026-05-13 07:56:52','js'),(324,7,2,1,1,'2026-05-13 07:57:35','js'),(325,7,3,1,1,'2026-06-07 10:09:46','js'),(326,7,4,0,1,NULL,'js'),(327,7,5,0,0,NULL,'js'),(328,7,6,0,0,NULL,'js'),(329,7,7,0,0,NULL,'js'),(330,7,8,0,0,NULL,'js'),(331,7,9,0,0,NULL,'js'),(332,7,10,0,0,NULL,'js'),(333,7,11,0,0,NULL,'js'),(334,7,12,0,0,NULL,'js'),(335,7,13,0,0,NULL,'js'),(336,7,1,1,1,'2026-06-07 10:12:09','ts'),(337,7,2,0,1,NULL,'ts'),(338,7,3,0,0,NULL,'ts'),(339,7,4,0,0,NULL,'ts'),(340,7,5,0,0,NULL,'ts'),(341,7,6,0,0,NULL,'ts'),(342,7,7,0,0,NULL,'ts'),(343,7,8,0,0,NULL,'ts'),(344,7,9,0,0,NULL,'ts'),(345,7,10,0,0,NULL,'ts'),(346,7,11,0,0,NULL,'ts'),(347,7,12,0,0,NULL,'ts'),(348,7,13,0,0,NULL,'ts'),(349,7,1,0,1,NULL,'react'),(350,7,2,0,0,NULL,'react'),(351,7,3,0,0,NULL,'react'),(352,7,4,0,0,NULL,'react'),(353,7,5,0,0,NULL,'react'),(354,7,6,0,0,NULL,'react'),(355,7,7,0,0,NULL,'react'),(356,7,8,0,0,NULL,'react'),(357,7,9,0,0,NULL,'react'),(358,7,10,0,0,NULL,'react'),(359,7,11,0,0,NULL,'react'),(360,7,12,0,0,NULL,'react'),(361,7,13,0,0,NULL,'react'),(362,7,1,0,1,NULL,'vue'),(363,7,2,0,0,NULL,'vue'),(364,7,3,0,0,NULL,'vue'),(365,7,4,0,0,NULL,'vue'),(366,7,5,0,0,NULL,'vue'),(367,7,6,0,0,NULL,'vue'),(368,7,7,0,0,NULL,'vue'),(369,7,8,0,0,NULL,'vue'),(370,7,9,0,0,NULL,'vue'),(371,7,10,0,0,NULL,'vue'),(372,7,11,0,0,NULL,'vue'),(373,7,12,0,0,NULL,'vue'),(374,7,13,0,0,NULL,'vue'),(375,7,1,0,1,NULL,'angular'),(376,7,2,0,0,NULL,'angular'),(377,7,3,0,0,NULL,'angular'),(378,7,4,0,0,NULL,'angular'),(379,7,5,0,0,NULL,'angular'),(380,7,6,0,0,NULL,'angular'),(381,7,7,0,0,NULL,'angular'),(382,7,8,0,0,NULL,'angular'),(383,7,9,0,0,NULL,'angular'),(384,7,10,0,0,NULL,'angular'),(385,7,11,0,0,NULL,'angular'),(386,7,12,0,0,NULL,'angular'),(387,7,13,0,0,NULL,'angular');
/*!40000 ALTER TABLE `user_progress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `level` int DEFAULT '1',
  `exp` int DEFAULT '0',
  `streak` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'test','test@test.com','$2b$10$/hMyU97ys.0jZgjfcbLxzet5WMGjLqBvLUeMr0AkZADxWIgLcqflu',1,30,0,'2026-05-07 12:28:20'),(2,'test2','test2@test.com','$2b$10$uqx1t1E1M02crH0EooLn8.a/7nYYJl1YhRzhp6QudTm7M9GLbmTf.',1,0,0,'2026-05-08 12:34:56'),(3,'test3','test3@test.com','$2b$10$9bWp10SVvOD5Y4Z1ZqrYd.WjEg1U1GV4PCeab/gk8VVgw8X/NnTfC',1,0,0,'2026-05-08 12:39:19'),(4,'test4','test4@test.com','$2b$10$VPSbY7dfszc.nLNTkBewCeEWrpEd/RXHaNnuZrfBVkqIIhp/znXX.',1,0,0,'2026-05-12 10:25:53'),(6,'test6','test6@test.com','$2b$10$9tVAE86PgqIjYu9h0aqG5uMNMnsmtJds/KsvCjsZXUCvTLysL7XJS',1,0,0,'2026-05-12 10:50:40'),(7,'yapalyne','yapalyne@icloud.com','$2b$10$wlwqat.2yeTSDJJSzNdJIeIqUO24J6vg/mm/8qDsHHXqsP0eFbd2a',1,0,0,'2026-05-12 14:11:48');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-07 19:14:32
