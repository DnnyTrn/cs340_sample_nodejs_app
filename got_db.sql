-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: Feb 28, 2019 at 12:42 PM
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

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `got_characters`;
DROP TABLE IF EXISTS `got_continents`;
DROP TABLE IF EXISTS `got_events`;
DROP TABLE IF EXISTS `got_events_characters`;
DROP TABLE IF EXISTS `got_house`;
DROP TABLE IF EXISTS `got_house_status`;
DROP TABLE IF EXISTS `got_locations`;
DROP TABLE IF EXISTS `got_species`;

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
(1, 'Jon', 'Snow', 4, NULL, 'Longclaw', 'alive', NULL, 1),
(41, 'Eddard', 'Stark', 2, 3, 'Ice', 'dead', NULL, 1),
(42, 'Hodor', NULL, NULL, NULL, NULL, 'dead', NULL, 1),
(43, 'Arya', 'Stark', 2, NULL, 'Valyrian steel dagger', 'alive', NULL, 1),
(2, 'Tommen', 'Baratheon', 3, NULL, NULL, 'dead', 'Seven Kingdoms', 1),
(3, 'Cersei', 'Lannister', 4, NULL, NULL, 'alive', 'Seven Kingdoms', 1),
(46, 'Drogon', NULL, NULL, NULL, NULL, 'Wight', NULL, 3),
(47, 'Night King', NULL, NULL, NULL, NULL, 'alive', NULL, 2),
(48, 'Leaf', NULL, NULL, NULL, NULL, 'dead', NULL, 5),
(49, 'Pyat', 'Pree', NULL, 8, NULL, 'dead', 'Warlocks of Quarth', 6),
(50, 'Robb', 'Stark', 2, 3, NULL, 'dead', NULL, 1);

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
(6, 'Red Wedding', 9, 3, 9, 'The Red Wedding was a massacre that happened at the Twins, castle homeland of the Freys, arranged by Lord Walder Frey as revenge against King Robb Stark for breaking the marriage pact between House Stark and House Frey. During the massacre, King Robb, his wife, Queen Talisa, his mother, Lady Catelyn, most of his bannermen and men-at-arms (~15,000 men) are murdered following the marriage feast and bedding of Edmure Tully, Robb\'s uncle, and Roslin Frey.'),
(7, 'event', 3, 1, 300, '1\r\n2\r\n3\r\n4\r\n5\r\n6\r\n7\r\n8\r\n9\r\n10\r\n11\r\n12\r\n13\r\n14\r\n15\r\n16\r\n17\r\n18\r\n19\r\n20\r\n21\r\n22\r\n23\r\n24\r\n25\r\n26\r\n27\r\n28\r\n29\r\n30\r\n31\r\n32\r\n33\r\n34\r\n35\r\n36\r\n37\r\n38\r\n39\r\n40\r\n41\r\n42\r\n43\r\n44\r\n45\r\n46\r\n47\r\n48\r\n49\r\n50\r\n51\r\n52\r\n53\r\n54\r\n55\r\n56\r\n57\r\n58\r\n59\r\n60\r\n61\r\n62\r\n63\r\n64\r\n65\r\n66\r\n67\r\n68\r\n69\r\n70\r\n71\r\n72\r\n73\r\n74\r\n75\r\n76\r\n77\r\n78\r\n79\r\n80\r\n81\r\n82\r\n83\r\n84\r\n85\r\n86\r\n87\r\n88\r\n89\r\n90\r\n91\r\n92\r\n93\r\n94\r\n95\r\n96\r\n97\r\n98\r\n99\r\n100\r\n101\r\n102\r\n103\r\n104\r\n105\r\n106\r\n107\r\n108\r\n109\r\n110\r\n111\r\n112\r\n113\r\n114\r\n115\r\n116\r\n117\r\n118\r\n119\r\n120\r\n121\r\n122\r\n123\r\n124\r\n125\r\n126\r\n127\r\n128\r\n129\r\n130\r\n131\r\n132\r\n133\r\n134\r\n135\r\n136\r\n137\r\n138\r\n139\r\n140\r\n141\r\n142\r\n143\r\n144\r\n145\r\n146\r\n147\r\n148\r\n149\r\n150\r\n151\r\n152\r\n153\r\n154\r\n155\r\n156\r\n157\r\n158\r\n159\r\n160\r\n161\r\n162\r\n163\r\n164\r\n165\r\n166\r\n167\r\n168\r\n169\r\n170\r\n171\r\n172\r\n173\r\n174\r\n175\r\n176\r\n177\r\n178\r\n179\r\n180\r\n181\r\n182\r\n183\r\n184\r\n185\r\n186\r\n187\r\n188\r\n189\r\n190\r\n191\r\n192\r\n193\r\n194\r\n195\r\n196\r\n197\r\n198\r\n199\r\n200\r\n201\r\n202\r\n203\r\n204\r\n205\r\n206\r\n207\r\n208\r\n209\r\n210\r\n211\r\n212\r\n213\r\n214\r\n215\r\n216\r\n217\r\n218\r\n219\r\n220\r\n221\r\n222\r\n223\r\n224\r\n225\r\n226\r\n227\r\n228\r\n229\r\n230\r\n231\r\n232\r\n233\r\n234\r\n235\r\n236\r\n237\r\n238\r\n239\r\n240\r\n241\r\n242\r\n243\r\n244\r\n245\r\n246\r\n247\r\n248\r\n249\r\n250\r\n251\r\n252\r\n253\r\n254\r\n255\r\n256\r\n257\r\n258\r\n259\r\n260\r\n261\r\n262\r\n263\r\n264\r\n265\r\n266\r\n267\r\n268\r\n269\r\n270\r\n271\r\n272\r\n273\r\n274\r\n275\r\n276\r\n277\r\n278\r\n279\r\n280\r\n281\r\n282\r\n283\r\n284\r\n285\r\n286\r\n287\r\n288\r\n289\r\n290\r\n291\r\n292\r\n293\r\n294\r\n295\r\n296\r\n297\r\n298\r\n299\r\n300\r\n301\r\n302\r\n303\r\n304\r\n305\r\n306\r\n307\r\n308\r\n309\r\n310\r\n311\r\n312\r\n313\r\n314\r\n315\r\n316\r\n317\r\n318\r\n319\r\n320\r\n321\r\n322\r\n323\r\n324\r\n325\r\n326\r\n327\r\n328\r\n329\r\n330\r\n331\r\n332\r\n333\r\n334\r\n335\r\n336\r\n337\r\n338\r\n339\r\n340\r\n341\r\n342\r\n343\r\n344\r\n345\r\n346\r\n347\r\n348\r\n349\r\n350\r\n351\r\n352\r\n353\r\n354\r\n355\r\n356\r\n357\r\n358\r\n359\r\n360\r\n361\r\n362\r\n363\r\n364\r\n365\r\n366\r\n367\r\n368\r\n369\r\n370\r\n371\r\n372\r\n373\r\n374\r\n375\r\n376\r\n377\r\n378\r\n379\r\n380\r\n381\r\n382\r\n383\r\n384\r\n385\r\n386\r\n387\r\n388\r\n389\r\n390\r\n391\r\n392\r\n393\r\n394\r\n395\r\n396\r\n397\r\n398\r\n399\r\n400\r\n401\r\n402\r\n403\r\n404\r\n405\r\n406\r\n407\r\n408\r\n409\r\n410\r\n411\r\n412\r\n413\r\n414\r\n415\r\n416\r\n417\r\n418\r\n419\r\n420\r\n421\r\n422\r\n423\r\n424\r\n425\r\n426\r\n427\r\n428\r\n429\r\n430\r\n431\r\n432\r\n433\r\n434\r\n435\r\n436\r\n437\r\n438\r\n439\r\n440\r\n441\r\n442\r\n443\r\n444\r\n445\r\n446\r\n447\r\n448\r\n449\r\n450\r\n451\r\n452\r\n453\r\n454\r\n455\r\n456\r\n457\r\n458\r\n459\r\n460\r\n461\r\n462\r\n463\r\n464\r\n465\r\n466\r\n467\r\n468\r\n469\r\n470\r\n471\r\n472\r\n473\r\n474\r\n475\r\n476\r\n477\r\n478\r\n479\r\n480\r\n481\r\n482\r\n483\r\n484\r\n485\r\n486\r\n487\r\n488\r\n489\r\n490\r\n491\r\n492\r\n493\r\n494\r\n495\r\n496\r\n497\r\n498\r\n499\r\n500\r\n501\r\n502\r\n503\r\n504\r\n505\r\n506\r\n507\r\n508\r\n509\r\n510\r\n511\r\n512\r\n513\r\n514\r\n515\r\n516\r\n517\r\n518\r\n519\r\n520\r\n521\r\n522\r\n523\r\n524\r\n525\r\n526\r\n527\r\n528\r\n529\r\n530\r\n531\r\n532\r\n533\r\n534\r\n535\r\n536\r\n537\r\n538\r\n539\r\n540\r\n541\r\n542\r\n543\r\n544\r\n545\r\n546\r\n547\r\n548\r\n549\r\n550\r\n551\r\n552\r\n553\r\n554\r\n555\r\n556\r\n557\r\n558\r\n559\r\n560\r\n561\r\n562\r\n563\r\n564\r\n565\r\n566\r\n567\r\n568\r\n569\r\n570\r\n571\r\n572\r\n573\r\n574\r\n575\r\n576\r\n577\r\n578\r\n579\r\n580\r\n581\r\n582\r\n583\r\n584\r\n585\r\n586\r\n587\r\n588\r\n589\r\n590\r\n591\r\n592\r\n593\r\n594\r\n595\r\n596\r\n597\r\n598\r\n599\r\n600\r\n601\r\n602\r\n603\r\n604\r\n605\r\n606\r\n607\r\n608\r\n609\r\n610\r\n611\r\n612\r\n613\r\n614\r\n615\r\n616\r\n617\r\n618\r\n619\r\n620\r\n621\r\n622\r\n623\r\n624\r\n625\r\n626\r\n627\r\n628\r\n629\r\n630\r\n631\r\n632\r\n633\r\n634\r\n635\r\n636\r\n637\r\n638\r\n639\r\n640\r\n641\r\n642\r\n643\r\n644\r\n645\r\n646\r\n647\r\n648\r\n649\r\n650\r\n651\r\n652\r\n653\r\n654\r\n655\r\n656\r\n657\r\n658\r\n659\r\n660\r\n661\r\n662\r\n663\r\n664\r\n665\r\n666\r\n667\r\n668\r\n669\r\n670\r\n671\r\n672\r\n673\r\n674\r\n675\r\n676\r\n677\r\n678\r\n679\r\n680\r\n681\r\n682\r\n683\r\n684\r\n685\r\n686\r\n687\r\n688\r\n689\r\n690\r\n691\r\n692\r\n693\r\n694\r\n695\r\n696\r\n697\r\n698\r\n699\r\n700\r\n701\r\n702\r\n703\r\n704\r\n705\r\n706\r\n707\r\n708\r\n709\r\n710\r\n711\r\n712\r\n713\r\n714\r\n715\r\n716\r\n717\r\n718\r\n719\r\n720\r\n721\r\n722\r\n723\r\n724\r\n725\r\n726\r\n727\r\n728\r\n729\r\n730\r\n731\r\n732\r\n733\r\n734\r\n735\r\n736\r\n737\r\n738\r\n739\r\n740\r\n741\r\n742\r\n743\r\n744\r\n745\r\n746\r\n747\r\n748\r\n749\r\n750\r\n751\r\n752\r\n753\r\n754\r\n755\r\n756\r\n757\r\n758\r\n759\r\n760\r\n761\r\n762\r\n763\r\n764\r\n765\r\n766\r\n767\r\n768\r\n769\r\n770\r\n771\r\n772\r\n773\r\n774\r\n775\r\n776\r\n777\r\n778\r\n779\r\n780\r\n781\r\n782\r\n783\r\n784\r\n785\r\n786\r\n787\r\n788\r\n789\r\n790\r\n791\r\n792\r\n793\r\n794\r\n795\r\n796\r\n797\r\n798\r\n799\r\n800\r\n801\r\n802\r\n803\r\n804\r\n805\r\n806\r\n807\r\n808\r\n809\r\n810\r\n811\r\n812\r\n813\r\n814\r\n815\r\n816\r\n817\r\n818\r\n819\r\n820\r\n821\r\n822');

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
(4, 1),
(3, 1),
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
(2, 'Stark', 'A grey direwolf on a white field\r\n', 1, 1),
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
  `region` varchar(60) DEFAULT NULL,
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
(8, 'Quarth', NULL, 2),
(9, 'The Twins', 'The Riverlands', 1),
(16, 'missing required field', NULL, 2),
(17, 'test', 'why222', 2),
(18, 'Seattle', 'Washington', 1);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `got_continents`
--
ALTER TABLE `got_continents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `got_events`
--
ALTER TABLE `got_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
