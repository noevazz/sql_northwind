-- .......:::::: Select the whole table ::::::.......
-- Syntax
SELECT * FROM table_name;

	-- Select all the columns from the customers table
	SELECT * FROM customers;
	
	-- Select all the columns from the employees table
	SELECT * FROM employees;






-- .......:::::: Select specific columns from a table ::::::.......
SELECT columna1, columna2, columnaX FROM table_name;
	-- the orders of the columns can be arbitrary

	-- Select the id, contact name and city of all customers
	SELECT customer_id, contact_name, city FROM customers;
	
	-- Select id, first name, title and hiring date of all employees
	SELECT employee_id, first_name, title, hire_date FROM employees;






-- .......:::::: Use an alias for each column ::::::.......
	-- Dependiendo el gestor de bd se debe usar comillas dobles o comillas simples
SELECT columna1 as nombre, columna2 as "Nombre con espacios" FROM table_name;
	-- En este caso los alias con espacios  deben estar entre COMILLAS DOBLES
	-- comillas simples son usadas para definir strings (los aliases usan comillas dobles porque definen aliases, lol)

	-- Usar alias para seleccionar el id, nombre de contacto y ciudad de todos los clientes:
	SELECT customer_id as identificador, contact_name as "nombre del cliente", city as "ciudad" FROM customers;

-- Seleccionar columas con registros que no esten duplicados
SELECT DISTINCT columa1, columaX FROM table_name;
	-- Seleccionar las ciudades (sin repetir) de la tabla clientes:
	SELECT DISTINCT city FROM customers;






-- .......:::::: Use an alias for each column ::::::.......
-- When using an alias for a table always remember to use the dot notation to select the desired columns:
-- doted notation aliasUsed.nameOfTheColumn
	-- Use an alias for the customers table and retrieve the contact name and the title
	SELECT cus.contact_name, cus.contact_title FROM customers as cus;






-- .......:::::: Count registries  ::::::.......
-- The COUNT() function returns the number of rows that matches a specified criterio.
-- Sintax:
SELECT COUNT(column) FROM table_name;

	-- Count the number of employees
	SELECT COUNT(employee_id) FROM employees;
	
	-- Count how many diferent cities exists in the customers table
	SELECT COUNT(DISTINCT city) FROM customers;
	
	-- Count how many diferent cities exists in the customers table AND USE AN ALIAS
	SELECT COUNT(DISTINCT city) as "AMount of cities" FROM customers;






-- .......:::::: Select columns bases in a condition (WHERE) ::::::.......
SELECT columna1, columnaX FROM table_name WHERE columnaZ='un valor'
	-- Nota que se uso COMILLAS SIMPLES para difinir el string

	-- Seleccionar el nombre de contacto (con el alias "nombre del cliente") y ciudad de los clientes que son de London
	SELECT contact_name as "nombre del cliente", city FROM customers WHERE city='London'
	
	-- Contar cuantos clientes son de de London
	SELECT COUNT(customer_id) as "clientes de London" FROM customers WHERE city='London'
	
	-- Seleccionar todos los datos del cliente que tiene el id BOLID
	SELECT * FROM customers WHERE customer_id='BOLID'
	
	-- Seleccionar el nombre y precio todos los productos que cuestan mas de 30
	SELECT product_name, unit_price FROM products WHERE unit_price>30;
	-- Para usar > el tipo de columna debe de ser de algun tipo numerico
	
	-- Seleccionar el nombre y precio todos los productos que cuestan MENOS de 15
	SELECT product_name, unit_price FROM products WHERE unit_price<15;
	
	-- Seleccionar el nombre y precio todos los productos que cuestan 30 o mas
	SELECT product_name, unit_price FROM products WHERE unit_price>=30;
	-- Para usar > el tipo de columna debe de ser de algun tipo numerico
	
	-- Seleccionar el nombre y precio todos los productos que cuestan 15 o menos
	SELECT product_name, unit_price FROM products WHERE unit_price<=15;
	
	-- Seleccionar todos los clientes que no son de London
	SELECT customer_id, contact_name, city FROM customers WHERE city<>'London'
	-- En algunos gestores se debe usar != en lugar de <>
	
	-- Seleccionar todos los productos que cuesten mas de 15 y menos de 30
	SELECT product_name, unit_price FROM products WHERE unit_price BETWEEN 15 AND 30;
	-- BETWEEN x AND Y significa mayor o igual a 15 y menor o igual a 30 (osea se incluyen los dos valores)
	-- The values can be numbers, text, or dates.
	
	-- Seleccionar los clientes que son de London y Berlin
	SELECT customer_id, contact_name, city FROM customers WHERE city IN ('London', 'Berlin');
	
	-- Contar cuantos clientes son de London y Berlin
	SELECT COUNT(customer_id) FROM customers WHERE city IN ('London', 'Berlin');

	-- Select all the customers that come from the same cities as the employees:
	SELECT * FROM customers WHERE city IN (SELECT city FROM employees);
	
	-- Seleccionar los clientes de un pais que termine en n
	SELECT customer_id, contact_name, city FROM customers WHERE city LIKE '%n';
	-- % significa: la cantidad de caracteres que sean de este lado
	
	-- Seleccionar los clientes de un pais que empiece con MA
	SELECT customer_id, contact_name, city FROM customers WHERE city LIKE 'Ma%';
	
	-- Seleccionar los clientes cuyo pais tenga una h en alguna parte de la ciudad
	SELECT customer_id, contact_name, city FROM customers WHERE city LIKE '%h%';
	
	-- Seleccionar los clientes cuyo pais pais empiece con M, lugo un caracter cualquiera, luego n y luego cualquier cantidad de caracteres
	SELECT customer_id, contact_name, city FROM customers WHERE city LIKE 'M_n%';
	-- el guión bajo significa cualquier caracter (pero solo uno)
	
	-- Seleccionar todos los clientes que se llamen Mario, Marie, Mauricio o Miguel y que su cargo (contact_tile) sea Owner
	SELECT
	      contact_name, contact_title
	FROM
	      customers
	WHERE
	      (contact_name LIKE '%Mari_%' OR contact_name LIKE '%Mauricio%' OR contact_name LIKE '%Miguel%')
	      AND contact_title='Owner';
	
	-- Seleccionar los clientes que se llamen Marie o que sean Owner
	SELECT contact_name, contact_title FROM customers WHERE contact_name LIKE 'Marie%' OR contact_title='Owner';
	
	-- Seleccionar todos los clientes que no sean owners
	Select contact_name, contact_title FROM customers WHERE NOT contact_title='Owner';






-- .......:::::: Order registries (ORDER BY) ::::::.......
SELECT * FROM table_name ORDER BY columnaX ASC|DESC
	--- ASC|DESC (Ascendente|Descendente) Son valores opcionales, ascendete se usa por defecto si no se especifica nada
	-- Seleccionar el nombre de contacto (con el alias "nombre del cliente") y ciudad de los clientes que son de London
	-- y ordenar de manera descendente por la ciudad
	SELECT contact_name as "nombre del cliente", city FROM customers WHERE city='London' ORDER BY city;
	
	-- Seleccionar el cargo, pais y ciuedad de todos los clientes, ordernar la tabla resultanto por pais de manera ascendente,
	-- si un pais se repite ordernar de manera descendente por la ciudad
	SELECT contact_title, country, city FROM customers ORDER BY country, city DESC;






-- .......:::::: Insert new registries ::::::.......
INSERT INTO table_name (columna1, columna2, columnaX) VALUES (value1, value2, valueX);
-- Si se van a usar todas las columnas no hay que especificarlas:
INSERT INTO table_name VALUES (value1, value2, valueX);
	-- Insertar un registro para un cliente, se debe especificar el nombre de la compañia, id y otros valores extras
	-- esto porque el nombre de la compañia es NOT NULL (requerido) al igual que el id
	-- por cierto el ID NO tiene AUTO INCREMENT porque es un ocnjunto de caracteres 
	INSERT INTO customers (customer_id, company_name, contact_name) VALUES ('ANDRE', 'papeleria la palma', 'Andressa');
	
	-- Seleccionar toda la tabla y ver si se creo mi registro
	Select * FROM customers;





-- .......:::::: About NULL values ::::::.......
-- Un campo con valor NULL significa que ese campo no tiene valor,
-- un campo AL QUE NO se le especifico explicitamente el constraint NOT NULL
-- puede tener NULL como valor (osea puedes no insertarle valor)
-- (constraints especifican reglas a los datos de una tabla o tabla)
	-- Seleccionar los clientes a los que no se especifico region
	SELECT customer_id, contact_title, region FROM customers WHERE region IS NULL;
	
	-- Seleccionar los clientes a los QUE SI se le especifico una ciudad
	SELECT customer_id, contact_title, region FROM customers WHERE region IS NOT NULL;






-- .......:::::: Update registries (INSERT INTO) ::::::.......
UPDATE table_name SET columna1=valor1, columna2=valor2, columna1=valorX WHERE condicion;
-- Si se omite el WHERE se aplicaran los SETs a todos los registros de la tabla
	-- Averiguar cual es el ID de andressa
	SELECT customer_id, contact_name from customers where contact_name LIKE 'Andressa%';
	
	-- Actualizar el registro de Andressa y ponerle que es de London en base a la query anterior:
	UPDATE customers SET city='London' WHERE customer_id=(SELECT customer_id from customers where contact_name LIKE 'Andressa%')
	
	-- seleccionar ese registro usando su id para comprobar:
	SELECT customer_id, contact_name, city FROM customers WHERE customer_id='ANDRE';
	
	-- A todos los clientes de Mexico (country) ponerle que su ciudad es Colima
	UPDATE customers SET city='Colima' WHERE country='Mexico';

	-- Comprobar la query anterior
	SELECT * FROM customers WHERE country='Mexico';






-- .......:::::: Delete registries (DELETE FROM) ::::::.......
DELETE FROM table_name WHERE condicion;
	-- Eliminar el registro de Andressa
	DELETE FROm customers WHERE customer_id='ANDRE';

	-- Comprobar la query anterior
	SELECT * FROM customers where customer_id='ANDRE';





	
-- .......:::::: Limit the amout of registries to return ::::::.......
-- Depending of the DB management system we can use:

-- SQL Server/MS Access:
SELECT TOP number|percent column_name(s) FROM table_name WHERE condition; 

-- MySQL 
SELECT column_name(s) FROM table_name WHERE condition LIMIT number; 

-- Oracle Syntax:
SELECT column_name(s) FROM table_name WHERE ROWNUM <= number; 

-- The WHERE is optional but was used to show how we can use it in conjuntion with LIMIT

	-- Select the last 2 registries from the customers table that are from Colima (it's a city)
	SELECT * FROM customers WHERE city='Colima' ORDER BY customer_id DESC LIMIT 3;
	-- By default Limit returns the registries on the top of the specified table,
	-- that's why I used ORDER BY (to put the last items on the top)






-- .......:::::: SQL MIN() and MAX() Functions ::::::.......
-- The MIN() function returns the smallest value of the selected column.
-- SINTAX of MIN(): 
SELECT MIN(column_name) FROM table_name WHERE condition; 
	-- Select the cheapest unit price (unit_price) in the products table
	SELECT MIN(unit_price) AS SmallestPrice FROM products;
	
	-- Select the name of the cheapest product
	SELECT product_name, unit_price FROM products WHERE unit_price=(SELECT MAX(unit_price) as "Cheapest Product" FROM products)

-- The MAX() function returns the largest value of the selected column.
	-- Select the most expensive unit price (unit_price) in the products table
	SELECT MAX(unit_price) AS "MOST expensive Product" FROM products;
	
	-- Select the name of the most expensive product
	SELECT product_name, unit_price FROM products WHERE unit_price=(SELECT MAX(unit_price) as "Cheapest Product" FROM products)






-- .......:::::: SQL AVG() and SUM() Functions ::::::.......
-- The AVG() function returns the average value of a numeric column.
-- Syntax
SELECT AVG(column_name) FROM table_name WHERE condition; 
	-- Select the average price of all products
	SELECT AVG(unit_price) FROM products;

-- The SUM() function returns the total sum of a numeric column.
-- Syntax
SELECT SUM(column_name) FROM table_name WHERE condition; 
	-- Find the average price of all products that costs more than 15 (unit_price)
	SELECT SUM(unit_price) FROM products WHERE unit_price>15;