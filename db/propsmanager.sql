-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 19, 2023 at 02:22 AM
-- Server version: 5.7.36
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `propsmanager`
--

-- --------------------------------------------------------

--
-- Table structure for table `appsettings`
--

DROP TABLE IF EXISTS `appsettings`;
CREATE TABLE IF NOT EXISTS `appsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `appsettings`
--

INSERT INTO `appsettings` (`id`, `name`, `value`, `description`, `createdAt`, `updatedAt`) VALUES
(1, 'urlPrefix', 'http://localhost:3001/', 'The domain to use in correspondence', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(2, 'appTitle', 'Tenant Service Portal', 'Page title', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(3, 'stripeApiKey', 'pk_test_edJT25Bz1YVCJKIMvmBGCS5Y', 'Shareable stripe api key', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(4, 'bannerText', '132 Chapel St', 'Text to display in the navbar', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(5, 'DOMAIN', 'mg.propyty.com', 'mailgun domain', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(6, 'PRIVATE_KEY', '96ccaab2966f51524690354622d8cf12-d1a07e51-29129807', 'mailgun private key', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(7, 'GOOGLE_CLIENT_ID', '65718648734-6287l7c33m77jpm0civ9s2m4qnqv9ges.apps.googleusercontent.com', 'mailgun private key', '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(8, 'GOOGLE_CLIENT_SECRET', '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', 'mailgun private key', '2023-02-12 04:27:37', '2023-02-12 04:27:37');

-- --------------------------------------------------------

--
-- Table structure for table `creds`
--

DROP TABLE IF EXISTS `creds`;
CREATE TABLE IF NOT EXISTS `creds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `local_password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
CREATE TABLE IF NOT EXISTS `maintenances` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UnitId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UnitId` (`UnitId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` float NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `due_date` datetime NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UnitId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UnitId` (`UnitId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `amount`, `paid`, `due_date`, `createdAt`, `updatedAt`, `UnitId`) VALUES
(1, 450, 0, '2018-04-16 17:58:52', '2023-02-12 04:27:37', '2023-02-12 04:27:37', 1),
(2, 500, 0, '2018-04-16 17:58:52', '2023-02-12 04:27:37', '2023-02-12 04:27:37', 1),
(3, 90, 0, '2023-01-31 17:00:00', '2023-02-12 04:28:00', '2023-02-12 04:28:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(32) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
CREATE TABLE IF NOT EXISTS `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unitName` varchar(255) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unitName`, `rate`, `createdAt`, `updatedAt`) VALUES
(1, 'Big Office', 90, '2023-02-12 04:27:37', '2023-02-12 04:27:37');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `activationCode` varchar(255) DEFAULT NULL,
  `authtype` varchar(255) DEFAULT NULL,
  `local_username` varchar(255) DEFAULT NULL,
  `googleId` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `zip` int(11) DEFAULT NULL,
  `stripeCustToken` varchar(255) DEFAULT NULL,
  `stripeACHToken` varchar(255) DEFAULT NULL,
  `stripeACHVerified` tinyint(1) NOT NULL DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `role`, `activationCode`, `authtype`, `local_username`, `googleId`, `phone`, `email`, `address`, `city`, `state`, `zip`, `stripeCustToken`, `stripeACHToken`, `stripeACHVerified`, `createdAt`, `updatedAt`) VALUES
(1, 'admin j. user', 'admin', 'admin', NULL, NULL, NULL, '000-000-0000', 'fake@web.com', 'none', 'none', 'CA', 90210, NULL, NULL, 0, '2023-02-12 04:27:37', '2023-02-12 04:27:37'),
(2, 'Freddy McTenant', 'tenant', 'tenant', NULL, NULL, NULL, '000-000-0000', 'fake@mail.com', 'none', 'none', 'CA', 90210, NULL, NULL, 0, '2023-02-12 04:27:37', '2023-02-12 04:27:37');

-- --------------------------------------------------------

--
-- Table structure for table `user_unit`
--

DROP TABLE IF EXISTS `user_unit`;
CREATE TABLE IF NOT EXISTS `user_unit` (
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UnitId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`UnitId`,`UserId`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_unit`
--

INSERT INTO `user_unit` (`createdAt`, `updatedAt`, `UnitId`, `UserId`) VALUES
('2023-02-12 04:27:38', '2023-02-12 04:27:38', 1, 1),
('2023-02-12 04:27:38', '2023-02-12 04:27:38', 1, 2);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `creds`
--
ALTER TABLE `creds`
  ADD CONSTRAINT `creds_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `maintenances`
--
ALTER TABLE `maintenances`
  ADD CONSTRAINT `maintenances_ibfk_1` FOREIGN KEY (`UnitId`) REFERENCES `units` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`UnitId`) REFERENCES `units` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `user_unit`
--
ALTER TABLE `user_unit`
  ADD CONSTRAINT `user_unit_ibfk_1` FOREIGN KEY (`UnitId`) REFERENCES `units` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_unit_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
