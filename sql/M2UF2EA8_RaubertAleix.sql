/* 1. Mostra el nom i cognom de tots els empleats. S'han de mostrar amb la primera lletra en
majúscula i la resta en minúscules. */

SELECT INITCAP(CONCAT(FIRST_NAME, ' ', LAST_NAME)) AS "Nom Complet"
FROM EMPLOYEES;


/* 2. Mostra els empleats que han sigut contractats durant el més de maig. */

SELECT *
FROM EMPLOYEES
WHERE MONTH(HIRE_DATE) > 5;


/* 3. Mostra els oficis (job_title) diferents que hi ha a la base de dades. */

SELECT DISTINCT JOB_TITLE
FROM JOBS;


/* 4. Calcula quants empleats hi ha en cada departament. */

SELECT DEPARTMENT_NAME, COUNT(*) as quantitat_empleats
FROM EMPLOYEES
GROUP BY JOB_ID;


/* 5. Calcula quants empleats hi ha de cada tipus d'ocupació (JOB_ID). */

SELECT JOB_ID, COUNT(*) as quantitat_empleats
FROM EMPLOYEES
GROUP BY JOB_ID;


/* 6. Mostra el número de països que tenen cadascun dels continents que tinguin com
identificador de regió 1,2 o 3; */

SELECT COUNTRY_ID, COUNT(*) as num_countries
FROM COUNTRIES
WHERE REGION_ID IN (1, 2, 3)
GROUP BY COUNTRY_ID;


/* 7. Mostra per cada manager el manager_id, el nombre d'emplets que té al seu carrec i la mitja
dels salaris d'aquests empleats. */

SELECT MANAGER_ID, COUNT(*) as num_empleats, AVG(SALARY) as mitjana_salarial
FROM EMPLOYEES
GROUP BY MANAGER_ID;


/* 8. Mostra l’id del departament i el número d’empleats dels departaments amb més de 4
empleats. */

SELECT DEPARTMENT_ID, COUNT(*) as num_empleats
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) > 4;
