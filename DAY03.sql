CREATE TABLE ogrenciler5
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --ondalıklı sayılar için kullanılır(double gibi)
kayit_tarih date
);

--VAROLAN BİR TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler5;

select * from ogrenciler5;

--INSERT- TABLO İÇİNE VERİ EKLEME

select * from notlar;

Create table talabeler
(
id char(4)
notlar real

);
INSERT INTO talebeler VALUES ('HUMANUR',95.5);
INSERT INTO talebeler VALUES ('ABDULKADİR',95.5);
INSERT INTO talebeler VALUES ('YUSUF',95.5);
INSERT INTO talebeler VALUES ('ÖMER',95.5);
INSERT INTO talebeler VALUES ('İPEK',95.5);
INSERT INTO notlar VALUES ('leyla',75.5);