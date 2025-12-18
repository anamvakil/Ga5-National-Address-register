------------------------------------------------------------
-- script_1.sql  (GA5 - National Address Register)
-- Create staging + normalized (3NF) tables
------------------------------------------------------------

USE [25f_cst2112_group_09];
GO

------------------------------------------------------------
-- 0. DROP OLD TABLES IN FK-SAFE ORDER
------------------------------------------------------------

IF OBJECT_ID('dbo.GA5_AddressNormalized', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_AddressNormalized;
GO

IF OBJECT_ID('dbo.GA5_MailingAddress', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_MailingAddress;
GO

IF OBJECT_ID('dbo.GA5_Geography', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_Geography;
GO

IF OBJECT_ID('dbo.GA5_Province', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_Province;
GO

IF OBJECT_ID('dbo.GA5_Municipality', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_Municipality;
GO

IF OBJECT_ID('dbo.GA5_Street', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_Street;
GO

IF OBJECT_ID('dbo.GA5_Address', 'U') IS NOT NULL
    DROP TABLE dbo.GA5_Address;
GO

------------------------------------------------------------
-- 1. STAGING TABLE: GA5_Address
--    Raw National Address Register data (all VARCHAR for safety)
------------------------------------------------------------

CREATE TABLE dbo.GA5_Address (
    LOC_GUID              VARCHAR(50),
    ADDR_GUID             VARCHAR(50),
    APT_NO_LABEL          VARCHAR(50),
    CIVIC_NO              VARCHAR(50),
    CIVIC_NO_SUFFIX       VARCHAR(50),
    OFFICIAL_STREET_NAME  VARCHAR(255),
    OFFICIAL_STREET_TYPE  VARCHAR(100),
    OFFICIAL_STREET_DIR   VARCHAR(50),
    PROV_CODE             VARCHAR(20),
    CSD_ENG_NAME          VARCHAR(255),
    CSD_FRE_NAME          VARCHAR(255),
    CSD_TYPE_ENG_CODE     VARCHAR(100),
    CSD_TYPE_FRE_CODE     VARCHAR(100),
    MAIL_STREET_NAME      VARCHAR(255),
    MAIL_STREET_TYPE      VARCHAR(100),
    MAIL_STEET_DIR        VARCHAR(50),
    MAIL_MUN_NAME         VARCHAR(255),
    MAIL_PROV_ABVN        VARCHAR(50),
    MAIL_POSTAL_CODE      VARCHAR(255),
    BG_DLS_LSD            VARCHAR(100),
    BG_DLS_QTR            VARCHAR(100),
    BG_DLS_SCTN           VARCHAR(100),
    BG_DLS_TWNSHP         VARCHAR(100),
    BG_DLS_RNG            VARCHAR(100),
    BG_DLS_MRD            VARCHAR(100),
    BG_X                  VARCHAR(50),
    BG_Y                  VARCHAR(50),
    BU_N_CIVIC_ADD        VARCHAR(255),
    BU_USE                VARCHAR(50)
);
GO

------------------------------------------------------------
-- 2. NORMALIZED ENTITY TABLES (3NF)
------------------------------------------------------------

-- 2.1 Street: official street information
CREATE TABLE dbo.GA5_Street (
    StreetID INT IDENTITY(1,1) PRIMARY KEY,
    OFFICIAL_STREET_NAME  VARCHAR(255) NOT NULL,
    OFFICIAL_STREET_TYPE  VARCHAR(100) NULL,
    OFFICIAL_STREET_DIR   VARCHAR(50)  NULL
);
GO

-- 2.2 Municipality: CSD-level information
CREATE TABLE dbo.GA5_Municipality (
    MunicipalityID    INT IDENTITY(1,1) PRIMARY KEY,
    CSD_ENG_NAME      VARCHAR(255) NOT NULL,
    CSD_FRE_NAME      VARCHAR(255) NULL,
    CSD_TYPE_ENG_CODE VARCHAR(100) NULL,
    CSD_TYPE_FRE_CODE VARCHAR(100) NULL
);
GO

-- 2.3 Province: province-level information
CREATE TABLE dbo.GA5_Province (
    ProvinceID     INT IDENTITY(1,1) PRIMARY KEY,
    PROV_CODE      VARCHAR(20)  NOT NULL,
    MAIL_PROV_ABVN VARCHAR(50)  NULL
);
GO

-- 2.4 Geography: DLS legal land description + coordinates
CREATE TABLE dbo.GA5_Geography (
    GeographyID   INT IDENTITY(1,1) PRIMARY KEY,
    BG_DLS_LSD    VARCHAR(100) NULL,
    BG_DLS_QTR    VARCHAR(100) NULL,
    BG_DLS_SCTN   VARCHAR(100) NULL,
    BG_DLS_TWNSHP VARCHAR(100) NULL,
    BG_DLS_RNG    VARCHAR(100) NULL,
    BG_DLS_MRD    VARCHAR(100) NULL,
    BG_X          VARCHAR(50)  NULL,
    BG_Y          VARCHAR(50)  NULL
);
GO

-- 2.5 MailingAddress: mailing address details
CREATE TABLE dbo.GA5_MailingAddress (
    MailingID        INT IDENTITY(1,1) PRIMARY KEY,
    MAIL_STREET_NAME VARCHAR(255) NULL,
    MAIL_STREET_TYPE VARCHAR(100) NULL,
    MAIL_STEET_DIR   VARCHAR(50)  NULL,
    MAIL_MUN_NAME    VARCHAR(255) NULL,
    MAIL_POSTAL_CODE VARCHAR(255) NULL
);
GO

------------------------------------------------------------
-- 3. MAIN ADDRESS TABLE (3NF)
--    Each physical address, linked to the above entities
------------------------------------------------------------

CREATE TABLE dbo.GA5_AddressNormalized (
    AddressID        INT IDENTITY(1,1) PRIMARY KEY,

    -- business keys / identifiers
    LOC_GUID         VARCHAR(50) NULL,
    ADDR_GUID        VARCHAR(50) NULL,

    -- dwelling-specific attributes
    APT_NO_LABEL     VARCHAR(50) NULL,
    CIVIC_NO         VARCHAR(50) NULL,
    CIVIC_NO_SUFFIX  VARCHAR(50) NULL,

    -- foreign keys to normalized entities
    StreetID         INT NOT NULL,
    MunicipalityID   INT NOT NULL,
    ProvinceID       INT NOT NULL,
    GeographyID      INT NULL,   -- optional (LEFT JOIN)
    MailingID        INT NULL,   -- optional (LEFT JOIN)

    -- additional attributes
    BU_N_CIVIC_ADD   VARCHAR(255) NULL,
    BU_USE           VARCHAR(50)  NULL,

    CONSTRAINT FK_GA5_AddressNormalized_Street
        FOREIGN KEY (StreetID)       REFERENCES dbo.GA5_Street(StreetID),

    CONSTRAINT FK_GA5_AddressNormalized_Municipality
        FOREIGN KEY (MunicipalityID) REFERENCES dbo.GA5_Municipality(MunicipalityID),

    CONSTRAINT FK_GA5_AddressNormalized_Province
        FOREIGN KEY (ProvinceID)     REFERENCES dbo.GA5_Province(ProvinceID),

    CONSTRAINT FK_GA5_AddressNormalized_Geography
        FOREIGN KEY (GeographyID)    REFERENCES dbo.GA5_Geography(GeographyID),

    CONSTRAINT FK_GA5_AddressNormalized_Mailing
        FOREIGN KEY (MailingID)      REFERENCES dbo.GA5_MailingAddress(MailingID)
);
GO
