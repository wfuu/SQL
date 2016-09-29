# List databases
\l;
# Create new database
create database schooldb;
# Choose a working database
\c schooldb;
# Delete a database
drop database schooldb;
# Identify current database
select current_database();
# List tables
\d;
# Create new table (relation)
create table Students (SSN varchar(10) primary key, FirstName varchar(20), LastName varchar(40));
# Add a new column
alter table Students add Major int;
# Delete a table
drop table Students;
# Show the structure of a table
\d+ Students;
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
# Get unique rows
select distinct SSN from Students;
# Match a pattern
select SSN from Students where LastName like 'Jens%';
# Choose from a set of values
select * from Students where zip in ('10027','10025');
# Modify a value
update Students set zip = 10025 where SSN = '123121234';
# Delete a row
delete from Students where zip = '10027';
# Group data and list selected columns
select zip, avg(balance) from Students group by zip;
