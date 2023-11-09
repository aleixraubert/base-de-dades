/* 1. Mostra totes les dades dels empleats que el seu lloc de feina sigui Sales Manager. */

SELECT E.*
FROM EMPLOYEES E,JOBS J
WHERE E.JOB_ID=J.JOB_ID AND J.JOB_ID='SA_MAN';

/* 2. Mostra els departaments que tinguin empleats que hagin finalitzat el seu contracte a l'any
1998. */

SELECT D.* 
FROM DEPARTMENTS D, JOB_HISTORY J
WHERE D.DEPARTMENT_ID=J.DEPARTMENT_ID AND END_DATE BETWEEN '1-1-1998' AND '31-12-1998';
