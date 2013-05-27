SET NAMES utf8;
SET foreign_key_checks = 0;
SET time_zone = '+03:00';
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `primoshop`;
CREATE DATABASE `primoshop` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `primoshop`;

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `customerId` int(11) NOT NULL COMMENT 'Foreign key - customer',
    `defaultExpedition` int(11) NOT NULL DEFAULT '1' COMMENT 'Default expedition address | 0 = no, 1 = yes',
    `defaultInvoice` int(11) NOT NULL DEFAULT '1' COMMENT 'Default invoice address | 0 = no, 1 = yes',
    `address1` varchar(2000) NOT NULL COMMENT 'Address - first line',
    `address2` varchar(2000) DEFAULT NULL COMMENT 'Address - second line',
    `city` varchar(500) NOT NULL COMMENT 'City',
    `zipPostalCode` varchar(100) DEFAULT NULL COMMENT 'Zip or postal code',
    `stateId` int(11) NOT NULL COMMENT 'Foreign key - state',
    `countryId` int(11) NOT NULL COMMENT 'Foreign key - country',
    PRIMARY KEY (`id`),
    KEY `stateId` (`stateId`),
    KEY `countryId` (`countryId`),
    KEY `customerId` (`customerId`),
    CONSTRAINT `address_ibfk_6` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`),
    CONSTRAINT `address_ibfk_3` FOREIGN KEY (`countryId`) REFERENCES `geographyCountry` (`id`),
    CONSTRAINT `address_ibfk_5` FOREIGN KEY (`stateId`) REFERENCES `geographyState` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `parentId` int(11) NOT NULL COMMENT 'Foreign key - parent category',
    `name` varchar(200) NOT NULL COMMENT 'Category name',
    `status` int(11) NOT NULL DEFAULT '1' COMMENT '1 = visible, 0 = hidden',
    PRIMARY KEY (`id`),
    KEY `parentId` (`parentId`),
    CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `currency`;
CREATE TABLE `currency` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `currencyName` varchar(30) NOT NULL COMMENT 'Currency name',
    `countryId` int(11) NOT NULL COMMENT 'Foreign key - country',
    PRIMARY KEY (`id`),
    KEY `countryId` (`countryId`),
    CONSTRAINT `currency_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `geographyCountry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `email` varchar(1024) NOT NULL COMMENT 'Unique',
    `password` varchar(256) DEFAULT NULL,
    `firstName` varchar(500) NOT NULL,
    `lastName` varchar(500) NOT NULL,
    `hashId` varchar(256) DEFAULT NULL,
    `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 = inactive | 1 = active | def: 0',
    `phone` varchar(30) DEFAULT NULL,
    `type` int(11) NOT NULL DEFAULT '0' COMMENT '0 = pf | 1 = company | def: 0',
    `pfCnp` varchar(13) DEFAULT NULL,
    `pfBiSeries` varchar(10) DEFAULT NULL,
    `pfBiNumber` varchar(20) DEFAULT NULL,
    `companyName` varchar(500) DEFAULT NULL,
    `companyCui` varchar(100) DEFAULT NULL,
    `companyAccount` varchar(500) DEFAULT NULL,
    `companyBank` varchar(500) DEFAULT NULL,
    `companyRegCom` varchar(100) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `deliveryMode`;
CREATE TABLE `deliveryMode` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `mode` varchar(500) NOT NULL COMMENT 'Delivery mode',
    `countryId` int(11) NOT NULL COMMENT 'Foreign key - country',
    `deliveryTax` float NOT NULL COMMENT 'Delivery extra tax without VAT',
    `deliveryExtraKg` float NOT NULL DEFAULT '0' COMMENT 'Extra delivery per kilo',
    `deliveryExtraMc` float NOT NULL DEFAULT '0' COMMENT 'Extra delivery per cubic meter',
    `deliveryVatRate` float NOT NULL COMMENT 'Delivery VAT',
    `currencyId` int(11) NOT NULL COMMENT 'Foreign key - currency',
    PRIMARY KEY (`id`),
    KEY `countryId` (`countryId`),
    KEY `currencyId` (`currencyId`),
    CONSTRAINT `deliveryMode_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `geographyCountry` (`id`),
    CONSTRAINT `deliveryMode_ibfk_2` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `geographyCountry`;
CREATE TABLE `geographyCountry` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `country` varchar(500) NOT NULL COMMENT 'Country name',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `geographyCountry` (`id`, `country`) VALUES
(1, 'Romania');

DROP TABLE IF EXISTS `geographyState`;
CREATE TABLE `geographyState` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `countryId` int(11) NOT NULL COMMENT 'Foreign key - country',
    `state` varchar(500) NOT NULL COMMENT 'State / Province name',
    PRIMARY KEY (`id`),
    KEY `countryId` (`countryId`),
    CONSTRAINT `geographyState_ibfk_1` FOREIGN KEY (`countryId`) REFERENCES `geographyCountry` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `geographyState` (`id`, `countryId`, `state`) VALUES
(1, 1, 'Bucuresti - Sector 1'),
(2, 1, 'Bucuresti - Sector 2'),
(3, 1, 'Bucuresti - Sector 3'),
(4, 1, 'Bucuresti - Sector 4'),
(5, 1, 'Bucuresti - Sector 5'),
(6, 1, 'Bucuresti - Sector 6'),
(7, 1, 'Alba'),
(8, 1, 'Arad'),
(9, 1, 'Arges'),
(10, 1, 'Bacau'),
(11, 1, 'Bihor'),
(12, 1, 'Bistrita-Nasaud'),
(13, 1, 'Botosani'),
(14, 1, 'Braila'),
(15, 1, 'Brasov'),
(16, 1, 'Buzau'),
(17, 1, 'Calarasi'),
(18, 1, 'Caras-Severin'),
(19, 1, 'Cluj'),
(20, 1, 'Constanta'),
(21, 1, 'Covasna'),
(22, 1, 'Dambovita'),
(23, 1, 'Dolj'),
(24, 1, 'Galati'),
(25, 1, 'Giurgiu'),
(26, 1, 'Gorj'),
(27, 1, 'Harghita'),
(28, 1, 'Hunedoara'),
(29, 1, 'Ialomita'),
(30, 1, 'Iasi'),
(31, 1, 'Ilfov'),
(32, 1, 'Maramures'),
(33, 1, 'Mehedinti'),
(34, 1, 'Mures'),
(35, 1, 'Neamt'),
(36, 1, 'Olt'),
(37, 1, 'Prahova'),
(38, 1, 'Salaj'),
(39, 1, 'Satu Mare'),
(40, 1, 'Sibiu'),
(41, 1, 'Suceava'),
(42, 1, 'Teleorman'),
(43, 1, 'Timis'),
(44, 1, 'Tulcea'),
(45, 1, 'Vaslui'),
(46, 1, 'Valcea'),
(47, 1, 'Vrancea');

DROP TABLE IF EXISTS `manufacturer`;
CREATE TABLE `manufacturer` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` varchar(500) NOT NULL COMMENT 'Manufacturer name',
    `description` text COMMENT 'Manufacturer description',
    `metadata` text COMMENT 'Serialized cache of normalized data',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `manufacturerData`;
CREATE TABLE `manufacturerData` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `manufacturerId` int(11) NOT NULL COMMENT 'Foreign key - manufacturer',
    `key` varchar(100) NOT NULL COMMENT 'Data key',
    `value` varchar(1000) NOT NULL COMMENT 'Data value',
    PRIMARY KEY (`id`),
    UNIQUE KEY `manufacturerId_key` (`manufacturerId`,`key`),
    CONSTRAINT `manufacturerData_ibfk_3` FOREIGN KEY (`manufacturerId`) REFERENCES `manufacturer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `customerId` int(11) NOT NULL COMMENT 'Foreign key - customer',
    `expeditionAddressId` int(11) NOT NULL COMMENT 'Foreign key - address',
    `invoiceAddressId` int(11) DEFAULT NULL COMMENT 'Foreign key - address',
    `status` int(11) NOT NULL DEFAULT '0' COMMENT '0 = new, 1 = processed, 2 = delivered, 3 = paid, 4 = returned',
    `addedOn` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Added date & time',
    `procesedOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Processed date & time',
    `deliveredOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Delivered date & time',
    `paidOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Paid date & time',
    `returnedOn` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Returned date & time',
    `orderTotal` float NOT NULL COMMENT 'Order total without VAT',
    `orderTotalVat` float NOT NULL COMMENT 'Order VAT total',
    `deliveryModeId` int(11) NOT NULL COMMENT 'Foreign key - deliveryMode',
    `deliveryTax` float NOT NULL COMMENT 'Delivery tax total without VAT',
    `deliveryTaxVat` float NOT NULL COMMENT 'Delivery tax VAT total',
    PRIMARY KEY (`id`),
    KEY `customerId` (`customerId`),
    KEY `expeditionAddressId` (`expeditionAddressId`),
    KEY `invoiceAddressId` (`invoiceAddressId`),
    KEY `deliveryModeId` (`deliveryModeId`),
    CONSTRAINT `order_ibfk_1` FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`),
    CONSTRAINT `order_ibfk_2` FOREIGN KEY (`expeditionAddressId`) REFERENCES `address` (`id`),
    CONSTRAINT `order_ibfk_3` FOREIGN KEY (`invoiceAddressId`) REFERENCES `address` (`id`),
    CONSTRAINT `order_ibfk_4` FOREIGN KEY (`deliveryModeId`) REFERENCES `deliveryMode` (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `orderProduct`;
CREATE TABLE `orderProduct` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `orderId` int(11) NOT NULL COMMENT 'Foreign key - order',
    `productId` int(11) NOT NULL COMMENT 'Foreign key - order',
    `quantity` int(11) NOT NULL COMMENT 'Product quantity',
    PRIMARY KEY (`id`),
    KEY `orderId` (`orderId`),
    KEY `productId` (`productId`),
    CONSTRAINT `orderProduct_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `order` (`id`),
    CONSTRAINT `orderProduct_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` varchar(5000) NOT NULL COMMENT 'Product name',
    `manufacturerId` int(11) NOT NULL COMMENT 'Foreign key - manufacturer',
    `supplierId` int(11) NOT NULL COMMENT 'Foreign key - supplier',
    `categoryId` int(11) NOT NULL COMMENT 'Foreign key - category',
    `description` text COMMENT 'Product description',
    `entryPrice` float NOT NULL COMMENT 'Acquisition price',
    `salePrice` float NOT NULL COMMENT 'Sale price',
    `vatRate` float NOT NULL COMMENT 'VAT rate',
    `countryId` int(11) NOT NULL COMMENT 'Foreign key - country',
    `currencyId` int(11) NOT NULL COMMENT 'Foreign key - currency',
    `status` int(11) NOT NULL DEFAULT '1' COMMENT '1 = visible, 0 = hidden',
    `availability` int(11) NOT NULL DEFAULT '2' COMMENT '0 = preorder, 1 = in_stock_supplier, 2 = in_stock, 3 = limited_stock, 4 = end_of_life',
    `stockInfo` int(11) NOT NULL COMMENT 'Available products count',
    `ratingCount` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of votes',
    `ratingValue` float NOT NULL DEFAULT '0' COMMENT '(ratingValue * ratingCount + newVoteValue) / (ratingCount + 1)',
    `metadata` text COMMENT 'Serialized cache of normalized data ',
    PRIMARY KEY (`id`),
    KEY `manufacturerId` (`manufacturerId`),
    KEY `categoryId` (`categoryId`),
    KEY `countryId` (`countryId`),
    KEY `currencyId` (`currencyId`),
    KEY `supplierId` (`supplierId`),
    CONSTRAINT `product_ibfk_5` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`id`),
    CONSTRAINT `product_ibfk_1` FOREIGN KEY (`manufacturerId`) REFERENCES `manufacturer` (`id`),
    CONSTRAINT `product_ibfk_2` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`),
    CONSTRAINT `product_ibfk_3` FOREIGN KEY (`countryId`) REFERENCES `geographyCountry` (`id`),
    CONSTRAINT `product_ibfk_4` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `productData`;
CREATE TABLE `productData` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `productId` int(11) NOT NULL COMMENT 'Foreign key - product',
    `key` varchar(100) NOT NULL COMMENT 'Data key',
    `value` varchar(1000) NOT NULL COMMENT 'Data value',
    PRIMARY KEY (`id`),
    UNIQUE KEY `productId_key` (`productId`,`key`),
    CONSTRAINT `productData_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `productGallery`;
CREATE TABLE `productGallery` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `productId` int(11) NOT NULL COMMENT 'Foreign key - product',
    `imageName` varchar(1000) NOT NULL COMMENT 'Image name',
    `imagePath` varchar(5000) NOT NULL COMMENT 'Image path on disk',
    `imageUrl` varchar(1024) NOT NULL COMMENT 'Image URL relative to main site url',
    `defaultImage` int(11) NOT NULL DEFAULT '0' COMMENT 'Default image | 0 = no, 1 = yes ',
    PRIMARY KEY (`id`),
    KEY `productId` (`productId`),
    CONSTRAINT `productGallery_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`)
)
ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `name` varchar(500) NOT NULL COMMENT 'Supplier name',
    `metadata` text COMMENT 'Serialized cache of normalized data ',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `supplierData`;
CREATE TABLE `supplierData` (
    `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key',
    `supplierId` int(11) NOT NULL COMMENT 'Foreign key - supplier',
    `key` varchar(100) NOT NULL COMMENT 'Data key',
    `data` varchar(1000) NOT NULL COMMENT 'Data value',
    PRIMARY KEY (`id`),
    UNIQUE KEY `supplierId_key` (`supplierId`,`key`),
    CONSTRAINT `supplierData_ibfk_1` FOREIGN KEY (`supplierId`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
