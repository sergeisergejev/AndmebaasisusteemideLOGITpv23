--kommentaar
--SQL SERVER Management Stuudio
--Connect TO:
--Server Name: (localdb)\MSSQLLocalDB
-- Authentification 2 tüüpi:
--1. Windows Auth - localdb admini õigused
--2. SQL Server Auth - kontrollida varem tehtud kasutajad


CREATE DATABASE sergejevLOGITpv23;
USE sergejevLOGITpv23;

--taabeli loomine
--identity(1,1) - ise täidab tabeli 1,2,3,...
CREATE TABLE inimene(
inimeneID int Primary Key identity(1,1),
nimi varchar(50) unique,
sunniaeg date,
telefon char(12),
pikkus decimal(5,2),
opilaskodu bit
);
SELECT * FROM inimene;
--tabeli kustutamine
DROP table inimene;

--andmete lisamine
--DDL - data definition language
--DML - data manipulation language

INSERT INTO inimene
(nimi, sunniaeg, telefon, pikkus, opilaskodu)
values
('Peeter Uus', '2021-12-30', '9564735', 85.5, 0),
('Mari Speek', '1980-10-20', '778795', 174.5, 0),
('Tonu Talve', '2075-05-10', '656295', 180.5, 0),
('Peeter Oja', '2005-11-17', '2865995', 182.5, 1)
;

select * from inimene;

delete from inimene
where inimeneID=3;
