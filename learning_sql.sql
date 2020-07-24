-- Seleccionar todas las columnas de una tabla
SELECT * FROM nombre_de_la_tabla;

	-- Seleccionar toda las columnas (osea la tabla) de clientes
	SELECT * FROM customers;
	
	-- Seleccionar toda las columnas (osea la tabla) de empleados
	SELECT * FROM employees;





-- Seleccionar columnas de una tabla:
SELECT columna1, columna2, columnaX FROM nombre_de_la_tabla;
	-- cuando se seleccionan columnas podemos acomodarlas en el orden que queramos

	-- Seleccionar el id, nombre de contacto y ciudad de todos los clientes:
	SELECT customer_id, contact_name, city FROM customers;
	
	-- Seleccionar id, primer nombre, titulo (cargo) y decha de contratación los empleados
	SELECT employee_id, first_name, title, hire_date FROM employees;

-- Usar alias para las columnas
	-- Dependiendo el gestor de bd se debe usar comillas dobles o comillas simples
SELECT columna1 as nombre, columna2 as "Nombre con espacios" FROM nombre_de_la_tabla;
	-- En este caso los alias con espacios  deben estar entre COMILLAS DOBLES
	-- comillas simples son usadas para definir strings (los aliases usan comillas dobles porque definen aliases, lol)

	-- Usar alias para seleccionar el id, nombre de contacto y ciudad de todos los clientes:
	SELECT customer_id as identificador, contact_name as "nombre del cliente", city as "ciudad" FROM customers;

-- Seleccionar columas con registros que no esten duplicados
SELECT DISTINCT columa1, columaX FROM nombre_de_la_tabla;
	-- Seleccionar las ciudades (sin repetir) de la tabla clientes:
	SELECT DISTINCT city FROM customers;

-- Contar registros
SELECT COUNT(columna) FROM nombre_de_la_tabla;
	-- Contar cuantos empleados hay
	SELECT COUNT(employee_id) FROM employees;
	
	-- Contar cuantas ciudades diferentes hay en la tabla clientes
	SELECT COUNT(DISTINCT city) FROM customers;
	
	-- Contar cuantas ciudades diferentes hay en la tabla clientes Y USAR UN ALIAS
	SELECT COUNT(DISTINCT city) as "numero de ciudaddes" FROM customers;
		
-- Seleccionar en base a algo
SELECT columna1, columnaX FROM nombre_de_la_tabla WHERE columnaZ='un valor'
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
	
	-- Seleccionar los clientes que son de London y Berlin
	SELECT customer_id, contact_name, city FROM customers WHERE city IN ('London', 'Berlin');
	
	-- Contar cuantos clientes son de London y Berlin
	SELECT COUNT(customer_id) FROM customers WHERE city IN ('London', 'Berlin');
	
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





-- Ordernar registros de las columnas
SELECT * FROM nombre_de_la_tabla ORDER BY columnaX ASC|DESC
	--- ASC|DESC (Ascendente|Descendente) Son valores opcionales, ascendete se usa por defecto si no se especifica nada
	-- Seleccionar el nombre de contacto (con el alias "nombre del cliente") y ciudad de los clientes que son de London
	-- y ordenar de manera descendente por la ciudad
	SELECT contact_name as "nombre del cliente", city FROM customers WHERE city='London' ORDER BY city;
	
	-- Seleccionar el cargo, pais y ciuedad de todos los clientes, ordernar la tabla resultanto por pais de manera ascendente,
	-- si un pais se repite ordernar de manera descendente por la ciudad
	SELECT contact_title, country, city FROM customers ORDER BY country, city DESC;





-- Insertar registros nuevos
INSERT INTO nombre_de_la_tabla (columna1, columna2, columnaX) VALUES (value1, value2, valueX);
-- Si se van a usar todas las columnas no hay que especificarlas:
INSERT INTO nombre_de_la_tabla VALUES (value1, value2, valueX);
	-- Insertar un registro para un cliente, se debe especificar el nombre de la compañia, id y otros valores extras
	-- esto porque el nombre de la compañia es NOT NULL (requerido) al igual que el id
	-- por cierto el ID NO tiene AUTO INCREMENT porque es un ocnjunto de caracteres 
	INSERT INTO customers (customer_id, company_name, contact_name) VALUES ('ANDRE', 'papeleria la palma', 'Andressa');
	
	-- Seleccionar toda la tabla y ver si se creo mi registro
	Select * FROM customers;





-- NULL values
-- Un campo con valor NULL significa que ese campo no tiene valor,
-- un campo AL QUE NO se le especifico explicitamente el constraint NOT NULL
-- puede tener NULL como valor (osea puedes no insertarle valor)
-- (constraints especifican reglas a los datos de una tabla o tabla)
	-- Seleccionar los clientes a los que no se especifico region
	SELECT customer_id, contact_title, region FROM customers WHERE region IS NULL;
	
	-- Seleccionar los clientes a los QUE SI se le especifico una ciudad
	SELECT customer_id, contact_title, region FROM customers WHERE region IS NOT NULL;





-- Actualizar registros
UPDATE nombre_de_la_tabla SET columna1=valor1, columna2=valor2, columna1=valorX WHERE condicion;
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





-- Eliminar registros
DELETE FROM nombre_de_la_tabla WHERE condicion;
	-- Eliminar el registro de Andressa
	DELETE FROm customers WHERE customer_id='ANDRE';

	-- Comprobar la query anterior
	SELECT * FROM customers where customer_id='ANDRE';




	
-- Especificar la cantidad de registros a regresar
-- Dependiendo el sistema de bd se puede usar:

-- SQL Server/MS Access:
SELECT TOP number|percent column_name(s) FROM table_name WHERE condition; 

-- MySQL 
SELECT column_name(s) FROM table_name WHERE condition LIMIT number; 

-- Oracle Syntax:
SELECT column_name(s) FROM table_name WHERE ROWNUM <= number; 

-- La condicion es opcional solo se uso para mostrar como se pondria

