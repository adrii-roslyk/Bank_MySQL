-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.29 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5958
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for bamk
CREATE DATABASE IF NOT EXISTS `bamk` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `bamk`;

-- Dumping structure for table bamk.accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `balance` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_currency_id` (`user_id`,`currency_id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `accounts_ibfk_2` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.accounts: ~16 rows (approximately)
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` (`id`, `balance`, `user_id`, `currency_id`) VALUES
	(1, 10867, 1, 1),
	(2, 435, 1, 2),
	(3, 5563, 1, 3),
	(4, 25458, 2, 1),
	(5, 22849, 2, 2),
	(6, 451, 2, 3),
	(7, 3844, 3, 1),
	(8, 100, 3, 2),
	(9, 100, 3, 3),
	(10, 1500, 4, 1),
	(11, 52622, 4, 2),
	(12, 1500, 4, 3),
	(13, 8187, 5, 2),
	(14, 2655, 5, 3),
	(15, 129, 6, 1),
	(16, 7266, 6, 3);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;

-- Dumping structure for table bamk.amounts
CREATE TABLE IF NOT EXISTS `amounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `cashbox_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cashbox_id_value` (`cashbox_id`,`value`),
  CONSTRAINT `amounts_ibfk_1` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.amounts: ~16 rows (approximately)
/*!40000 ALTER TABLE `amounts` DISABLE KEYS */;
INSERT INTO `amounts` (`id`, `value`, `quantity`, `cashbox_id`) VALUES
	(1, 100, 100, 1),
	(2, 50, 100, 1),
	(3, 20, 150, 1),
	(4, 10, 200, 1),
	(5, 5, 200, 1),
	(6, 50, 200, 2),
	(7, 20, 250, 2),
	(8, 10, 250, 2),
	(9, 5, 300, 2),
	(10, 500, 50, 3),
	(11, 200, 50, 3),
	(12, 100, 90, 3),
	(13, 50, 130, 3),
	(14, 20, 160, 3),
	(15, 10, 160, 3),
	(16, 5, 180, 3);
/*!40000 ALTER TABLE `amounts` ENABLE KEYS */;

-- Dumping structure for table bamk.cashboxes
CREATE TABLE IF NOT EXISTS `cashboxes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `city` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `model` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `currency_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `currency_id` (`currency_id`),
  CONSTRAINT `cashboxes_ibfk_1` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.cashboxes: ~3 rows (approximately)
/*!40000 ALTER TABLE `cashboxes` DISABLE KEYS */;
INSERT INTO `cashboxes` (`id`, `city`, `model`, `currency_id`) VALUES
	(1, 'Chicago', 'Genmega 2500', 1),
	(2, 'London', 'Triton’s RL5000', 2),
	(3, 'Amsterdam', 'Hyosung 1800', 3);
/*!40000 ALTER TABLE `cashboxes` ENABLE KEYS */;

-- Dumping structure for table bamk.currencies
CREATE TABLE IF NOT EXISTS `currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sign` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `sign` (`sign`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.currencies: ~4 rows (approximately)
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` (`id`, `sign`, `name`) VALUES
	(1, '$', 'USD'),
	(2, '£', 'GBP'),
	(3, '€', 'EUR');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;

-- Dumping structure for table bamk.logs
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `amount` int(11) NOT NULL,
  `cashbox_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cashbox_id` (`cashbox_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`cashbox_id`) REFERENCES `cashboxes` (`id`),
  CONSTRAINT `logs_ibfk_2` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.logs: ~13 rows (approximately)
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` (`id`, `date`, `amount`, `cashbox_id`, `account_id`) VALUES
	(1, '2019-11-17 19:07:03', 2000, 1, 1),
	(2, '2019-11-25 15:06:01', 900, 2, 2),
	(3, '2019-12-30 20:09:15', 1500, 3, 3),
	(4, '2019-12-25 11:25:39', 4500, 1, 4),
	(5, '2019-12-30 14:05:18', 4000, 2, 5),
	(6, '2020-02-14 17:42:02', 7400, 3, 6),
	(7, '2019-12-24 09:54:56', 800, 1, 7),
	(8, '2019-12-31 12:26:16', 550, 1, 7),
	(9, '2019-12-31 19:45:34', 100, 1, 7),
	(10, '2019-12-23 16:04:25', 5000, 2, 11),
	(11, '2020-01-02 13:41:00', 5000, 2, 11),
	(12, '2020-01-07 07:12:58', 1500, 2, 13),
	(13, '2020-01-13 21:05:15', 1350, 3, 14),
	(14, '2019-12-23 18:38:25', 2000, 3, 16),
	(15, '2019-12-30 14:14:23', 12500, 3, 16);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;

-- Dumping structure for table bamk.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `age` int(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table bamk.users: ~5 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `age`) VALUES
	(1, 'Ernst Handel', 26),
	(2, 'John Steel', 35),
	(3, 'Yoshi Latimer', 37),
	(4, 'Rene Phillips', 46),
	(5, 'Fran Wilson', 51),
	(6, 'Martin Bein', 19);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
