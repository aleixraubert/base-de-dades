/*

CREATE DATABASE biblio;
CREATE USER biblio WITH SUPERUSER ENCRYPTED PASSWORD 'biblio';
ALTER DATABASE biblio OWNER TO biblio;
GRANT ALL PRIVILEGES ON DATABASE biblio TO biblio;

*/

/*Exercici 1. (1,5 punts)
Escriu les sentències necessàries per crear les taules SOCI, PRESTEC i LLIBRE a la base de
dades biblio. tenint en compte les restriccions indicades.
*/


CREATE TABLE soci (
    idsoci SERIAL NOT NULL UNIQUE,
    nom VARCHAR(30),
    cognoms VARCHAR(50),
    dni VARCHAR(9) NOT NULL UNIQUE,
    telefon NUMERIC(9) NOT NULL UNIQUE,
    email VARCHAR(35) NOT NULL UNIQUE,

        CONSTRAINT PK_idsoci PRIMARY KEY (idsoci)
);

CREATE TABLE llibre (
    idllibre NUMERIC(15) NOT NULL,
    isbn VARCHAR(25) NOT NULL UNIQUE,
    titol VARCHAR(70),
    autor VARCHAR(60),

        CONSTRAINT PK_idllibre PRIMARY KEY (idllibre)
);

CREATE TABLE prestec (
    idprestec NUMERIC(35) NOT NULL,
    idllibre NUMERIC(15),
    dataPres DATE,
    dataRet DATE,
    idsoci INTEGER,
    estat CHAR(1),
    penalitzacio NUMERIC(10) NOT NULL DEFAULT 1,

        CONSTRAINT PK_idprestec PRIMARY KEY (idprestec),
        CONSTRAINT FK_idsoci FOREIGN KEY (idsoci) REFERENCES soci(idsoci),
        CONSTRAINT FK_idllibre FOREIGN KEY (idllibre) REFERENCES llibre(idllibre),
        CONSTRAINT CHK_estat CHECK (estat IN('P', 'R')),
        CONSTRAINT CHK_penalitzacio CHECK (penalitzacio>0)
);

/* Exercici 2. (0,25 punts)
Elimina la columna email de la taula soci i comprova l’estructura de la taula soci.
*/

ALTER TABLE soci DROP COLUMN email;

/* Comprobat desde el datagrip que la columna emil ja no existeix, sino es pot comprobar desde el cmd amb \d soci.
*/

/* Exercici 3. (0,25 punts)
Torna a afegir la columma email a la taula soci amb el tipus de dades VARCHAR(40) i
comprova l’estructura de la taula soci.
*/

ALTER TABLE soci ADD COLUMN email VARCHAR(40);

/* Comprobat desde el datagrip que la columna emil torna a existir, sino es pot comprobar desde el cmd amb \d soci.
*/

/*Exercici 4. (0,25 punts)
Canvia el nom de la restricció que obliga que el camp penalitzacio ha de ser més gran que 0. Ara
es diu penalty_ck. Comprova si s’ha realitzat el canvi de nom.
*/

ALTER TABLE prestec RENAME CONSTRAINT CHK_penalitzacio TO penalty_ck;

/* Comprobat desde el datagrip o amb el \d prestec a la terminal.*/

/* Exercici 5. (0,25 punts)
Canvia el tipus de dades del camp idsoci de la taula prestec. El nou tipus de dades d’aquest camp
ha de ser NUMERIC(15). Si no es pot fer el canvi explica perquè.
*/

ALTER TABLE prestec
ALTER COLUMN idsoci SET DATA TYPE NUMERIC(15);

/* No ens deixa ja que el camp que estem intentar canviar de la taula prestec, te una clau foranea
i si la cambiessim de tipus de variable no coincidiria amb el mateix data type de  a la que fa referencia.
*/

/* Exercici 6. (0,25 punts)
Afegeix una nova restricció a la taula prestec per controlar que la data de retorn ha de ser
superior a la data del préstec. */

ALTER TABLE prestec ADD CONSTRAINT CHK_date CHECK (dataRet>dataPres);

/* Exercici 7. (0,5 punts)
Insereix 5 socis a la taula soci amb dades inventades. Tots els camps han de tenir un valor, i
comprova que s’han insertat correctament. */

INSERT INTO soci VALUES (1,'Fulanito', 'Fulanito de Tal', '40564966G', 649767894, 'raubert2003@gmail.com');
INSERT INTO soci VALUES (2,'Joan', 'Sanz', '40264966G', 649764344, 'joan.sanz@gmail.com');
INSERT INTO soci VALUES (3,'Marc', 'Rodriguez', '40556766G', 623467894, 'marc.18@gmail.com');
INSERT INTO soci VALUES (4,'Pere', 'Perez', '40564936G', 649567894, 'pere.gal@gmail.com');
INSERT INTO soci VALUES (5,'Cris', 'Casanova', '42344966G', 643457894, 'uwu@gmail.com');

/* Amb el datagrip podem comprobar com s'han afegit tots, sino desde el cmd amb un SELECT *
*/

/* Exercici 8. (0,75 punts)
Introdueix les següents dades a la taula llibre. Si a l’introduir les dades et dona errors, explica
el motiu de l’error que et dona i no insereixis el registre. Comprova quins són els registres
que s’han inserit.
*/

INSERT INTO llibre VALUES (2121213, '0-7645-2641-22', 'Preludi de la fundació', 'Isaac Asimov');
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO llibre VALUES (2124215, '0-7645-2481-1', 'Estranger', 'Albert Camus');
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO llibre VALUES (2123217, '0-7645-2633-3', 'Jo Claudi', 'Robert Graves');
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO llibre VALUES (2121213, '0-7645-2641-3', 'Ulises', 'James Joyce');
/* ^^ NO deixa introduirla ja que la clau idllibre no pot esta repetida, i li estem intentar ficar la mateixa
que al primer INSERT. */

INSERT INTO llibre VALUES (2126219, '0-7645-34641-11', 'Els miserables', 'Victor Hugo');
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO llibre VALUES (21292110, '0-8445-2641-45', 'Rayuela', 'Julio Cortázar');
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO llibre VALUES (21212124, '0-7645-2633-3', 'El vell i el mar', 'Ernest Hemingway');
/* ^^ NO deixa introduirla ja que la clau isbn no pot esta repetida, i li estem intentar ficar la mateixa
que al tercer INSERT. */

INSERT INTO llibre VALUES (212123234, NULL, 'La taronja mecànica', 'Anthony Burgess');
/* ^^ NO deixa introduirla ja que la clau isbn no pot ser NULL. */


/* Exercici 9. (0,25 punts)
Crea una seqüència perquè el camp idprestec de la taula prestec es pugui autoincrementar.
Que comenci per 10, que incrementi 5 i el valor màxim sigui 9000000. La seqüència s’ha
d’anomenar idprestec_seq.
*/

CREATE SEQUENCE idprestec_seq
INCREMENT 5
START WITH 10
MAXVALUE 9000000;


/* Exercici 10. (0,75 punts)
Intenta inserir els següents registres a la taula prestec. Utilitza la seqüencia creada en
l’exercici anterior. Si a l’introduir les dades et dona errors, explica l’error que et dona i no
insereixis el registre. La informació que ha d’intentar inserir és la següent:
*/

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 2121213, '2016-04-04', '2016-11-06', 4, 'R', NULL);
/* ^^ NO deixa insertarlo ja que la columna penalització no pot ser NULL. */

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 2123217, '2017-01-29', '2017-05-28', 3, 'R', 2);
/* ^^ Deixa introduirla sense cap error. */

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 21331216, '2021-08-19', '2021-12-08', 1, 'R', 3);
/* ^^ NO deixa insertarlo ja que el idllibre que fa referencia a la taula llibre te un valor que no existeix
en la taula llibre */ 

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 21292110, '2019-09-25', '2019-12-24', 2, 'P', NULL);
/* ^^ NO deixa insertarlo ja que la columna penalització no pot ser NULL. */

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 2123217, '2017-03-14', '2017-03-11', 2, 'R', 2);
/* ^^ NO deixa insertarlo ja que la data de prestec no pot ser més petita que la data de retorn. */

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 2124215, '2019-08-14', '2020-01-05', 1, 'S', NULL);
/* ^^ NO deixa insertarlo ja que la columna penalització no pot ser NULL, i a més estat només
pot ser 'P' o 'R'. */

INSERT INTO prestec VALUES (NEXTVAL('idprestec_seq'), 2123217, '2017-01-02', '01-02-2017', 9, 'R', 3);
/* ^^ NO deixa insertarlo ja que el idsoci que fa referencia a la taula soci te un valor que no existeix
en la taula soci */ 


/* Exercici 11. (0,5 punts)
Actualitza els valors del camp estat de la taula prestec de tots els préstecs que la penalització
sigui igual a 1. L’estat de tots aquests préstecs ha de ser R. Comprova que l’actualització s’ha
realitzat correctament.
*/

BEGIN;

UPDATE prestec SET estat='R' WHERE penalitzacio=1;

SELECT * FROM  prestec;

/* Amb un SELECT podem comprobar que efectivament s'han modificat. */


/* Exercici 12. (0,5 punts)
Elimina el llibre que el codi del llibre sigui igual a 2126219
*/

BEGIN;

DELETE FROM llibre WHERE idllibre=2126219;

SELECT * FROM llibre;


/* Exercici 13. (0,25 punts)
Intenta eliminar la taula soci. Ho pots fer? En cas negatiu explica perquè. Torna-la a crear
afegint les 5 files inicials si l’has pogut eliminar. */

DROP TABLE soci;

/* NO deixa ja que la taula te claus foraneas que ho impedeixen. */


/* Exercici 14. (0,25 punts)
Intenta eliminar tot els valors de la taula soci. Ho pots fer? En cas negatiu explica perquè. */



/* No deixarà eliminar els valor que tinguin una clau foreanea en una altre taula. */

/* Exercici 15. (0,25 punts)
Crea una vista anomenada titolsllibres amb el títol i autor del tots els llibres.
Comprova el contingut de la vista creada.*/

CREATE VIEW titolsllibres AS
(SELECT titol, autor FROM llibre);

/* A la carpeta Views del Datagrip es pot veure com s'ha creat correctament.

/* Exercici 16. (0,5 punts)
Crea una vista anomenada socisambprestec amb el nom, cognoms i telèfon dels socis que
tinguin préstecs retornats. Comprova el contingut de la vista creada. */

/*CREATE VIEW prestecs AS
(SELECT idsoci FROM prestec WHERE estat='R');*/

CREATE VIEW socismabprestec AS
(SELECT nom, cognoms, telefon FROM soci);

/*Exercici 17. (0,25 punts)
Crea un índex únic anomenat llibre_idx sobre el camp isbn de la taula llibre i comprova que
s’ha creat correctament.*/

CREATE UNIQUE INDEX llibre_idx
ON llibre(isbn);

/* A la carpeta indexes del datagrip dins de llibre podem veure que s'ha creat correctament. */


/* Exercici 18. (0,25 punts)
Crea un índex anomenat soci_idx sobre el camp cognoms de la taula soci i comprova que
s’ha creat correctament.
*/

CREATE INDEX soci_idx
ON soci(cognoms);

/* A la carpeta indexes del datagrip dins de soci podem veure que s'ha creat correctament. */


/* Exercici 19. (0,75 punt)
Actualitza el codi del llibre amb idllibre igual a 2121213. El nou codi és 3121213. Si no es
pot modificar explica perquè i realitza els canvis que siguin necessaris a l‘estructura de les
taules perquè aquest valor es pugui actualitzar. Comprova que realment s'ha pogut actualitzar. */

BEGIN;

UPDATE llibre SET idllibre=3121213 WHERE idllibre=2121213;

SELECT * FROM llibre

/* Si m ha deixat modificarlo, i amb el select ho podem confirmar. */


/* Exercici 20. (1,5 punts)
Exercici de transaccions. Suposem que inicialment la taula llibre esta buida. Tenint en
compte les següents sentències respon les preguntes: */

/* a) La taula tindra una fila, amb els valors que li acabem de introduir. */

/* b) Tornarà a haver-hi la columna que hem creat previament, ja que hem fet rollback.*/

/* c) La taula té la columna que li acaben de introduir. Ja que li hem tornat a introduir
una fila i ho hem fet amb COMMIT; */

/* d) Tornarà a haver-hi la columna que hem creat previament, ja que hem fet rollback.*/

/* e) La taula tindrà les dos columnes que li acabem de introduir. */

/* f) Estarà en el mateix estat que en el e), ja que em fet un rollback al SAVEPOINT que hem ficat en aquell pas. */

/* g) La taula haurà cambiat el nom de el llibre que te el isbn=12345680. */

/* h) En el mateix, ja que no es pot fer ROLLBACK un cop has fet COMMIT. */