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
    
    
