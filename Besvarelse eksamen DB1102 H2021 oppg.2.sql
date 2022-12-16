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


SELECT * FROM fylke;
SELECT * FROM kommune;
SELECT * FROM spiller;
SELECT * FROM vinner;
