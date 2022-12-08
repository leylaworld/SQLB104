--GROOUP BY
CREATE TABLE personel
(
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

delete from personel
SELECT * FROM personel;

1)Isme gore toplam maaslari bulun

SELECT isim,sum(maas) FROM personel
GROUP BY isim

-- personel tablosundaki isimleri gruplayınız
SELECT isim  FROM personel
GROUP BY isim

--sehre göre toplam personel sayısını bulunuz
SELECT isim ,count(sehir) AS calisan_sayisi
FROM personel
GROUP BY isim

---Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun

--HAVING CLAUSE
-- HAVING, AGGREGATE FUNCTION’lar ile birlikte kullanilan FILTRELEME komutudur.
/*
Havıng komutu yanlızca group by komutu ile kullanılır 
Eger gruplamadan sonra bir şart varsa Havıng komutu kullanılır
Where kullanımı ile aynı mantıkta çalışır
*/
--1) Her sirketin MIN maaslarini eger 4000’den buyukse goster

SELECT * FROM personel

SELECT sirket,min(maas) as en_dusuk_maas FROM personel
GROUP BY sirket
HAVING min(maas)>4000

-- 2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi
-- ve toplam maasi gosteren sorgu yaziniz

SELECT isim, SUM(maas) AS toplam_maas FROM personel
GROUP BY isim
HAVING SUM(maas)>10000


-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir,count(isim)  as toplam_personel_sayisi from personel
GROUP BY sehir
HAVING count(isim)>1

-- 4) Eger bir sehirde alinan MAX maas 5000’den dusukse
-- sehir ismini ve MAX maasi veren sorgu yaziniz
SELECT sehir ,max(maas) AS en_yuksek_maas FROM personel
GROuP BY sehir
HAVING max(maas)<5000

--UNION OPERATOR
--İKİ FARKLI UYGULAMANIN SONUCUNU BİRLEŞTİREN İŞLEMDİR. SECİLEN FİELD SAYISI VE DATA TYPE İ AYNI OLMALIDIR

-- 1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan
-- sehirleri gosteren sorguyu yaziniz

SELECT isim AS isim_ve_sehirler,maas FROM personel WHERE maas>4000
UNION
SELECT sehir,maas FROM personel WHERE maas>5000

-- 2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini
-- bir tabloda gosteren sorgu yaziniz

SELECT isim AS isim_ve_sehir, maas FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir, maas FROM personel WHERE sehir='Istanbul'
ORDER BY maas DESC

--Sonuna ORDER BY koyarsak istediğimiz seye göre sıralar order by buyukten küçüğe sıralar
--DESC yazarsak kuçukten buyuge sıralar

-- 								UNION OPERATOR
-- 						2 Tablodan Data Birlestirme

CREATE TABLE personel2
(
id int,
isim varchar(50),  
sehir varchar(50), 
maas int,  
sirket varchar(20),

CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel2 VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel2 VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel2 VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel2 VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel2 VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel2 VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel2 VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel2

CREATE TABLE personel_bilgi3  (
id int,
tel char(10) UNIQUE ,  
cocuk_sayisi int,
CONSTRAINT personel_bilgi3_fk FOREIGN KEY (id) REFERENCES personel2(id)
);
INSERT INTO personel_bilgi3 VALUES(123456789, '5302345678', 5);  
INSERT INTO personel_bilgi3 VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi3 VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi3 VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi3 VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi3 VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi3 VALUES(123456710, '5537488585', 1);

SELECT * FROM personel_bilgi3
SELECT * FROM personel2

-- id’si 123456789 olan personelin    Personel tablosundan sehir ve maasini, 
-- personel_bilgi  tablosundan da tel ve cocuk sayisini yazdirin

SELECT sehir AS sehir_ve_tel,maas AS maas_ve_cocuk_sayisi FROM personel2 WHERE id=123456789
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi3 WHERE id=123456789

--UNION ALL
/*
UNION TEKRARLI VERİLERİ TEKE DÜŞÜRÜR VE BİZE O ŞEKİLDE SONUÇ VERİR 
UNİON ALL İSE TEKRARLI VERİLERLE BİRLİKTE TÜM SORGULARI GETİRİR
*/

/*UNION islemi 2 veya daha cok SELECT isleminin sonuc KUMELERINI birlestirmek icin kullanilir,
Ayni kayit birden fazla olursa, sadece bir tanesini alir. UNION ALL ise tekrarli elemanlari, tekrar sayisinca yazar.*/

--NOT : Union islemi yaparken 1)Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali 
--2)Alt alta gelecek sutunlarin data type’lari ayni olmali-


--SORU:Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz
SELECT isim,maas FROM personel2 WHERE maas<5000
UNION 
SELECT isim,maas FROM personel2 WHERE maas<5000
-- VERSİYON
SELECT isim,maas FROM personel2 WHERE maas<5000
UNION ALL
SELECT isim,maas FROM personel2 WHERE maas<5000


--INTERSECT OPERATOR----(KESİŞİM)
--SQL INTERSECT operatörü, 2 veya daha fazla SELECT ifadesinin sonuçlarını döndürmek için kullanılır. 
--Ancak, yalnızca tüm sorgular veya veri kümeleri tarafından seçilen satırları döndürür. 
--Bir sorguda bir kayıt varsa ve diğerinde yoksa, INTERSECT sonuçlarından çıkarılacaktır.

/*
Farklı iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz
*/
--Personel tablosundan Istanbul veya Ankara’da calisanlarin id’lerini yazdir
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
--Iki sorguyu INTERSECT ile birlestirin

SELECT id FROM personel2 WHERE sehir IN ('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi3 WHERE cocuk_sayisi IN(2,3)


-- Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT * FROM personel2

SELECT isim FROM personel2 WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel2 WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel2 WHERE sirket='Tofas'

--EXCEPT (MINIS)OPERATOR
/*
İKİ sorgulamada harici bir sorgulama istenirse EXCEPT komutu kullanılır
SQL EXCEPT yan tümcesi/operatörü, iki SELECT deyimini birleştirmek için kullanılır ve 
ilk SELECT deyiminden ikinci SELECT deyimi tarafından döndürülmeyen satırları döndürür. 
Bu, EXCEPT'in yalnızca ikinci SELECT deyiminde bulunmayan satırları döndürdüğü anlamına gelir.
UNION işlecinde olduğu gibi, EXCEPT işlecini kullanırken de aynı kurallar geçerlidir. 
MySQL, EXCEPT operatörünü desteklemiyor.
*/

--5000’den az maas alip Honda’da calismayanlari 
SELECT isim,sirket FROM personel WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel WHERE sirket='Honda'







