CREATE DATABASE  IF NOT EXISTS `pizzajoint` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `pizzajoint`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: pizzajoint
-- ------------------------------------------------------
-- Server version	5.7.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `basic_toppings`
--

DROP TABLE IF EXISTS `basic_toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basic_toppings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(128) DEFAULT 'dummy',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basic_toppings`
--

LOCK TABLES `basic_toppings` WRITE;
/*!40000 ALTER TABLE `basic_toppings` DISABLE KEYS */;
/*!40000 ALTER TABLE `basic_toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `basic_toppings_price`
--

DROP TABLE IF EXISTS `basic_toppings_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `basic_toppings_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basic_toppings_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `basic_toppings_price_basic_toppings_id_idx` (`basic_toppings_id`),
  KEY `basic_toppings_price_product_id_idx` (`product_id`),
  CONSTRAINT `basic_toppings_price_basic_toppings_id` FOREIGN KEY (`basic_toppings_id`) REFERENCES `basic_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `basic_toppings_price_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basic_toppings_price`
--

LOCK TABLES `basic_toppings_price` WRITE;
/*!40000 ALTER TABLE `basic_toppings_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `basic_toppings_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deluxe_toppings`
--

DROP TABLE IF EXISTS `deluxe_toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deluxe_toppings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(128) DEFAULT 'dummy',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deluxe_toppings`
--

LOCK TABLES `deluxe_toppings` WRITE;
/*!40000 ALTER TABLE `deluxe_toppings` DISABLE KEYS */;
/*!40000 ALTER TABLE `deluxe_toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deluxe_toppings_price`
--

DROP TABLE IF EXISTS `deluxe_toppings_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deluxe_toppings_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deluxe_toppings_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `deluxe_toppings_price_deluxe_toppings_id_idx` (`deluxe_toppings_id`),
  KEY `deluxe_toppings_price_product_id_idx` (`product_id`),
  CONSTRAINT `deluxe_toppings_price_deluxe_toppings_id` FOREIGN KEY (`deluxe_toppings_id`) REFERENCES `deluxe_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `deluxe_toppings_price_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deluxe_toppings_price`
--

LOCK TABLES `deluxe_toppings_price` WRITE;
/*!40000 ALTER TABLE `deluxe_toppings_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `deluxe_toppings_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` datetime DEFAULT NULL,
  `takeaway` int(11) DEFAULT '0',
  `issued` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_basic_toppings`
--

DROP TABLE IF EXISTS `order_basic_toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_basic_toppings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `basic_toppings_id` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_basic_toppings_order_id_idx` (`order_id`),
  KEY `order_basic_toppings_basic_toppings_id_idx` (`basic_toppings_id`),
  CONSTRAINT `order_basic_toppings_basic_toppings_id` FOREIGN KEY (`basic_toppings_id`) REFERENCES `basic_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_basic_toppings_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_basic_toppings`
--

LOCK TABLES `order_basic_toppings` WRITE;
/*!40000 ALTER TABLE `order_basic_toppings` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_basic_toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_deluxe_toppings`
--

DROP TABLE IF EXISTS `order_deluxe_toppings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_deluxe_toppings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `deluxe_toppings_id` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_deluxe_toppings_order_id_idx` (`order_id`),
  KEY `order_deluxe_toppings_deluxe_toppings_id_idx` (`deluxe_toppings_id`),
  CONSTRAINT `order_deluxe_toppings_deluxe_toppings_id` FOREIGN KEY (`deluxe_toppings_id`) REFERENCES `deluxe_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_deluxe_toppings_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_deluxe_toppings`
--

LOCK TABLES `order_deluxe_toppings` WRITE;
/*!40000 ALTER TABLE `order_deluxe_toppings` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_deluxe_toppings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_products`
--

DROP TABLE IF EXISTS `order_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_products_order_id_idx` (`order_id`),
  KEY `order_products_product_id_idx` (`product_id`),
  CONSTRAINT `order_products_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(128) DEFAULT 'dummy',
  `price` decimal(16,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`id`, `description`, `price`) VALUES (1,'Small Pizza',12.00),(2,'Medium Pizza',14.00),(3,'Large Pizza',16.00);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT 'dummy',
  `value` varchar(45) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` (`id`, `name`, `value`) VALUES (1,'GST','5');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pizzajoint'
--

--
-- Dumping routines for database 'pizzajoint'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-10 20:44:48
