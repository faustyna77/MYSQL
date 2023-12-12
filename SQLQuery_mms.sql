CREATE DATABASE Biblioteka_skrypt56
GO

USE Biblioteka_skrypt56
GO

CREATE TABLE Czytelnicy(
ID_czytelnika smallint PRIMARY KEY IDENTITY(1,1),
Imie varchar(20) NOT NULL,
Nazwisko varchar(50) NOT NULL,
Kod_pocztowy varchar(6) NOT NULL,
Miejscowosc varchar(50) NOT NULL,
Adres varchar(50) NOT NULL,
);

CREATE TABLE Dzialy(
ID_dzialu smallint PRIMARY KEY IDENTITY(1,1),
Nazwa varchar(10) NOT NULL
);

CREATE TABLE Ksiazki(
ID_ksiazki smallint PRIMARY KEY,
Tytul varchar(100) NOT NULL,
Autor varchar(50) NOT NULL,
Wydawca varchar(50),
Rok_wydania char(4),
Cena real,
Dzial smallint FOREIGN KEY REFERENCES Dzialy
);

CREATE TABLE Wypozyczenia(
ID_czytelnika smallint NOT NULL	FOREIGN KEY REFERENCES Czytelnicy,
ID_kziazki smallint NOT NULL FOREIGN KEY REFERENCES Ksiazki,
DataWyp date NOT NULL DEFAULT GETDATE(),
ZwrotDo date NOT NULL DEFAULT GETDATE()+60
);


ALTER TABLE Dzialy 
ALTER COLUMN Nazwa varchar(20) NOT NULL 

ALTER TABLE Wypozyczenia 
ADD ID_Wypozyczenia smallint PRIMARY KEY IDENTITY(1,1);


ALTER TABLE Wypozyczenia
ADD Data_zwrotu Date; 

INSERT INTO Czytelnicy
VALUES	('Adam', 'Abacki','11-111', 'Adamów', 'Asnyka 1'),
		('Barbara', 'Be³z','22-222', 'Bemów', 'Bia³a 2'),
		('Czes³aw', 'Czy¿','33-333', 'Celestów', 'Czarna 3'),
		('Danuta', 'Domin','44-444', 'Dynów', 'D³uga 4'),
		('Eryk', 'Eberbach','55-555', 'E³k', 'Edukacji 1');

INSERT INTO Dzialy (Nazwa)
VALUES ('Matematyka'),
('Elektrotechnika'),
('Informatyka'),
('Literatura');

INSERT INTO Ksiazki (ID_ksiazki,Tytul,Autor,Wydawca,Rok_wydania,Cena,Dzial)
VALUES	(6, 'Matematyka', 'Jan Kowalski', 'WNT','2016', 23, 1),
		(7, 'PHP', 'Marian Nowak', 'Helion','2013', 37, 2),
		(8, 'Bazy danych', 'Henryk Fic', 'Helion','2014', 85, 3),
		(9, 'Pan Tedeusz', 'Adam Mickiewicz', 'Czytelnik', '1995', 12, 1),
		(10, 'Dziady', 'Adam Mickiewicz', 'Arkady','2001', 8, 1),
		(11, 'Programowanie', 'Anna Skibiñska', 'Mikom', '2010', 74, 1),
		(12, 'Sieci komputerowe', 'Wojciech Bis', 'Helion','2012', 20, 1),
		(13, 'Analiza matemtyczna', 'Maria Siwy', 'PWN','2008', 30, 1),
		(14, 'Sztuczna inteligencka', 'Adam Lis', 'WNT','2016', 50, 2),
		(15, 'Lot æmy', 'Fryderyk Forsyth', 'Limba','2015', 33, 2);
		

INSERT INTO Wypozyczenia (ID_Czytelnika, ID_kziazki, DataWyp, ZwrotDo, Data_Zwrotu)
VALUES	(1, 10, '2017-02-15', '2017-03-15', '2017-03-10'),
		(2, 9, '2017-02-05', '2017-03-05', '2017-03-01'),
		(3, 8, '2017-01-15', '2017-02-15', '2017-02-10'),
		(4, 15, '2017-01-15', '2017-02-15', '2017-02-10'),
		(5, 12, '2018-01-15', '2018-02-15', '2018-01-31'),
		(2, 8, '2018-01-15', '2018-02-15', '2018-02-10'),
		(3, 15, '2018-01-15', '2018-02-15', '2018-02-10'),
		(1, 12, '2018-01-15', '2018-02-15', '2018-01-31');


		 

/* 4.1 */
SELECT *
FROM Ksi¹¿ki;
 
 
-- 4.2
SELECT Autor, Tytu³
FROM Ksi¹¿ki;

/* 4.3 */
SELECT *
FROM Czytelnicy;

/* 4.4 */
SELECT Nazwisko, Imie, Kod_Pocztowy, Miejscowoœæ, Adres
FROM Czytelnicy
ORDER BY Nazwisko, Imie

/* 4.5 */
SELECT Autor, Tytu³, Wydawnictwo, Rok_Wydania
FROM Ksi¹¿ki
ORDER BY Rok_Wydania DESC

/* 4.6 */
SELECT *
FROM Ksi¹¿ki
WHERE Rok_wydania >= 2000

/* 4.7 */
SELECT *
FROM Ksi¹¿ki
WHERE Rok_wydania BETWEEN 2010 AND 2013

SELECT *
FROM Ksi¹¿ki
WHERE Rok_wydania >= 2010 AND Rok_wydania <=2013

/* 4.8 */
SELECT *
FROM Wypo¿yczenia

/*--------------------------------------------------------------------------------------*/

-- 5.1
SELECT Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Dzia³y.Nazwa
FROM Ksi¹¿ki, Dzia³y
WHERE Ksi¹¿ki.Dzia³ = Dzia³y.Id_dzia³u 
ORDER BY Ksi¹¿ki.Autor

	-- 5.1a   ksi¹¿ki uporz¹dkowane dzia³ami
	SELECT Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Dzia³y.Nazwa
	FROM Ksi¹¿ki, Dzia³y
	WHERE Ksi¹¿ki.Dzia³ = Dzia³y.Id_dzia³u
	ORDER BY Dzia³y.Nazwa

	-- 5.1b Odp na pytanie  - lista wszystkich ksi¹¿ek z przypisaniem do dzia³ów i tych nieprzypisanych 
	SELECT Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Dzia³y.Nazwa 
	FROM Ksi¹¿ki LEFT JOIN Dzia³y
	ON Ksi¹¿ki.Dzia³ = Dzia³y.ID_Dzia³u
	ORDER BY Dzia³y.Nazwa


-- 5.2 
SELECT Czytelnicy.Nazwisko, Czytelnicy.Imiê, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³
FROM Ksi¹¿ki, Czytelnicy, Wypo¿yczenia
WHERE Wypo¿yczenia.ID_czytelnika=Czytelnicy.ID_czytelnika and 	Wypo¿yczenia.ID_ksi¹¿ki=Ksi¹¿ki.ID_Ksi¹¿ki;

	-- 5.2a
	SELECT Cz.Nazwisko, Cz.Imiê, K.Autor, K.Tytu³
	FROM Ksi¹¿ki K, Czytelnicy Cz, Wypo¿yczenia W
	WHERE W.ID_Ksi¹¿ki=K.Id_Ksi¹¿ki AND W.ID_Czytelnika=Cz.ID_Czytelnika 

-- 5.3
SELECT Czytelnicy.Nazwisko, Czytelnicy.Imie, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³
FROM Ksi¹¿ki, Czytelnicy, Wypo¿yczenia
WHERE Wypo¿yczenia.ID_Ksi¹¿ki=Ksi¹¿ki.Id_Ksi¹¿ki AND Wypo¿yczenia.ID_Czytelnika=Czytelnicy.ID_Czytelnika 
ORDER BY Czytelnicy.Nazwisko, Czytelnicy.Imie


-- 5.4 
SELECT Czytelnicy.Nazwisko, Czytelnicy.Imie, 
	   Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, 
	   Wypo¿yczenia.ID_Wypo¿yczenia, Wypo¿yczenia.DataZwrotu
FROM Ksi¹¿ki, Czytelnicy, Wypo¿yczenia
WHERE Wypo¿yczenia.ID_Ksi¹¿ki=Ksi¹¿ki.Id_Ksi¹¿ki 
  AND Wypo¿yczenia.ID_Czytelnika=Czytelnicy.ID_Czytelnika 
ORDER BY Czytelnicy.Nazwisko, Czytelnicy.Imie


	-- 5.5a Lista ksi¹¿ek nie oddanych
	SELECT Czytelnicy.Nazwisko, Czytelnicy.Imie, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Wypo¿yczenia.ZwrotDO, Wypo¿yczenia.DataZwrotu
	FROM Ksi¹¿ki, Czytelnicy, Wypo¿yczenia
	WHERE Wypo¿yczenia.ID_Ksi¹¿ki=Ksi¹¿ki.Id_Ksi¹¿ki 
		AND Wypo¿yczenia.ID_Czytelnika=Czytelnicy.ID_Czytelnika  
		AND Wypo¿yczenia.DataZwrotu IS NULL;

-- 5.5 Lista ksi¹¿ek przeterminowanych
SELECT Czytelnicy.Nazwisko, Czytelnicy.Imiê, 
	   Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, 
	   Wypo¿yczenia.ID_Wypo¿yczenia, Wypo¿yczenia.ZwrotDO
FROM Ksi¹¿ki, Czytelnicy, Wypo¿yczenia
WHERE Wypo¿yczenia.ID_Ksi¹¿ki=Ksi¹¿ki.Id_Ksi¹¿ki 
	AND Wypo¿yczenia.ID_Czytelnika=Czytelnicy.ID_Czytelnika  
	AND Wypo¿yczenia.Data_zwrotu IS NULL
	AND Wypo¿yczenia.ZwrotDO < GETDATE()


-- 5.6 
SELECT ID_Czytelnika, COUNT(*) AS LiczbaKsi¹¿ek
FROM Wypo¿yczenia
GROUP BY ID_Czytelnika


-- 5.7a z nazwiskami
SELECT	Czytelnicy.Nazwisko, Czytelnicy.Imiê, 
		Wypo¿yczenia.ID_czytelnika,  
		COUNT(*) AS Lb_Po¿yczonych
FROM Wypo¿yczenia, Czytelnicy
WHERE Czytelnicy.ID_Czytelnika = Wypo¿yczenia.ID_czytelnika 
     AND Wypo¿yczenia.Data_Zwrotu IS NULL
GROUP BY	Wypo¿yczenia.ID_Czytelnika, 
			Czytelnicy.Nazwisko, 
			Czytelnicy.Imiê



-- 5.12
SELECT Czytelnicy.Nazwisko, Czytelnicy.Imiê, 
		Wypo¿yczenia.ID_czytelnika,  COUNT(*) AS Lb_Po¿yczonych
FROM Wypo¿yczenia, Czytelnicy
WHERE Czytelnicy.ID_Czytelnika = Wypo¿yczenia.ID_czytelnika 
AND Wypo¿yczenia.Data_zwrotu IS NULL
GROUP BY Wypo¿yczenia.ID_Czytelnika, Czytelnicy.Nazwisko, Czytelnicy.Imiê

/* 5.13  Czytelnicy, którzy po¿yczyli ksi¹¿ki na literê B i podany tytu³ tej ksi¹¿ki */
SELECT Czytelnicy.ID_Czytelnika, Czytelnicy.Nazwisko, Czytelnicy.Imiê, Ksi¹¿ki.Tytu³
FROM Czytelnicy, Ksi¹¿ki, Wypo¿yczenia
WHERE Czytelnicy.ID_Czytelnika=Wypo¿yczenia.ID_Czytelnika 
AND Ksi¹¿ki.ID_Ksi¹¿ki=Wypo¿yczenia.ID_Ksi¹¿ki 
AND Ksi¹¿ki.Tytu³ LIKE 'B%'

-- 5.14 
/* Najni¿sza cena ksi¹¿ki */
SELECT MIN(Ksi¹¿ki.Cena)
FROM Ksi¹¿ki




/*--------------------------------------------------------------------------------------*/

/* Podzapytania */
-- 6.1 
SELECT Tytu³
FROM Ksi¹¿ki
WHERE Dzia³ =  (SELECT ID_Dzia³u
				FROM Dzia³y
				WHERE Nazwa = 'Informatyka');


/* 6.2 */
SELECT *
FROM Czytelnicy
WHERE ID_Czytelnika = ANY (SELECT ID_Czytelnika
						  FROM Wypo¿yczenia);




/* 6.3 */
SELECT *
FROM Czytelnicy
WHERE ID_Czytelnika <> ALL (SELECT ID_Czytelnika
						  FROM Wypo¿yczenia);



/* 6.4. lub lista czytelników, którzy nigdy nie pozyczyli ksi¹¿ki */
SELECT *
FROM Czytelnicy
WHERE ID_Czytelnika NOT IN (SELECT ID_Czytelnika
						  FROM Wypo¿yczenia)
						  

/* 6.5. Ksi¹¿ki nigdy nie wypozyczone */
SELECT Ksi¹¿ki.ID_Ksi¹¿ki, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³ 
FROM Ksi¹¿ki
WHERE ID_Ksi¹¿ki NOT IN (SELECT ID_Ksi¹¿ki
					 FROM Wypo¿yczenia)

/* 6.6. Ksi¹¿ki dostepne do wypo¿yczenia*/

SELECT Ksi¹¿ki.ID_Ksi¹¿ki, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³ 
FROM Ksi¹¿ki
WHERE ID_Ksi¹¿ki IN (SELECT ID_Ksi¹¿ki
					 FROM Wypo¿yczenia
					 WHERE Wypo¿yczenia.Data_zwrotu IS NOT NULL)  
AND ID_Ksi¹¿ki NOT IN (SELECT ID_Ksi¹¿ki
					 FROM Wypo¿yczenia
					 WHERE Wypo¿yczenia.Data_zwrotu IS NULL ) 
OR ID_Ksi¹¿ki NOT IN (SELECT ID_Ksi¹¿ki
					 FROM Wypo¿yczenia)

/* 6.7. ksi¹¿ka o najni¿szej cenie   */ 
SELECT Ksi¹¿ki.ID_Ksi¹¿ki, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Ksi¹¿ki.cena
FROM Ksi¹¿ki
WHERE Ksi¹¿ki.Cena = (SELECT Min(Ksi¹¿ki.cena) 
					FROM Ksi¹¿ki)

SELECT Ksi¹¿ki.ID_Ksi¹¿ki, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³, Min(Ksi¹¿ki.cena)
FROM Ksi¹¿ki
GROUP BY Ksi¹¿ki.Cena, Ksi¹¿ki.ID_Ksi¹¿ki, Ksi¹¿ki.Autor, Ksi¹¿ki.Tytu³
HAVING Ksi¹¿ki.Cena =  Min(Ksi¹¿ki.cena)
ORDER BY Ksi¹¿ki.Cena




/* 6.8 */
SELECT *
FROM Czytelnicy
WHERE Id_Czytelnika IN (SELECT ID_Czytelnika
					    FROM Wypo¿yczenia
						WHERE ID_Ksi¹¿ki IN (SELECT ID_Ksi¹¿ki
											 FROM Ksi¹¿ki
											 WHERE Tytu³ LIKE 'B%'));
					 





			 

SELECT *
FROM Czytelnicy
WHERE Id_Czytelnika
		IN (SELECT Id_Czytelnika
	FROM Wypo¿yczenia
	WHERE Id_Ksi¹¿ki
			IN (SELECT Id_Ksi¹¿ki
		FROM Ksi¹¿ki
		WHERE Tytu³ LIKE'B%'));









