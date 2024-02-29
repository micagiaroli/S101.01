#N1.Exercici 2: Has d'obtenir el nom, email i país de cada companyia, ordena les dades en funció del nom de les companyies.
SELECT company_name, email, country
FROM company
ORDER BY company_name;

#N1.Exercici 3: llistat dels països que estan fent compres.
SELECT distinct country
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0;

#N1.Exercici 4: des de quants països es realitzen les compres
SELECT COUNT(DISTINCT country) AS 'Cantidad_paises'
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0;

#N1.Exercici 5: país i nom de companyia amb id = 'b-2354'.
SELECT country, company_name
FROM company
WHERE id = 'b-2354';

#N1.Exercici 6: quina és la companyia amb major despesa mitjana?
SELECT company_name, avg(amount) AS gasto_medio
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0
GROUP BY company_name
ORDER BY gasto_medio DESC
LIMIT 1;

## NIVELL 2
#N2.Exercici 1: verificar si en la base de dades existeixen companyies amb identificadors (id) duplicats.
SELECT id, company_name
FROM company
WHERE company_name IN (
	SELECT company_name
    FROM company
    GROUP BY company_name
    HAVING count(*)>1
    );
    
#N2.Exercici 2: En quin dia es van realitzar les cinc vendes més costoses? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT left(timestamp,10) as date, sum(amount) AS total_diario
FROM transaction
WHERE declined = 0
GROUP BY date
ORDER BY total_diario DESC
LIMIT 5;

#N2. Ecercici 3: En quin dia es van realitzar les cinc vendes de menor valor? Mostra la data de la transacció i la sumatòria de la quantitat de diners.
SELECT left(timestamp,10) as date, sum(amount) AS total_diario
FROM transaction
WHERE declined = 0
GROUP BY date
ORDER BY total_diario
LIMIT 5;

#N2. Exercici 4: Quina és la mitjana de despesa per país? Presenta els resultats ordenats de major a menor mitjà.
SELECT country, AVG(amount)
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0
GROUP BY country
ORDER BY AVG(amount) DESC;

## NIVELL 3
#N3.Exercici 1: Presenta el nom, telèfon i país de les companyies, juntament amb la quantitat total gastada, d'aquelles que van realitzar transaccions amb una despesa compresa entre 100 i 200 euros. Ordena els resultats de major a menor quantitat gastada.
SELECT company_name, phone, country, sum(amount) AS total_amount_company
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0
GROUP BY company_name, phone, country
HAVING SUM(amount) >= 100 AND SUM(amount) <= 200
ORDER BY SUM(amount) DESC;

#N3.Exercici 2: Indica el nom de les companyies que van fer compres el 16 de març del 2022, 28 de febrer del 2022 i 13 de febrer del 2022.
SELECT company_name, left(timestamp,10) as date
FROM company
INNER JOIN transaction 
ON company.id=transaction.company_id
WHERE declined = 0
HAVING date IN ("2022-03-16","2022-02-28","2022-02-13");




