

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    order_date DATE,
    product_name VARCHAR(100),
    category_product VARCHAR(50),
    region VARCHAR(50),
    quantity INT,
    sales DECIMAL(10,2),
    customer_id INT,

    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);



INSERT INTO customers VALUES (1, 'Ana', 'Sul');
INSERT INTO customers VALUES (2, 'Bruno', 'Sudeste');
INSERT INTO customers VALUES (3, 'Carlos', 'Nordeste');
INSERT INTO customers VALUES (4, 'Daniela', 'Sul');
INSERT INTO customers VALUES (5, 'Eduardo', 'Sudeste');


INSERT INTO sales VALUES(1, TO_DATE('2024-01-05','YYYY-MM-DD'),'Notebook','Tecnologia','Sul',2,5000.00,1);
INSERT INTO sales VALUES(2, TO_DATE('2024-01-06','YYYY-MM-DD'),'Mouse','Tecnologia','Sul',10,500.00,2);
INSERT INTO sales VALUES(3, TO_DATE('2024-01-07','YYYY-MM-DD'),'Teclado','Tecnologia','Sudeste',5,750.00,3);
INSERT INTO sales VALUES(4, TO_DATE('2024-01-08','YYYY-MM-DD'),'Cadeira','Móveis','Sudeste',3,1200.00,4);
INSERT INTO sales VALUES(5, TO_DATE('2024-01-09','YYYY-MM-DD'),'Mesa','Móveis','Sul',2,1500.00,1);
INSERT INTO sales VALUES(6, TO_DATE('2024-01-10','YYYY-MM-DD'),'Celular','Tecnologia','Nordeste',4,4000.00,2);
INSERT INTO sales VALUES(7, TO_DATE('2024-01-11','YYYY-MM-DD'),'Fone de Ouvido','Tecnologia','Nordeste',8,800.00,3);
INSERT INTO sales VALUES(8, TO_DATE('2024-01-12','YYYY-MM-DD'),'Monitor','Tecnologia','Sul',3,1800.00,4);
INSERT INTO sales VALUES(9, TO_DATE('2024-01-13','YYYY-MM-DD'),'Caderno','Papelaria','Sudeste',20,400.00,5);
INSERT INTO sales VALUES(10, TO_DATE('2024-01-14','YYYY-MM-DD'),'Caneta','Papelaria','Sul',50,250.00,1);
INSERT INTO sales VALUES(11, TO_DATE('2024-01-15','YYYY-MM-DD'),'Notebook','Tecnologia','Sudeste',1,2500.00,2);
INSERT INTO sales VALUES(12, TO_DATE('2024-01-16','YYYY-MM-DD'),'Mouse','Tecnologia','Nordeste',7,350.00,3);
INSERT INTO sales VALUES(13, TO_DATE('2024-01-17','YYYY-MM-DD'),'Teclado','Tecnologia','Sul',6,900.00,4);
INSERT INTO sales VALUES(14, TO_DATE('2024-01-18','YYYY-MM-DD'),'Cadeira','Móveis','Nordeste',2,800.00,5);
INSERT INTO sales VALUES(15, TO_DATE('2024-01-19','YYYY-MM-DD'),'Mesa','Móveis','Sudeste',1,750.00,5);
INSERT INTO sales VALUES(16, TO_DATE('2024-01-20','YYYY-MM-DD'),'Celular','Tecnologia','Sul',2,2000.00,1);
INSERT INTO sales VALUES(17, TO_DATE('2024-01-21','YYYY-MM-DD'),'Fone de Ouvido','Tecnologia','Sudeste',5,500.00,2);
INSERT INTO sales VALUES(18, TO_DATE('2024-01-22','YYYY-MM-DD'),'Monitor','Tecnologia','Nordeste',2,1200.00,3);
INSERT INTO sales VALUES(19, TO_DATE('2024-01-23','YYYY-MM-DD'),'Caderno','Papelaria','Sul',15,300.00,4);
INSERT INTO sales VALUES(20, TO_DATE('2024-01-24','YYYY-MM-DD'),'Caneta','Papelaria','Nordeste',40,200.00,5);

-- ==============
-- FUNDAMENTOS
-- ==============

-- 1. Liste o nome do produto, quantidade e valor de venda
SELECT product_name, quantity, sales FROM sales;

-- 2. Mostre os pedidos com valor de venda acima de 500
SELECT order_id, product_name, sales
FROM sales
WHERE sales > 500;

-- 3. Liste os produtos ordenados do maior valor de venda para o menor
SELECT product_name, sales
FROM sales
ORDER BY sales DESC;

-- 4. Mostre os pedidos realizados após 01/01/2024
SELECT order_id, order_date
FROM sales
WHERE order_date > TO_DATE('2024-01-01','YYYY-MM-DD');

-- 5. Liste os pedidos da região Sul com valor de venda maior que 300
SELECT order_id, region, sales
FROM sales
WHERE region = 'Sul'
AND sales > 300;

-- 6. Mostre pedidos onde a quantidade é maior que 5 OU o valor de venda é maior que 1000
SELECT order_id, quantity, sales
FROM sales
WHERE quantity > 5
OR sales > 1000;

-- 7. Liste os pedidos que NÃO pertencem à categoria "Móveis"
SELECT order_id, category_product
FROM sales
WHERE category_product <> 'Móveis';

-- 8. Liste todas as categorias únicas de produtos
SELECT DISTINCT category_product FROM sales;

-- 9. Liste todas as regiões únicas
SELECT DISTINCT region FROM sales;

-- 10. Conte quantas categorias diferentes existem
SELECT COUNT(DISTINCT category_product) AS total_categories
FROM sales;

-- =========
-- JOIN
-- =========

-- 11. Liste os pedidos com nome do cliente e produto
SELECT s.order_id, s.product_name, c.customer_name
FROM sales s
JOIN customers c ON c.customer_id = s.customer_id;

-- 12. Mostre os pedidos com nome do cliente e valor de venda
SELECT s.order_id, c.customer_name, s.sales
FROM sales s
JOIN customers c ON c.customer_id = s.customer_id;

-- 13. Liste os clientes que compraram mais de 1 item
SELECT DISTINCT c.customer_name
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.quantity > 1;

-- 14. Calcule o total de pedidos por cliente
SELECT c.customer_id, COUNT(*) AS total_sales
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id;

-- 15. Identifique o cliente que mais gastou
SELECT c.customer_name, SUM(s.sales) AS total_spent
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
FETCH FIRST 1 ROWS ONLY;

-- 16. Liste os produtos comprados por cada cliente
SELECT c.customer_name, s.product_name
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id;

-- 17. Mostre os clientes da região Sul que realizaram compras
SELECT DISTINCT c.customer_name
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE c.region = 'Sul';

-- 18. Calcule o total de pedidos por cliente
SELECT c.customer_id, COUNT(*) AS total_orders
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id;