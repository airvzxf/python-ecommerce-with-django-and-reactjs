-- MySQL Script generated by MySQL Workbench
-- Mon 04 Mar 2019 12:45:51 PM CST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema python_ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `python_ecommerce` ;

-- -----------------------------------------------------
-- Schema python_ecommerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `python_ecommerce` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
SHOW WARNINGS;
USE `python_ecommerce` ;

-- -----------------------------------------------------
-- Table `python_ecommerce`.`app_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_customer` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_customer` (
  `id_app_customer` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_app_customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `email_UNIQUE` ON `python_ecommerce`.`app_customer` (`email` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `python_ecommerce`.`app_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_product` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_product` (
  `id_app_product` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10,2) UNSIGNED NOT NULL,
  `sku` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_app_product`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE UNIQUE INDEX `sku_UNIQUE` ON `python_ecommerce`.`app_product` (`sku` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `python_ecommerce`.`app_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_orders` (
  `id_app_orders` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_app_customer` INT UNSIGNED NOT NULL,
  `utc_date` DATETIME NULL,
  `total` DECIMAL(20,2) NULL DEFAULT 0,
  PRIMARY KEY (`id_app_orders`, `id_app_customer`),
  CONSTRAINT `fk_app_orders_with_app_customer`
    FOREIGN KEY (`id_app_customer`)
    REFERENCES `python_ecommerce`.`app_customer` (`id_app_customer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE INDEX `fk_app_orders_with_app_customer_idx` ON `python_ecommerce`.`app_orders` (`id_app_customer` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `python_ecommerce`.`app_orders_detail`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_orders_detail` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_orders_detail` (
  `id_app_orders_detail` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_app_orders` INT UNSIGNED NOT NULL,
  `id_app_customer` INT UNSIGNED NOT NULL,
  `id_app_product` INT UNSIGNED NOT NULL,
  `price` DECIMAL(20,2) UNSIGNED NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`))
ENGINE = MyISAM
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SHOW WARNINGS;
CREATE INDEX `fk_app_orders_detail_with_app_orders_idx` ON `python_ecommerce`.`app_orders_detail` (`id_app_orders` ASC, `id_app_customer` ASC) VISIBLE;

SHOW WARNINGS;
CREATE INDEX `fk_app_orders_detail_with_app_product_idx` ON `python_ecommerce`.`app_orders_detail` (`id_app_product` ASC) VISIBLE;

SHOW WARNINGS;
USE `python_ecommerce` ;

-- -----------------------------------------------------
-- Placeholder table for view `python_ecommerce`.`app_customer_orders_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_customer_orders_view` (`id_app_customer` INT, `last_name` INT, `first_name` INT, `sum_total` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `python_ecommerce`.`app_orders_total_by_customer_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `python_ecommerce`.`app_orders_total_by_customer_view` (`id_app_customer` INT, `sum_total` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `python_ecommerce`.`app_customer_orders_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_customer_orders_view`;
SHOW WARNINGS;
DROP VIEW IF EXISTS `python_ecommerce`.`app_customer_orders_view` ;
SHOW WARNINGS;
USE `python_ecommerce`;
CREATE  OR REPLACE VIEW `app_customer_orders_view` AS
SELECT
    c.id_app_customer,
    c.last_name,
    c.first_name,
    ov.sum_total
FROM
    app_customer AS c
LEFT JOIN
    app_orders_total_by_customer_view AS ov
    ON c.id_app_customer = ov.id_app_customer
GROUP BY
    c.id_app_customer;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `python_ecommerce`.`app_orders_total_by_customer_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `python_ecommerce`.`app_orders_total_by_customer_view`;
SHOW WARNINGS;
DROP VIEW IF EXISTS `python_ecommerce`.`app_orders_total_by_customer_view` ;
SHOW WARNINGS;
USE `python_ecommerce`;
CREATE  OR REPLACE VIEW `app_orders_total_by_customer_view` AS
SELECT
    o.id_app_customer,
    SUM(o.total) AS sum_total
FROM
    app_orders AS o
GROUP BY
    o.id_app_customer;
SHOW WARNINGS;
USE `python_ecommerce`;

DELIMITER $$

USE `python_ecommerce`$$
DROP TRIGGER IF EXISTS `python_ecommerce`.`app_orders_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `python_ecommerce`$$
CREATE DEFINER = CURRENT_USER TRIGGER `python_ecommerce`.`app_orders_BEFORE_INSERT` BEFORE INSERT ON `app_orders` FOR EACH ROW
BEGIN
SET NEW.utc_date = utc_timestamp();
END$$

SHOW WARNINGS$$

USE `python_ecommerce`$$
DROP TRIGGER IF EXISTS `python_ecommerce`.`app_orders_detail_BEFORE_INSERT` $$
SHOW WARNINGS$$
USE `python_ecommerce`$$
CREATE DEFINER = CURRENT_USER TRIGGER `python_ecommerce`.`app_orders_detail_BEFORE_INSERT` BEFORE INSERT ON `app_orders_detail` FOR EACH ROW
BEGIN
SET NEW.price = (SELECT app_product.price FROM app_product WHERE app_product.id_app_product = NEW.id_app_product);
END$$

SHOW WARNINGS$$

USE `python_ecommerce`$$
DROP TRIGGER IF EXISTS `python_ecommerce`.`app_orders_detail_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `python_ecommerce`$$
CREATE DEFINER = CURRENT_USER TRIGGER `python_ecommerce`.`app_orders_detail_AFTER_INSERT` AFTER INSERT ON `app_orders_detail` FOR EACH ROW
BEGIN
UPDATE
    app_orders
SET
    app_orders.total = (
        SELECT
            sum(app_orders_detail.price * app_orders_detail.quantity)
        FROM
            app_orders_detail
        WHERE
            app_orders_detail.id_app_orders = NEW.id_app_orders
    )
WHERE
    app_orders.id_app_orders = NEW.id_app_orders
;
END$$

SHOW WARNINGS$$

DELIMITER ;
SET SQL_MODE = '';
DROP USER IF EXISTS dev_user;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW WARNINGS;
CREATE USER 'dev_user' IDENTIFIED BY '111';

GRANT ALL ON `python_ecommerce`.* TO 'dev_user';
GRANT SELECT ON TABLE `python_ecommerce`.* TO 'dev_user';
GRANT SELECT, INSERT, TRIGGER ON TABLE `python_ecommerce`.* TO 'dev_user';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `python_ecommerce`.* TO 'dev_user';
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `python_ecommerce`.`app_customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `python_ecommerce`;
INSERT INTO `python_ecommerce`.`app_customer` (`id_app_customer`, `first_name`, `last_name`, `email`) VALUES (1, 'Ken 👻️', 'Rogers', 'k.rogers@gmail.com');
INSERT INTO `python_ecommerce`.`app_customer` (`id_app_customer`, `first_name`, `last_name`, `email`) VALUES (2, 'Julia 👧🏻️', 'Blacksmith', 'flowers.3292@hotmail.com');
INSERT INTO `python_ecommerce`.`app_customer` (`id_app_customer`, `first_name`, `last_name`, `email`) VALUES (3, 'Al 🉐️', 'Yenzi', 'ayenzi@businessenterprice.net');
INSERT INTO `python_ecommerce`.`app_customer` (`id_app_customer`, `first_name`, `last_name`, `email`) VALUES (4, 'Alfonso 🎥️', 'Kukult', 'akukult@yahoo.com.mx');

COMMIT;


-- -----------------------------------------------------
-- Data for table `python_ecommerce`.`app_product`
-- -----------------------------------------------------
START TRANSACTION;
USE `python_ecommerce`;
INSERT INTO `python_ecommerce`.`app_product` (`id_app_product`, `name`, `price`, `sku`) VALUES (1, 'Glass', 30.19, 'PEC01G0981292');
INSERT INTO `python_ecommerce`.`app_product` (`id_app_product`, `name`, `price`, `sku`) VALUES (2, 'Wood', 7.83, 'PEC01G7392982');
INSERT INTO `python_ecommerce`.`app_product` (`id_app_product`, `name`, `price`, `sku`) VALUES (3, 'Metal', 20.37, 'PEC01G8739833');
INSERT INTO `python_ecommerce`.`app_product` (`id_app_product`, `name`, `price`, `sku`) VALUES (4, 'Metal Mate', 15, 'PEC01G9873848');
INSERT INTO `python_ecommerce`.`app_product` (`id_app_product`, `name`, `price`, `sku`) VALUES (5, 'Crystal', 52.51, 'PEC01G8375928');

COMMIT;


-- -----------------------------------------------------
-- Data for table `python_ecommerce`.`app_orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `python_ecommerce`;
INSERT INTO `python_ecommerce`.`app_orders` (`id_app_orders`, `id_app_customer`, `utc_date`, `total`) VALUES (1, 1, NULL, NULL);
INSERT INTO `python_ecommerce`.`app_orders` (`id_app_orders`, `id_app_customer`, `utc_date`, `total`) VALUES (2, 2, NULL, NULL);
INSERT INTO `python_ecommerce`.`app_orders` (`id_app_orders`, `id_app_customer`, `utc_date`, `total`) VALUES (3, 3, NULL, NULL);
INSERT INTO `python_ecommerce`.`app_orders` (`id_app_orders`, `id_app_customer`, `utc_date`, `total`) VALUES (4, 1, NULL, NULL);
INSERT INTO `python_ecommerce`.`app_orders` (`id_app_orders`, `id_app_customer`, `utc_date`, `total`) VALUES (5, 4, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `python_ecommerce`.`app_orders_detail`
-- -----------------------------------------------------
START TRANSACTION;
USE `python_ecommerce`;
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (1, 1, 1, 1, NULL, 2);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (2, 1, 1, 2, NULL, 3);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (3, 2, 2, 3, NULL, 1);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (4, 2, 2, 4, NULL, 1);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (5, 3, 3, 5, NULL, 2);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (6, 3, 3, 1, NULL, 19);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (7, 4, 1, 2, NULL, 2);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (8, 4, 1, 3, NULL, 1);
INSERT INTO `python_ecommerce`.`app_orders_detail` (`id_app_orders_detail`, `id_app_orders`, `id_app_customer`, `id_app_product`, `price`, `quantity`) VALUES (9, 5, 4, 4, NULL, 38);

COMMIT;

