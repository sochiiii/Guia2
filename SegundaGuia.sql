DROP DATABASE IF EXISTS `coffeeshop`;

CREATE DATABASE IF NOT EXISTS `coffeeshop`;
USE `coffeeshop`;

show tables;

select * from pedido;
select * from cliente;

-- EJERCICIO 1
SELECT c.nombre_cliente, p.id_pedido
FROM pedido p
INNER JOIN Cliente c ON c.id_cliente = p.id_cliente;

-- VISTA DEL EJERCICIO 1
DROP VIEW IF EXISTS Clientes_pedidos;
CREATE VIEW Clientes_pedidos AS
SELECT DISTINCT c.nombre_cliente AS 'Nombre del cliente',
c.apellido_cliente AS 'Apellido del cliente',
COUNT(p.id_pedido) AS 'Cantidad de pedidos'
FROM pedido p
INNER JOIN Cliente c ON c.id_cliente = p.id_cliente
GROUP BY c.nombre_cliente, c.apellido_cliente;

SELECT * FROM Clientes_pedidos;

-- EJERCICIO 2
SELECT * FROM pedido
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-03-09';

-- EJERCICIO 3
SELECT * FROM cliente
ORDER BY nacimiento_cliente DESC;

SELECT * FROM producto;
SELECT * FROM pedido;
SELECT * FROM detalle_pedido;

-- EJERCICIO 4
SELECT * FROM producto WHERE id_producto IN ( SELECT detalle_pedido.id_producto FROM detalle_pedido WHERE id_pedido = 1);

-- EJERCICIO 5
SELECT MAX(precio_producto) AS 'Producto con mayor precio' FROM producto;

-- EJERCICIO 6
SELECT ROUND(AVG(precio_producto),2) AS 'Promedio de precios de los productos' FROM producto;

-- EJERCICIO 7
SELECT * FROM pedido;
SELECT p.estado_pedido AS 'Estado del pedido',
COUNT(p.id_pedido) AS 'Cantidad de pedidos'
FROM pedido p
GROUP BY p.estado_pedido;

-- EJERCICIO 8
SELECT * FROM cliente
WHERE nombre_cliente LIKE 'd%';

SELECT * FROM pedido;

-- EJERCICIO 9
SELECT DISTINCT c.nombre_cliente AS 'Nombre del cliente', 
COUNT(p.id_pedido) AS 'Cantidad de pedidos',
p.fecha_registro AS 'Fecha del registro'
FROM pedido p 
INNER JOIN Cliente c ON c.id_cliente = p.id_cliente WHERE p.fecha_registro BETWEEN '2024-01-01' AND '2024-02-06' 
GROUP BY c.nombre_cliente ORDER BY COUNT(p.id_pedido) ASC;

-- EJERCICIO 10
SELECT p.nombre_producto AS 'Nombre del producto', 
SUM(dp.cantidad_producto) 'Cantidad vendida de productos', 
(SUM(dp.cantidad_producto) * dp.precio_producto) AS 'Precio total' 
FROM detalle_pedido dp 
INNER JOIN producto p ON p.id_producto = dp.id_producto 
GROUP BY p.nombre_producto 
ORDER BY SUM(dp.cantidad_producto) DESC LIMIT 3;

-- EJERCICIO 11
SELECT c.nombre_cliente AS 'Nombre del cliente', 
COUNT(p.id_pedido) AS 'Cantidad de pedidos'
FROM pedido p 
INNER JOIN Cliente c ON c.id_cliente = p.id_cliente 
GROUP BY c.nombre_cliente ORDER BY COUNT(p.id_pedido) DESC LIMIT 1;

-- EJERCICIO 12
SELECT p.id_pedido, c.id_cliente, c.nombre_cliente, p.direccion_pedido, p.estado_pedido, p.fecha_registro, 
dp.id_detalle, pr.nombre_producto, pr.existencias_producto, pr.precio_producto
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.id_cliente
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido
INNER JOIN producto pr ON dp.id_producto = pr.id_producto;
