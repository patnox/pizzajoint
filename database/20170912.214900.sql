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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basic_toppings`
--

LOCK TABLES `basic_toppings` WRITE;
/*!40000 ALTER TABLE `basic_toppings` DISABLE KEYS */;
INSERT INTO `basic_toppings` (`id`, `description`) VALUES (1,'Cheese'),(2,'Pepperoni'),(3,'Ham'),(4,'Pineapple');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `basic_toppings_price`
--

LOCK TABLES `basic_toppings_price` WRITE;
/*!40000 ALTER TABLE `basic_toppings_price` DISABLE KEYS */;
INSERT INTO `basic_toppings_price` (`id`, `basic_toppings_id`, `product_id`, `price`) VALUES (1,1,1,0.50),(2,2,1,0.50),(3,3,1,0.50),(4,4,1,0.50),(5,1,2,0.75),(6,2,2,0.75),(7,3,2,0.75),(8,4,2,0.75),(9,1,3,1.00),(10,2,3,1.00),(11,3,3,1.00),(12,4,3,1.00);
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deluxe_toppings`
--

LOCK TABLES `deluxe_toppings` WRITE;
/*!40000 ALTER TABLE `deluxe_toppings` DISABLE KEYS */;
INSERT INTO `deluxe_toppings` (`id`, `description`) VALUES (1,'Sausage'),(2,'Feta Cheese'),(3,'Tomatoes'),(4,'Olives');
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deluxe_toppings_price`
--

LOCK TABLES `deluxe_toppings_price` WRITE;
/*!40000 ALTER TABLE `deluxe_toppings_price` DISABLE KEYS */;
INSERT INTO `deluxe_toppings_price` (`id`, `deluxe_toppings_id`, `product_id`, `price`) VALUES (1,1,1,2.00),(2,2,1,2.00),(3,3,1,2.00),(4,4,1,2.00),(5,1,2,3.00),(6,2,2,3.00),(7,3,2,3.00),(8,4,2,3.00),(9,1,3,4.00),(10,2,3,4.00),(11,3,3,4.00),(12,4,3,4.00);
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
  `user_id` int(11) DEFAULT '0',
  `total` decimal(16,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` (`id`, `order_date`, `takeaway`, `issued`, `user_id`, `total`) VALUES (1,'2017-09-12 20:34:56',1,1,1,16.00),(2,'2017-09-12 20:38:39',1,1,1,30.00),(3,'2017-09-12 21:03:33',1,1,1,48.75),(4,'2017-09-12 21:25:02',1,1,1,46.50),(5,'2017-09-12 21:28:28',1,1,1,48.83);
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
  `quantity` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_basic_toppings_order_id_idx` (`order_id`),
  KEY `order_basic_toppings_basic_toppings_id_idx` (`basic_toppings_id`),
  CONSTRAINT `order_basic_toppings_basic_toppings_id` FOREIGN KEY (`basic_toppings_id`) REFERENCES `basic_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_basic_toppings_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_basic_toppings`
--

LOCK TABLES `order_basic_toppings` WRITE;
/*!40000 ALTER TABLE `order_basic_toppings` DISABLE KEYS */;
INSERT INTO `order_basic_toppings` (`id`, `order_id`, `basic_toppings_id`, `price`, `quantity`) VALUES (1,3,2,0.75,1),(2,4,2,1.00,1),(3,4,1,1.00,1),(4,4,2,0.75,1),(5,4,1,0.75,1),(6,4,2,0.50,1),(7,4,1,0.50,1),(8,5,2,1.00,1),(9,5,1,1.00,1),(10,5,2,0.75,1),(11,5,1,0.75,1),(12,5,2,0.50,1),(13,5,1,0.50,1);
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
  `quantity` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_deluxe_toppings_order_id_idx` (`order_id`),
  KEY `order_deluxe_toppings_deluxe_toppings_id_idx` (`deluxe_toppings_id`),
  CONSTRAINT `order_deluxe_toppings_deluxe_toppings_id` FOREIGN KEY (`deluxe_toppings_id`) REFERENCES `deluxe_toppings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_deluxe_toppings_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_deluxe_toppings`
--

LOCK TABLES `order_deluxe_toppings` WRITE;
/*!40000 ALTER TABLE `order_deluxe_toppings` DISABLE KEYS */;
INSERT INTO `order_deluxe_toppings` (`id`, `order_id`, `deluxe_toppings_id`, `price`, `quantity`) VALUES (1,3,4,4.00,1),(2,3,3,2.00,1);
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
  `quantity` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `order_products_order_id_idx` (`order_id`),
  KEY `order_products_product_id_idx` (`product_id`),
  CONSTRAINT `order_products_order_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `order_products_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_products`
--

LOCK TABLES `order_products` WRITE;
/*!40000 ALTER TABLE `order_products` DISABLE KEYS */;
INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `price`, `quantity`) VALUES (1,3,3,16.00,1),(2,3,2,14.00,1),(3,3,1,12.00,1),(4,4,3,16.00,1),(5,4,2,14.00,1),(6,4,1,12.00,1),(7,5,3,16.00,1),(8,5,2,14.00,1),(9,5,1,12.00,1);
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

-- Dump completed on 2017-09-12 21:40:40
