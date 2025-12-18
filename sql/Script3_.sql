
------------------------------------------------------------
-- script_3.sql
-- Populate normalized GA5 tables from staging GA5_Address
------------------------------------------------------------

USE [25f_cst2112_group_09];
GO

------------------------------------------------------------
-- 1. Load GA5_Street (official street info)
------------------------------------------------------------
INSERT INTO dbo.GA5_Street (
    OFFICIAL_STREET_NAME,
    OFFICIAL_STREET_TYPE,
    OFFICIAL_STREET_DIR
)
SELECT DISTINCT
    OFFICIAL_STREET_NAME,
    OFFICIAL_STREET_TYPE,
    OFFICIAL_STREET_DIR
FROM dbo.GA5_Address
WHERE OFFICIAL_STREET_NAME IS NOT NULL;
GO

------------------------------------------------------------
-- 2. Load GA5_Municipality (CSD info)
------------------------------------------------------------
INSERT INTO dbo.GA5_Municipality (
    CSD_ENG_NAME,
    CSD_FRE_NAME,
    CSD_TYPE_ENG_CODE,
    CSD_TYPE_FRE_CODE
)
SELECT DISTINCT
    CSD_ENG_NAME,
    CSD_FRE_NAME,
    CSD_TYPE_ENG_CODE,
    CSD_TYPE_FRE_CODE
FROM dbo.GA5_Address
WHERE CSD_ENG_NAME IS NOT NULL;
GO

------------------------------------------------------------
-- 3. Load GA5_Province (province info)
------------------------------------------------------------
INSERT INTO dbo.GA5_Province (
    PROV_CODE,
    MAIL_PROV_ABVN
)
SELECT DISTINCT
    PROV_CODE,
    MAIL_PROV_ABVN
FROM dbo.GA5_Address
WHERE PROV_CODE IS NOT NULL;
GO

------------------------------------------------------------
-- 4. Load GA5_Geography (legal land description + coordinates)
------------------------------------------------------------
INSERT INTO dbo.GA5_Geography (
    BG_DLS_LSD,
    BG_DLS_QTR,
    BG_DLS_SCTN,
    BG_DLS_TWNSHP,
    BG_DLS_RNG,
    BG_DLS_MRD,
    BG_X,
    BG_Y
)
SELECT DISTINCT
    BG_DLS_LSD,
    BG_DLS_QTR,
    BG_DLS_SCTN,
    BG_DLS_TWNSHP,
    BG_DLS_RNG,
    BG_DLS_MRD,
    BG_X,
    BG_Y
FROM dbo.GA5_Address;
GO

------------------------------------------------------------
-- 5. Load GA5_MailingAddress (mailing address info)
------------------------------------------------------------
INSERT INTO dbo.GA5_MailingAddress (
    MAIL_STREET_NAME,
    MAIL_STREET_TYPE,
    MAIL_STEET_DIR,
    MAIL_MUN_NAME,
    MAIL_POSTAL_CODE
)
SELECT DISTINCT
    MAIL_STREET_NAME,
    MAIL_STREET_TYPE,
    MAIL_STEET_DIR,
    MAIL_MUN_NAME,
    MAIL_POSTAL_CODE
FROM dbo.GA5_Address;
GO

------------------------------------------------------------
-- 6. Load GA5_AddressNormalized (main address entity)
------------------------------------------------------------
INSERT INTO dbo.GA5_AddressNormalized (
    LOC_GUID,
    ADDR_GUID,
    APT_NO_LABEL,
    CIVIC_NO,
    CIVIC_NO_SUFFIX,
    StreetID,
    MunicipalityID,
    ProvinceID,
    GeographyID,
    MailingID,
    BU_N_CIVIC_ADD,
    BU_USE
)
SELECT
    GA5_Address.LOC_GUID,
    GA5_Address.ADDR_GUID,
    GA5_Address.APT_NO_LABEL,
    GA5_Address.CIVIC_NO,
    GA5_Address.CIVIC_NO_SUFFIX,

    GA5_Street.StreetID,
    GA5_Municipality.MunicipalityID,
    GA5_Province.ProvinceID,

    NULL AS GeographyID,      -- optional, left NULL
    NULL AS MailingID,        -- optional, left NULL

    GA5_Address.BU_N_CIVIC_ADD,
    GA5_Address.BU_USE
FROM dbo.GA5_Address
INNER JOIN dbo.GA5_Street
    ON  GA5_Address.OFFICIAL_STREET_NAME = GA5_Street.OFFICIAL_STREET_NAME
    AND ISNULL(GA5_Address.OFFICIAL_STREET_TYPE,'') = ISNULL(GA5_Street.OFFICIAL_STREET_TYPE,'')
    AND ISNULL(GA5_Address.OFFICIAL_STREET_DIR,'')  = ISNULL(GA5_Street.OFFICIAL_STREET_DIR,'')
INNER JOIN dbo.GA5_Municipality
    ON  GA5_Address.CSD_ENG_NAME = GA5_Municipality.CSD_ENG_NAME
    AND ISNULL(GA5_Address.CSD_FRE_NAME,'')      = ISNULL(GA5_Municipality.CSD_FRE_NAME,'')
    AND ISNULL(GA5_Address.CSD_TYPE_ENG_CODE,'') = ISNULL(GA5_Municipality.CSD_TYPE_ENG_CODE,'')
    AND ISNULL(GA5_Address.CSD_TYPE_FRE_CODE,'') = ISNULL(GA5_Municipality.CSD_TYPE_FRE_CODE,'')
INNER JOIN dbo.GA5_Province
    ON  GA5_Address.PROV_CODE = GA5_Province.PROV_CODE
    AND ISNULL(GA5_Address.MAIL_PROV_ABVN,'') = ISNULL(GA5_Province.MAIL_PROV_ABVN,'');
GO

----------------------------------------------------------------
USE [25f_cst2112_group_09];
GO

-- 1NF: all attributes in a single wide table (no repeating groups)
SELECT TOP (20) *
FROM dbo.GA5_Address;


-- 2NF: logical Street–Municipality–Province entity
CREATE VIEW dbo.GA5_2NF_StreetMunProv AS
SELECT DISTINCT
    OFFICIAL_STREET_NAME,
    OFFICIAL_STREET_TYPE,
    OFFICIAL_STREET_DIR,
    CSD_ENG_NAME,
    CSD_FRE_NAME,
    CSD_TYPE_ENG_CODE,
    CSD_TYPE_FRE_CODE,
    PROV_CODE,
    MAIL_PROV_ABVN
FROM dbo.GA5_Address;
GO
-- Show some rows from this 2NF view
SELECT TOP (20) *
FROM dbo.GA5_2NF_StreetMunProv;


-- 3NF: each entity in its own table
SELECT TOP (2) * FROM dbo.GA5_Street;          -- street-only attributes
SELECT TOP (2) * FROM dbo.GA5_Municipality;    -- CSD attributes
SELECT TOP (2) * FROM dbo.GA5_Province;        -- province attributes
SELECT TOP (2) * FROM dbo.GA5_Geography;       -- legal land + coordinates
SELECT TOP (2) * FROM dbo.GA5_MailingAddress;  -- mailing-only attributes
SELECT TOP (2) * FROM dbo.GA5_AddressNormalized; -- main address + FKs
