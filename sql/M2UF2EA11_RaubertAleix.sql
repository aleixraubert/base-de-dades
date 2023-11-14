/* 1. Mostra el nom de l’empleat, el nom del departament on treballa i l'id del seu cap. Fes servir
primer JOIN i USING i després o resols amb JOIN ON. */

SELECT e.first_name, d.department_name, e.employee_id
FROM EMPLOYEES E
JOIN DEPARTMENTS D USING (department_id);

SELECT e.first_name, d.department_name, e.employee_id
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON (d.department_id=e.department_id);


/* 2. Mostra la ciutat i el nom del departament de la localització 1400 (LOCATION_ID=1400).
Primer ho resols fent servir JOIN ON i després fent servir JOIN USING. */

SELECT l.city, d.department_name
FROM LOCATIONS L
JOIN DEPARTMENTS D ON (l.location_id=d.location_id)
WHERE l.location_id=1400;

SELECT l.city, d.department_name
FROM LOCATIONS L
JOIN DEPARTMENTS D USING (location_id)
WHERE l.location_id=1400;


/* 3. Mostra el cognom i la data de contractació de qualsevol empleat contractat després de
l’empleat Davies. Fes servir JOIN. */

SELECT e.last_name, e.hire_date
FROM EMPLOYEES E
JOIN EMPLOYEES ED ON (e.hire_date>ed.hire_date)
WHERE ed.last_name='Davies';


/* 4. Mostra el nom i cognom dels empleats, el nom del departament on treballen i el nom de la
ciutat on es troba el departament. Fes servir primer JOIN i USING i després o resols amb
JOIN ON. */

SELECT e.first_name, e.last_name, d.department_name, l.city
FROM EMPLOYEES E
JOIN DEPARTMENTS D USING (department_id)
JOIN LOCATIONS L USING (location_id);

SELECT e.first_name, e.last_name, d.department_name, l.city
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON (e.department_id=d.department_id)
JOIN LOCATIONS L ON (d.location_id=l.location_id);


/* 5. Mostra l'id del departament i el cognom de l’empleat de tots els empleats que treballin al
mateix departament que un empleat donat. Assignar a cada columna una etiqueta adequada.
Fes servir JOIN. */

SELECT e.department_id AS "Nom del departament", ed.last_name AS "Cognom del empleat"
FROM EMPLOYEES E
JOIN EMPLOYEES ED ON (e.department_id = ed.department_id)
WHERE e.employee_id = 120;

