-- CS340 Project Step 7 Data Definition Queries
-- Project Group 23: Danny Tran, Jesus Madrigales
-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Mar 08, 2019 at 06:58 PM
-- Server version: 10.1.22-MariaDB
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_trandan`
--

-- --------------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `got_characters`;
DROP TABLE IF EXISTS `got_continents`;
DROP TABLE IF EXISTS `got_events`;
DROP TABLE IF EXISTS `got_events_characters`;
DROP TABLE IF EXISTS `got_house`;
DROP TABLE IF EXISTS `got_house_status`;
DROP TABLE IF EXISTS `got_locations`;
DROP TABLE IF EXISTS `got_species`;

-- --------------------------------------------------------

--
-- Table structure for table `got_characters`
--

CREATE TABLE `got_characters` (
  `id` int(11) NOT NULL,
  `fname` varchar(30) NOT NULL,
  `lname` varchar(30) DEFAULT NULL,
  `house_id` int(11) DEFAULT NULL,
  `origin` int(11) DEFAULT NULL,
  `weapon` varchar(30) DEFAULT NULL,
  `status` enum('alive','dead','Wight') NOT NULL DEFAULT 'alive',
  `organization` varchar(60) DEFAULT NULL,
  `species_id` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_characters`
--

INSERT INTO `got_characters` (`id`, `fname`, `lname`, `house_id`, `origin`, `weapon`, `status`, `organization`, `species_id`) VALUES
(49, 'Pyat', 'Pree', NULL, NULL, NULL, 'dead', 'Warlocks of Quarth', 6),
(50, 'Robb', 'Stark', 2, NULL, NULL, 'dead', NULL, 1),
(141, 'Jon', 'Snow', 2, NULL, 'Longclaw', 'alive', NULL, 1),
(142, 'Aegon', 'Targaryeon', 2, NULL, NULL, 'alive', NULL, 1),
(147, 'Hodor', NULL, NULL, NULL, NULL, 'dead', NULL, 1),
(344, 'Tommen', 'Baratheon', 3, 7, NULL, 'dead', 'Seven Kingdoms', 1),
(433, 'Cersei', 'Lannister', 4, 4, NULL, 'alive', 'Seven Kingdoms', 1),
(443, 'Eddard', 'Stark', 2, NULL, 'Ice', 'dead', NULL, 1),
(454, 'Petyr', 'Baelish', NULL, NULL, NULL, 'alive', NULL, 1),
(462, 'Daenerys', 'Targaryen', NULL, 20, 'dragons', 'alive', NULL, 1),
(540, 'Tyrion', 'Lannister', 4, 4, 'Intelligence', 'alive', 'Team Targaryen', 1),
(737, 'Drogon', NULL, NULL, NULL, 'dragon fire', 'alive', NULL, 3),
(752, 'Robert', 'Baratheon', 3, NULL, 'War Hammer', 'dead', 'Seven Kingdoms', 1),
(757, 'Sansa', 'Stark', 2, 3, NULL, 'alive', 'The North', 1),
(758, 'Talla', 'Tarly', 2, 21, NULL, 'alive', NULL, 1),
(759, 'Euron', 'Greyjoy', 34, NULL, 'Two-handed battleaxe', 'alive', NULL, 1),
(760, 'Robin', 'Arryn', 37, 32, NULL, 'alive', NULL, 1),
(761, 'Wun Wun', NULL, NULL, NULL, NULL, 'Wight', 'Free Folk', 4),
(762, 'Edmure', 'Tully', 40, 52, 'Sword', 'alive', NULL, 1),
(763, 'Oberyn ', 'Martell', 41, 36, 'Spear', 'dead', 'Small Council', 1),
(764, 'Doran ', 'Martell', 41, 36, NULL, 'dead', NULL, 1),
(765, 'Arthur ', 'Dayne', 42, 36, 'Dawn (sword)', 'dead', 'Kingsguard', 1),
(766, 'Arya ', 'Stark', 2, 3, 'Many faces; Needle (sword)', 'alive', 'Faceless Men', 1),
(767, 'Walder', 'Frey', 43, 23, NULL, 'dead', NULL, 1),
(768, 'Balon', 'Greyjoy', 34, 35, 'Ships', 'dead', NULL, 1),
(769, 'Joffrey', 'Baratheon', 3, 7, 'Bow and Arrow', 'dead', 'The Seven Kingdoms', 1),
(770, 'Olenna', 'Martell', 41, 53, 'Poison', 'dead', NULL, 1),
(771, 'Tywin', 'Lannister', 4, 4, 'Influence', 'alive', 'Small Council ', 1),
(772, 'Stannis ', 'Baratheon ', 3, 29, 'Sword', 'dead', NULL, 1),
(773, 'Renly', 'Baratheon', 3, 29, NULL, 'dead', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `got_continents`
--

CREATE TABLE `got_continents` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_continents`
--

INSERT INTO `got_continents` (`id`, `name`) VALUES
(2, 'Essos'),
(3, 'Sothoryos'),
(1, 'Westeros');

-- --------------------------------------------------------

--
-- Table structure for table `got_events`
--

CREATE TABLE `got_events` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `location` int(11) DEFAULT NULL,
  `season` smallint(6) DEFAULT NULL,
  `episode` smallint(6) DEFAULT NULL,
  `summary` varchar(4000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_events`
--

INSERT INTO `got_events` (`id`, `name`, `location`, `season`, `episode`, `summary`) VALUES
(3, 'The Battle of Castle Black', NULL, 4, 9, 'A group of wildlings, including Jon Snow\'s lover Ygritte, attempt to take Castle Black at the Wall, but they lose the battle. Ygritte is killed and dies in Jon\'s arms.'),
(4, 'Battle of the Bastards', 3, 6, 9, 'The Battle of the Bh.'),
(5, 'Battle of the Blackwater', 7, 2, 9, 'The battle was an attempt by Stannis Baratheon, brother of the late King Robert Baratheon, to take King\'s Landing, the capital of the Seven Kingdoms, and to seize the Iron Throne from King Joffrey Baratheon. It required a naval assault and an attack on the city gates by land. Tyrion Lannister, acting Hand of the King, led the defense of the city. He successfully destroyed a large portion of Stannis\'s fleet through the use of wildfire, but was unable to prevent Stannis\'s army from landing and gaining the walls of the city. However, late-arriving reinforcements under Lord Tywin Lannister, Lord Mace Tyrell, and Ser Loras Tyrell defeated Stannis\'s army, resulting in a decisive Lannister-Tyrell victory in King Joffrey\'s name.'),
(6, 'Red Wedding', NULL, 3, 9, 'The Red Wedding was a massacre that happened at the Twins, castle homeland of the Freys, arranged by Lord Walder Frey as revenge against King Robb Stark for breaking the marriage pact between House Stark and House Frey. During the massacre, King Robb, his wife, Queen Talisa, his mother, Lady Catelyn, most of his bannermen and men-at-arms (~15,000 men) are murdered following the marriage feast and bedding of Edmure Tully, Robb\'s uncle, and Roslin Frey.'),
(7, 'Purple Wedding', 7, 4, 9, 'The Purple Wedding was an event in the War of the Five Kings that lead to the death of King Joffrey Baratheon at the wedding feast to his new queen, Margaery Tyrell. Mere hours after their wedding ceremony in the Great Sept of Baelor, King Joffrey is poisoned during the wedding feast. Joffrey\'s uncle, Tyrion Lannister, is arrested for the murder, and Sansa Stark is accused of being his accomplice, though the actual orchestrators are Lord Petyr Baelish and Lady Olenna Tyrell.'),
(18, 'The War of the Five Kings', 7, 1, 3, 'The War of the Five Kings was a major civil war in the Seven Kingdoms of Westeros that erupted in the wake of the death of King Robert I. In essence, the war was a three-way battle for the Iron Throne fought alongside two independence movements. The five kings in question were Robert\'s heir apparent, Joffrey Baratheon, Robert\'s two younger brothers, Stannis and Renly Baratheon, the \"King in the North\" Robb Stark, and the \"King of the Iron Islands\" Balon Greyjoy.');

-- --------------------------------------------------------

--
-- Table structure for table `got_events_characters`
--

CREATE TABLE `got_events_characters` (
  `id` int(11) NOT NULL,
  `event_id` int(11) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_events_characters`
--

INSERT INTO `got_events_characters` (`id`, `event_id`, `character_id`) VALUES
(31, 7, 769),
(32, 7, 454),
(33, 7, 770),
(34, 7, 757),
(35, 7, 540),
(36, 7, 344),
(37, 7, 763),
(38, 18, 769),
(39, 18, 50),
(40, 18, 771),
(41, 18, 772),
(42, 18, 773),
(43, 6, 50),
(44, 5, 49),
(45, 5, 540),
(46, 4, 141),
(47, 4, 757),
(48, 3, 49),
(51, 18, 752);

-- --------------------------------------------------------

--
-- Table structure for table `got_house`
--

CREATE TABLE `got_house` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `sigil` varchar(90) DEFAULT NULL,
  `head` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_house`
--

INSERT INTO `got_house` (`id`, `name`, `sigil`, `head`, `status_id`) VALUES
(2, 'Stark', 'A grey direwolf on a white field', 49, 3),
(3, 'Baratheon', 'A crowned black stag rampant on a gold field', 44, 3),
(4, 'Lannister', 'A golden lion rampant on a crimson field', 433, 1),
(7, 'Targaryen', 'A red three-headed dragon', 462, 1),
(29, 'Tyrell', 'A golden rose on a green field', NULL, 3),
(33, 'Tarly', 'A striding huntsman, red on green', 758, 2),
(34, 'Greyjoy', 'A golden kraken on a black field', 759, 1),
(36, 'Bolton ', 'A red flayed man, hanging upside-down on a white X-shaped cross, on a black background.', NULL, 3),
(37, 'Arryn', 'A white falcon volant and crescent moon on a blue field.', 760, 1),
(40, 'Tully', 'A silver trout leaping on a red and blue background.', 762, 1),
(41, 'Martell', 'A red sun spear pierced by a gold spear on an orange field.', NULL, 3),
(42, 'Dayne', 'A white sword and falling star on a purple field.', NULL, 2),
(43, 'Frey', 'The two stone grey towers and bridge of the Twins, on a dark grey field.', NULL, 3);

-- --------------------------------------------------------

--
-- Table structure for table `got_house_status`
--

CREATE TABLE `got_house_status` (
  `id` int(11) NOT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_house_status`
--

INSERT INTO `got_house_status` (`id`, `status`) VALUES
(3, 'Extinct'),
(1, 'Great House'),
(2, 'Vassal');

-- --------------------------------------------------------

--
-- Table structure for table `got_locations`
--

CREATE TABLE `got_locations` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `region` varchar(60) DEFAULT NULL,
  `continent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_locations`
--

INSERT INTO `got_locations` (`id`, `name`, `region`, `continent_id`) VALUES
(3, 'Winterfell', 'The North', 1),
(4, 'Casterly Rock', 'The Westerlands', 1),
(5, 'Braavos', 'The Free Cities', 3),
(6, 'Naath', 'The Summer Sea', 3),
(7, 'King\'s Landing', 'The Crownlands', 1),
(20, 'Dragonstone', 'Blackwater Bay', 1),
(21, 'Horn Hill', 'The Reach', 1),
(22, 'Quarth', NULL, 2),
(23, 'The Twins', 'The Riverlands', 1),
(24, 'Bear Island', 'The North', 1),
(25, 'The Dreadfort', 'The North', 1),
(26, 'Karhold ', 'The North', 1),
(27, 'Clegane\'s Keep', 'The Westerlands', 1),
(28, 'Highgarden', 'The Reach', 1),
(29, 'Storm\'s End', 'The Stormlands', 1),
(30, 'Evenfall Hall', 'The Stormlands', 1),
(31, 'Blackhaven', 'The Stormlands', 1),
(32, 'The Eyrie', 'The Vale', 1),
(33, 'Runestone', 'The Vale', 1),
(34, 'Dragonstone', 'The Crownlands', 1),
(35, 'Pyke ', 'Iron Islands', 1),
(36, 'Sunspear', 'Dorne', 1),
(37, 'Starfall', 'Dorne', 1),
(38, 'Fist of First Men', 'Beyond the Wall', 1),
(39, 'Hardhome', 'Beyond the Wall', 1),
(40, 'Crasters Keep', 'Beyond the Wall', 1),
(41, 'Pentos', 'The Free Cities', 2),
(42, 'Volantis', 'The Free Cities', 2),
(43, 'Lys', 'The Free Cities', 2),
(44, 'Lorath', 'The Free Cities', 2),
(45, 'Myr', 'The Free Cities', 2),
(46, 'Tyroshi', 'The Free Cities', 2),
(47, 'Astapor', 'Slaver\'s Bay', 2),
(48, 'Yunkai', 'Slaver\'s Bay', 2),
(49, 'Meereen ', 'Slaver\'s Bay', 2),
(50, 'Valyria', 'Valyrian Peninsula', 2),
(51, 'Vaes Dothrak', 'Dothraki Sea', 2),
(52, 'Riverrun', 'The Riverlands', 1),
(53, 'The Arbor', 'The Reach', 1);

-- --------------------------------------------------------

--
-- Table structure for table `got_species`
--

CREATE TABLE `got_species` (
  `id` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_species`
--

INSERT INTO `got_species` (`id`, `name`) VALUES
(5, 'Children of the Forest'),
(3, 'dragon'),
(4, 'giant'),
(1, 'human'),
(6, 'warlock'),
(2, 'White Walker');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `got_characters`
--
ALTER TABLE `got_characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `origin` (`origin`),
  ADD KEY `got_characters_ibfk_2` (`house_id`),
  ADD KEY `species_id` (`species_id`);

--
-- Indexes for table `got_continents`
--
ALTER TABLE `got_continents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `got_events`
--
ALTER TABLE `got_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location` (`location`);

--
-- Indexes for table `got_events_characters`
--
ALTER TABLE `got_events_characters`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `character_id` (`character_id`);

--
-- Indexes for table `got_house`
--
ALTER TABLE `got_house`
  ADD PRIMARY KEY (`id`),
  ADD KEY `current_head` (`head`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `got_house_status`
--
ALTER TABLE `got_house_status`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `status` (`status`);

--
-- Indexes for table `got_locations`
--
ALTER TABLE `got_locations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `continent_id` (`continent_id`);

--
-- Indexes for table `got_species`
--
ALTER TABLE `got_species`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `got_characters`
--
ALTER TABLE `got_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=774;

--
-- AUTO_INCREMENT for table `got_continents`
--
ALTER TABLE `got_continents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `got_events`
--
ALTER TABLE `got_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `got_events_characters`
--
ALTER TABLE `got_events_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `got_house`
--
ALTER TABLE `got_house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `got_house_status`
--
ALTER TABLE `got_house_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `got_locations`
--
ALTER TABLE `got_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `got_species`
--
ALTER TABLE `got_species`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `got_characters`
--
ALTER TABLE `got_characters`
  ADD CONSTRAINT `got_characters_ibfk_1` FOREIGN KEY (`origin`) REFERENCES `got_locations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `got_characters_ibfk_2` FOREIGN KEY (`house_id`) REFERENCES `got_house` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `got_characters_ibfk_3` FOREIGN KEY (`species_id`) REFERENCES `got_species` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `got_events`
--
ALTER TABLE `got_events`
  ADD CONSTRAINT `got_events_ibfk_1` FOREIGN KEY (`location`) REFERENCES `got_locations` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `got_events_characters`
--
ALTER TABLE `got_events_characters`
  ADD CONSTRAINT `got_events_characters_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `got_events` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `got_events_characters_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `got_characters` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `got_house`
--
ALTER TABLE `got_house`
  ADD CONSTRAINT `got_house_ibfk_1` FOREIGN KEY (`head`) REFERENCES `got_characters` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `got_house_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `got_house_status` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `got_locations`
--
ALTER TABLE `got_locations`
  ADD CONSTRAINT `got_locations_ibfk_1` FOREIGN KEY (`continent_id`) REFERENCES `got_continents` (`id`) ON DELETE SET NULL;
COMMIT;



SET FOREIGN_KEY_CHECKS = 1;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
