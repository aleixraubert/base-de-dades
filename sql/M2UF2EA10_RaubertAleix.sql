/* 1. Mostra per cada cap (manager_id), la suma dels salaris dels seus empleats, però només, per
aquells casos en els quals la mitja del salari dels seus empleats sigui més gran que 3000. */

SELECT MANAGER_ID, SUM(SALARY) AS SUMA_SALARY
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING AVG(SALARY) > 3000;


/* 2. Mostra per cada cap (manager_id) quants empleats tenen al seu carrec i quin és el salari
màxim, però només per aquells caps amb més de 6 empleats al seu càrrec. */

SELECT MANAGER_ID, COUNT(EMPLOYEE_ID) AS num_empleats, MAX(SALARY) AS salari_maxim
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING COUNT(EMPLOYEE_ID) > 6;


/* 3. Fes al mateix que a la consulta anterior, però només per aquells caps que tinguin com a
id_manager_id 100, 121 o 122. Ordena els resultats per manager_id. */

SELECT MANAGER_ID, COUNT(EMPLOYEE_ID) AS num_empleats, MAX(SALARY) AS salari_maxim
FROM EMPLOYEES
WHERE MANAGER_ID IN (100, 121,122)
GROUP BY MANAGER_ID
HAVING COUNT(EMPLOYEE_ID) > 6
ORDER BY MANAGER_ID;


/* 4. Calcular el nombre empleats que realitzen cada ofici a cada departament.
Les dades que es visualitzen són: codi del departament, ofici i nombre empleats. */

SELECT E.DEPARTMENT_ID, J.JOB_TITLE, COUNT(E.EMPLOYEE_ID) AS nombre_empleats
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID=J.JOB_ID
GROUP BY E.DEPARTMENT_ID, E.JOB_ID, J.JOB_TITLE;


/* 5. Mostra el nom del departament i el número d'emplets que té cada departament. */

SELECT D.DEPARTMENT_NAME, COUNT(E.DEPARTMENT_ID) as nombre_empleats
FROM EMPLOYEES E, DEPARTMENTS D
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME;


/* 6. Mostra el número d'empletas del departamant de 'SALES'. */

SELECT D.DEPARTMENT_NAME, COUNT(E.DEPARTMENT_ID) as nombre_empleats
FROM EMPLOYEES E, DEPARTMENTS D
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND D.DEPARTMENT_NAME='Sales'
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME;


/* 7. Mostra quants departaments diferents hi ha a Seattle. */

SELECT C.CITY, COUNT(D.LOCATION_ID) AS nombre_departaments
FROM LOCATIONS C, DEPARTMENTS D
WHERE C.LOCATION_ID=D.LOCATION_ID AND C.CITY='Seattle'
GROUP BY D.LOCATION_ID, C.CITY;