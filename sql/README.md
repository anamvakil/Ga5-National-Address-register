# SQL Scripts – National Address Register (GA5)

This folder contains the **T-SQL scripts** developed for the *National Address Register (GA5)* data engineering project.  
The scripts implement a complete database pipeline, from **raw data staging** to **normalization (3NF)** while enforcing **referential integrity**.

---

## 📌 Project Objective
To design and implement a **relational database schema** that supports efficient storage, integrity, and querying of national address data using best practices in data engineering.

---

## 📂 Script Overview & Execution Order

###  `script1_sql`
**Staging Table Creation**
- Creates staging tables to ingest raw address data
- Preserves original structure for controlled transformations
- Acts as the entry point of the ETL pipeline

###  `Script2_sql`
**Data Loading & Initial Transformation**
- Loads raw data into staging tables
- Performs basic cleansing and preparation
- Prepares data for normalization

###  `Script3_sql`
**Normalization to 3NF**
- Decomposes data into normalized relational tables
- Eliminates redundancy and update anomalies
- Implements primary and foreign key relationships

---

##  Key Concepts Demonstrated
- Staging tables for raw data ingestion
- Normalization up to **Third Normal Form (3NF)**
- Primary & foreign key constraints
- Referential integrity enforcement
- Modular and reusable SQL scripting

---

##  Technologies Used
- **SQL Server**
- **T-SQL**

---

##  Related Artifacts
- **ERD**: See `/erd/` folder
- **Project Report**: See `/report/GA5_Project.pdf`

---

##  Contribution Note
This was a **group academic project**.  
My primary contributions included:
- Designing the staging and normalized schemas
- Writing the majority of T-SQL scripts
- Implementing constraints and relationships
- Preparing technical documentation and ERD

---

📎 *For full project context, refer to the repository root README.*

