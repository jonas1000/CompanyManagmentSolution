DROP DATABASE RE1101_CompanyManagmentDB;
CREATE DATABASE RE1101_CompanyManagmentDB CHARACTER SET utf8 COLLATE utf8_bin;

USE RE1101_CompanyManagmentDB;

CREATE TABLE RE1101_CMContrInf
(
	CMContrInfID INT AUTO_INCREMENT,
	CMContractor VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMDueDate DATETIME NOT NULL,
	CMAdvPay REAL(16,2) NOT NULL DEFAULT 0.0,
	CMContrPay REAL(16,2) NOT NULL DEFAULT 0.0,
	CMDateS DATETIME NOT NULL DEFAULT NOW(),
	CMProdName VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	PRIMARY KEY(CMContrInfID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMCompInf
(
	CMCompInfID INT AUTO_INCREMENT,
	CMCompName VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMDateC DATETIME NOT NULL DEFAULT NOW(),
	CMLocation VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMLocInterest REAL(3,2) NOT NULL DEFAULT 0.0,
	PRIMARY KEY(CMCompInfID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMContr
(
	CMContrID INT AUTO_INCREMENT,
	CMContrInfID INT,
	PRIMARY KEY(CMContrID),
	FOREIGN KEY(CMContrInfID) REFERENCES RE1101_CMContrInf(CMContrInfID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMComp
(
	CMCompID INT AUTO_INCREMENT,
	CMCompInfID INT,
	PRIMARY KEY(CMCompID),
	FOREIGN KEY(CMCompInfID) REFERENCES RE1101_CMCompInf(CMCompInfID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMProj
(
	CMProjID INT AUTO_INCREMENT,
	CMContrID INT,
	CMCompID INT,
	PRIMARY KEY(CMProjID),
	FOREIGN KEY(CMContrID) REFERENCES RE1101_CMContr(CMContrID),
	FOREIGN KEY(CMCompID) REFERENCES RE1101_CMComp(CMCompID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMTaskInf
(
	CMTaskInfID INT AUTO_INCREMENT,
	CMPos INT(4) NOT NULL DEFAULT 0,
	CMNeg INT(4) NOT NULL DEFAULT 0,
	CMNorm INT(4) NOT NULL DEFAULT 0,
	CMExp REAL(8,3) NOT NULL DEFAULT 0,
	CMVar REAL(8,3) NOT NULL DEFAULT 0,
	CMMonth INT(3) NOT NULL DEFAULT 0,
	CMDateC DATETIME NOT NULL DEFAULT NOW(),
	PRIMARY KEY(CMTaskInfID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMTask
(
	CMTaskID INT AUTO_INCREMENT,
	CMTaskInfID INT,
	CMProjID INT,
	PRIMARY KEY(CMTaskID),
	FOREIGN KEY(CMTaskInfID) REFERENCES RE1101_CMTaskInf(CMTaskInfID),
	FOREIGN KEY(CMProjID) REFERENCES RE1101_CMProj(CMProjID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMEmpSal
(
	CMEmpSalID INT AUTO_INCREMENT,
	CMIncome REAL(16,2) NOT NULL DEFAULT 0,
	CMDate DATETIME NOT NULL DEFAULT 0,
	PRIMARY KEY(CMEmpSalID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMEmpInf
(
	CMEmpInfID INT AUTO_INCREMENT,
	CMEmpSalID INT,
	CMEmpName VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMBirthDate DATE NOT NULL,
	CMCity VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMCivCode VARCHAR(16) NOT NULL,
	CMAvail REAL(3,3) NOT NULL DEFAULT 0.0,
	PRIMARY KEY(CMEmpInfID),
	FOREIGN KEY(CMEmpSalID) REFERENCES RE1101_CMEmpSal(CMEmpSalID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMDep
(
	CMDepID INT AUTO_INCREMENT,
	PRIMARY KEY(CMDepID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMDepInf
(
	CMDepInfID INT AUTO_INCREMENT,
	CMDepID INT,
	CMProjID INT,
	CMName VARCHAR(32) NOT NULL DEFAULT "MISSING FIELD",
	CMDateC DATETIME NOT NULL DEFAULT NOW(),
	PRIMARY KEY(CMDepInfID),
	FOREIGN KEY(CMDepID) REFERENCES RE1101_CMDep(CMDepID),
	FOREIGN KEY(CMProjID) REFERENCES RE1101_CMProj(CMProjID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMEmp
(
	CMEmpID INT AUTO_INCREMENT,
	CMEmpInfID INT,
	CMDepID INT,
	PRIMARY KEY(CMEmpID),
	FOREIGN KEY(CMEmpInfID) REFERENCES RE1101_CMEmpInf(CMEmpInfID),
	FOREIGN KEY(CMDepID) REFERENCES RE1101_CMDep(CMDepID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMEmpUnav
(
	CMEmpUnavID INT AUTO_INCREMENT,
	CMEmpID INT,
	CMDateS DATETIME NOT NULL DEFAULT NOW(),
	CMDateE DATETIME NOT NULL DEFAULT NOW(),
	PRIMARY KEY(CMEmpUnavID),
	FOREIGN KEY(CMEmpID) REFERENCES RE1101_CMEmp(CMEmpID)
)ENGINE = innoDB;

CREATE TABLE RE1101_CMEmpAssigTask
(
	CMEmpAssigTask INT AUTO_INCREMENT,
	CMEmpID INT,
	CMTaskID INT,
	PRIMARY KEY(CMEmpAssigTask),
	FOREIGN KEY(CMEmpID) REFERENCES RE1101_CMEmp(CMEmpID),
	FOREIGN KEY(CMTaskID) REFERENCES RE1101_CMTask(CMTaskID)
)ENGINE = innoDB;
