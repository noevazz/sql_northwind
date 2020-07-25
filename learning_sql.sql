-- Hi welcome to this big file where you can find tons of SQL queries that
-- you can use to consult the well known northwild database.
-- The queries are organized from simple to complex.

-- Send me an email if you see something to improve: jonovagu@gmail.com




-- .......:::::: Select the whole table (all columns) ::::::.......
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






-- .......:::::: Use an alias for a table ::::::.......
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
-- Syntax:
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

-- The WHERE is optional but it was used to show how we can use it in conjuntion with LIMIT

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
	SELECT SUM(unit_price) FROM products WHERE unit_price>15;;






-- .......:::::: SQL joins ::::::.......
-- INNER JOIN
-- Returns records that have matching values in both tables, INTERSECTION
-- Syntax:
SELECT column_name(s) FROM table1 INNER JOIN table2 ON table1.column_name = table2.column_name;
	--  Select all orders with customer information
	SELECT orders.order_id, customers.customer_id, orders.ship_name
	FROM orders INNER JOIN customers ON customers.customer_id=orders.customer_id;

	--  Select all orders with customer information and also retrieve product details,
	SELECT orders.order_id, customers.customer_id, orders.ship_name, order_details.product_id
	FROM orders INNER JOIN customers ON customers.customer_id=orders.customer_id
	INNER JOIN order_details ON orders.order_id=order_details.order_id;

	--  Select all orders with customer information and also retrieve product details, AND also be specific with the product
	SELECT orders.order_id, customers.customer_id, orders.ship_name, order_details.product_id, products.product_name
	FROM orders INNER JOIN customers ON customers.customer_id=orders.customer_id
	INNER JOIN order_details ON orders.order_id=order_details.order_id
	INNER JOIN products ON products.product_id=order_details.product_id;

-- LEFT JOIN
-- Basically: A-B difference + Intersection, in other words conjuntion A + INNNER JOIN
SELECT column_name(s) FROM table1 LEFT JOIN table2 ON table1.column_name = table2.column_name;
-- See a graphival representation: https://www.w3schools.com/sql/img_leftjoin.gif
	-- Select all the customers either they have an order or not, expected result: customer name, order id
	-- also order the resulting table by the id of the order (desc)
	SELECT customers.contact_name, orders.order_id FROM customers LEFT JOIN orders ON orders.customer_id=customers.customer_id
	ORDER BY orders.order_id DESC;

-- Right Join
-- Basically: B-A + intersection
SELECT column_name(s) FROM table1 RIGHT JOIN table2 ON table1.column_name = table2.column_name;
-- See a graphical representation: https://www.w3schools.com/sql/img_rightjoin.gif
	-- Select all orders and information about the customer
	SELECT orders.order_id, customers.contact_name, orders.order_date, customers.phone
	FROM orders
	RIGHT JOIN customers ON orders.customer_id=customers.customer_id;

-- FULL OUTER JOIN
-- Returns all records when there is a match in left (table1) or right (table2) table records
SELECT column_name(s) FROM table1 FULL OUTER JOIN table2 ON table1.column_name = table2.column_name WHERE condition; 
-- See a graphical representation: https://www.w3schools.com/sql/img_fulljoin.gif
	-- Select all orders and all customers
	SELECT orders.order_id, customers.contact_name, orders.order_date, customers.phone
	FROM orders
	FULL OUTER JOIN customers ON orders.customer_id=customers.customer_id ORDER BY customers.contact_name;

-- self join
-- A self JOIN is a regular join, but the table is joined with itself.
SELECT column_name(s) FROM table1 T1, table1 T2 WHERE condition;
	-- Select customers that are from the same city:
		SELECT T1.contact_name AS "CustomerName1", T2.contact_name AS "CustomerName2", T1.city
	FROM customers T1, customers T2
	WHERE T1.customer_id <> T2.customer_id
	AND T1.city = T2.city
	ORDER BY T1.city;






-- .......:::::: UNION ::::::.......
-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- Each SELECT statement within UNION must have the same number of columns
-- The columns must also have similar data types
-- The columns in each SELECT statement must also be in the same order
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2; 

-- UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL:
SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;
	
	--  Return the cities (only distinct values) from both the "customers" and the "employees" table:
	SELECT city FROM customers UNION SELECT city FROM employees ORDER BY city LIMIT 6;

	-- Allow duplicate values:
	SELECT city FROM customers UNION ALL SELECT city FROM employees ORDER BY city LIMIT 6;

	-- Return the German cities (only distinct values) from both the "customers" and the "employees" table:
	SELECT city, country FROM customers WHERE country='Germany'
	UNION
	SELECT city, Country FROM employees WHERE country='Germany' ORDER BY city;

	-- List al de employees and all the customers
	SELECT 'Customer' AS Type, city FROM customers
	UNION
	SELECT 'Employee', city FROM employees;






-- .......:::::: GROUP BY ::::::.......
-- Groups rows that have the same values into summary rows
-- It is often used with aggregate functions (COUNT, MAX, MIN, SUM, AVG) to group the result-set by one or more columns
SELECT column_name(s) FROM table_name
WHERE condition
GROUP BY column_name(s) ORDER BY column_name(s);

	-- Select the amount of customers for each city:
		SELECT COUNT(city), city
	FROM customers
	GROUP BY city ORDER By city;

	-- Select the amount of customer of these cities: Colima, London88
	SELECT COUNT(city), city
	FROM customers
	WHERE city='Colima' or city='London'
	GROUP BY city ORDER By city;

	-- Select the amount of orders that each customer have
	SELECT COUNT(orders.customer_id), customers.customer_id, customers.contact_name
	FROM orders
	LEFT JOIN customers on customers.customer_id=orders.customer_id
	GROUP BY customers.contact_name, customers.customer_id
	ORDER BY customers.contact_name;

	-- Select the amout of orders taht a specific user has
	SELECT COUNT(orders.customer_id), customers.customer_id, customers.contact_name
	FROM orders
	LEFT JOIN customers on customers.customer_id=orders.customer_id
	WHERE customers.customer_id='LAMAI'
	GROUP BY customers.contact_name, customers.customer_id
	ORDER BY customers.contact_name;







-- .......:::::: Having ::::::.......
-- The HAVING clause was added to SQL because the WHERE keyword could not be used with aggregate functions.
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);

	-- Select the amount of customers for each city with more that 2 customers:
		SELECT COUNT(city), city
	FROM customers
	GROUP BY city
	HAVING COUNT(city)>2;

	-- Select the amount of orders that each customer have, having a customer with more than 10 orders
	SELECT COUNT(orders.customer_id), customers.customer_id, customers.contact_name
	FROM orders
	LEFT JOIN customers on customers.customer_id=orders.customer_id
	GROUP BY customers.contact_name, customers.customer_id
	HAVING COUNT(orders.customer_id)>10
	ORDER BY customers.contact_name;
	-- orderning by the count:
	SELECT COUNT(orders.customer_id) AS "Amount of orders", customers.customer_id, customers.contact_name
	FROM orders
	LEFT JOIN customers on customers.customer_id=orders.customer_id
	GROUP BY customers.contact_name, customers.customer_id
	HAVING COUNT(orders.customer_id)>10
	ORDER BY "Amount of orders";
