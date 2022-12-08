--DISTINCT
-- DISTINCT clause, çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT * FROM musteri_urun

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyini

--GROUP BY ÇÖZÜMÜ
select urun_isim FROM musteri_urun
group by urun_isim

-DISTINCT ÇÖZÜMÜ
SELECT DISTINCT(urun_isim) FROM musteri_urun;

-- Tabloda kac farkli meyve vardir ?
SELECT urun_isim,  count( urun_isim) FROM musteri_urun
GROUP BY urun_isim


SELECT urun_isim,  count(DISTINCT urun_isim) FROM musteri_urun
GROUP BY urun_isim  -- HERŞEYDEN BİRER TANE VERİR DISTINCT TEKRARSIZ

FETCH NEXT (SAYI) ROW ONLY-OFFSET-LIMIT

--Musteri urun tablosundan ilk üç kaydı listeleyiniz

--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id LIMIT 3

 
SELECT * FROM musteri_urun ORDER BY urun_id 
fetch next 3 row only

-- Musteri urun tablosundan ilk kaydi listeleyiniz.
SELECT * FROM musteri_urun ORDER BY urun_id 
limit 1

--Musteri urun tablosundan son üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY urun_id DESC
limit 3


CREATE TABLE maas
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

SELECT * FROM maas

--En yuksek maası alan musteriyi listeleyiniz

SELECT * FROM maas ORDER BY maas DESC 

--En yuksek ilk 2 maası alan musteriyi listeleyiniz
SELECT * FROM maas ORDER BY maas DESC 
limit 2

--Maas tablosundan en yuksek 2. maası listeleyiniz
SELECT * FROM maas ORDER BY maas DESC limit 1 offset 1
/*
OFFSET--> satır atlamak istediğimiz de offset komutunu kullanırız
*/

SELECT * FROM maas ORDER BY maas desc
offset 1 row
fetch next 1 row only

--maas tablosundan en düşük dördüncü maası listeleyiniz
select * from maas ORDER BY maas OFFSET 3 limit 1


/*
			DDL-		ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
drop table personel
CREATE TABLE personel1
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT persone1_pk PRIMARY KEY (id)
);


INSERT INTO personel1 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel1 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel1 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel1 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel1 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel1 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel1 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda')

SELECT * FROM personel1

--1) ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel1
ADD ulke varchar(30)

ALTER TABLE personel1
ADD zipcode varchar(30)

ALTER TABLE personel1
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak olusturdugumuz sutuna belirttigimiz veriyi tum satirlara girer

--2) DROP tablodan sutun silme

ALTER TABLE personel1
DROP COLUMN zipcode

ALTER TABLE personel1
DROP ulke, drop adres

--3)RENAME COLUMN sutun adi degistirme

ALTER TABLE personel1
RENAME COLUMN sehir TO il


--4)RENAME tablonun ismini degistirme
ALTER TABLE personel1
RENAME TO isci

SELECT * FROM isci

--5)TYPE/SET(modify) sutunlarin ozelliklerini degistirme
ALTER TABLE isci
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;

--eger numerik data tipine sahip bir sutunun data türüne string bir data türü atamak istersek 
--TYPE varchar (30) USING(maas::varchar(30)) bu formatı kullanırız
ALTER COLUMN maas 
TYPE varchar (30) USING(maas::varchar(30))

/*
			TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT
	Transaction veritabani sistemlerinde bir islem basladiginda baslar ve bitince sona erer. Bu
	islemler veritabani olusturma, veri silme, veri guncelleme, veriyi geri getirme gibi islemler olabilir.
	Transaction baslatmak için BEGIN komutu kullanmamız gerekir.
 */


CREATE TABLE ogrenciler1
(
id serial,   -- Serial data türü otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
	          --INSERT INTO ile tabloya veri eklerken serial data turunu kullandığım veri değeri yerine DEFAULT yazarız
	
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler1 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler1 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler1 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler1 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler1 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler1 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

SELECT * FROM ogrenciler1
delete from ogrenciler1
drop table ogrenciler1

/*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */

