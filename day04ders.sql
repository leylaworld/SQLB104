--ALIASES
drop table if exists calisanlar4
CREATE TABLE calisanlar4  (
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50)
);
INSERT INTO calisanlar4 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar4 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar4 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar4
-- Eğer iki sutunun verilerini birleştirmek istersek concat sembolu || kullanırız
SELECT calisan_id AS id, calisan_isim||' '||calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar4
--2. YOl
SELECT calisan_id AS id, concat (calisan_isim,calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar4
--veya
--second way
SELECT calisan_id AS id, calisan_isim || ' ' || calisan_dogdugu_sehir AS calisan_bilgisi FROM calisanlar4

--IS NULL CONDITION
CREATE TABLE insanlar1
(
ssn char(9),
name varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar1 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar1 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar1 VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar1 (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar1 (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar1
--Name sutununda null olan değerleri listeleyelim

SELECT name FROM insanlar1 WHERE IS NULL

--İnsanlar tablosunda sadece null olmayan değerleri listeleyiniz
SELECT name FROM insanlar1 WHERE IS NOT NULL

--Insanlar tablosunda null değer almış verileri no name olarak değiştiriniz

UPDATE insanlar1
SET name='No Name'
WHERE name is null;

--ORDER BY CLAUSE
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe yada küçükten büyüğe sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar ASC(eskendig)
Eğer BÜYÜKTEN KÜÇÜĞE sıralmak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/
/*
	ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama
	yapmak icin kullanilir
	ORDER BY komutu sadece SELECT komutu Ile kullanilir
*/

CREATE TABLE insanlar3
(
ssn char(9),
isim varchar(50),
soyisim varchar(50),  
adres varchar(50)
);
INSERT INTO insanlar3 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar3 VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar3 VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar3 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar3 VALUES (344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar3 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar3

--Insanlar tablosundaki datalari adres’e gore siralayin ---(ascending  ascend  X descend)
SELECT * FROM insanlar3 ORDER BY adres;

SELECT * FROM insanlar3 ORDER BY soyisim;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin

SELECT * FROM insanlar3 WHERE isim='Mine' ORDER BY ssn

--NOT : Order By komutundan sonra field ismi yerine field(SUTUN) numarasi da kullanilabilir

--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin

SELECT * FROM insanlar3 WHERE soyisim='Bulut' ORDER BY 4
--İSME GÖRE İSTERSEK
SELECT * FROM insanlar3 WHERE soyisim='Bulut' ORDER BY 2

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin

SELECT * FROM insanlar3 ORDER BY ssn DESC --(DESC BUYUKTEN KUCUGE SIRALAR)

-- Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
SELECT * FROM insanlar3 ORDER BY isim ASC, soyisim DESC;

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eger sutun uzunluguna göre sıralamak istersek LENGTH komutu kullanırız
ve yine uzunlugu buyukten kucuge sıralamak istersek sonuna DESC komutunu ekleriz
*/
SELECT isim,soyisim FROM insanlar3 ORDER BY LENGTH (soyisim) DESC;

-- Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar3 ORDER BY LENGTH (isim||soyisim) 

SELECT isim||' '||soyisim AS isim_soyisim FROM insanlar3 ORDER BY LENGTH (isim)+LENGTH (soyisim) 

SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar3 ORDER BY LENGTH (isim)+LENGTH (soyisim) 

SELECT CONCAT(isim,' ',soyisim) AS isim_soyisim FROM insanlar3 ORDER BY LENGTH (concat(isim,soyisim))

__GROUP BY CLAUSE

/*
Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT
komutuyla birlikte kullanılır.
*/
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);
INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

SELECT * FROM manav

--Isme gore alinan toplam urunleri  listeleyiniz

SELECT isim,sum(urun_miktar) AS aldıgı_toplam_urun FROM manav
GROUP BY isim;

--Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz

SELECT isim,sum(urun_miktar) AS aldığı_toplam_urun FROM manav
GROUP BY isim
ORDER BY aldığı_toplam_urun DESC;

-- Urun ismine gore urunu alan toplam kisi sayisi

SELECT urun_adi,count(isim) FROM manav
GROUP BY urun_adi;

SELECT isim ,count(urun_adi) FROM manav
GROUP BY isim;

SELECT isim ,count(urun_adi) AS aldıgı_urun_cesidi FROM manav
GROUP BY isim;














