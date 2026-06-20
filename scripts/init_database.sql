/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Drop the database if it exists 
-- (The WITH (FORCE) clause is available in PostgreSQL 13+ and terminates existing connections)
DROP DATABASE IF EXISTS "DataWarehouse" WITH (FORCE);

-- Create the 'DataWarehouse' database
CREATE DATABASE "DataWarehouse";

-- Switch to the new database (psql command)
-- NOTE: If using pgAdmin/DBeaver, you must manually connect to "DataWarehouse" here instead.
\c "DataWarehouse"

-- Create Schemas
CREATE SCHEMA IF NOT EXISTS bronze;
CREATE SCHEMA IF NOT EXISTS silver;
CREATE SCHEMA IF NOT EXISTS gold;
