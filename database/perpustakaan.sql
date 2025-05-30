-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: perpusdig
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `isbn` varchar(255) NOT NULL,
  `cover` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `available` int(11) NOT NULL DEFAULT 0,
  `year` year(4) NOT NULL,
  `publisher` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `category_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `books_category_id_foreign` (`category_id`),
  CONSTRAINT `books_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'2025-01-14 19:19:53','2025-01-14 19:20:37','One Piece','Tere Liye','12345678','book-cover/01JHKW55Z17WE877QDCYG2XXPM.jpg','buku sample',3,1,2025,'gramedia','indonesian','phisical book',2),(2,'2025-01-14 20:01:10','2025-01-15 22:03:31','Sakura','Manuver','323213123213','book-cover/01JHKYGS083M68RVD86P124B3V.jpg','sample books',24,1,2024,'gramedia','indonesian','phisical book',3),(3,'2025-01-14 20:18:23','2025-01-14 20:21:36','One Piece','Manuver','213','book-cover/01JHKZP5MX77YGD64FYM7TTH4D.jpg','dsadada',24,22,2024,'gramedia','indonesian','phisical book',3),(6,'2025-01-15 21:48:06','2025-01-15 21:48:06','Surat untuk Senja','Manuver','221221','book-cover/01JHPQ1977HY19VQN37S69ADYW.jpg','qwewewqe',5,2,2023,'gramedia','indonesian','e-book',5),(7,'2025-01-18 05:58:58','2025-01-18 05:58:58','Filosofi Teras','Tere Liye','1234567898765','book-cover/01JHWQXHDNHJMMDG3Q3H95R5X9.jpg','ssdsads',4,2,2024,'gramedia','indonesian','e-book',1),(8,'2025-01-23 07:53:43','2025-01-23 07:53:43','Berani bersikap bodoh amat','Tere Liye','1234567898765','book-cover/01JJ92E699VKM3MMPZN0QKZ4EA.jpg','Buku sample',20,20,2023,'gramedia','indonesian','phisical book',1);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_records`
--

DROP TABLE IF EXISTS `borrow_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrow_records` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `borrow_request_id` bigint(20) unsigned NOT NULL,
  `borrow_at` date NOT NULL,
  `return_at` date DEFAULT NULL,
  `due_date` date NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'borrowed',
  PRIMARY KEY (`id`),
  KEY `borrow_records_borrow_request_id_foreign` (`borrow_request_id`),
  CONSTRAINT `borrow_records_borrow_request_id_foreign` FOREIGN KEY (`borrow_request_id`) REFERENCES `borrow_requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_records`
--

LOCK TABLES `borrow_records` WRITE;
/*!40000 ALTER TABLE `borrow_records` DISABLE KEYS */;
INSERT INTO `borrow_records` VALUES (25,'2025-01-20 13:36:12','2025-01-21 13:15:48',162,'2025-01-21','2025-01-21','2025-02-02','returned'),(26,'2025-01-21 11:00:36','2025-01-21 11:00:36',166,'2025-01-22','2025-02-05','2025-02-08','borrowed');
/*!40000 ALTER TABLE `borrow_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_request_books`
--

DROP TABLE IF EXISTS `borrow_request_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrow_request_books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `borrow_request_id` bigint(20) unsigned NOT NULL,
  `book_id` bigint(20) unsigned NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `borrow_request_books_borrow_request_id_foreign` (`borrow_request_id`),
  KEY `borrow_request_books_book_id_foreign` (`book_id`),
  CONSTRAINT `borrow_request_books_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrow_request_books_borrow_request_id_foreign` FOREIGN KEY (`borrow_request_id`) REFERENCES `borrow_requests` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_request_books`
--

LOCK TABLES `borrow_request_books` WRITE;
/*!40000 ALTER TABLE `borrow_request_books` DISABLE KEYS */;
INSERT INTO `borrow_request_books` VALUES (1,'2025-01-19 20:31:24','2025-01-19 20:31:24',186,2,1),(2,'2025-01-19 20:31:24','2025-01-19 20:31:24',184,6,1),(3,'2025-01-19 20:31:24','2025-01-19 20:31:24',210,1,1),(4,'2025-01-19 20:31:24','2025-01-19 20:31:24',181,6,1),(5,'2025-01-19 20:31:24','2025-01-19 20:31:24',172,6,1),(6,'2025-01-19 20:31:24','2025-01-19 20:31:24',172,7,1),(7,'2025-01-19 20:31:24','2025-01-19 20:31:24',203,1,1),(8,'2025-01-19 20:31:24','2025-01-19 20:31:24',197,7,1),(9,'2025-01-19 20:31:24','2025-01-19 20:31:24',173,3,1),(10,'2025-01-19 20:31:24','2025-01-19 20:31:24',176,1,1),(11,'2025-01-19 20:31:24','2025-01-19 20:31:24',164,6,1),(12,'2025-01-19 20:31:24','2025-01-19 20:31:24',166,1,1),(13,'2025-01-19 20:31:24','2025-01-19 20:31:24',190,6,1),(14,'2025-01-19 20:31:24','2025-01-19 20:31:24',210,6,2),(15,'2025-01-19 20:31:24','2025-01-19 20:31:24',166,2,1),(16,'2025-01-19 20:31:24','2025-01-19 20:31:24',167,2,1),(17,'2025-01-19 20:31:24','2025-01-19 20:31:24',172,6,1),(18,'2025-01-19 20:31:24','2025-01-19 20:31:24',179,2,1),(19,'2025-01-19 20:31:24','2025-01-19 20:31:24',193,2,1),(20,'2025-01-19 20:31:24','2025-01-19 20:31:24',206,2,1),(21,'2025-01-19 20:31:24','2025-01-19 20:31:24',175,2,1),(22,'2025-01-19 20:31:24','2025-01-19 20:31:24',197,6,1),(23,'2025-01-19 20:31:24','2025-01-19 20:31:24',188,7,1),(24,'2025-01-19 20:31:24','2025-01-19 20:31:24',186,7,1),(25,'2025-01-19 20:31:24','2025-01-19 20:31:24',206,6,1),(26,'2025-01-19 20:31:24','2025-01-19 20:31:24',201,7,1),(27,'2025-01-19 20:31:24','2025-01-19 20:31:24',196,7,1),(28,'2025-01-19 20:31:24','2025-01-19 20:31:24',190,1,1),(29,'2025-01-19 20:31:24','2025-01-19 20:31:24',164,7,1),(30,'2025-01-19 20:31:24','2025-01-19 20:31:24',194,2,1),(31,'2025-01-19 20:31:24','2025-01-19 20:31:24',199,6,1),(32,'2025-01-19 20:31:24','2025-01-19 20:31:24',207,7,1),(33,'2025-01-19 20:31:24','2025-01-19 20:31:24',172,2,1),(34,'2025-01-19 20:31:24','2025-01-19 20:31:24',173,3,1),(35,'2025-01-19 20:31:24','2025-01-19 20:31:24',166,7,1),(36,'2025-01-19 20:31:24','2025-01-19 20:31:24',195,1,1),(37,'2025-01-19 20:31:24','2025-01-19 20:31:24',200,1,1),(38,'2025-01-19 20:31:24','2025-01-19 20:31:24',208,7,1),(39,'2025-01-19 20:31:24','2025-01-19 20:31:24',204,6,1),(40,'2025-01-19 20:31:24','2025-01-19 20:31:24',178,6,1),(41,'2025-01-19 20:31:24','2025-01-19 20:31:24',192,3,1),(42,'2025-01-19 20:31:24','2025-01-19 20:31:24',173,7,1),(43,'2025-01-19 20:31:24','2025-01-19 20:31:24',180,6,1),(44,'2025-01-19 20:31:24','2025-01-19 20:31:24',162,3,1),(45,'2025-01-19 20:31:24','2025-01-19 20:31:24',194,2,1),(46,'2025-01-19 20:31:24','2025-01-19 20:31:24',200,1,1),(47,'2025-01-19 20:31:24','2025-01-19 20:31:24',176,2,1),(48,'2025-01-19 20:31:24','2025-01-19 20:31:24',177,6,1),(49,'2025-01-19 20:31:24','2025-01-19 20:31:24',207,7,1),(50,'2025-01-19 20:31:24','2025-01-19 20:31:24',198,7,1);
/*!40000 ALTER TABLE `borrow_request_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_requests`
--

DROP TABLE IF EXISTS `borrow_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `borrow_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `member_id` bigint(20) unsigned NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `request_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_at` timestamp NULL DEFAULT NULL,
  `is_taken` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `borrow_requests_member_id_foreign` (`member_id`),
  CONSTRAINT `borrow_requests_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_requests`
--

LOCK TABLES `borrow_requests` WRITE;
/*!40000 ALTER TABLE `borrow_requests` DISABLE KEYS */;
INSERT INTO `borrow_requests` VALUES (162,'2025-01-19 09:43:06','2025-01-20 13:36:12',9,'approved','2025-01-04 18:06:32','2025-01-20 13:36:12',1),(164,'2025-01-19 09:43:06','2025-01-19 09:43:06',27,'pending','2024-12-20 22:02:22',NULL,0),(166,'2025-01-19 09:43:06','2025-01-21 11:00:36',24,'approved','2025-01-05 03:54:57','2025-01-21 11:00:36',1),(167,'2025-01-19 09:43:06','2025-01-19 09:43:06',14,'approved','2024-12-20 01:19:09','2025-01-19 09:43:06',1),(172,'2025-01-19 09:43:06','2025-01-19 09:43:06',9,'rejected','2025-01-06 18:55:46','2025-01-19 09:43:06',0),(173,'2025-01-19 09:43:06','2025-01-19 09:43:06',11,'approved','2024-12-26 20:49:52','2025-01-19 09:43:06',1),(175,'2025-01-19 09:43:06','2025-01-19 09:43:06',26,'rejected','2025-01-13 09:42:42','2025-01-19 09:43:06',0),(176,'2025-01-19 09:43:06','2025-01-19 09:43:06',1,'approved','2025-01-06 21:40:20','2025-01-19 09:43:06',1),(177,'2025-01-19 09:43:06','2025-01-19 09:43:06',19,'pending','2025-01-02 23:20:15',NULL,0),(178,'2025-01-19 09:43:06','2025-01-19 09:43:06',6,'pending','2025-01-12 05:25:53',NULL,0),(179,'2025-01-19 09:43:06','2025-01-19 09:43:06',19,'rejected','2024-12-31 20:26:57','2025-01-19 09:43:06',0),(180,'2025-01-19 09:43:06','2025-01-19 09:43:06',18,'rejected','2024-12-31 07:05:14','2025-01-19 09:43:06',0),(181,'2025-01-19 09:43:06','2025-01-19 09:43:06',22,'rejected','2025-01-07 01:30:00','2025-01-19 09:43:06',0),(184,'2025-01-19 09:43:06','2025-01-19 09:43:06',13,'approved','2025-01-16 11:49:52','2025-01-19 09:43:06',1),(186,'2025-01-19 09:43:06','2025-01-19 09:43:06',8,'approved','2024-12-27 15:39:02','2025-01-19 09:43:06',1),(188,'2025-01-19 09:43:06','2025-01-19 09:43:06',25,'pending','2025-01-06 10:21:26',NULL,0),(190,'2025-01-19 09:43:06','2025-01-19 09:43:06',27,'approved','2025-01-16 02:21:13','2025-01-19 09:43:06',1),(192,'2025-01-19 09:43:06','2025-01-19 09:43:06',21,'pending','2024-12-25 04:00:26',NULL,0),(193,'2025-01-19 09:43:06','2025-01-19 09:43:06',1,'rejected','2025-01-18 07:29:07','2025-01-19 09:43:06',0),(194,'2025-01-19 09:43:06','2025-01-19 09:43:06',22,'pending','2025-01-17 00:45:37',NULL,0),(195,'2025-01-19 09:43:06','2025-01-19 09:43:06',20,'approved','2024-12-25 06:46:36','2025-01-19 09:43:06',1),(196,'2025-01-19 09:43:06','2025-01-19 09:43:06',17,'pending','2024-12-26 04:13:02',NULL,0),(197,'2025-01-19 09:43:06','2025-01-19 09:43:06',3,'approved','2025-01-09 00:17:12','2025-01-19 09:43:06',1),(198,'2025-01-19 09:43:06','2025-01-19 09:43:06',31,'pending','2024-12-21 15:35:58',NULL,0),(199,'2025-01-19 09:43:06','2025-01-19 09:43:06',22,'pending','2024-12-28 22:41:54',NULL,0),(200,'2025-01-19 09:43:06','2025-01-19 09:43:06',23,'approved','2025-01-01 17:21:38','2025-01-19 09:43:06',1),(201,'2025-01-19 09:43:06','2025-01-19 09:43:06',18,'approved','2025-01-03 21:14:34','2025-01-19 09:43:06',1),(203,'2025-01-19 09:43:06','2025-01-19 09:43:06',25,'pending','2024-12-29 12:30:29',NULL,0),(204,'2025-01-19 09:43:06','2025-01-19 09:43:06',5,'rejected','2024-12-19 09:52:19','2025-01-19 09:43:06',0),(206,'2025-01-19 09:43:06','2025-01-19 09:43:06',27,'pending','2025-01-14 13:10:22',NULL,0),(207,'2025-01-19 09:43:06','2025-01-19 09:43:06',18,'approved','2025-01-02 02:00:04','2025-01-19 09:43:06',1),(208,'2025-01-19 09:43:06','2025-01-19 09:43:06',11,'pending','2024-12-28 02:46:37',NULL,0),(210,'2025-01-19 09:43:06','2025-01-19 09:43:06',17,'pending','2025-01-02 10:02:48',NULL,0);
/*!40000 ALTER TABLE `borrow_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('1f1362ea41d1bc65be321c0a378a20159f9a26d0','i:3;',1737618848),('1f1362ea41d1bc65be321c0a378a20159f9a26d0:timer','i:1737618848;',1737618848),('livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3','i:1;',1737652813),('livewire-rate-limiter:a17961fa74e9275d529f489537f179c05d50c2f3:timer','i:1737652813;',1737652813),('spatie.permission.cache','a:3:{s:5:\"alias\";a:4:{s:1:\"a\";s:2:\"id\";s:1:\"b\";s:4:\"name\";s:1:\"c\";s:10:\"guard_name\";s:1:\"r\";s:5:\"roles\";}s:11:\"permissions\";a:82:{i:0;a:4:{s:1:\"a\";i:1;s:1:\"b\";s:9:\"view_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:1;a:4:{s:1:\"a\";i:2;s:1:\"b\";s:13:\"view_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:2;a:4:{s:1:\"a\";i:3;s:1:\"b\";s:11:\"create_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:3;a:4:{s:1:\"a\";i:4;s:1:\"b\";s:11:\"update_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:4;a:4:{s:1:\"a\";i:5;s:1:\"b\";s:11:\"delete_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:5;a:4:{s:1:\"a\";i:6;s:1:\"b\";s:15:\"delete_any_role\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:6;a:4:{s:1:\"a\";i:7;s:1:\"b\";s:10:\"view_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:7;a:4:{s:1:\"a\";i:8;s:1:\"b\";s:14:\"view_any_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:8;a:4:{s:1:\"a\";i:9;s:1:\"b\";s:12:\"create_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:9;a:4:{s:1:\"a\";i:10;s:1:\"b\";s:12:\"update_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:10;a:4:{s:1:\"a\";i:11;s:1:\"b\";s:13:\"restore_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:11;a:4:{s:1:\"a\";i:12;s:1:\"b\";s:17:\"restore_any_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:12;a:4:{s:1:\"a\";i:13;s:1:\"b\";s:15:\"replicate_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:13;a:4:{s:1:\"a\";i:14;s:1:\"b\";s:13:\"reorder_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:14;a:4:{s:1:\"a\";i:15;s:1:\"b\";s:12:\"delete_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:15;a:4:{s:1:\"a\";i:16;s:1:\"b\";s:16:\"delete_any_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:16;a:4:{s:1:\"a\";i:17;s:1:\"b\";s:18:\"force_delete_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:17;a:4:{s:1:\"a\";i:18;s:1:\"b\";s:22:\"force_delete_any_admin\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:18;a:4:{s:1:\"a\";i:19;s:1:\"b\";s:9:\"view_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:19;a:4:{s:1:\"a\";i:20;s:1:\"b\";s:13:\"view_any_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:20;a:4:{s:1:\"a\";i:21;s:1:\"b\";s:11:\"create_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:21;a:4:{s:1:\"a\";i:22;s:1:\"b\";s:11:\"update_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:22;a:4:{s:1:\"a\";i:23;s:1:\"b\";s:12:\"restore_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:23;a:4:{s:1:\"a\";i:24;s:1:\"b\";s:16:\"restore_any_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:24;a:4:{s:1:\"a\";i:25;s:1:\"b\";s:14:\"replicate_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:25;a:4:{s:1:\"a\";i:26;s:1:\"b\";s:12:\"reorder_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:26;a:4:{s:1:\"a\";i:27;s:1:\"b\";s:11:\"delete_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:27;a:4:{s:1:\"a\";i:28;s:1:\"b\";s:15:\"delete_any_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:28;a:4:{s:1:\"a\";i:29;s:1:\"b\";s:17:\"force_delete_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:29;a:4:{s:1:\"a\";i:30;s:1:\"b\";s:21:\"force_delete_any_book\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:30;a:4:{s:1:\"a\";i:31;s:1:\"b\";s:19:\"view_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:31;a:4:{s:1:\"a\";i:32;s:1:\"b\";s:23:\"view_any_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:32;a:4:{s:1:\"a\";i:33;s:1:\"b\";s:21:\"create_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:33;a:4:{s:1:\"a\";i:34;s:1:\"b\";s:21:\"update_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:34;a:4:{s:1:\"a\";i:35;s:1:\"b\";s:22:\"restore_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:35;a:4:{s:1:\"a\";i:36;s:1:\"b\";s:26:\"restore_any_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:36;a:4:{s:1:\"a\";i:37;s:1:\"b\";s:24:\"replicate_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:37;a:4:{s:1:\"a\";i:38;s:1:\"b\";s:22:\"reorder_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:38;a:4:{s:1:\"a\";i:39;s:1:\"b\";s:21:\"delete_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:39;a:4:{s:1:\"a\";i:40;s:1:\"b\";s:25:\"delete_any_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:40;a:4:{s:1:\"a\";i:41;s:1:\"b\";s:27:\"force_delete_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:41;a:4:{s:1:\"a\";i:42;s:1:\"b\";s:31:\"force_delete_any_borrow::record\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:42;a:4:{s:1:\"a\";i:43;s:1:\"b\";s:20:\"view_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:43;a:4:{s:1:\"a\";i:44;s:1:\"b\";s:24:\"view_any_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:44;a:4:{s:1:\"a\";i:45;s:1:\"b\";s:22:\"create_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:45;a:4:{s:1:\"a\";i:46;s:1:\"b\";s:22:\"update_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:46;a:4:{s:1:\"a\";i:47;s:1:\"b\";s:23:\"restore_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:47;a:4:{s:1:\"a\";i:48;s:1:\"b\";s:27:\"restore_any_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:48;a:4:{s:1:\"a\";i:49;s:1:\"b\";s:25:\"replicate_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:49;a:4:{s:1:\"a\";i:50;s:1:\"b\";s:23:\"reorder_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:50;a:4:{s:1:\"a\";i:51;s:1:\"b\";s:22:\"delete_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:51;a:4:{s:1:\"a\";i:52;s:1:\"b\";s:26:\"delete_any_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:52;a:4:{s:1:\"a\";i:53;s:1:\"b\";s:28:\"force_delete_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:53;a:4:{s:1:\"a\";i:54;s:1:\"b\";s:32:\"force_delete_any_borrow::request\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:54;a:4:{s:1:\"a\";i:55;s:1:\"b\";s:15:\"view_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:55;a:4:{s:1:\"a\";i:56;s:1:\"b\";s:19:\"view_any_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:56;a:4:{s:1:\"a\";i:57;s:1:\"b\";s:17:\"create_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:57;a:4:{s:1:\"a\";i:58;s:1:\"b\";s:17:\"update_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:58;a:4:{s:1:\"a\";i:59;s:1:\"b\";s:18:\"restore_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:59;a:4:{s:1:\"a\";i:60;s:1:\"b\";s:22:\"restore_any_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:60;a:4:{s:1:\"a\";i:61;s:1:\"b\";s:20:\"replicate_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:61;a:4:{s:1:\"a\";i:62;s:1:\"b\";s:18:\"reorder_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:62;a:4:{s:1:\"a\";i:63;s:1:\"b\";s:17:\"delete_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:63;a:4:{s:1:\"a\";i:64;s:1:\"b\";s:21:\"delete_any_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:64;a:4:{s:1:\"a\";i:65;s:1:\"b\";s:23:\"force_delete_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:65;a:4:{s:1:\"a\";i:66;s:1:\"b\";s:27:\"force_delete_any_categories\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:66;a:4:{s:1:\"a\";i:67;s:1:\"b\";s:11:\"view_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:67;a:4:{s:1:\"a\";i:68;s:1:\"b\";s:15:\"view_any_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:68;a:4:{s:1:\"a\";i:69;s:1:\"b\";s:13:\"create_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:69;a:4:{s:1:\"a\";i:70;s:1:\"b\";s:13:\"update_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:70;a:4:{s:1:\"a\";i:71;s:1:\"b\";s:14:\"restore_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:71;a:4:{s:1:\"a\";i:72;s:1:\"b\";s:18:\"restore_any_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:72;a:4:{s:1:\"a\";i:73;s:1:\"b\";s:16:\"replicate_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:73;a:4:{s:1:\"a\";i:74;s:1:\"b\";s:14:\"reorder_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:74;a:4:{s:1:\"a\";i:75;s:1:\"b\";s:13:\"delete_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:75;a:4:{s:1:\"a\";i:76;s:1:\"b\";s:17:\"delete_any_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:76;a:4:{s:1:\"a\";i:77;s:1:\"b\";s:19:\"force_delete_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:77;a:4:{s:1:\"a\";i:78;s:1:\"b\";s:23:\"force_delete_any_member\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:2:{i:0;i:3;i:1;i:4;}}i:78;a:4:{s:1:\"a\";i:79;s:1:\"b\";s:20:\"widget_StatsOverview\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:79;a:4:{s:1:\"a\";i:80;s:1:\"b\";s:23:\"widget_StatsRecordChart\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:80;a:4:{s:1:\"a\";i:81;s:1:\"b\";s:20:\"widget_StatBookChart\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}i:81;a:4:{s:1:\"a\";i:82;s:1:\"b\";s:23:\"widget_StatsLowestBooks\";s:1:\"c\";s:3:\"web\";s:1:\"r\";a:1:{i:0;i:4;}}}s:5:\"roles\";a:2:{i:0;a:3:{s:1:\"a\";i:4;s:1:\"b\";s:11:\"super_admin\";s:1:\"c\";s:3:\"web\";}i:1;a:3:{s:1:\"a\";i:3;s:1:\"b\";s:5:\"admin\";s:1:\"c\";s:3:\"web\";}}}',1737715813);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_category_name_unique` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'filosofi',NULL,NULL),(2,'education',NULL,NULL),(3,'comic',NULL,NULL),(4,'novel',NULL,NULL),(5,'ensiclopedia',NULL,NULL),(6,'self improvement',NULL,NULL),(7,'Science','2025-01-14 06:36:18','2025-01-14 06:36:18');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nik` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `members_nik_unique` (`nik`),
  KEY `members_user_id_foreign` (`user_id`),
  CONSTRAINT `members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'9441263589','approved',22,'2025-01-15 03:34:30','2025-01-15 19:26:35'),(2,'5427982626','approved',23,'2025-01-15 03:34:30','2025-01-15 07:05:29'),(3,'4149223155','approved',24,'2025-01-15 03:34:30','2025-01-15 07:08:10'),(4,'3790557636','approved',25,'2025-01-15 03:34:30','2025-01-15 19:36:21'),(5,'0676829175','approved',26,'2025-01-15 03:34:30','2025-01-15 03:34:30'),(6,'4848346024','approved',27,'2025-01-15 03:34:30','2025-01-21 10:42:35'),(7,'6281344833','pending',28,'2025-01-15 03:34:30','2025-01-15 03:34:30'),(8,'4115866836','pending',29,'2025-01-15 03:34:30','2025-01-15 03:34:30'),(9,'6709804702','pending',30,'2025-01-15 03:34:30','2025-01-15 03:34:30'),(10,'3080287837','pending',31,'2025-01-15 03:34:30','2025-01-15 03:34:30'),(11,'1186558056','pending',49,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(12,'8200184660','pending',50,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(13,'3230076523','pending',51,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(14,'3196337766','pending',52,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(15,'4960076509','pending',53,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(16,'1859266095','pending',54,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(17,'7825311010','pending',55,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(18,'9720318471','pending',56,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(19,'2327535679','pending',57,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(20,'6541331857','pending',58,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(21,'2719996802','pending',59,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(22,'5940625529','pending',60,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(23,'1283933684','pending',61,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(24,'0799408892','pending',62,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(25,'3803218644','pending',63,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(26,'3515882773','pending',64,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(27,'0237642192','pending',65,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(28,'8676521048','pending',66,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(29,'5850300811','pending',67,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(30,'8868360302','pending',68,'2025-01-18 11:24:08','2025-01-18 11:24:08'),(31,'5945688198','pending',69,'2025-01-18 11:24:08','2025-01-18 11:24:08');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(5,'2025_01_13_005140_create_books_table',2),(8,'2025_01_14_094934_delete_category_from_books',3),(14,'2025_01_14_100723_create_category_table',4),(15,'2025_01_14_101837_create_books_table',4),(17,'2025_01_15_033935_create_members_table',5),(18,'2025_01_15_094509_add_photo_path_to_user_table',6),(25,'2025_01_16_142020_create_borrow_requests_table',7),(26,'2025_01_16_161531_create_borrow_records_table',7),(27,'2025_01_19_155434_create_borrow_request_books_table',8),(28,'2025_01_19_160455_delete_book_id',9),(29,'2025_01_19_162004_delete_borrow_request_id',10),(31,'2025_01_22_100821_create_permission_tables',11);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_permissions`
--

DROP TABLE IF EXISTS `model_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_permissions`
--

LOCK TABLES `model_has_permissions` WRITE;
/*!40000 ALTER TABLE `model_has_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `model_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model_has_roles`
--

DROP TABLE IF EXISTS `model_has_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model_has_roles`
--

LOCK TABLES `model_has_roles` WRITE;
/*!40000 ALTER TABLE `model_has_roles` DISABLE KEYS */;
INSERT INTO `model_has_roles` VALUES (3,'App\\Models\\User',75),(3,'App\\Models\\User',76),(3,'App\\Models\\User',77),(4,'App\\Models\\User',74);
/*!40000 ALTER TABLE `model_has_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES ('ilman@gmail.com','$2y$12$YdolktL7k.sVD5qR2usUjeMryYQf5wdXEptgnSWXU5hlddUx0D.h.','2025-01-15 01:56:24'),('ilmannafi04@gmail.com','$2y$12$/Xj581moXi6tkMbzUbxl/.C31eizMjPY95jKxpwWiuw.w9XRuZDv6','2025-01-15 01:57:04');
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'view_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(2,'view_any_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(3,'create_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(4,'update_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(5,'delete_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(6,'delete_any_role','web','2025-01-22 05:11:50','2025-01-22 05:11:50'),(7,'view_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(8,'view_any_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(9,'create_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(10,'update_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(11,'restore_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(12,'restore_any_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(13,'replicate_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(14,'reorder_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(15,'delete_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(16,'delete_any_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(17,'force_delete_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(18,'force_delete_any_admin','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(19,'view_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(20,'view_any_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(21,'create_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(22,'update_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(23,'restore_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(24,'restore_any_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(25,'replicate_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(26,'reorder_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(27,'delete_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(28,'delete_any_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(29,'force_delete_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(30,'force_delete_any_book','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(31,'view_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(32,'view_any_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(33,'create_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(34,'update_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(35,'restore_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(36,'restore_any_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(37,'replicate_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(38,'reorder_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(39,'delete_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(40,'delete_any_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(41,'force_delete_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(42,'force_delete_any_borrow::record','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(43,'view_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(44,'view_any_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(45,'create_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(46,'update_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(47,'restore_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(48,'restore_any_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(49,'replicate_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(50,'reorder_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(51,'delete_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(52,'delete_any_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(53,'force_delete_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(54,'force_delete_any_borrow::request','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(55,'view_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(56,'view_any_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(57,'create_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(58,'update_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(59,'restore_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(60,'restore_any_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(61,'replicate_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(62,'reorder_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(63,'delete_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(64,'delete_any_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(65,'force_delete_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(66,'force_delete_any_categories','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(67,'view_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(68,'view_any_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(69,'create_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(70,'update_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(71,'restore_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(72,'restore_any_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(73,'replicate_member','web','2025-01-22 05:18:35','2025-01-22 05:18:35'),(74,'reorder_member','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(75,'delete_member','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(76,'delete_any_member','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(77,'force_delete_member','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(78,'force_delete_any_member','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(79,'widget_StatsOverview','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(80,'widget_StatsRecordChart','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(81,'widget_StatBookChart','web','2025-01-22 05:18:36','2025-01-22 05:18:36'),(82,'widget_StatsLowestBooks','web','2025-01-22 05:18:36','2025-01-22 05:18:36');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_has_permissions`
--

DROP TABLE IF EXISTS `role_has_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_has_permissions`
--

LOCK TABLES `role_has_permissions` WRITE;
/*!40000 ALTER TABLE `role_has_permissions` DISABLE KEYS */;
INSERT INTO `role_has_permissions` VALUES (1,4),(2,4),(3,4),(4,4),(5,4),(6,4),(7,4),(8,4),(9,4),(10,4),(11,4),(12,4),(13,4),(14,4),(15,4),(16,4),(17,4),(18,4),(19,3),(19,4),(20,3),(20,4),(21,3),(21,4),(22,3),(22,4),(23,3),(23,4),(24,3),(24,4),(25,3),(25,4),(26,3),(26,4),(27,3),(27,4),(28,3),(28,4),(29,3),(29,4),(30,3),(30,4),(31,3),(31,4),(32,3),(32,4),(33,3),(33,4),(34,3),(34,4),(35,3),(35,4),(36,3),(36,4),(37,3),(37,4),(38,3),(38,4),(39,3),(39,4),(40,3),(40,4),(41,3),(41,4),(42,3),(42,4),(43,3),(43,4),(44,3),(44,4),(45,3),(45,4),(46,3),(46,4),(47,3),(47,4),(48,3),(48,4),(49,3),(49,4),(50,3),(50,4),(51,3),(51,4),(52,3),(52,4),(53,3),(53,4),(54,3),(54,4),(55,3),(55,4),(56,3),(56,4),(57,3),(57,4),(58,3),(58,4),(59,3),(59,4),(60,3),(60,4),(61,3),(61,4),(62,3),(62,4),(63,3),(63,4),(64,3),(64,4),(65,3),(65,4),(66,3),(66,4),(67,3),(67,4),(68,3),(68,4),(69,3),(69,4),(70,3),(70,4),(71,3),(71,4),(72,3),(72,4),(73,3),(73,4),(74,3),(74,4),(75,3),(75,4),(76,3),(76,4),(77,3),(77,4),(78,3),(78,4),(79,4),(80,4),(81,4),(82,4);
/*!40000 ALTER TABLE `role_has_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (3,'admin','web','2025-01-22 05:18:58','2025-01-22 05:18:58'),(4,'super_admin','web','2025-01-22 05:25:13','2025-01-22 05:25:13');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('1QgPoXZAIyZ8ggUCXhzosxT0G4Iw8wHCaeuwPBJs',77,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiV2VLMXU3aHVsTjN4QThCa0RpQlYzZlcxQTdQWm9OaEZsWm9DeTNUOCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM4OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vY2F0ZWdvcmllcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjc3O3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkRFlVbEtRR2h4RU4yVEJIRXJSVk1ET1BOLy5tOG9tUklyMVdEa01jbWNXYmpJMFVnL2xRWVciO30=',1737629575),('s4Jx4dpe93c43jD3zdzCIrB0gbYcdhv9CUy0umY8',74,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaFNvY05XTU1uWWRzb3N5SjJRVTNXTWNsa2hkZGlhSldBYmZQMjlQSyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9hZG1pbnMiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aTo3NDtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJEdTNlY4bWgzTlJmUUZvQWpVTm1vSWVPOWNqUFcvSjFRNXBiVFR0N21XN1pRL2pjNHZ4dzRHIjtzOjg6ImZpbGFtZW50IjthOjA6e319',1737629569),('ZDXFFIFdwUbEYY1RQG1szxxJbgy6fjlpRIB7oVYN',74,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiemVzNzRIT3pEMWhxOHdIU1lwVzZNeExDRm5Ic1VpTDZpQjh6djVaMCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYWRtaW4vc2hpZWxkL3JvbGVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NzQ7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRHUzZWOG1oM05SZlFGb0FqVU5tb0llTzljalBXL0oxUTVwYlRUdDdtVzdaUS9qYzR2eHc0RyI7fQ==',1737653368);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `address` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photo_path` varchar(255) NOT NULL DEFAULT 'foto-profile/user-profile-default.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (13,'Esther Waelchi','jarret.quigley@example.org','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','960 Vandervort Islands Apt. 367\nWest Nyasia, DE 88170','281-651-3045','JXhhbqedea','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(14,'Mr. Colton Schaden Sr.','fbechtelar@example.net','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','67268 Bashirian Center Apt. 383\nKuvalisside, ME 84744','+1-610-334-3970','Kr1pHtSgv3','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(15,'Cleta Daniel','maximillia26@example.net','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','277 Gulgowski Via Apt. 238\nSharonfurt, OH 18239','+1 (917) 907-7539','HA4BQbgvG5','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(16,'Johann Bernier','mcremin@example.com','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','2259 Wolf Court\nWest Billy, RI 14364','+12199535281','aJJ8a92CO9','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(17,'Mabel Spinka DDS','kerluke.javier@example.com','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','15015 Heathcote Unions Apt. 514\nKshlerinchester, HI 16484','+1-586-798-1894','9ePiyJTrEv','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(18,'Thora Strosin','ethyl.casper@example.org','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','53193 Price Walks Suite 412\nLake Ransom, LA 97106-6852','640-565-7485','3i0QtgXLZT','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(19,'Elyssa Wolf','stephany53@example.net','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','636 Greenholt Gateway\nVerdafurt, CA 38145-0227','+1 (301) 726-7489','WNMsSQT3bR','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(20,'Geraldine O\'Conner','ledner.rey@example.net','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','9853 Cruickshank Plaza\nWeberchester, NJ 67919-3424','1-580-683-2714','INDedsdFhe','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(21,'Prof. Joy Durgan','greg81@example.net','2025-01-15 03:20:00','$2y$12$vurvgtFoALQ8x0y826zNWOf8W/ZeNo0.X7p/Oifzf08UtrF6DVkyy','user','224 Jaskolski Fort Suite 556\nWest Keshawnside, AZ 88762-6919','+1 (857) 917-0337','gARogKBSkv','2025-01-15 03:20:00','2025-01-15 03:20:00','foto-profile/user-profile-default.png'),(22,'Webster Kris Jr.','sanford.donald@example.net','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','9009 Donnelly Walk\nCristborough, ID 80116-4118','254.827.4684','QDY9vCt66t','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(23,'Kaylee Pfannerstill II','okon.quinton@example.com','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','769 Deven Loop Suite 528\nLake Kasey, IA 59283','(339) 583-1883','WMiIQ1OKmX','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(24,'Zoila Wehner','hassie.boyer@example.org','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','578 Arden Hollow\nKunzeburgh, NJ 72596-4094','+1-785-566-8901','CkAZHLTVnp','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(25,'Sheridan Sawayn','pmurphy@example.org','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','27884 Santa Spur Apt. 976\nSouth Pansy, CO 11546-1858','+1-706-742-1870','OxP2Wz9sNU','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(26,'Ms. Harmony Kuhn','balistreri.frank@example.net','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','6633 Rhianna Drives Suite 484\nNorth Marlen, AR 91782-8526','+1-585-417-3720','TZlI43dgAj','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(27,'Delbert Borer Sr.','sswift@example.org','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','2007 Randy Groves\nKassandraborough, MO 83293-9480','+12176300879','pFRRJOr7nZ','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(28,'Ryann Krajcik','kirstin20@example.com','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','13524 Frieda Highway Suite 338\nMaybelleville, OR 96472-2512','+1.936.982.3311','pMmgJw157k','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(29,'Rodger Runolfsson','dandre.schumm@example.net','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','183 Kilback Bypass\nPort Deion, IN 98075-5277','1-640-340-9457','YhLPke0WNM','2025-01-15 03:34:29','2025-01-15 03:34:29','foto-profile/user-profile-default.png'),(30,'Marietta Altenwerth','collins.tyreek@example.net','2025-01-15 03:34:29','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','80109 Johnson Manors\nEast Katlyn, MA 82833','650-890-9943','9N6IyIpsRX','2025-01-15 03:34:30','2025-01-15 03:34:30','foto-profile/user-profile-default.png'),(31,'Prof. Silas Reichel MD','koelpin.mckenzie@example.com','2025-01-15 03:34:30','$2y$12$hsjkGfCyvT2hlXU8FOSdFOF81XIMFMGbksOI0fIrkWrtEuGnt3kse','user','255 Theresia Avenue Suite 104\nBoshire, MT 57053-0065','+16788731922','e9Udqf43r2','2025-01-15 03:34:30','2025-01-15 03:34:30','foto-profile/user-profile-default.png'),(48,'Test User','test@example.com','2025-01-16 08:15:58','$2y$12$qDk1IiE6s8qoZUedor2A9eKZygr6DknXliLy.BcWMXct0cuhbvMFq','user','44599 Yost Turnpike\nNew Jaunitaport, ID 71537-6418','+1-843-727-2331','KkbGMs4NgL','2025-01-16 08:15:59','2025-01-16 08:15:59','foto-profile/user-profile-default.png'),(49,'Miss Viola Batz IV','crunolfsson@example.net','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','7162 Bashirian Stravenue\nNorth Kimberlyborough, IL 26170-3503','+1-936-235-0092','iinSL7GzUL','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(50,'Connor Luettgen','renee.kunze@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','7239 Walsh Drives Suite 001\nReynoldschester, MN 55638-2974','+1 (952) 432-4108','eeDfWUDvRz','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(51,'Bert Kuphal','daisha82@example.net','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','437 Cartwright Ways\nCarterview, NJ 82509-6634','+1 (541) 825-3884','zz5ULuTfsm','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(52,'Clyde Gerlach','humberto40@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','958 Tromp Loop\nSouth Gay, FL 10702-1381','+1-930-600-6536','1EWHhAan2J','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(53,'Cecilia Bailey','uwitting@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','9258 Daniella Fork Apt. 855\nWilmaside, VT 95661-2173','+1-470-627-6075','TBgoVQSkF6','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(54,'Ms. Audra Bartell MD','gislason.rolando@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','90772 Tressie Key\nOlsonport, PA 51392','1-678-893-6010','AfJNCs4TPZ','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(55,'Rebekah Hackett','qbarton@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','80410 Veum Falls\nOtisstad, FL 45248-7629','(717) 992-9750','zJVIgbzxW8','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(56,'Dr. Ward Stroman DDS','zlemke@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','4408 Raynor Tunnel Suite 218\nWest Lew, KS 69924-2107','+1-228-701-8626','ZB9j9JTE6K','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(57,'Isabell Stehr','berge.julius@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','8403 Alyson Stream Suite 610\nAltenwerthview, OR 67646','978.544.9920','k1kqpJ2t4F','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(58,'Dr. Tyler Emmerich','okeebler@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','424 Mae Unions\nLindgrenville, NC 42989','+1 (214) 943-6460','GA6CQUrgls','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(59,'Jeffry Lubowitz V','ziemann.heber@example.net','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','70224 Waters Street\nFreddieville, OR 39196','(215) 396-8754','IpGLbvO4ud','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(60,'Anne Emmerich','katrina79@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','8872 Schneider Gardens\nPort Danstad, MT 29379','+1-254-634-2059','bsnkOUSmsf','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(61,'Lina Hickle','qcole@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','446 Walker Overpass\nTrystanchester, MI 93254-3930','+1 (785) 724-6570','6kiHdw7vd0','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(62,'Trenton Rosenbaum','onienow@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','75506 Maria Islands Suite 419\nWest Shannyburgh, SD 64900-1659','+1.769.934.8450','Fqo5aUMQXA','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(63,'Miss Lois Strosin Jr.','taylor.stoltenberg@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','7349 Rickie Road Suite 136\nMetzmouth, AR 03947','419-934-4412','JU3PZWT56M','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(64,'Madaline Kling','iflatley@example.net','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','6932 Purdy Centers Apt. 041\nPort Allisonton, WA 81147-1710','+1 (423) 980-9848','Q6VoGxYBfL','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(65,'Angus Koch','harris.golden@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','90991 Fay Viaduct\nSouth Orion, VT 31892','+1-772-404-0571','A9V3eQO3Wi','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(66,'Prof. Carroll Berge','marvin.rodrigo@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','7997 Stehr Circle\nSouth Lestermouth, AK 99542-1183','+1-956-507-4675','PdlepY5r7h','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(67,'Ferne Krajcik','kyleigh.kassulke@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','258 Douglas Row\nStammton, MD 05659-3659','904.512.0010','UJxHBcCzvV','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(68,'Meredith Hintz','jovanny98@example.org','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','66252 Odessa Views\nLeannonmouth, MI 55787-2294','(561) 595-2739','JfcrCUaHMC','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(69,'Mariah Mraz','dooley.pearlie@example.com','2025-01-18 11:24:08','$2y$12$w9sfEJ4WtRroboj4.D9mUOlaHHWMWczRQppFcvMC0DcIdF5bHXSre','user','131 Boyer Mission\nPort Saige, NH 74187','731.752.6814','R3II6IAYmP','2025-01-18 11:24:08','2025-01-18 11:24:08','foto-profile/user-profile-default.png'),(74,'nana','nana@gmail.com',NULL,'$2y$12$GS6V8mh3NRfQFoAjUNmoIeO9cjPW/J1Q5pbTTt7mW7ZQ/jc4vxw4G','4','masaran','087654565456',NULL,'2025-01-22 05:19:58','2025-01-22 05:19:58','foto-profile/user-profile-default.png'),(75,'adminku','admin@gmail.com',NULL,'$2y$12$6KeM5vpc5h3WabT2FVTdHedhJ4SJnTsE2Nl9pxcimBsWXwOsLO1sO','3','masaran','086565654346',NULL,'2025-01-22 05:28:33','2025-01-22 05:28:33','foto-profile/user-profile-default.png'),(76,'Gudung Juang','fajarfadhilah510s@gmail.com',NULL,'$2y$12$o2ZIiSiBYOLzQiXrJzsequmAJXJVeZrt0f41ptGYDf39uJxm7aIae','3','masaran','087676545654',NULL,'2025-01-23 10:45:44','2025-01-23 10:45:44','foto-profile/user-profile-default.png'),(77,'Gudung Juangs','amely.schroededr@example.net',NULL,'$2y$12$DYUlKQGhxEN2TBHErRVMDOPN/.m8omRIr1WDkMcmcWbjI0Ug/lQYW','3','masaran','087676565456',NULL,'2025-01-23 10:48:36','2025-01-23 10:48:36','foto-profile/user-profile-default.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-24  0:35:39
