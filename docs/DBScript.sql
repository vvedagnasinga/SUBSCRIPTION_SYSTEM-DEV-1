
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hclbss
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema hclbss
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hclbss` DEFAULT CHARACTER SET utf8 ;
USE `hclbss` ;



CREATE TABLE IF NOT EXISTS `hclbss`.`id_gen` (
  `gen_name` VARCHAR(80) NOT NULL,
  `gen_val` BIGINT(10) NOT NULL,
  PRIMARY KEY (`gen_name`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hclbss`.`tb_temporder` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `ORDER_NUMBER` VARCHAR(15) NOT NULL,
  `BILLTO_FIRSTNAME` VARCHAR(45) NULL,
  `BILLTO_LASTNAME` VARCHAR(45) NULL,
  `BILLTO_EMAIL` VARCHAR(45) NULL,
  `BILLTO_PHONENO` VARCHAR(20) NULL,
  `BILLTO_ADDRESS_LINE1` VARCHAR(45) NULL,
  `BILLTO_ADDRESS_LINE2` VARCHAR(45) NULL,
  `BILLTO_ZIP_CODE` VARCHAR(15) NULL,
  `BILLTO_CITY` VARCHAR(45) NULL,
  `BILLTO_STATE` VARCHAR(45) NULL,
  `BILLTO_COUNTRY` VARCHAR(5) NULL,
  `SOLDTO_FIRSTNAME` VARCHAR(45) NULL,
  `SOLDTO_LASTNAME` VARCHAR(45) NULL,
  `SOLDTO_EMAIL` VARCHAR(45) NULL,
  `SOLDTO_PHONENO` VARCHAR(20) NULL,
  `SOLDTO_ADDRESS_LINE1` VARCHAR(45) NULL,
  `SOLDTO_ADDRESS_LINE2` VARCHAR(45) NULL,
  `SOLDTO_ZIP_CODE` VARCHAR(15) NULL,
  `SOLDTO_CITY` VARCHAR(45) NULL,
  `SOLDTO_STATE` VARCHAR(45) NULL,
  `SOLDTO_COUNTRY` VARCHAR(5) NULL,
  `COMPANY_NAME` VARCHAR(45) NULL,
  `LOCALE` VARCHAR(5) NULL,
  `CURRENCY` VARCHAR(5) NULL,
  `ORDER_SOURCE` VARCHAR(45) NULL,
  `IS_CORPORATE` TINYINT(1) NOT NULL,
  `STATUS` VARCHAR(45) NULL,
  `RATE_PLAN_ID` BIGINT(10) UNSIGNED NULL,
  `AUTORENEW` VARCHAR(45) NULL,
  `BILLING_CYCLE` DECIMAL(5) NULL,
  `BILLING_FREQUENCY` VARCHAR(20) NULL,
  `PRICING_SCHEME_CODE` VARCHAR(45) NULL,
  `PRODUCT_ID` BIGINT(10) UNSIGNED NULL,
  `QUANTITY` INT,
  `CRE_BY` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`))
ENGINE = InnoDB;


#CREATE TABLE IF NOT EXISTS `hclbss`.`TB_ORDER_ERRORS` (
 # `UIDPK` BIGINT(10) UNSIGNED NOT NULL auto_increment,
  #`ORDER_NUMBER` VARCHAR(15) NOT NULL,
  #`ERROR_DESC` VARCHAR(200) NULL,
  #`STATUS` VARCHAR(45) NULL,
  #`CRE_BY` VARCHAR(45) NULL,
  #`CRE_DT` TIMESTAMP(3) NULL,
  #`UPD_DT` TIMESTAMP(3) NULL,
  #`UPD_BY` VARCHAR(45) NULL,
  #PRIMARY KEY (`UIDPK`))
#ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `hclbss`.`TB_BATCH_RUN_LOG` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `ORDER_NUMBER` VARCHAR(15) NOT NULL,
  `ERR_DESC` VARCHAR(450) NULL,
  `RUN_DWN_DATE` TIMESTAMP(3) NULL,
  `SUBSCRIPTION_ID` VARCHAR(20) NULL,
  `STATUS` VARCHAR(10) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  INDEX `tb_Subscription_idx` (`SUBSCRIPTION_ID` ASC),
  CONSTRAINT `tb_Subscription`
    FOREIGN KEY (`SUBSCRIPTION_ID`)
    REFERENCES `hclbss`.`TB_SUBSCRIPTION` (`SUBSCRIPTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `hclbss`.`TB_UOM_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_UOM_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `UNIT_OF_MEASURE` VARCHAR(15) NOT NULL,
  `DESC` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UNIT_OF_MEASURE`),
  UNIQUE INDEX `unit_of_measure_UNIQUE` (`UNIT_OF_MEASURE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_RATEPLAN_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_RATEPLAN_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `RATEPLAN_ID` VARCHAR(20) NOT NULL,
  `RATEPLAN_DESC` VARCHAR(100) NULL DEFAULT NULL,
  `PRICING_SCHEME` VARCHAR(20) NOT NULL,
  `PRICE` DECIMAL(10,3) NULL,
  `UNIT_OF_MEASUREID` VARCHAR(15) NULL,
  `IS_ACTIVE` TINYINT(1) NULL,
  `FREQUENCY_CODE` VARCHAR(10) DEFAULT NULL,
  `BILLING_CYCLE_TERM` decimal(3) DEFAULT NULL,
  `FREE_TRIAL` DECIMAL(2) DEFAULT NULL,
  `SETUP_FEE` DECIMAL(5,3) DEFAULT NULL,
  `EXPIRE_AFTER` DECIMAL(4) DEFAULT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(50) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(50) NULL,
  PRIMARY KEY (`UIDPK`),
  INDEX `fk_uom_idx` (`UNIT_OF_MEASUREID` ASC),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC)
  )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `hclbss`.`TB_RATEPLAN_VOLUME_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_RATEPLAN_VOLUME_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `START_QTY` INT(10) NULL DEFAULT '0',
  `END_QTY` INT(10) NULL DEFAULT '0',
  `PRICE` DECIMAL(10,3) NOT NULL,
  `RATE_PLAN_UID` BIGINT(10) UNSIGNED NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(50) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(50) NULL,
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  PRIMARY KEY (`UIDPK`),
  INDEX `fk_tb_rateplan_vol_tb_rate_pln_mstr_idx` (`RATE_PLAN_UID` ASC),
  CONSTRAINT `fk_tb_rateplan_vol_tb_rate_pln_mstr`
    FOREIGN KEY (`RATE_PLAN_UID`)
    REFERENCES `hclbss`.`TB_RATEPLAN_MASTER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_COMPANY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_COMPANY` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL auto_increment,
  `COMP_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `BILLTO_ID` VARCHAR(20) NULL,
  `SOLDTO_ID` VARCHAR(20) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(50) NULL ,
  `UPD_DT` TIMESTAMP(3) NULL ,
  `UPD_BY` VARCHAR(50) NULL ,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_COUNTRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_COUNTRY` (
  `UIDPK` BIGINT(10) NOT NULL,
  `ISO_CODE` VARCHAR(10) NOT NULL,
  `NAME` VARCHAR(45) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`ISO_CODE`),
  UNIQUE INDEX `ISO_CODE_UNIQUE` (`ISO_CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_CUST_ADDRESS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_CUST_ADDRESS` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `LINE1` VARCHAR(100) NULL DEFAULT NULL,
  `LINE2` VARCHAR(100) NULL DEFAULT NULL,
  `ZIP_CODE` VARCHAR(10) NULL DEFAULT NULL,
  `CITY` VARCHAR(40) NULL DEFAULT NULL,
  `STATE` VARCHAR(40) NULL DEFAULT NULL,
  `COUNTRY_UID` VARCHAR(10) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NOT NULL ,
  `CRE_BY` VARCHAR(50) NULL ,
  `UPD_DT` TIMESTAMP(3) NULL ,
  `UPD_BY` VARCHAR(50) NULL ,
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  INDEX `fk_tb_cust_address_tb_country_idx` (`COUNTRY_UID` ASC),
  CONSTRAINT `fk_tb_cust_address_tb_country`
    FOREIGN KEY (`COUNTRY_UID`)
    REFERENCES `hclbss`.`TB_COUNTRY` (`ISO_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_CUSTOMER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `CUST_FIRST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `CUST_LAST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `CUST_EMAIL` VARCHAR(50) NULL DEFAULT NULL,
  `COMP_ID` BIGINT(10) UNSIGNED NOT NULL,
  `CUST_PHONE_NO` VARCHAR(13) NULL DEFAULT NULL,
  `BILLTO_ID` BIGINT(10) UNSIGNED NOT NULL,
  `SOLDTO_ID` BIGINT(10) UNSIGNED NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(50) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(50) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  INDEX `fk_compantuid_idx` (`COMP_ID` ASC),
  INDEX `fk_customerBillToId_idx` (`BILLTO_ID` ASC),
  CONSTRAINT `fk_compantuid`
    FOREIGN KEY (`COMP_ID`)
    REFERENCES `hclbss`.`TB_COMPANY` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customerBillToId`
    FOREIGN KEY (`BILLTO_ID`)
    REFERENCES `hclbss`.`TB_CUST_ADDRESS` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customerSoldToId`
    FOREIGN KEY (`SOLDTO_ID`)
    REFERENCES `hclbss`.`TB_CUST_ADDRESS` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_PRODUCT_TYPE_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_PRODUCT_TYPE_MASTER` (
  `PRODUCT_TYPE_CODE` VARCHAR(5) NOT NULL,
  `PRODUCT_TYPE` VARCHAR(45) NOT NULL,
  `DESC` VARCHAR(100) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  UNIQUE INDEX `product_type_UNIQUE` (`PRODUCT_TYPE` ASC),
  PRIMARY KEY (`PRODUCT_TYPE_CODE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_PRODUCT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_PRODUCT` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `PRODUCT_DISP_NAME` VARCHAR(100) NOT NULL,
  `SKU` VARCHAR(20) NOT NULL,
  `PRODUCT_DESCRIPTION` VARCHAR(100) NULL,
  `PRODUCT_EXP_DT` DATE NOT NULL,
  `PRODUCT_START_DT` DATE NULL,
  `PRODUCT_TYPE_CODE` VARCHAR(5) NOT NULL,
  `PARENT_ID` BIGINT(10) UNSIGNED NULL,
  `IS_BUNDLE_PRODUCT` TINYINT(1) NULL,
  `IS_ACTIVE` TINYINT(1) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `SKU_UNIQUE` (`SKU` ASC),
  INDEX `fk_tb_product_tb_prod_type_idx` (`PRODUCT_TYPE_CODE` ASC),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  CONSTRAINT `fk_tb_product_tb_prod_type`
    FOREIGN KEY (`PRODUCT_TYPE_CODE`)
    REFERENCES `hclbss`.`TB_PRODUCT_TYPE_MASTER` (`PRODUCT_TYPE_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `hclbss`.`TB_TRANSACTION_REASON_CODE_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_TRANSACTION_REASON_CODE_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `TRANSACTION_CODE` VARCHAR(30) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`TRANSACTION_CODE`),
  UNIQUE INDEX `Transaction_code_UNIQUE` (`TRANSACTION_CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_ORDER_SOURCE_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_ORDER_SOURCE_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `ORDER_SOURCE_CODE` VARCHAR(20) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`ORDER_SOURCE_CODE`),
  UNIQUE INDEX `ORDER_SOURCE_CODE_UNIQUE` (`ORDER_SOURCE_CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_SUBSCRIPTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_SUBSCRIPTION` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `SUBSCRIPTION_ID` VARCHAR(20) NOT NULL,
  `CUST_ID` BIGINT(10) UNSIGNED NOT NULL,
  `ACTIVATION_DT` TIMESTAMP(3) NULL,
  `TRANSACTION_REASON_CODE_ID` VARCHAR(30) NOT NULL,
  `ORDER_SOURCE_CODE` VARCHAR(20) NOT NULL,
  `SUBSCRIPTION_START_DT` DATE NULL,
  `SUBSCRIPTION_END_DT` DATE NULL,
  `AUTO_RENEW` TINYINT(1) NOT NULL,
  `STATUS` VARCHAR(30) NOT NULL,
  `IS_ACTIVE` TINYINT(1) NOT NULL,
  `LAST_BILL_DT` DATE NULL,
  `NEXT_BILL_DT` DATE NULL,
  `PREVIOUS_SUBSCRIPTION_ID` VARCHAR(20) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  INDEX `fk_tb_subscription_tb_customer1_idx` (`TRANSACTION_REASON_CODE_ID` ASC),
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `Subscription_ID_UNIQUE` (`SUBSCRIPTION_ID` ASC),
  INDEX `fk_tb_subscription_tb_ord_src_master_idx` (`ORDER_SOURCE_CODE` ASC),
  INDEX `fk_tb_subsription_tb_customer_idx` (`CUST_ID` ASC),
  CONSTRAINT `fk_tb_subscription_tb_transactionReasonCodeMaster`
    FOREIGN KEY (`TRANSACTION_REASON_CODE_ID`)
    REFERENCES `hclbss`.`TB_TRANSACTION_REASON_CODE_MASTER` (`TRANSACTION_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_subscription_tb_ord_src_master`
    FOREIGN KEY (`ORDER_SOURCE_CODE`)
    REFERENCES `hclbss`.`TB_ORDER_SOURCE_MASTER` (`ORDER_SOURCE_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_subsription_tb_customer`
    FOREIGN KEY (`CUST_ID`)
    REFERENCES `hclbss`.`TB_CUSTOMER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
    ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_USER_ROLE_MAPPING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_USER_ROLE_MAPPING` (
  `UIDPK` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `USER_ID` VARCHAR(50) NOT NULL,
  `ROLE_UID` INT(1) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL ,
  `CRE_BY` VARCHAR(50) NULL ,
  `UPD_DT` TIMESTAMP(3) NULL ,
  `UPD_BY` VARCHAR(50) NULL ,
  PRIMARY KEY (`ROLE_UID`),
  UNIQUE INDEX `ROLE_UID_UNIQUE` (`ROLE_UID` ASC),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_USER_DETAILS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_USER_DETAILS` (
  `UIDPK` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `USER_ID` VARCHAR(50) NOT NULL,
  `PASSWORD` VARCHAR(80) NOT NULL,
  `ROLE_ID` INT(1) NOT NULL,
  `USER_FIRST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `USER_MIDDLE_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `USER_LAST_NAME` VARCHAR(50) NULL DEFAULT NULL,
  `LAST_LOGIN` TIMESTAMP(3) NOT NULL ,
  `IS_LOCKED` INT(1) NOT NULL ,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(50) NULL ,
  `UPD_DT` TIMESTAMP(3) NULL ,
  `UPD_BY` VARCHAR(50) NULL ,
  PRIMARY KEY (`USER_ID`),
  UNIQUE INDEX `USER_ID_UNIQUE` (`USER_ID` ASC),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  INDEX `ROLE_ID` (`ROLE_ID` ASC),
  CONSTRAINT `ROLE_ID`
    FOREIGN KEY (`ROLE_ID`)
    REFERENCES `hclbss`.`TB_USER_ROLE_MAPPING` (`ROLE_UID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_ROLE_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_ROLE_MASTER` (
  `UIDPK` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` VARCHAR(50) NOT NULL,
  `DESCRIPTION` VARCHAR(50) NULL DEFAULT NULL,
  `CRE_DT` TIMESTAMP(3) NULL ,
  `CRE_BY` VARCHAR(50) NULL ,
  `UPD_DT` TIMESTAMP(3) NULL ,
  `UPD_BY` VARCHAR(50) NULL ,
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_CURRENCY_MASTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_CURRENCY_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `CURRENCY_NAME` VARCHAR(10) NOT NULL,
  `CURRENCY_CODE` VARCHAR(3) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `currency_Name_UNIQUE` (`CURRENCY_NAME` ASC),
  UNIQUE INDEX `currency_code_UNIQUE` (`CURRENCY_CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_RATEPLAN_CURRENCY_MAPPING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_RATEPLAN_CURRENCY_MAPPING` (
  `RATEPLAN_UID` BIGINT(10) UNSIGNED NOT NULL,
  `CURRENCY_CODE` VARCHAR(3) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  INDEX `fk_rate_plan_id_idx` (`RATEPLAN_UID` ASC),
  INDEX `fk_currency_id_idx` (`CURRENCY_CODE` ASC),
  CONSTRAINT `fk_rate_plan_id`
    FOREIGN KEY (`RATEPLAN_UID`)
    REFERENCES `hclbss`.`TB_RATEPLAN_MASTER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_currency_code`
    FOREIGN KEY (`CURRENCY_CODE`)
    REFERENCES `hclbss`.`TB_CURRENCY_MASTER` (`CURRENCY_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_PRICING_SCHEME`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_PRICING_SCHEME_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `PRICING_SCHEME_CODE` VARCHAR(10) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`PRICING_SCHEME_CODE`),
  UNIQUE INDEX `PRICING_SCHEME_CODE_UNIQUE` (`PRICING_SCHEME_CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_RATEPLAN_TRANSACTION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_RATEPLAN_TRANSACTION` (
  `UIDPK` BIGINT(10) NOT NULL,
  `SUBSCRIPTION_UID` BIGINT(10) UNSIGNED NOT NULL,
  `RATE_PLAN_UID` BIGINT(10) UNSIGNED NOT NULL,
  `PRODUCT_ID` BIGINT(10) UNSIGNED NOT NULL,
  `QUANTITY` INT NOT NULL,
  `PRICE` DECIMAL(10,3) NULL,
  `BILLING_CYCLE` DECIMAL(5) NULL,
  `BILLING_FREQUENCY` VARCHAR(20) NULL,
  `RATEPLAN_VOLUME_UID` BIGINT(10) UNSIGNED NULL,
  `PRICING_SCHEME` VARCHAR(10) NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  INDEX `fk_subscription_uid_idx` (`SUBSCRIPTION_UID` ASC),
  INDEX `fk_rateplanuid_idx` (`RATE_PLAN_UID` ASC),
  INDEX `fk_prodcutuid_idx` (`PRODUCT_ID` ASC),
  INDEX `fk_rateplan_vol_uid_idx` (`RATEPLAN_VOLUME_UID` ASC),
  ## to be added once it is discussed
  INDEX `fk_tb_rateplan_trans_tb_pricing_scheme_idx` (`PRICING_SCHEME` ASC),
  CONSTRAINT `fk_subscription_uid`
    FOREIGN KEY (`SUBSCRIPTION_UID`)
    REFERENCES `hclbss`.`TB_SUBSCRIPTION` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rateplanuid`
    FOREIGN KEY (`RATE_PLAN_UID`)
    REFERENCES `hclbss`.`TB_RATEPLAN_MASTER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prodcutuid`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `hclbss`.`TB_PRODUCT` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
## to be added once it is discussed
  CONSTRAINT `fk_rateplan_vol_uid`
	FOREIGN KEY (`RATEPLAN_VOLUME_UID`)
    REFERENCES `hclbss`.`TB_RATEPLAN_VOLUME_MASTER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_rateplan_trans_tb_pricing_scheme`
    FOREIGN KEY (`PRICING_SCHEME`)
    REFERENCES `hclbss`.`TB_PRICING_SCHEME_MASTER` (`PRICING_SCHEME_CODE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hclbss`.`TB_RATEPLAN_PRODUCT_MAPPING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hclbss`.`TB_RATEPLAN_PRODUCT_MAPPING` (
  `PRODUCT_UID` BIGINT(10) UNSIGNED NOT NULL,
  `RATEPLAN_UID` BIGINT(10) UNSIGNED NOT NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  INDEX `fk_tb_rateplan_product_tb_product_idx` (`PRODUCT_UID` ASC),
  INDEX `fk_tb_rateplan_product_tb_rateplan_idx` (`RATEPLAN_UID` ASC),
  CONSTRAINT `fk_tb_rateplan_product_tb_product`
    FOREIGN KEY (`PRODUCT_UID`)
    REFERENCES `hclbss`.`TB_PRODUCT` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_rateplan_product_tb_rateplan`
    FOREIGN KEY (`RATEPLAN_UID`)
    REFERENCES `hclbss`.`TB_RATEPLAN_MASTER` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `hclbss`.`TB_ERROR_LOG`(
 `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
 `ERROR_CODE` VARCHAR(50) NULL, 
 `OPERATION` VARCHAR(30) NULL,
 `DESCRIPTION` VARCHAR(700), 
 `CRE_DT` TIMESTAMP(3) NULL,
 `CRE_BY` VARCHAR(45),
 `UPD_DT` TIMESTAMP(3) NULL,
 `UPD_BY` VARCHAR(45) NULL)
 ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `hclbss`.`TB_AUTORENEWAL_BATCH_LOG` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `SUBSCRIPTION_ID` VARCHAR(20) NULL,
  `ERR_DESC` VARCHAR(450) NULL,
  `RUN_DWN_DATE` TIMESTAMP(3) NULL,
  `STATUS` VARCHAR(10) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  INDEX `tb_Subscription_idx` (`SUBSCRIPTION_ID` ASC),
  CONSTRAINT `t_Subscription`
    FOREIGN KEY (`SUBSCRIPTION_ID`)
    REFERENCES `hclbss`.`TB_SUBSCRIPTION` (`SUBSCRIPTION_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE `sequence` (
  `seq_name` VARCHAR(50) NOT NULL,
  `seq_val` BIGINT(6) unsigned NOT NULL,
  PRIMARY KEY (`seq_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `hclbss`.`TB_BUNDLE_PRODUCT_MAPPING` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,  
  `BUNDLE_PRODUCT_UID` BIGINT(10) UNSIGNED NULL,
  `PRODUCT_UID` BIGINT(10) UNSIGNED NULL,
  `DESCRIPTION` VARCHAR(100) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`UIDPK`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC),
  CONSTRAINT `fk_bundle_product`
    FOREIGN KEY (`BUNDLE_PRODUCT_UID`)
    REFERENCES `hclbss`.`TB_PRODUCT` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
   CONSTRAINT `fk_product`
    FOREIGN KEY (`PRODUCT_UID`)
    REFERENCES `hclbss`.`TB_PRODUCT` (`UIDPK`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `hclbss`.`TB_BILL_FREQUENCY_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `FREQUENCY_CODE` VARCHAR(10) NOT NULL,
  `DESCRIPTION` VARCHAR(45) NULL,
  `CRE_DT` TIMESTAMP(3) NULL,
  `CRE_BY` VARCHAR(45) NULL,
  `UPD_DT` TIMESTAMP(3) NULL,
  `UPD_BY` VARCHAR(45) NULL,
  PRIMARY KEY (`FREQUENCY_CODE`),
  UNIQUE INDEX `UIDPK_UNIQUE` (`UIDPK` ASC))
ENGINE = InnoDB; 

---------------------------------------------------------
-- Table for App Constant master
---------------------------------------------------------
  
  CREATE TABLE `hclbss`.`TB_APP_CONSTANTS_MASTER` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `APPCONSTANT_CODE` VARCHAR(30) NOT NULL,
  `SUB_APPCONSTANT_CODE` VARCHAR(20) NOT NULL,
  `SUB_APPCONSTANT_DESC` VARCHAR(100) NOT NULL,
  `CRE_BY` VARCHAR(50)  NULL,
  `CRE_DT` TIMESTAMP(3)  NULL,
  `UPD_DT` TIMESTAMP(3)  NULL,
  `UPD_BY` VARCHAR(50)  null,
  PRIMARY KEY (`UIDPK`));
  
---------------------------------------------------------
-- Table for NOTIFICATION_TRANSACTION
---------------------------------------------------------
  
 CREATE TABLE `hclbss`.`TB_NOTIFICATION_TRANSACTION` (
  `UIDPK` BIGINT(10) UNSIGNED NOT NULL,
  `SUBSCRIPTION_ID` VARCHAR(20) NOT NULL,
  `LAST_NOTIFICATION_DATE` TIMESTAMP(3) NULL,
  `NEXT_NOTIFICATION_DATE` TIMESTAMP(3) NULL,
  `NOTIFICATIONS_SENT_COUNT` INT NOT NULL,
  `CRE_BY` VARCHAR(50)  NULL,
  `CRE_DT` TIMESTAMP(3)  NULL,
  `UPD_DT` TIMESTAMP(3)  NULL,
  `UPD_BY` VARCHAR(50)  null,
  PRIMARY KEY (`UIDPK`));
-- -----------------------------------------------------
-- Callable function to get next sequence value
-- -----------------------------------------------------
/*
DELIMITER //
CREATE DEFINER=`root`@`localhost` FUNCTION `getNextSeq`(sSeqName varchar(50)) RETURNS bigint(6) unsigned MODIFIES SQL DATA
begin
    declare nLast_val bigint;

    set nLast_val =  (select seq_val
                          from sequence
                          where seq_name = sSeqName);
    if nLast_val is null then
        set nLast_val = 100001;
        insert into sequence (seq_name,seq_val)
        values (sSeqName,nLast_Val);
            else
        if nLast_val<199999 then
        set nLast_val = nLast_val + 1;
        update sequence set seq_val = nLast_val
        where seq_name = sSeqName;
        else 
        set nLast_val = 100001;
        update sequence set seq_val = nLast_val
        where seq_name = sSeqName;
        end if;
    end if;

    return nLast_val;
end //
DELIMITER ;*/

DELIMITER $$

CREATE PROCEDURE getNextSeq(sSeqName VARCHAR(50), OUT nLast_val BIGINT)
BEGIN
    DECLARE temp_val BIGINT;

    SELECT seq_val INTO temp_val
    FROM sequence
    WHERE seq_name = sSeqName;

    IF temp_val IS NULL THEN
        SET temp_val = 100001;
        INSERT INTO sequence (seq_name, seq_val)
        VALUES (sSeqName, temp_val);
    ELSE
        IF temp_val < 199999 THEN
            SET temp_val = temp_val + 1;
            UPDATE sequence
            SET seq_val = temp_val
            WHERE seq_name = sSeqName;
        ELSE
            SET temp_val = 100001;
            UPDATE sequence
            SET seq_val = temp_val
            WHERE seq_name = sSeqName;
        END IF;
    END IF;

    SET nLast_val = temp_val;
END$$

DELIMITER ;


-- -----------------------------------------------------
-- Stored procedure to update the last sequence value
-- -----------------------------------------------------

delimiter //
drop procedure if exists sp_setSeqVal //
 
create procedure sp_setSeqVal(sSeqName varchar(50), nVal int unsigned)
begin
    if (select count(*) from sequence where seq_name = sSeqName) = 0 then
        insert into sequence (seq_name,seq_val)
        values (sSeqName,nVal);
    else
        update sequence set seq_val = nVal
        where seq_name = sSeqName;
    end if;
end //
 
delimiter ;

-- -----------------------------------------------------
-- Inserting first value of sequence
-- -----------------------------------------------------

INSERT INTO `hclbss`.`sequence`
(`seq_name`,
`seq_val`)
VALUES
('SubscriptionSeq',
100000);


-- -----------------------------------------------------
-- Table `hclbss`.`spring_session`
-- -----------------------------------------------------

CREATE TABLE spring_session (
    PRIMARY_ID CHAR(36) NOT NULL,
    SESSION_ID CHAR(36) NOT NULL,
    CREATION_TIME BIGINT NOT NULL,
    LAST_ACCESS_TIME BIGINT NOT NULL,
    MAX_INACTIVE_INTERVAL INT NOT NULL,
    EXPIRY_TIME BIGINT NOT NULL,
    PRINCIPAL_NAME VARCHAR(100),
    CONSTRAINT SPRING_SESSION_PK PRIMARY KEY (PRIMARY_ID)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

CREATE UNIQUE INDEX SPRING_SESSION_IX1 ON spring_session (SESSION_ID);
CREATE INDEX SPRING_SESSION_IX2 ON spring_session (EXPIRY_TIME);
CREATE INDEX SPRING_SESSION_IX3 ON spring_session (PRINCIPAL_NAME);


-- -----------------------------------------------------
-- Table `hclbss`.`spring_session_attributes`
-- -----------------------------------------------------

CREATE TABLE spring_session_attributes (
    SESSION_PRIMARY_ID CHAR(36) NOT NULL,
    ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
    ATTRIBUTE_BYTES BLOB NOT NULL,
    CONSTRAINT SPRING_SESSION_ATTRIBUTES_PK PRIMARY KEY (SESSION_PRIMARY_ID, ATTRIBUTE_NAME),
    CONSTRAINT SPRING_SESSION_ATTRIBUTES_FK FOREIGN KEY (SESSION_PRIMARY_ID)
        REFERENCES spring_session (PRIMARY_ID) ON DELETE CASCADE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


