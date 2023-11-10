/* 1. Mostra totes les dades dels empleats que el seu lloc de feina sigui Sales Manager. */

SELECT E.*
FROM EMPLOYEES E,JOBS J
WHERE E.JOB_ID=J.JOB_ID AND J.JOB_ID='SA_MAN';


/* 2. Mostra els departaments que tinguin empleats que hagin finalitzat el seu contracte a l'any
1998. */

SELECT D.* 
FROM DEPARTMENTS D, JOB_HISTORY J
WHERE D.DEPARTMENT_ID=J.DEPARTMENT_ID AND END_DATE BETWEEN '1-1-1998' AND '31-12-1998';


/* 3. Mostra els noms dels departaments en els que hi treballin empleats amb noms que
comencen per la lletra A. */

SELECT D.DEPARTMENT_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND E.FIRST_NAME LIKE '%A%';


/* 4. Mostra el nom del departament, el nom i el cognom dels empleats que el seu departament
no sigui IT. */

SELECT D.DEPARTMENT_NAME, E.FIRST_NAME, E.LAST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND DEPARTMENT_NAME!='IT';


/* 5. Mostra totes les dades dels departaments que es troben a Seattle. */

SELECT D.*
FROM DEPARTMENTS D, LOCATIONS L
WHERE D.LOCATION_ID=L.LOCATION_ID AND L.CITY='Seattle';


/* 6. Mostra el nom, el cognom i el nom del departament dels empleats que treballen a Seattle. */
/* Location_id=1700. */

SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND D.LOCATION_ID='1700';


/* 7. Mostra el nom del departament i totes les dades dels empleats que no treballen en el
departament de Marketing ni el de vendes (Sales). */

SELECT D.DEPARTMENT_NAME, E.*
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND (D.DEPARTMENT_NAME!='Marketing' AND D.DEPARTMENT_NAME!='Sales');


/* 8. Mostra els noms de tots els departaments i la ciutat i país on estiguin ubicats. */

SELECT D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
FROM DEPARTMENTS D, LOCATIONS L, COUNTRIES C
WHERE D.LOCATION_ID=L.LOCATION_ID AND L.COUNTRY_ID=C.COUNTRY_ID;


/* 9. Mostra els noms dels països (country_name) i el nom del continent (region_name) d'Àsia i
Europa. */

SELECT C.COUNTRY_NAME, R.REGION_NAME
FROM COUNTRIES C, REGIONS R
WHERE C.REGION_ID=R.REGION_ID AND (R.REGION_NAME='Europe' OR R.REGION_NAME='Asia');


/* 10. Mostra el cognom i el job_id dels empleats que tinguin el mateix ofici que el seu cap i
mostra el nom del cap. */

SELECT E.FIRST_NAME, E.LAST_NAME, E.JOB_ID, M.FIRST_NAME 
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID=M.EMPLOYEE_ID AND E.JOB_ID=M.JOB_ID;


/* 11. Mostra el cognom dels empleats que tinguin el mateix ofici que el seu cap, el nom del cap
i mostra també el nom de l'ofici (job_title). */

SELECT E.LAST_NAME, M.FIRST_NAME, J.JOB_TITLE
FROM EMPLOYEES E, EMPLOYEES M, JOBS J
WHERE E.MANAGER_ID=M.EMPLOYEE_ID AND E.JOB_ID=M.JOB_ID AND M.JOB_ID=J.JOB_ID;
