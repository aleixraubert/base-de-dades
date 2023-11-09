/*Resultats d'aprenentatge

RA2. Realitza el disseny físic de bases de dades utilitzant assistents, eines gràfiques i el llen-
guatge de definició de dades.

Exercicis
Crea una base de dades i usuari anomenats shop. Es crearà l’estructura de la base de dades d’una
botiga d’informàtica.
Exercici 1: Realitza les següents tasques:
*/



/*a) (1,5 punts). Escriu les sentències necessàries per crear les taules ORDERF, PRODUCT i
ORDER_DETAILS en la base de dades shop. tenint en compte les restriccions indicades en
l’estructura de la base de dades.*/


CREATE TABLE ORDERF
(
    "order_id" NUMERIC(12),
    "order_date" DATE,
    "shipped_date" DATE,
    "ship_adress" VARCHAR(50) NOT NULL,
    "ship_city" VARCHAR(20),
    "ship_region" VARCHAR(20),

        CONSTRAINT PK_ORDER_ID PRIMARY KEY (order_id),
        CONSTRAINT CK_SHIPPED_DATE CHECK(shipped_date>order_date),
        CONSTRAINT CK_SHIP_REGION CHECK(ship_region IN ('USA', 'EUROPA', 'ASIA', 'AMERICA', 'RUSIA'))
);


CREATE TABLE PRODUCT
(
    "product_id" NUMERIC(12),
    "product_name" VARCHAR(50) NOT NULL,
    "unitprice" DOUBLE PRECISION NOT NULL,
    "unitstock" NUMERIC(3) NOT NULL,
    "unitonorder" NUMERIC(3) NOT NULL DEFAULT 1,

        CONSTRAINT PK_PRODUCT_ID PRIMARY KEY (product_id)

);


CREATE TABLE ORDER_DETAILS
(
    "order_id" NUMERIC(12) NOT NULL,
    "product_id" NUMERIC(12) NOT NULL,
    "quantity" NUMERIC(3) NOT NULL,
    "discount" NUMERIC(3),

        CONSTRAINT PK_PRODUCT_ID_ORDER_ID PRIMARY KEY (order_id,product_id),
        CONSTRAINT FK_ORDER_ID FOREIGN KEY (order_id) REFERENCES ORDERF(order_id),
        CONSTRAINT FK_PRODUCT_ID FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);



/* b) (0,25 punts). Comprova que les 3 taules s'han creat correctament amb la comanda que mostra
la definició de les taules amb els camps de les taules, tipus de dades, etc. */


/* S'han creat correctament, comprobat amb el \d. */


/* Una vegada creades les taules, ens hem adonat que hi ha un error a la taula
ORDERF. Hem de modificar dos camps.
ship_city VARCHAR(40),
ship_region VARCHAR(40))
Escriu el codi per realitzar aquests canvis i comprova que s'han modificat correctament. */


ALTER TABLE ORDERF
ALTER COLUMN ship_city SET DATA TYPE VARCHAR(40);

ALTER TABLE ORDERF
ALTER COLUMN ship_region SET DATA TYPE VARCHAR(40);

/* Comprobat que s'ha cambiat correctament amb \d orderf */


/* d) (0,75 punts). Crea una seqüència perquè el camp product_id es pugui autoincrementar.
Que comenci per 1, que incrementi 1 i el valor màxim sigui 99999. */

CREATE SEQUENCE PRODUCT_SEQ
INCREMENT 1
START WITH 1
MAXVALUE 99999;

/* e) (0,75 punts). Introdueix les següents dades a la taula PRODUCT. Utilitza la seqüencia
creada en l’exercici anterior i comprova que s’han inserit correctament els valors. */

INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'nikkon ds90', 67.09, 75, 1);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'canon t90', 82.82, 92, 1);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'dell inspirion', 182.78, 56, 2);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'ipad air', 482.83, 34, 2);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'microsoft surface', 93.84, 92, 2);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'nexus 6', 133.88, 16);
INSERT INTO PRODUCT VALUES (NEXTVAL('PRODUCT_SEQ'), 'thinkpad t365', 341.02, 22);


/* f) (0,75 punts). Intenta inserir els següents registres a la taula ORDERF. La informació que
ha de contenir la taula és la següent: */

INSERT INTO ORDERF VALUES (4001, '2016-04-04', '2016-11-06', '93 Spohn Place', 'Manggekompo', 'ASIA');
INSERT INTO ORDERF VALUES (4002, '2017-01-29', '2016-05-28', '46 Eliot Trail', 'Virginia', 'USA');
INSERT INTO ORDERF VALUES (4001, '2016-08-19', '2016-12-08', '23 Sundown Junction', 'Obodivka', 'RUSIA');
INSERT INTO ORDERF VALUES (4004, '2016-09-25', '2016-12-24', NULL, 'Nova Venécia', 'AMERICA');
INSERT INTO ORDERF VALUES (4005, '2017-03-14', '2017-03-19', '7 Ludington Court', 'Sukamaju', 'ASIA');
INSERT INTO ORDERF VALUES (4006, '2016-08-14', '2016-12-05', '859 Dahle Plaza', NULL, 'ASIA');
INSERT INTO ORDERF VALUES (4007, '2017-01-02', '01-02-2017', '5 Fuller Center Log pri', 'Brezovici', 'EUROP');

/* Si a l’introduir les dades en la taula ORDERF et dona errors, explica l’error que et dona i no
insereixis el registre. */

/* El còdig dona error a varios llocs, primer a la segona fila, ja que shipment_dat es mes petita que order_date, i li hem dit al principi que no pot ser aixi que ha de ser més gran. 
Després a la tercera linea peta perque esta repetin la clau primaria, i ha de ser única. La columna 4 i peten perque no hi ha informació a els parameters NOT NULLS. I la última peta perque el ultim parametre està mal escrit
haura de ser EUROPA enlloc de EUROP. */


/* g) (0,75 punts) Intenta inserir els següents registres a la taula ORDER_DETAILS. La infor-
mació que ha de contenir la taula és la següent: */

INSERT INTO ORDER_DETAILS VALUES (4001, 1, 5 , 8.73);
INSERT INTO ORDER_DETAILS VALUES (4003, 3, 8 , 4.01);
INSERT INTO ORDER_DETAILS VALUES (4005, 601, 2 , 3.05);
INSERT INTO ORDER_DETAILS VALUES (4006, 2, 4 , 5.78);

/* Si a l’introduir les dades en la taula ORDER_DETAILS et dona errors, explica l’error que et dona i
no insereixis el registre. Com que el camp discount el vam crear com a NUMERIC(3) ara l’hem de
modificar i que sigui DOUBLE PRECISION. */

ALTER TABLE ORDER_DETAILS
ALTER COLUMN discount SET DATA TYPE DOUBLE PRECISION;





/* Exercici 2. Realitza les següents tasques:
a) (0,25 punts). Crea un índex per la taula ORDERF, pel camp ship_address. */

CREATE INDEX ship_adress_index
ON ORDERF(ship_adress);


/* b) (0,5 punts). Crea un índex únic per la taula PRODUCT, pel camp product_name. */

CREATE UNIQUE INDEX product_name_index
ON PRODUCT(product_name);


/* Exercici 3. Realitza les següents tasques:
a) (1 punt). Afegeix els següents camps a la taula ORDERF:
cost_ship DOUBLE PRECISION DEFAULT 1500,
logistic_cia VARCHAR(100),
others VARCHAR(250), 

El camp logistic_cia només pot contenir una de les següents empreses de transport:
UPS,MRW,Post_Office,Fedex,TNT,DHL,Moldtrans,SEUR.*/

ALTER TABLE ORDERF
ADD cost_ship DOUBLE PRECISION DEFAULT 1500;

ALTER TABLE ORDERF
ADD logistic_cia VARCHAR(100);

ALTER TABLE ORDERF
ADD others VARCHAR(250);

ALTER TABLE ORDERF
ADD CONSTRAINT CK_LOGISTIC_CIA CHECK(logistic_cia IN('UPS', 'MRW', 'Post_Office', 'TNT', 'DHL', 'Moldtrans', 'SEUR'));



/* b) (0,5 punts). Elimina el camp others de la taula ORDERF. */

ALTER TABLE ORDERF
DROP COLUMN others;



/*Exercici 4. Realitza les següents tasques:
Recorda que per treballar les transaccions has de deixar sense efecte el autocommit executant
la sentència BEGIN;
a) (0,5 punts). Modifica els valors del camp discount de la taula ORDER_DETAILS dels
registres que la quantitat sigui més gran que 2. El nou descompte serà 7.5. Comprova que s'ha
efectuat el canvi. */

BEGIN;

UPDATE ORDER_DETAILS SET discount=7.5 WHERE quantity>2;

SELECT * FROM order_details;


/* b) (0,25 punts) desfés els canvis que has fet en l'apartat anterior i comprova si s'han desfet. */

ROLLBACK;

SELECT * FROM order_details;


/* c) (0,5 punts) Elimina els productes que tinguin un unitstock < 30 i fes que els canvis siguin
permanents. */

BEGIN;

DELETE FROM PRODUCT WHERE unitstock<30;

SELECT * FROM PRODUCT;
COMMIT;


/* d) (1,25 punt) Elimina la comanda de la taula ORDERF amb order_id = 4006. Si no la pots

eliminar explica perquè no pots, i realitza les modificacions que siguin necessàries a les tau-
les perquè la puguis eliminar. Comprova que realment s'ha eliminat la comanda.
*/

BEGIN;
DELETE FROM orderf WHERE order_id=4006;

/* No hem deixara borrarla ja que  order_id esta asociat a una clau foranea a la taula de order_details. S'hauria de borrar la CONSTRAINT de la clau foranea per a pode eliminarlo. */
