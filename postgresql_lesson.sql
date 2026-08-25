1.2. Download and installation PostgreSQL
--- steps to install PostgreSQL on your local PC: 
https://www.postgresql.org/download/
- Go to the official PostgreSQL website and download the installer for your operating system.
- Run the installer and follow the wizard prompts.
- Choose the installation directory or accept the default.
- Select components to install: PostgreSQL server, pgAdmin (graphical client), and command line tools.
- Set a password for the default PostgreSQL user (postgres).
- Keep the default port 5432 unless you have a reason to change it.
- Choose the default locale and proceed.
- Complete the installation and finish.
After installation, you’ll have both the server and client tools ready to use on your PC.
-- PostgreSQL home location after installation with installer
> cd /Library/PostgreSQL/18

--- Using Docker to run a PostgreSQL database server offers several advantages:
https://www.docker.com/products/docker-desktop/
- It isolates the database server in a container, so it doesn't interfere with your computer's main system.
- You can quickly create, copy, or delete PostgreSQL servers, making it easy to manage multiple versions or separate projects.
- If you misconfigure something, you can simply discard the container and create a fresh one in seconds.
This flexibility and ease of management make Docker a preferred choice for experimenting with PostgreSQL and managing different environments efficiently.
--- Docker cmd to install container of PostgreSQL
-- check docker is running on pc
> docker
-- install postgresql server in container (-p external port:inside container port)
> docker run --name postgresql-server-1 -e POSTGRES_PASSWORD=qaz123@A -p 5430:5432 -d postgres:latest

1.4. Connect to the server with psql
-- Add psql to PATH on bash profile terminal
> echo 'export PATH="/Library/PostgreSQL/18/bin:$PATH"' >> ~/.zshrc
> source ~/.zshrc
> cat ~/.zshrc 
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/php@8.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/php@8.1/include"
export PATH="/Library/PostgreSQL/18/bin:$PATH"

> which psql
/Library/PostgreSQL/18/bin/psql
> psql --version
psql (PostgreSQL) 18.6

-- login to psql 
> psql -h localhost -p 5432 -U postgres -d postgres
postgres=-- select version();
                                                      version                                                      
-------------------------------------------------------------------------------------------------------------------
 PostgreSQL 18.6 on aarch64-apple-darwin24.6.0, compiled by Apple clang version 17.0.0 (clang-1700.0.13.5), 64-bit
(1 row)
postgres=-- 
postgres=-- select now();
             now              
------------------------------
 2026-08-21 15:32:41.60886+07
(1 row)

-- Test some cmd
postgres=-- create database colors;
CREATE DATABASE

-- show/use database with shortcut cmd
postgres=-- \l
                                                List of databases
   Name    |  Owner   | Encoding | Locale Provider | Collate | Ctype | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+---------+-------+--------+-----------+-----------------------
 colors    | postgres | UTF8     | libc            | C       | C     |        |           | 
 postgres  | postgres | UTF8     | libc            | C       | C     |        |           | 
 template0 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | C       | C     |        |           | =c/postgres          +
           |          |          |                 |         |       |        |           | postgres=CTc/postgres
(4 rows)

postgres=-- 
postgres=-- \c colors;
You are now connected to database "colors" as user "postgres".
colors=-- 
colors=-- 
colors=-- create table colors (colorID int, colorName char(20));
CREATE TABLE
colors=-- 
colors=-- insert into colors values (1, 'red'), (2, 'white'), (3, 'black');
INSERT 0 3
colors=-- 
colors=-- select * from colors;
 colorid |      colorname       
---------+----------------------
       1 | red                 
       2 | white               
       3 | black               
(3 rows)

colors=-- 

1.9. Use pgAdmin's toolset
--- Setup psql cmd tool in pgadmin
preference -> paths -> binary paths -> PostgreSQL binary path -> version -> path (on server) -> validate -> save
-> Go to psql toolbar -> click on a database -> run psql

2.4. Create a table and insert rows of data
-- - You can use pgAdmin's dialog-based workflow to create tables by defining columns, data types, and constraints like primary keys and NOT NULL to ensure data integrity.
-- - Primary keys uniquely identify each row and help with indexing for faster data retrieval.
-- - Data types should be chosen carefully (e.g., integer, character varying, text, numeric) to match the kind of data stored.
-- - Constraints like NOT NULL enforce required fields, while others can allow optional data.
-- - pgAdmin helps generate SQL commands for inserting data, which you can execute to add rows to your tables.
CREATE TABLE public.fruit
(
    fruit_id integer,
    fruit_name character varying(20) NOT NULL,
    description text,
    price numeric(5, 2),
    PRIMARY KEY (fruit_id)
);

ALTER TABLE IF EXISTS public.fruit
    OWNER to postgres;

INSERT INTO public.fruit(
	fruit_id, fruit_name, description, price)
	VALUES (1, 'Apple', 'Red apple', 1.55);

INSERT INTO public.fruit(
	fruit_id, fruit_name, description, price)
	VALUES (2, 'Banana', 'Yellow banana', 3.99);

SELECT * FROM public.fruit
ORDER BY fruit_id ASC 

2.5. Using array data types
-- - PostgreSQL supports array data types, allowing you to store multiple values of the same type in a single column, which can simplify data organization.
-- - You create array columns by adding square brackets to the data type (e.g., text[]), and insert multiple values using curly braces with comma-separated items.
-- - You can retrieve individual elements from an array using their position with square bracket notation (e.g., phone[1] for the first item).

-- Using arrays can be a powerful way to handle related data within one table, offering flexibility beyond traditional relational designs.

-- What is a data array?
An array is a group of values of the same type. For instance, you could group all of the phone numbers used for a single customer in a text array, and keep everything together in the same table. This is an alternative to storing each phone number item as a separate record in a related table using a one-to-many relationship.

-- using array
CREATE TABLE IF NOT EXISTS public.customers
(
    customer_id integer NOT NULL,
    customer_name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    phone text[] COLLATE pg_catalog."default",
    CONSTRAINT customers_pkey PRIMARY KEY (customer_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customers
    OWNER to postgres;

INSERT INTO public.customers(
	customer_id, customer_name, phone)
	VALUES (1, 'Ponleu', '{1111-2222, 3333-4444}');

SELECT * FROM public.customers
ORDER BY customer_id ASC 


SELECT customer_name, 
	phone[1] AS "primary_phone",
	phone[2] AS "secondary_phone"
FROM public.customers
WHERE customer_id = 1;

--- 3. Building a Database
--- 3.1. Organize tables with schemas
-- - Schemas in PostgreSQL help organize database objects like tables into logical groups, often reflecting business departments or functions.
-- - Using schemas improves database organization and security by allowing permissions to be managed at the schema level, controlling user access efficiently.
-- You can create schemas using pgAdmin's graphical interface or by executing SQL commands directly, and understanding the SQL syntax is valuable for effective database management.

CREATE SCHEMA hr
    AUTHORIZATION postgres;

CREATE SCHEMA manufacturing AUTHORIZATION postgres;


--- 3.2 Create tables with pgAdmin
CREATE TABLE IF NOT EXISTS manufacturing.products
(
    product_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    power integer,
    manufacturing_cost numeric(10,2) NOT NULL,
    category_id integer NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS manufacturing.products
    OWNER to postgres;

CREATE TABLE manufacturing.categories
(
    category_id integer NOT NULL,
    name character varying(50) NOT NULL,
    market character varying(20) NOT NULL,
    PRIMARY KEY (category_id)
);

-- table HR
CREATE TABLE IF NOT EXISTS hr.departments
(
    department_id integer NOT NULL,
    department_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    building character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT departments_pkey PRIMARY KEY (department_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS hr.departments
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS hr.employees
(
    employee_id integer NOT NULL,
    first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    hire_date date NOT NULL,
    department_id integer NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id),
    CONSTRAINT employees_department_id_fkey FOREIGN KEY (department_id)
        REFERENCES hr.departments (department_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS hr.employees
    OWNER to postgres;


--- Link primary and foreign keys
ALTER TABLE IF EXISTS manufacturing.categories
    OWNER to postgres;

ALTER TABLE IF EXISTS manufacturing.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
    REFERENCES manufacturing.categories (category_id) MATCH SIMPLE
    ON UPDATE CASCADE
    ON DELETE NO ACTION;


--- 4. Retrive information with queries
--- 4.4. Join tables for additional information
SELECT 
	products.product_id,
	products.name AS pro_name,
	products.manufacturing_cost,
	categories.name AS cat_name,
	categories.market
FROM manufacturing.products 
JOIN manufacturing.categories
ON products.category_id = categories.category_id
WHERE categories.market = 'domestic';


--- 4.5. Save a query as a database view
-- -You can save complex queries as database views using the CREATE VIEW statement, which stores the query in the database for easy reuse.
-- - Views act like tables but don't store data themselves; they provide a shortcut to the original data in your tables.
-- - You can query views just like tables, including adding filters with WHERE clauses to get specific results.

CREATE VIEW manufacturing.products_details AS
SELECT 
	products.product_id,
	products.name AS pro_name,
	products.manufacturing_cost,
	categories.name AS cat_name,
	categories.market
FROM manufacturing.products 
JOIN manufacturing.categories
ON products.category_id = categories.category_id;

SELECT *
FROM manufacturing.products_details;

--- 4.6. Challege
SELECT * 
FROM hr.employees
JOIN hr.departments
ON employees.department_id = departments.department_id
WHERE departments.building = 'South';

SELECT 
	employees.first_name,
	employees.last_name,
	departments.building
FROM hr.employees
JOIN hr.departments
ON employees.department_id = departments.department_id
WHERE departments.building = 'South';

--- 5. Managing Data
--- 5.1. Add indexes to tables
-- - Indexes in PostgreSQL function like a textbook index, helping the database quickly locate records without scanning the entire table.
-- - Creating an index involves selecting columns to index, with the B-tree method being the most common and effective for speeding up searches.
-- - PostgreSQL automatically indexes primary keys, but you can add indexes on other frequently queried columns to improve performance.
-- - Options like unique constraints, clustering, and collation settings allow fine-tuning of how indexes behave and store data.
-- - Properly naming indexes helps keep your database organized and makes it easier to identify their purpose.
-- Understanding and managing indexes effectively is a valuable skill for optimizing database performance in your field.

CREATE INDEX products_name_idx
    ON manufacturing.products USING btree
    (name ASC NULLS LAST)
    WITH (deduplicate_items=False)
;

--- 5.2. Automatically fill in default values
ALTER TABLE IF EXISTS manufacturing.products
    ALTER COLUMN category_id SET DEFAULT 5;
--- 5.3. Contraint acceptable input values
ALTER TABLE IF EXISTS manufacturing.categories
    ADD CONSTRAINT categories_market_check CHECK (market = 'domestic' OR market = 'industrial')
    NOT VALID;

--- 6. Database administrator in PostgreSQL
--- 6.1 User accounts and roles

-- - Roles in PostgreSQL represent user accounts and groups combined, used to control access and permissions on the database server.
-- - The superuser role has full privileges, including creating roles and managing permissions, so its access must be carefully protected.
-- - You can create custom roles with specific login capabilities, passwords, and permissions to manage user access efficiently, including grouping users under umbrella roles for easier permission management.
-- -This knowledge is essential for securing your database and managing who can do what within your PostgreSQL environment.

CREATE ROLE hr_manager WITH
	NOLOGIN
	NOSUPERUSER
	NOCREATEDB
	NOCREATEROLE
	INHERIT
	NOREPLICATION
	NOBYPASSRLS
	CONNECTION LIMIT -1;


--- 6.2. Grant privileges to a role
    -- # Roles in PostgreSQL define user accounts and groups, controlling who can access or modify data at various levels like schemas and tables.
    -- # The superuser role has full access and can create or manage other roles, so its security is critical.
    -- # You can grant specific permissions (read, write, update, delete) to roles to enforce data access boundaries, ensuring users only perform authorized actions.
    -- # Switching roles lets you test and verify permissions effectively.
    -- # Removing roles and revoking permissions helps maintain security by cleaning up unused or unnecessary access.
    -- This approach helps protect your database by giving users just the right level of access they need for their responsibilities.

-- View tables from the KinetEco database
SELECT * FROM manufacturing.products;
SELECT * FROM hr.employees;

-- Impersonate the hr_manager
SET ROLE hr_manager;

-- Switch permissions back to posgres super user
RESET ROLE;

-- Give hr_manager permissions in database
GRANT USAGE ON SCHEMA hr TO hr_manager;
GRANT SELECT ON ALL TABLES IN SCHEMA hr TO hr_manager;
GRANT ALL ON ALL TABLES IN SCHEMA hr TO hr_manager;

-- Remove the hr_manager role from Postgres Server
RESET ROLE;
REVOKE ALL ON ALL TABLES IN SCHEMA hr FROM hr_manager;
REVOKE USAGE ON SCHEMA hr FROM hr_manager;
DROP ROLE hr_manager;


--- 6.4. Start and stop the server
    -- # The pgAdmin interface is just a client; the PostgreSQL server runs independently and needs to stay running for users to connect.
    -- # You can manage the server's running state using different methods depending on your setup: Docker dashboard for containers, 
        -- Windows Services app for local Windows installs, or the pg_ctl command line utility on Windows and Mac.
    -- # To use pg_ctl, you need to know the data directory location, which you can find by running the "show data_directory" command in pgAdmin's query tool.
    -- # Properly starting and stopping the server ensures your database remains available and prevents connection issues.
    -- This knowledge helps you maintain control over your PostgreSQL server's availability and stability in your environment.

-- # find data directoy of PostgresSQL
show data_directory;
/Library/PostgreSQL/18/data
-- # go to bin directory
cd /Library/PostgreSQL/18/bin
ls -l
-rwxr-xr-x@ 1 root  daemon    245808 Aug 13 13:55 pg_ctl

-- # run cmd pg_ctl to stop PostgreSQL server
ps aux | grep postgres
sudo -u postgres /Library/PostgreSQL/18/bin/pg_ctl stop -D /Library/PostgreSQL/18/data 
ps aux | grep postgres

-- # start server
sudo -u postgres /Library/PostgreSQL/18/bin/pg_ctl start -D /Library/PostgreSQL/18/data

-- # check status
sudo -u postgres /Library/PostgreSQL/18/bin/pg_ctl status -D /Library/PostgreSQL/18/data
pg_ctl: server is running (PID: 7239)
/Library/PostgreSQL/18/bin/postgres "-D" "/Library/PostgreSQL/18/data"

ps aux | grep postgres

--- 6.5. Work with PSQL meta-commands
-- # Executing meta-commands
 --In addition to executing standard SQL commands, PSQL has its own set of short-code commands that can be extremely useful when managing a PostgreSQL database. The meta-commands all start with the backslash \ character. 

\?   This will display the help information and list out all available meta commands. Press the spacebar to page through the text until you reach the end and are returned to the command prompt
\l    Lists all of the databases on the same server, including templates
\dt  Lists the tables in the current database
\dv Lists all of the view objects in the current database
\di  Lists all of the indexes in the database
\dn Lists all schemas in the database and their owners