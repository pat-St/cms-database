SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `ferienwvk_db1` DEFAULT CHARACTER SET utf16 COLLATE utf16_general_ci;
USE `ferienwvk_db1`;

DROP TABLE IF EXISTS `Tile`;
CREATE TABLE `Tile` (
  `ID` int(11) NOT NULL,
  `titleName` varchar(30) NOT NULL,
  `description` text NULL,
  `kachelType` int(11) NOT NULL,
  `modalType` int(11) NOT NULL,
  `kachelSize` int(11) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `ApartmentContent`;
CREATE TABLE `ApartmentContent` (
  `ID` int(11) NOT NULL,
  `fk_tile` int(11) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `ApartmentContent_ibfk_1` FOREIGN KEY (`fk_tile`) 
  REFERENCES `Tile` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `ApartmentDescription`;
CREATE TABLE `ApartmentDescription` (
  `ID` int(11) NOT NULL,
  `description` text NOT NULL,
  `info` text NOT NULL,
  `fk_apartment` int(11) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `ApartmentDescription_ibfk_1` FOREIGN KEY (`fk_apartment`) 
  REFERENCES `ApartmentContent` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `ApartmentDetails`;
CREATE TABLE `ApartmentDetails` (
  `ID` int(11) NOT NULL,
  `identifier` text NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `ApartmentPrice`;
CREATE TABLE `ApartmentPrice` (
  `ID` int(11) NOT NULL,
  `personCount` text NOT NULL,
  `peakSeason` text NOT NULL,
  `offSeason` text NOT NULL,
  `nights` text NOT NULL,
  `fk_apartment` int(11) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `ApartmentPrice_ibfk_1` FOREIGN KEY (`fk_apartment`) 
  REFERENCES `ApartmentContent` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `DetailsToApartment`;
CREATE TABLE `DetailsToApartment` (
  `ID` int(11) NOT NULL,
  `info` text NOT NULL,
  `fk_apartment` int(11) NOT NULL,
  `fk_details` int(11) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `DetailsToApartment_ibfk_1` FOREIGN KEY (`fk_apartment`) 
  REFERENCES `ApartmentContent` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `DetailsToApartment_ibfk_2` FOREIGN KEY (`fk_details`) 
  REFERENCES `ApartmentDetails` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `InfoText`;
CREATE TABLE `InfoText` (
  `ID` int(11) NOT NULL,
  `headerText` text NULL,
  `contentText` text NULL,
  `link` text NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `InfoTextToTile`;
CREATE TABLE `InfoTextToTile` (
  `ID` int(11) NOT NULL,
  `fk_info` int(11) NOT NULL,
  `fk_tile` int(11) NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `InfoTextToTile_ibfk_1` FOREIGN KEY (`fk_info`) 
  REFERENCES `InfoText` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `InfoTextToTile_ibfk_2` FOREIGN KEY (`fk_tile`) 
  REFERENCES `Tile` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `Image`;
CREATE TABLE `Image` (
  `ID` int(11) NOT NULL,
  `image` longblob NOT NULL,
  `description` varchar(70) DEFAULT NULL,
  `fk_apartment` int(11) DEFAULT NULL,
  `fk_info` int(11) DEFAULT NULL,  
  `fk_tile` int(11) DEFAULT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT `Image_ibfk_1` FOREIGN KEY (`fk_apartment`) 
  REFERENCES `ApartmentContent` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `Image_ibfk_2` FOREIGN KEY (`fk_info`) 
  REFERENCES `InfoText` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `Image_ibfk_3` FOREIGN KEY (`fk_tile`) 
  REFERENCES `Tile` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

DROP TABLE IF EXISTS `WUser`;
CREATE TABLE `WUser` (
  `ID` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `pw` text NOT NULL,
  `salt` text NOT NULL,
  `token` text NOT NULL,
  `mail` text NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT name_unique UNIQUE (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf16;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;