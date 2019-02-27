-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Feb 27, 2019 at 11:19 AM
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
(40, 'Jon', 'Snow', 2, 3, 'Longclaw', 'alive', 'Night\'s Watch', 1),
(41, 'Eddard', 'Stark', 2, 3, 'Ice', 'dead', NULL, 1),
(42, 'Hodor', NULL, NULL, 3, NULL, 'dead', NULL, 1),
(43, 'Arya', 'Stark', 2, 3, 'Valyrian steel dagger', 'alive', NULL, 1),
(44, 'Tommen', 'Baratheon', 3, NULL, NULL, 'dead', 'Seven Kingdoms', 1),
(45, 'Cersei', 'Lannister', 4, 4, NULL, 'alive', 'Seven Kingdoms', 1),
(46, 'Drogon', NULL, NULL, NULL, NULL, 'Wight', NULL, 3),
(47, 'Night King', NULL, NULL, NULL, NULL, 'alive', NULL, 2),
(48, 'Leaf', NULL, NULL, NULL, NULL, 'dead', NULL, 5),
(49, 'Pyat', 'Pree', NULL, 8, NULL, 'dead', 'Warlocks of Quarth', 6),
(50, 'Robb', 'Stark', 2, 3, NULL, 'dead', NULL, 1),
(51, 'aegon', 'targeryon', 4, 6, 'toothpick', 'Wight', 'brothers with banners', 3),
(52, '', '', 2, 3, '', 'alive', '', 5);

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
(3, 'The Battle of Castle Black', 9, 4, 9, 'A group of wildlings, including Jon Snow\'s lover Ygritte, attempt to take Castle Black at the Wall, but they lose the battle. Ygritte is killed and dies in Jon\'s arms.'),
(4, 'Battle of the Bastards', 3, 6, 9, 'The Battle of the Bastards is a battle late in the War of the Five Kings in which Jon Snow and Sansa Stark retake Winterfell from Lord Ramsay Bolton, the Warden of the North, and restore House Stark as the ruling house of the North.'),
(5, 'Battle of the Blackwater', 7, 2, 9, 'The battle was an attempt by Stannis Baratheon, brother of the late King Robert Baratheon, to take King\'s Landing, the capital of the Seven Kingdoms, and to seize the Iron Throne from King Joffrey Baratheon. It required a naval assault and an attack on the city gates by land. Tyrion Lannister, acting Hand of the King, led the defense of the city. He successfully destroyed a large portion of Stannis\'s fleet through the use of wildfire, but was unable to prevent Stannis\'s army from landing and gaining the walls of the city. However, late-arriving reinforcements under Lord Tywin Lannister, Lord Mace Tyrell, and Ser Loras Tyrell defeated Stannis\'s army, resulting in a decisive Lannister-Tyrell victory in King Joffrey\'s name.'),
(6, 'Red Wedding', 9, 3, 9, 'The Red Wedding was a massacre that happened at the Twins, castle homeland of the Freys, arranged by Lord Walder Frey as revenge against King Robb Stark for breaking the marriage pact between House Stark and House Frey. During the massacre, King Robb, his wife, Queen Talisa, his mother, Lady Catelyn, most of his bannermen and men-at-arms (~15,000 men) are murdered following the marriage feast and bedding of Edmure Tully, Robb\'s uncle, and Roslin Frey.');

-- --------------------------------------------------------

--
-- Table structure for table `got_events_characters`
--

CREATE TABLE `got_events_characters` (
  `event_id` int(11) DEFAULT NULL,
  `character_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_events_characters`
--

INSERT INTO `got_events_characters` (`event_id`, `character_id`) VALUES
(4, 40),
(3, 40),
(6, 50),
(5, 45);

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
(2, 'Stark', 'A grey direwolf on a white field\r\n', 40, 1),
(3, 'Baratheon', 'A crowned black stag rampant on a gold field', 44, 3),
(4, 'Lannister', 'A golden lion rampant on a crimson field', NULL, 1);

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
  `region` varchar(60) NOT NULL,
  `continent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `got_locations`
--

INSERT INTO `got_locations` (`id`, `name`, `region`, `continent_id`) VALUES
(3, 'Winterfell', 'The North', 1),
(4, 'Casterly Rock', 'The Westerlands', 1),
(5, 'Braavos', 'The Free Cities', 2),
(6, 'Naath', 'The Summer Sea', 3),
(7, 'King\'s Landing', 'The Crownlands', 1),
(8, 'Quarth', '', 2),
(9, 'The Twins', 'The Riverlands', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `got_continents`
--
ALTER TABLE `got_continents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `got_events`
--
ALTER TABLE `got_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `got_house`
--
ALTER TABLE `got_house`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `got_house_status`
--
ALTER TABLE `got_house_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `got_locations`
--
ALTER TABLE `got_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  ADD CONSTRAINT `got_characters_ibfk_1` FOREIGN KEY (`origin`) REFERENCES `got_locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `got_characters_ibfk_2` FOREIGN KEY (`house_id`) REFERENCES `got_house` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `got_characters_ibfk_3` FOREIGN KEY (`species_id`) REFERENCES `got_species` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `got_events`
--
ALTER TABLE `got_events`
  ADD CONSTRAINT `got_events_ibfk_1` FOREIGN KEY (`location`) REFERENCES `got_locations` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `got_events_characters`
--
ALTER TABLE `got_events_characters`
  ADD CONSTRAINT `got_events_characters_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `got_events` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `got_events_characters_ibfk_2` FOREIGN KEY (`character_id`) REFERENCES `got_characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `got_house`
--
ALTER TABLE `got_house`
  ADD CONSTRAINT `got_house_ibfk_1` FOREIGN KEY (`head`) REFERENCES `got_characters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `got_house_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `got_house_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `got_locations`
--
ALTER TABLE `got_locations`
  ADD CONSTRAINT `got_locations_ibfk_1` FOREIGN KEY (`continent_id`) REFERENCES `got_continents` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
