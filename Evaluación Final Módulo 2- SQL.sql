-- Evaluación Final Módulo 2: SQL --

USE sakila;

--  1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. --
SELECT *
	FROM film;
    
SELECT DISTINCT title -- 👉 esto es lo que a primeras se me ocurre hacer  --
	FROM film;

SELECT title, COUNT(*) -- 👉 como quería serciorarme de saber si habían titulos repetidos si quiera, hice esto. De esta manera corroboro que en la tabla film no hay titulos repetidos. --
	FROM film 
	GROUP BY title 
	HAVING COUNT(*) > 1;
    
-- ✅ por lo tanto, mantengo mi query original como la solución --
SELECT DISTINCT title AS Nombre_Pelicula
	FROM film;


-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13" --

SELECT *
	FROM film;
    
-- ✅ query solución --    
SELECT title AS  Nombre_Pelicula, rating AS Clasificacion
	FROM film
	WHERE rating = "PG-13";
    
    
-- 3. Encuentra el título y la descripcion de todas las películas que contengan la palabra "amazing" en su descripcion --
SELECT *
	FROM film;

 -- ✅ query solución --  
SELECT title AS Nombre_Pelicula, description AS Descripcion
	FROM film
    WHERE description LIKE "%amazing%";
    
-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos --
SELECT *
	FROM film;
    
 -- ✅ query solución --      
SELECT title AS Nombre_Pelicula, length AS Duracion
	FROM film
    WHERE length > 120;
    
    
-- 5. Recupera los nombres de todos los actores --
SELECT *
	FROM actor;
    
SELECT first_name AS Nombre, last_name AS Apellido -- he llamado también al Apellido como manera de cerciorarme de que no hay repetidos --
	FROM actor;

-- ✅ query solución -- dado que este output es igual al anterior y el anunciado solo me pide los nombres
SELECT first_name AS Nombre
	FROM actor;


-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido --

-- ✅ query solución -- 
SELECT first_name AS Nombre, last_name AS Apellido 
	FROM actor
    WHERE last_name = "Gibson"; -- elegí un (=) porque solo es 1 apellido por nombre --
    
    
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. --

SELECT first_name AS Nombre, actor_id  -- selecciono ver el actor_id para corroborar que me muestra lo que le pido -- 
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;

-- ✅ query solución --
SELECT first_name AS Nombre
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;
    
-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación --
SELECT *
	FROM film;

SELECT title AS Titulo, rating AS Clasificacion
	FROM film
    WHERE rating NOT LIKE "R" AND  "PG-13"; -- no me funciona porque sigue mostrando los "PG-13" --

-- ✅ query solución --    
SELECT title AS Titulo, rating AS Clasificacion
	FROM film
    WHERE rating NOT LIKE "R" AND rating NOT LIKE "PG-13"; 
    

-- 9. Encuentra la cantidad total de películas en cada clasificacion de la tabla film y muestra la clasificacion junto con el recuento --
SELECT *
	FROM film;

SELECT COUNT(rating) AS Total_Peliculas, rating AS Clasificacion -- asi es como lo resolví--
	FROM film
    GROUP BY rating; 

-- ✅ query solución	
SELECT rating AS Clasificacion, COUNT(*) AS Total_Peliculas -- luego me di cuenta que el orden del select se podía mejorar para hacer más sentido --
FROM film
GROUP BY rating;


-- 10. cantidad total de películas alquiladas por cada cliente mostrando id de cliente, nombre y apellido junto con la cantidad de pelis alquiladas --
SELECT *
	FROM rental;
  
SELECT *
FROM customer; 
    
SELECT c.customer_id AS ID_Cliente, c.first_name AS Nombre, c.last_name AS Apellido, COUNT(*) AS Total_Peliculas
	FROM customer AS c
    LEFT JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id;
-- 👆 esta sentencia me daba error en el group by. Este count con left join me podia contar las filas vacías --	    
    
    
-- ✅ query solución --	    
SELECT c.customer_id AS ID_Cliente, c.first_name AS Nombre, c.last_name AS Apellido, COUNT(r.rental_id) AS Total_Peliculas
FROM customer AS c
LEFT JOIN rental AS r USING (customer_id)
GROUP BY c.customer_id, c.first_name, c.last_name;

    
-- 11. total de peliculas alquiladas por categoría. muestra nombre de la categoria y recuento de alquileres -- 	  
SELECT *
	FROM rental;
  
SELECT *
	FROM film_category;

SELECT *
	FROM category;
    
SELECT *
	FROM inventory; 

SELECT *
	FROM film; 
    
SELECT r.inventory_id, c.name -- 1er view de lo que obtengo--
	FROM rental AS r 
    INNER JOIN inventory AS i
    USING (inventory_id)
	INNER JOIN film AS f
    USING (film_id)
    INNER JOIN film_category AS f_c
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id);


SELECT  c.name, COUNT(r.rental_id) -- 2do view de lo que obtengo--
	FROM rental AS r 
    INNER JOIN inventory AS i
    USING (inventory_id)
	INNER JOIN film AS f
    USING (film_id)
    INNER JOIN film_category AS f_c
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
    GROUP BY c.name;

-- ✅ query solución --	 
SELECT  c.name AS Categoria, COUNT(r.rental_id) AS Total_Alquileres 
	FROM rental AS r 
    INNER JOIN inventory AS i
    USING (inventory_id)
	INNER JOIN film AS f
    USING (film_id)
    INNER JOIN film_category AS f_c
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
    GROUP BY c.name;

