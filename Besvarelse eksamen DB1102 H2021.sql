/*a) Lag en spørring som gir informasjon om hvilken av de registrerte kommunene som har størst innbyggertall, og hva denne kommunen heter.*/
SELECT navn, MAX(innbyggertall) AS innbyggertall
FROM kommune
ORDER BY innbyggertall DESC;

/*b) Lag en spørring som gir informasjon om hvilke registrerte spillere som bor i en kommune som heter Herøy.*/
SELECT s.navn, k.navn
FROM spiller AS s LEFT JOIN kommune AS k 
ON s.kommuneid = k.kommuneid
where k.navn = "Herøy";

/*c) Lag en spørring som gir navn på alle registrerte kommuner som har samme navn, men ligger i forskjellige fylker.*/
SELECT navn, COUNT(navn) AS antallKommuner
FROM kommune
GROUP BY navn
HAVING COUNT(fylke) > 1;

/*d) Lag en spørring som viser hvor mange registrerte kommuner som har en liten 'u' i navnet sitt. Navngi kolonnen i svaret: Antall U-Kommuner.
Kommentar: Får ikke kjørt spørring med ønsket navn, nytt navn blir Antall_U_Kommuner.
*/
SELECT navn AS Antall_U_Kommuner
FROM kommune
WHERE navn LIKE "%u%";

/*e) Lag en spørring som viser hvilket fylke som samlet sett har hatt flest premievinnere til nå. Resultatet skal vise fylket, og antall vinnere. Hvis noen har vunnet flere ganger, så skal de telles for hver gang de vinner.*/
SELECT k.navn, k.kommuneid, count(v.spillernr) AS totalVinn
FROM kommune AS k LEFT JOIN spiller as s 
ON k.kommuneid = s.kommuneid 
LEFT JOIN vinner AS v
ON s.spillernr = v.spillernr
GROUP BY k.kommuneid
HAVING MAX(v.spillernr)
ORDER BY totalVinn DESC;

/*f) Lag en spørring som viser hvilke trekninger som ikke har hatt noen vinnere. Resultatet skal vise trekningens dato, og navnet på hvem som var trekningsansvarlig.*/
SELECT dato, ansattid
FROM trekning
WHERE utbetaling = 0;

/*g) Lag en spørring som viser navn på spillere har vunnet flere enn en gang, hvor mange ganger de har vunnet, og hvilken kommune de bor i.
Kommentar: Uklart beskrevet, men mener du "...spillere som har vunnet flere..."? 
Jeg kommer å løse oppgaven hvor det er spillere som har vunnet mer en kun en gang. 
*/
SELECT s.navn, COUNT(v.spillernr) AS antallVinn, k.navn AS kommune
FROM spiller as s LEFT JOIN vinner AS v
ON s.spillernr = v.spillernr
LEFT JOIN kommune AS k
ON s.kommuneid = k.kommuneid
GROUP BY s.navn
HAVING COUNT(v.spillernr) > 1;

/*h) Legg inn en ny kolonne Areal i kommunetabellen. 
Legg inn fornuftige verdier i den nye kolonnen for de eksisterende kommunene. 
Velg datatype du selv mener er passende. Arealet skal oppgis i antall kvadratkilometer, med to desimaler.*/
ALTER TABLE kommune
ADD km2 int;

UPDATE kommune SET km2 = 454 WHERE navn = "oslo";
UPDATE kommune SET km2 = 433 WHERE navn = "Eigersund";
UPDATE kommune SET km2 = 71 WHERE navn = "Stavanger";
UPDATE kommune SET km2 = 73 WHERE navn = "Haugesund";
UPDATE kommune SET km2 = 632 WHERE navn = "Ålesund";
UPDATE kommune SET km2 = 120 WHERE navn = "Herøy";
UPDATE kommune SET km2 = 64 WHERE navn = "Herøy";
UPDATE kommune SET km2 = 705 WHERE navn = "Våler";
UPDATE kommune SET km2 = 196 WHERE navn = "Nordre Follo";
UPDATE kommune SET km2 = 257 WHERE navn = "Våler";
UPDATE kommune SET km2 = 1229 WHERE navn = "Elverum";

SELECT * FROM kommune;

/*i) Det har vært en ny trekning. Legg inn følgende informasjon i databasen: Trekningen ble avholdt 4. desember 2021. Det var nøyaktig 11 millioner i utbetaling. 
Det var en ny trekningsansvarlig: Jens Jensen, som bor i Oslo. Det var to vinnere som delte utbetalingen: Lars Andersen, som bor i Ålesund (Lilliveien 56) og Line Jensen som bor på Elverum (Blåklokkaleen 4).*/
INSERT INTO ansatt (ansattid, navn, kommuneID)
VALUE (3, "Jens Jensen", "0301");
SELECT * FROM ansatt;
 
INSERT INTO trekning (trekningsid, dato, utbetaling, ansattid)
VALUE (5 , "2021-12-4" , 11000000, 3);
SELECT * FROM trekning;

INSERT INTO spiller (spillernr, navn, adresse, kommuneid) 
VALUE (14, "Lars Andersen", "Lilliveien 56", "1507");
INSERT INTO vinner (spillernr, trekningsid)
VALUE (14 ,5);

INSERT INTO spiller (spillernr, navn, adresse, kommuneid) 
VALUE (15, "Line Jensen", "Blåklokkaleen 4", "3420");
INSERT INTO vinner (spillernr, trekningsid)
VALUE (15 ,5);

SELECT * FROM spiller;
SELECT * FROM vinner;

/*j) (Vanskelig) Lag et view som viser hvilke fylker som har vunnet hvor mye penger. 
Viewet skal inneholde fylkets navn, og totale utbetalinger til fylkets spillere, sortert slik at fylket som har vunnet mest kommer først.*/

SELECT f.navn 
FROM fylke
JOIN kommune as k 
	ON f.fylkeid = k.fylke
JOIN spiller as s 
	ON k.kommuneid = s.kommuneid
JOIN vinner as v 
	ON s.spillernr = v.spillernr
JOIN trekning as t
	ON v.trekningsid = t.trekningsid
	
GROUP BY f.fylkeid
HAVING trekningsID ;

SELECT navn, SUM(totalSUM) AS totalVinn
FROM fylke
GROUP BY navn;

SELECT v.spillernr, v.trekningsid
FROM vinner as v LEFT JOIN trekning AS t ON v.trekningsid = t.trekningsid
GROUP BY v.spillernr
HAVING v.trekningsid * t.utbetaling = test;


    SELECT trekningsid, utbetaling FROM trekning;




SELECT * FROM fylke;
SELECT * FROM kommune;
SELECT * FROM spiller;
SELECT * FROM ansatt;
SELECT * FROM trekning;
SELECT * FROM vinner;







