/* PART A */
/* 1A - Creating Databases */

CREATE DATABASE Cus_Orders;
 

USE Cus_Orders;


/* 2A - Creating Data Types */

CREATE  TYPE prim_id FROM char(5) NOT NULL;
 

CREATE TYPE other_id FROM int NOT NULL;
 

CREATE TYPE tit_id FROM char(3) NOT NULL;
 

/* 3A - Creating tables */

CREATE TABLE customers
(
	customer_id prim_id,
	name	varchar(50) NOT NULL,
	contact_name	varchar(30),
	title_id tit_id,
	address	varchar(50),
	city	varchar(20),
	region	varchar(15),
	country_code	varchar(10),
	country varchar(15),
	phone	varchar(20),
	fax	varchar(20)
);
 

CREATE TABLE orders
(
	order_id	other_id,
	customer_id	prim_id,
	employee_id other_id,
	shipping_name varchar(50),
	shipping_address varchar(50),
	shipping_citt	varchar(20),
	shipping_region	varchar(15),
	shipping_country_code	varchar(10),
	shipping_country varchar(15),
	shipper_id	int NOT NULL,
	order_date datetime,
	required_date datetime,
	shipped_date datetime,
	freight_charge money,
);
 

CREATE TABLE order_details
(
	order_id	other_id,
	product_id other_id,
	quantity int NOT NULL,
	discount float NOT NULL
);
  

CREATE TABLE products
(
	product_id	other_id,
	supplier_id	other_id,
	name	varchar(50) NOT NULL,
	alternate_name	varchar(40),
	quantity_per_unit	varchar(40),
	unit_price	decimal(19,4),
	quantity_in_stock	int,
	units_on_order	int,
	reoder_level	int

);
  

CREATE TABLE shippers
(
	shipper_id 	other_id,
	name varchar(20) NOT NULL
	);
 
	
CREATE TABLE suppliers
(
	supplier_id	other_id,
    name	varchar(40) NOT NULL,
    address varchar(30),
	city varchar(20),
    province	varchar(2)
 );
 

CREATE TABLE titles
(
	title_id	tit_id,
    description varchar(35) NOT NULL
);
 

/* 4A -  Set Primary keys */

ALTER TABLE customers
	ADD PRIMARY KEY (customer_id);
 

ALTER TABLE order_details
	ADD PRIMARY KEY (order_id,product_id);
 
    
ALTER TABLE orders
	ADD PRIMARY KEY (order_id);
 

ALTER TABLE products
	ADD PRIMARY KEY (product_id);
 

ALTER TABLE shippers
	ADD PRIMARY KEY (shipper_id);
 

ALTER TABLE suppliers
	ADD PRIMARY KEY (supplier_id);
 

ALTER TABLE titles
		ADD PRIMARY KEY (title_id_id);
 

-- Foreign KEY 

ALTER TABLE customers
	ADD CONSTRAINT fk_customers_titles
	FOREIGN KEY(title_id)
	REFERENCES titles
	(title_id);
 

ALTER TABLE orders
	ADD CONSTRAINT fk_orders_customers
	FOREIGN KEY(customer_id)
	REFERENCES customers
	(customer_id);
 
	
ALTER TABLE orders
	ADD CONSTRAINT fk_orders_shippers
	FOREIGN KEY(shipper_id)
	(shipper_id);	
 
	
ALTER TABLE order_details
	ADD CONSTRAINT fk_order_details_products
	FOREIGN KEY(product_id)
	REFERENCES products
	(product_id);
 
	
ALTER TABLE products
	ADD CONSTRAINT fk_products_suppliers
	FOREIGN KEY(supplier_id)
	REFERENCES suppliers
	(supplier_id);
 
	
/* 5A - Adding constraints - Country to CANADA */

SELECT *
FROM customers;

ALTER TABLE customers
	ADD CONSTRAINT default_country
		DEFAULT ('Canada') FOR country;

SELECT *
FROM orders;

ALTER TABLE orders
	ADD CONSTRAINT default_required_date
		DEFAULT(GETDATE()+10) 
		FOR required_date;
 

ALTER TABLE order_details
	ADD CONSTRAINT default_quantity
		CHECK ( quantity >= 1);
 

SELECT *
FROM products;
 

ALTER TABLE products
	ADD CONSTRAINT default_reorder_level
		CHECK (reorder_level >= 1);
 

ALTER TABLE products
	DROP COLUMN reoder_level;
 

SELECT *
FROM products;
 

ALTER TABLE products
	ADD reorder_level int;
 

SELECT *
FROM products;
 

ALTER TABLE products
	ADD CONSTRAINT default_reorder_level
		CHECK (reorder_level >= 1);
 

SELECT *
FROM products;
 

ALTER TABLE products
	ADD CONSTRAINT default_quantity_in_stock
		CHECK (quantity_in_stock <= 150);
 

SELECT *
FROM suppliers
 

ALTER TABLE suppliers
	ADD CONSTRAINT default_suppliers
		DEFAULT ('BC') FOR province;
 

/* 6 - Bulk Inserctions on tables */

BULK INSERT titles 
FROM 'D:\Work\Downloads\TextFiles\titles.txt' 
WITH (
               CODEPAGE=1252,                  
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	 );
 

SELECT *
FROM titles;
 

BULK INSERT suppliers 
FROM 'D:\Work\Downloads\TextFiles\suppliers.txt' 
WITH (  
               CODEPAGE=1252,               
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM suppliers;

BULK INSERT shippers 
FROM 'D:\Work\Downloads\TextFiles\shippers.txt' 
WITH (
               CODEPAGE=1252,            
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM shippers;

BULK INSERT customers 
FROM 'D:\Work\Downloads\TextFiles\customers.txt' 
WITH (
               CODEPAGE=1252,            
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM customers

BULK INSERT products 
FROM 'D:\Work\Downloads\TextFiles\products.txt' 
WITH (
               CODEPAGE=1252,             
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM products
 

BULK INSERT order_details 
FROM 'D:\Work\Downloads\TextFiles\order_details.txt'  
WITH (
               CODEPAGE=1252,              
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM order_details;
 

BULK INSERT orders 
FROM 'D:\Work\Downloads\TextFiles\orders.txt'  
WITH (
               CODEPAGE=1252,              
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	  );
 

SELECT *
FROM orders
 

/* 1B - List customer id, name, city, and country from the customer table, Order by Customer_id */

SELECT *
FROM customers

SELECT	customer_id,
		name,
		city,
		country
FROM customers
ORDER BY customer_id;
 

/* 2B- Create new column called active , values 0/1, Default=1 */

ALTER TABLE customers
	ADD active bit;
 

/* Creating default value */

SELECT *
FROM customers;

ALTER TABLE customers
	ADD CONSTRAINT default_active
		DEFAULT (1) FOR active;
 

SELECT *
FROM customers;
 
UPDATE customers
SET active='1';
 

SELECT *
FROM customers;

/* 3B - List all orders with dates (order) between January 1 and December 31, Display order_id, order date, NEW shipped_date with plus 7 days from the
shipped date from orders table. Product name from products table, customer name from customer table and order_cost (quantity * unit_price). Shipped date
 format as MON DD YYYY. */
 
 SELECT *
 FROM orders;

SELECT  orders.order_id, 
		'product_name'= products.name,
		'customer_name'= customers.name,
		'order_date'= CONVERT(char(11),order_date),
		'new_shipped_date'=CONVERT(char(11),DATEADD(DAY,7,shipped_date)),
		'order_cost'=CAST((order_details.quantity*products.unit_price) as decimal(10,4))
FROM orders
INNER JOIN order_details ON orders.order_id=order_details.order_id
INNER JOIN products ON order_details.product_id=products.product_id
INNER JOIN customers ON orders.customer_id=customers.customer_id
WHERE orders.order_date BETWEEN 'Jan 1 2001' AND 'Dec 31 2001';

/* 4B - List all orders --not been shipped-- Display the customer id, name and phone number from the CUSTOMER TABLE,
and the order id and order date from the orders table. - Order by customer name. */

SELECT *
FROM customers

SELECT *
FROM order_details

SELECT	'customer_id'=customers.customer_id,
		'name'=customers.name,
		'phone'=customers.phone,
		'order_id'=orders.order_id,
		'order_date'=orders.order_date
FROM customers
INNER JOIN orders ON customers.customer_id=orders.customer_id
WHERE orders.shipped_date IS NULL
ORDER BY customers.name;

/* 5B - List all customers with REGION = NULL -- Display the customer id, name, and city from the CUSTOMERS TABLE,
 and the title description from the TITLES TABLE. */ 

SELECT	'customer_id'=customers.customer_id,
		'name'=customers.name,
		'city'=customers.city,
		'description'=titles.description
FROM titles
RIGHT JOIN customers ON titles.title_id=customers.title_id
WHERE customers.region IS NULL
ORDER BY customers.name;

SELECT *
FROM customers
WHERE region IS NULL
ORDER BY name;

SELECT	'customer_id'=customers.customer_id,
		'name'=customers.name,
		'city'=customers.city,
		'description'=titles.description
FROM customers
RIGHT JOIN titles ON customers.title_id=titles.title_id
WHERE customers.region IS NULL
ORDER BY customers.name;

SELECT	'customer_id'=customers.customer_id,
		'name'=customers.name,
		'city'=customers.city,
		'description'=titles.description
FROM customers
INNER JOIN titles ON customers.title_id=titles.title_id
WHERE customers.region IS NULL
ORDER BY customers.name;

/*TRY TO FIX DUPLICATE ERROR */

SELECT	'customer_id'=customers.customer_id,
		'name'=customers.name,
		'city'=customers.city,
		'description'=titles.description
FROM customers
INNER JOIN titles ON customers.title_id=titles.title_id
WHERE customers.region IS NULL
GROUP BY name;


/* Duplicate files. Documentation (chalenges) on that */

/* 6B - List PRODUCTS with REORDER_LEVEL is higher than the quantity in stock- Display SUPPLIER name from the SUPPLIERS
 NAME and the PRODUCT NAME, REORDER LEVEL, and QUANTITY IN STOCK from the products table - Order by supplier name */

SELECT *
FROM products;

SELECT *
FROM suppliers;

SELECT	suppliers.name,
		products.name,
		products.reorder_level,
		products.quantity_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id=suppliers.supplier_id
WHERE (products.reorder_level > products.quantity_in_stock)
ORDER BY suppliers.name; 

/* 7B - Calculate the length in years from January 1, 2008 and when an order was shipped where the shipped date is not null -
Display the ORDER_ID, and the SHIPPED_DATE from the ORDERS table, the customer NAME, and the CONTACT NAME from the 
CUSTOMERS table, and the length in years for each order -- Display the shipped date in the format MMM DD YYYY.  
Order the result set by order id AND the calculated years. */

SELECT *
FROM orders;

SELECT *
FROM customers;

SELECT  orders.order_id,
		customers.name,
		customers.contact_name,
		CONVERT(char(11),order_date),
		'elapsed'= CONVERT(char(11),DATEDIFF(YEAR, orders.shipped_date, 'Jan 1 2008'))
FROM orders
INNER JOIN customers ON orders.customer_id=customers.customer_id
WHERE orders.shipped_date IS NOT NULL
ORDER BY orders.order_id, elapsed;

/* 8B - List number of customers with names beginning with each letter of the alphabet.
Ignore customers whose name begins with the letter S. 
Do not display the letter and count unless at least two customer’s names begin with the letter */

SELECT *
FROM customers

SELECT temptable.*
FROM (
	SELECT 
	SUBSTRING(name,1,1) AS name,
	COUNT(name) AS total
	FROM customers
	WHERE name LIKE '[A-R]%'
	   OR name LIKE '[T-Z]%'
	GROUP BY SUBSTRING(name,1,1)
) temptable
WHERE total > 1;

/* 9B - List the order details where the quantity is greater than 100.  Display the order id
 and quantity from the order_details table, the product id and reorder level from the products
  table, and the supplier id from the suppliers table.  Order the result set by the order id. */

SELECT *
FROM order_details

SELECT
	order_details.order_id,
	order_details.quantity,
	products.product_id,
	products.reorder_level,
	suppliers.supplier_id
FROM order_details
INNER JOIN 	products ON order_details.product_id=products.product_id
INNER JOIN suppliers ON products.supplier_id=suppliers.supplier_id
WHERE order_details.quantity >100
ORDER BY order_details.order_id;

/*10B List the products which contain tofu or chef in their name 
-Display the product id, product name, quantity per unit and unit price from the products table.
Order the result set by product name.  */


SELECT *
FROM products
WHERE name LIKE 'tofu%'
	OR name LIKE 'chef%'
	OR name LIKE '%tofu'
ORDER BY name;

/* Part C ---- Create Table and Define Primary Key */

CREATE TABLE employee
(	employee_id	other_id PRIMARY KEY,
	last_name	varchar(30) NOT NULL,
	first_name	varchar(15) NOT NULL,
	address	varchar(30),
	city	varchar(20),
	province	char(2),
	postal_code	varchar(7),
	phone	varchar(10),
	birth_date datetime NOT NULL
)

/* 3C - Load data and create relaontionship with orders table. */

BULK INSERT employee 
FROM 'D:\Work\Downloads\TextFiles\employee.txt' 
WITH (         CODEPAGE=1252,            
		DATAFILETYPE = 'char',
		FIELDTERMINATOR = '\t',
		KEEPNULLS,
		ROWTERMINATOR = '\n'	            
	 );

ALTER TABLE orders
	ADD CONSTRAINT fk_orders_employee
	FOREIGN KEY(employee_id)
	REFERENCES employee
	(employee_id);

/* 4C - Insert new shipper "Quick Express" to the shippers table */

SELECT*
FROM shippers

INSERT INTO shippers
VALUES(4,'Quick Express');

SELECT*
FROM shippers

/* 5C - Increase UNIT_PRICE value by 5% on PRODUCTS table where price is between 5 and 10 dollars */ 

SELECT *
FROM products

UPDATE products
SET unit_price=unit_price*1.05
WHERE unit_price >= 5 
		AND unit_price <=10;
		
/* 6C - UPDATE FAX value to "Unknown" for all rows in the customers table where the current fax value is NULL */

SELECT *
FROM customers

UPDATE customers
SET fax='Unknown'
WHERE fax IS NULL;



/* 7C - Create a view call vw_order_cost to list the cost of the orders 
-Display the order id and order_date from the orders table,
 Product id from the products table -customer name from the customers table.
 And the order cost.  */

 SELECT*
 FROM order_details


CREATE VIEW vw_order_cost
AS
SELECT	orders.order_id,
		orders.order_date,
		products.product_id,
		customers.name,
		'order cost'=(order_details.quantity * products.unit_price)
FROM orders
INNER JOIN order_details ON orders.order_id=order_details.order_id
INNER JOIN products ON order_details.product_id=products.product_id
INNER JOIN customers ON orders.customer_id=customers.customer_id;

SELECT*
FROM vw_order_cost
WHERE	order_id >= 10000
		AND order_id <=10200;

/* 8C Create view called vw_list_employees to list all the employees and all the columns in the employee table.
Run the view for employee ids 5, 7, and 9.
Display the employee id, last name, first name, and birth date.  
Format the name as last name followed by a comma and a space followed by the first name.  
Format the birth date as YYYY.MM.DD. */

CREATE VIEW vw_list_employees
AS 
SELECT *
FROM employee;

/* Using code to display the asked date style 102=YYYY.MM.DD */

SELECT 
	vw_list_employees.employee_id,
	'name'= (vw_list_employees.last_name+ ', ' +vw_list_employees.first_name),
	CONVERT (varchar(10),vw_list_employees.birth_date, 102)
FROM vw_list_employees
WHERE vw_list_employees.employee_id=5
		OR vw_list_employees.employee_id=7
			OR vw_list_employees.employee_id=9;


/* 9C Create view called vw_all_orders listing all orders.
Display ORDER_ID and SHIPPED_DATE from orders table.
CUSTOMER_id, NAME, CITY and COUNTRY from customers table.
Run view for orders shipped from Jan 1 2002 and December 31, 2002. formatting the date as MON DD YYYY.
Order by customer name and country. */


CREATE VIEW vw_all_orders
(order_id,customer_id,customer_name,city,country,shipped_date)
AS
SELECT	orders.order_id,
		customers.customer_id,
        customers.name,
		customers.city,
		customers.country,
		orders.shipped_date
FROM orders
INNER JOIN customers ON orders.customer_id=customers.customer_id;

SELECT 
	order_id,
	customer_id,
    customer_name,
	city,
	country,
	CONVERT(char(11),shipped_date,100) AS shipped_date
FROM vw_all_orders
WHERE shipped_date BETWEEN'Jan 1 2002'
		AND'Dec 31 2002'
ORDER BY vw_all_orders.customer_name,vw_all_orders.country;


//* 10C  - Create a view with the suppliers and the itens they have shipped
Run the view. */

CREATE VIEW suppliers_products
(supplier_id, supplier_name, product_id,product_name)
AS
SELECT suppliers.supplier_id,
	   suppliers.name,
	   products.product_id,
	   products.name
FROM suppliers
INNER JOIN products ON suppliers.supplier_id=products.supplier_id;

SELECT *
FROM suppliers_products




/* --- Part D ---  */


/* 1D - Create a stored procedure called sp_customer_city displaying the customers living in a particular city.
The city will be an input parameter for the stored procedure.  Display the customer id, name, address, city 
and phone from the customers table.  Run the stored procedure displaying customers living in London.*/

CREATE PROCEDURE sp_customer_city
(
	@cityinput varchar(20)
)
AS 
SELECT customer_id, 
		name,
		address,
		city,
		phone
FROM customers
WHERE city= @cityinput;
                                                                                                                    
EXECUTE sp_customer_city 'London';


/* 2D - Create a stored procedure called sp_orders_by_dates -- Displaying the orders shipped between particular dates. 
 The start and end date will be input parameters for the stored procedure.  Display the order id, customer id,
 and shipped date from the orders table, the customer name from the customer table, and the shipper name from 
 the shippers table.  Run the stored procedure displaying orders from January 1, 2003 to June 30, 2003. */

 SELECT *
 FROM orders

  CREATE PROCEDURE sp_orders_by_dates
(
	@startdate datetime,
	@enddate datetime
)
AS 
SELECT	orders.order_id,  
		customers.customer_id,
		customers.name,
		shippers.name,
		orders.shipped_date
FROM orders
INNER JOIN customers ON orders.customer_id=customers.customer_id
INNER JOIN shippers ON orders.shipper_id=shippers.shipper_id
WHERE orders.order_date >= @startdate
	AND orders.order_date <= @enddate;
                                                                                                                    
EXECUTE sp_orders_by_dates 'January 1 2003','January 30 2003'

/* 3D - Create a procedure call sp_product_listing listing a specified product ordered during a specified month and year.  
The product and the month and year will be input parameters for the stored procedure. 
Display the product name, unit price, and quantity in stock from the products table, and the supplier name from the suppliers table. 
Run the stored procedure displaying a product name containing Jack and the month of the order date is June and the year is 2001. */

CREATE PROCEDURE sp_product_listing
(
	@product varchar(40),
	@month varchar(10),
	@year char(4)
)
AS 
SELECT	products.name,  
		products.unit_price,
		products.quantity_in_stock,
		suppliers.name
FROM products
INNER JOIN suppliers ON products.supplier_id=suppliers.supplier_id
INNER JOIN order_details ON products.product_id=order_details.product_id
INNER JOIN orders ON order_details.order_id=orders.order_id
WHERE	products.name LIKE '%'+@product+'%' AND
		DATENAME(MONTH, orders.order_date) = @month 
		AND DATENAME(YEAR, orders.order_date) = @year;


EXECUTE sp_product_listing 'Jack' , 'June' , '2001';


/* 4D Create a DELETE trigger on the order_details table to display the information shown below when you issue the following statement: */

CREATE TRIGGER order_details_deletion
ON order_details
FOR DELETE
AS
DECLARE @vorder_id int, 
		@vproduct_id int, 
		@quantity_in_order int, 
		@previous_quantity_in_stock int
SELECT @vproduct_id=product_id, 
	@vorder_id=order_id, 
	@quantity_in_order=quantity 
FROM deleted
SELECT @previous_quantity_in_stock=quantity_in_stock from products WHERE product_id=@vproduct_id;

UPDATE products
SET quantity_in_stock = quantity_in_stock + @quantity_in_order
WHERE product_id=@vproduct_id;

SELECT 	'Product ID' = product_id,
		'Product Name'= name, 
		'Quantity being deleted from Order'= @quantity_in_order,
		'In stock Quantity after Deletion'=quantity_in_stock
FROM products
WHERE product_id = @vproduct_id

DELETE order_details
WHERE order_id=10001 AND product_id=25;


/* 5D  - Create an INSERT and UPDATE trigger called tr_check_qty on the order_details table to only allow orders of products that have 
a quantity in stock greater than or equal to the units ordered.  Run the following query to verify your trigger */

CREATE TRIGGER tr_check_qty
ON order_details
FOR INSERT,UPDATE
AS
DECLARE @quantity_order int, 
		@product_order int 
SELECT	@quantity_order=quantity, 
		@product_order=product_id 
FROM inserted
	IF	( SELECT quantity_in_stock 
		FROM products 
		WHERE product_id=@product_order) < @quantity_order

BEGIN
	ROLLBACK TRANSACTION
	PRINT 'Not Enough Quantity in Stock'
END

UPDATE order_details
SET quantity = 30
WHERE order_id = '10044'
     AND product_id = 7

/* 6D - Create a stored procedure called sp_del_inactive_cust to delete customers that have no orders
--> The stored procedure should delete 1 row. */

CREATE PROCEDURE sp_del_inactive_cust
AS
DELETE	customers
FROM customers
LEFT OUTER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.customer_id IS NULL;


EXECUTE sp_del_inactive_cust;

/* 7D - Create a stored procedure called sp_employee_information 
Display the employee information for a particular employee.  
The employee id will be an input parameter for the stored procedure.  
Run the stored procedure displaying information for employee id of 5 */

CREATE PROCEDURE sp_employee_information
(
	@v_employee_id int
)
AS 
SELECT	*
FROM employee
WHERE	employee_id=@v_employee_id;

EXECUTE sp_employee_information '5';

/* 8D - Create a stored procedure called sp_reorder_qty to show when the reorder level subtracted from the quantity in stock is less than a specified value.
The unit value will be an input parameter for the stored procedure.  
Display the product id, quantity in stock, and reorder level from the products table, and the supplier name, address, city, and province from the suppliers table.
Run the stored procedure displaying the information for a value of 5. */

CREATE PROCEDURE sp_reorder_qty
(
	@v_quantity_stock int
)
AS 
SELECT	products.product_id,
		suppliers.name,
		suppliers.address,
		suppliers.city,
		suppliers.province,
		'qty'=products.quantity_in_stock,
		products.reorder_level
FROM products
INNER JOIN suppliers ON products.supplier_id=suppliers.supplier_id
WHERE	(products.reorder_level - products.quantity_in_stock) < @v_employee_id;

EXECUTE sp_reorder_qty '5';


/* 9D - Create a stored procedure called sp_unit_prices for the product table where the unit price is 
between particular values.  The two unit prices will be input parameters for the stored procedure.  
--> Display the product id, product name, alternate name, and unit price from the products table.  
Run the stored procedure to display products where the unit price is between $5.00 and $10.00. */

CREATE PROCEDURE sp_unit_prices
(
	@firstvalue money,
	@secondvalue money
)
AS 
SELECT	products.product_id,
		products.name,
		products.alternate_name,
		products.unit_price
FROM products
WHERE	products.unit_price >= @firstvalue
		AND products.unit_price <= @secondvalue;

DROP PROCEDURE sp_unit_prices;

EXECUTE sp_unit_prices '$5.00','$10.00';

SELECT *
FROM products 
WHERE products.unit_price >= 5.00 AND products.unit_price <= 10.00;