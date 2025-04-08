-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Aprill 08, 2025 kell 01:41 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `sergejevlogitpv23`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `autod`
--

CREATE TABLE `autod` (
  `autodID` int(11) NOT NULL,
  `autoNR` char(12) DEFAULT NULL,
  `mudell` char(12) DEFAULT NULL,
  `mark` char(12) DEFAULT NULL,
  `v_aasta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `autod`
--

INSERT INTO `autod` (`autodID`, `autoNR`, `mudell`, `mark`, `v_aasta`) VALUES
(1, 'EST111', 'Audi', 'Q7', 2016),
(2, 'TSE131', 'Audi', 'A8', 2007);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `elukoht`
--

CREATE TABLE `elukoht` (
  `elukohtID` int(11) NOT NULL,
  `elukoht` varchar(50) DEFAULT NULL,
  `maakond` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `elukoht`
--

INSERT INTO `elukoht` (`elukohtID`, `elukoht`, `maakond`) VALUES
(1, 'Tallinn', 'Harjumaa'),
(2, 'Keila', 'Harjumaa'),
(3, 'Pärnu', 'Pärnumaa');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `inimene`
--

CREATE TABLE `inimene` (
  `inimeneID` int(11) NOT NULL,
  `nimi` varchar(50) DEFAULT NULL,
  `sunniaeg` date DEFAULT NULL,
  `telefon` char(12) DEFAULT NULL,
  `pikkus` decimal(5,2) DEFAULT NULL,
  `opilaskodu` bit(1) DEFAULT NULL,
  `elukohtID` int(11) DEFAULT NULL,
  `autodID` int(11) DEFAULT NULL,
  `loomID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `inimene`
--

INSERT INTO `inimene` (`inimeneID`, `nimi`, `sunniaeg`, `telefon`, `pikkus`, `opilaskodu`, `elukohtID`, `autodID`, `loomID`) VALUES
(1, 'Peeter Uus', '2021-12-30', '9564735', 85.50, b'0', 2, 2, 1),
(2, 'Mari Speek', '1980-10-20', '778795', 174.50, b'0', 3, 1, 3),
(3, 'Tonu Talve', '2075-05-10', '656295', 180.50, b'0', 1, 2, 1),
(4, 'Peeter Oja', '2005-11-17', '2865995', 182.50, b'1', 1, 1, 2),
(5, 'Peeter Sir', '2021-12-30', '2564735', 82.50, b'0', 2, 1, 4),
(6, 'Peeter Surr22', '2002-12-30', '5835735', 192.00, b'0', 2, 1, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `loom`
--

CREATE TABLE `loom` (
  `loomID` int(11) NOT NULL,
  `nimi` varchar(50) DEFAULT NULL,
  `kaal` int(11) DEFAULT NULL,
  `tiipID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `loom`
--

INSERT INTO `loom` (`loomID`, `nimi`, `kaal`, `tiipID`) VALUES
(1, 'Timur', 28, 1),
(2, 'Kirill', 52, 3),
(3, 'Goshik', 15, 2),
(4, 'Kesha', 16, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tiip`
--

CREATE TABLE `tiip` (
  `tiipID` int(11) NOT NULL,
  `tiip` char(12) DEFAULT NULL,
  `kirjeldus` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `tiip`
--

INSERT INTO `tiip` (`tiipID`, `tiip`, `kirjeldus`) VALUES
(1, 'Koer', 'Koduloom'),
(2, 'Kass', 'Kodune lemmikloom'),
(3, 'Papagoi', 'Koduloom lind');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `autod`
--
ALTER TABLE `autod`
  ADD PRIMARY KEY (`autodID`),
  ADD UNIQUE KEY `autoNR` (`autoNR`);

--
-- Indeksid tabelile `elukoht`
--
ALTER TABLE `elukoht`
  ADD PRIMARY KEY (`elukohtID`),
  ADD UNIQUE KEY `elukoht` (`elukoht`);

--
-- Indeksid tabelile `inimene`
--
ALTER TABLE `inimene`
  ADD PRIMARY KEY (`inimeneID`),
  ADD UNIQUE KEY `nimi` (`nimi`),
  ADD KEY `fk_elukoht` (`elukohtID`),
  ADD KEY `fk_autod` (`autodID`),
  ADD KEY `fk_loom` (`loomID`);

--
-- Indeksid tabelile `loom`
--
ALTER TABLE `loom`
  ADD PRIMARY KEY (`loomID`),
  ADD UNIQUE KEY `nimi` (`nimi`),
  ADD KEY `fk_tiip` (`tiipID`);

--
-- Indeksid tabelile `tiip`
--
ALTER TABLE `tiip`
  ADD PRIMARY KEY (`tiipID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `autod`
--
ALTER TABLE `autod`
  MODIFY `autodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `elukoht`
--
ALTER TABLE `elukoht`
  MODIFY `elukohtID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `inimene`
--
ALTER TABLE `inimene`
  MODIFY `inimeneID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `loom`
--
ALTER TABLE `loom`
  MODIFY `loomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `tiip`
--
ALTER TABLE `tiip`
  MODIFY `tiipID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `inimene`
--
ALTER TABLE `inimene`
  ADD CONSTRAINT `fk_autod` FOREIGN KEY (`autodID`) REFERENCES `autod` (`autodID`),
  ADD CONSTRAINT `fk_elukoht` FOREIGN KEY (`elukohtID`) REFERENCES `elukoht` (`elukohtID`),
  ADD CONSTRAINT `fk_loom` FOREIGN KEY (`loomID`) REFERENCES `loom` (`loomID`);

--
-- Piirangud tabelile `loom`
--
ALTER TABLE `loom`
  ADD CONSTRAINT `fk_tiip` FOREIGN KEY (`tiipID`) REFERENCES `tiip` (`tiipID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
