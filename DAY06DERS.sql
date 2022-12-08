--INNER JOIN
CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota');  
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford'); 
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int, 
sirket_id int,  
siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '2020-04-17'); 
INSERT INTO siparisler VALUES(22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES(33, 103, '2020-04-19');  
INSERT INTO siparisler VALUES(44, 104, '2020-04-20'); 
INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

select * from sirketler
select * from siparisler


--SORU1: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

/*
 NOT :
1) Left Join’de ilk tablodaki tum record’lar gosterilir.
2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
ortak olmayan datalar icin o kisimlar bos kalir
3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
 */
 /*
	NOT :
	1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
	2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
	3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
 */
 
-- LEFT JOIN
--SORU1: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM siparisler LEFT JOIN sirketler 
ON sirketler.sirket_id=siparisler.sirket_id
 
--RIGHT JOIN

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler RIGHT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--ornek INTERSECT
SELECT sirket_id FROM sirketler 
INTERSECT
SELECT sirket_id FROM siparisler


FULL JOIN
 /*
	NOT :
	1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
	2) Bir tabloda olup otekinde olmayan data’lar bos kalir
	
	INNER KESİŞİMİ VERİR
	LENF SOL TARAFI VERİR
	RIGHT SAĞ TARAFI VERİR
	FULL HEPSİNİ VERİR

*/
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler FULL JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id

--SELF JOINS
CREATE TABLE personel3  (
id int,
isim varchar(20),  
title varchar(60),  yonetici_id int
);
INSERT INTO personel3 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel3 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel3 VALUES(3, 'Ayse Gul', 'QA Lead', 4);  
INSERT INTO personel3 VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel3

--SORU:Her personelin yanina yonetici ismini yazdiran bir tablo olusturun

SELECT isim FROM personel3

SELECT p1.isim AS personel_isim,p2.isim AS yonetici_isim  
FROM personel3 p1 INNER JOIN personel3 p2 ON p1.yonetici_id=p2.id


-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/
CREATE TABLE musteriler3  (
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);

INSERT INTO musteriler3 (id, isim, gelir) VALUES (1001, 'Ali', 62000);  
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1004, 'Fatma', 42000);  
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1006, 'ahmet', 82000);  
INSERT INTO musteriler3 (id, isim, gelir) VALUES (1007, 'erhan', 92000);
SELECT * FROM musteriler3

-- 1) % => 0 veya birden fazla karakter belirtir
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin

/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz .Eğer büyük küçük harf gözetmeksizin kullanmak 
istersek ~~* sembollerini kullanırız
*/
SELECT * FROM musteriler3 WHERE isim ILIKE 'A%'
SELECT * FROM musteriler3 WHERE isim ~~* 'A%'

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler3 WHERE isim ~~'%e'

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler3 WHERE isim ILIKE'%er%'

--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler3 WHERE isim ~~'_atma'

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler3 WHERE isim LIKE '_a%'

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler3 WHERE isim LIKE '__s%'

- LIKE Condition
/*
	3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
*/

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) 
NOT NULL, 
Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 8);  

--SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran
--       QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* 'h[ai]t' 

 -- * BUYUK KUCUK Hrf gözzetmeksizin getirir

--SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan
--3 harfli kelimelerin  tum bilgilerini  yazdiran QUERY yazin

SELECT * FROM kelimeler WHERE kelime ~* 'h[a-k]t'

--SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '^[as]'

--   ^   -->baslayan demektir

--SORU : m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~* '[mf]$'

--UPPER - LOWER -- INITCAP
-- Kelimeler tablosundaki kelime sütunundaki verileri önce hepsini büyük harf, sonra küçük harf ve ilk harfleri
-- büyük olucak şekilde yazdıralım
 SELECT UPPER(kelime)  as kelime FROM kelimeler
SELECT LOWER(kelime)  as kelime FROM kelimeler
SELECT INITCAP(kelime) as kelime FROM kelimeler --INITCAP İSTEDİĞİMİZ SUTUNDAKİ VERİLERİN İLK HARFİNİ BUYUK YAZAR
 -- Musteriler tablosundan  butun isimleri buyuk harf yapiniz
 SELECT UPPER(isim) FROM musteriler 
/*
Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
select lower(title),UPPER(isim) from personel şekilde yapabiliriz
*/
select lower(title),UPPER(isim) from personel