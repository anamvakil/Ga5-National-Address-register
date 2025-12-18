------------------------------------------------------------
-- script_2.sql
-- Load GA5 raw CSV files into staging table GA5_Address
------------------------------------------------------------

USE [25f_cst2112_group_09];
GO

-- Start with a clean staging table
TRUNCATE TABLE dbo.GA5_Address;
GO

------------------------------------------------------------
-- NOTE:
-- Files are stored on the SQL Server at:
--   c:\cst2112_data\ga5_NAR\
-- Each BULK INSERT appends rows into GA5_Address.
------------------------------------------------------------

-- Address_11.csv
BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_11.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '\n',
    TABLOCK
);
GO

-- Address_12.csv
BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '\n',
    TABLOCK
);
GO

-- Address_13.csv
BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_13.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR   = '\n',
    TABLOCK
);
GO

------------------------------------------------------------
-- Address_24 parts
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_24_part_1.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_24_part_2.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_24_part_3.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_24_part_4.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_24_part_5.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

------------------------------------------------------------
-- Address_35 parts (1–7)
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_1.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_2.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_3.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_4.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_5.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_6.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_35_part_7.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

------------------------------------------------------------
-- Address_46.csv, Address_47.csv
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_46.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_47.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

------------------------------------------------------------
-- Address_48 parts
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_48_part_1.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_48_part_2.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

------------------------------------------------------------
-- Address_59 parts
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_59_part_1.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_59_part_2.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_59_part_3.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

------------------------------------------------------------
-- Address_60.csv, Address_61.csv, Address_62.csv
------------------------------------------------------------

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_60.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_61.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO

BULK INSERT dbo.GA5_Address
FROM 'c:\cst2112_data\ga5_NAR\Address_62.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n', TABLOCK);
GO
