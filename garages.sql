
CREATE TABLE `user_parkings2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin,
  `plate` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
