CREATE TABLE `user_parkings2` (
	`identifier` varchar(60) DEFAULT NULL,
	`vehicle` longtext,
	`plate` varchar(12) DEFAULT NULL,

	PRIMARY KEY (`plate`)
)