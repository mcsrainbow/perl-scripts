CREATE DATABASE `testdb` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE testdb;
DROP TABLE IF EXISTS `test_table`;
CREATE TABLE `test_table` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL UNIQUE,
  `last_name` varchar(255) DEFAULT NULL UNIQUE,
  `sex` SET('M','F') NOT NULL DEFAULT 'M',
  `age` int(3) DEFAULT NULL,
  `income` DECIMAL(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

GRANT ALL PRIVILEGES ON testdb.* TO 'testuser'@'localhost' idENTIFIED BY 'test123';
