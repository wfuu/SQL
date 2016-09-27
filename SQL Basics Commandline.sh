# List databases
show databases;
# Create new database
create database schooldb;
# Choose a working database
use schooldb;
# Delete a database
drop database schooldb;
# Identify current database
select database();
# List tables
show tables;
# Create new table (relation)
create table Students (SSN varchar(10), FirstName varchar(20), LastName varchar(40)) primary key (SSN);
# Add a new column
alter table Students add Major int;
# Delete a table
drop table Students;
# Show the structure of a table
describe Students;
# Add data row into a table
insert into Students (SSN, FirstName, LastName) values ('123121234', 'Kevin', 'Jensen');
# List all data in a table
select * from Students;
# List selected columns from a table
select FirstName, LastName from Students;
# Conditionally list from a table
select SSN from Students where LastName='Jensen';
# Sort the rows
select * from Students order by SSN;
