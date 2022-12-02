
--DATABASE(Veritabanı) oluşturma
--Create dataBase leylayildiz;

create database ogrenciler;

--DDL -DATA DEFINITION LANG.
--CREATE -TABLO OLUŞTURMA
CREATE TABLE ogrenciler5
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --ondalıklı sayılar için kullanılır(double gibi)
kayit_tarih date
);

--VAROLAN TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE ogrenci_notlari1
AS --BENZER TABLODAKİ BAŞLIKLARLA VE DATA TİPLERİ İLE YENİ BİR TABLO OLŞTURMAK İÇİN  NORMAL 
--TABLO OLUŞTURURKEN Kİ PARANTEZLER YERİNE AS KULLANIP SELECT KOMUTUYLA ALMAK İSTEDİĞİMİZ VERİLERİ ALIRIZ
SELECT isim,soyisim,not_ort FROM ogrenciler5;

--DML - DATA MANUPULATION LANG.
--INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler5 VALUES ('1234567','LEYLA','YILDIZ',85.5,'2022-12-2');
INSERT INTO ogrenciler5 VALUES ('1234567','LEYLA','YILDIZ',85.5,now());

--BİR TABLOYA PARCALI VERİ EKLEMEK İSTERSEK

INSERT INTO ogrenciler5 (isim,soyisim) VALUES ('Erol','Evren');


--DQL - DATA QUERY LANG.
--SELECT

select * FROM ogrenciler5; --Burdaki * sembolü herşeyi anlamındadır



