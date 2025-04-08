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
where inimeneID=7;

--tabel elukoht
create table elukoht(
elukohtID int PRIMARY KEY identity(1,1),
elukoht varchar(50) unique,
maakond varchar(50)
);

select * from elukoht;
--andmete lisamine tabeli elukoht
insert into elukoht(elukoht, maakond)
values ('Tallinn', 'Harjumaa'),
('Keila', 'Harjumaa'),
('Pärnu', 'Pärnumaa')
;
--tabeli muutmine uue veergu lisamine
alter table inimene add elukohtID int;

select * from inimene;
select * from elukoht;

--foreign key lisamine
alter table inimene add constraint fk_elukoht
foreign key (elukohtID)
references elukoht(elukohtID);

INSERT INTO inimene
(nimi, sunniaeg, telefon, pikkus, opilaskodu, elukohtID)
values
('Peeter Sir', '2021-12-30', '2564735', 82.5, 0, 2);

select * from inimene join elukoht
ON inimene.elukohtID=elukoht.elukohtID;

select i.nimi, i.sunniaeg, e.elukoht, e.maakond 
from inimene i join elukoht e
ON i.elukohtID=e.elukohtID;


CREATE TABLE autod(
autodID int Primary Key identity(1,1),
autoNR char(12) unique,
mudell char(12),
mark char(12),
v_aasta int
);

select * from inimene;
select * from autod;

insert into autod
(autoNR, mudell, mark, v_aasta)
values
('EST111', 'Audi', 'Q7', '2016'),
('TSE131', 'Audi', 'A8', '2007');

alter table inimene add autodID int;

alter table inimene add constraint fk_autod
foreign key (autodID)
references autod(autodID);

INSERT INTO inimene
(nimi, sunniaeg, telefon, pikkus, opilaskodu, elukohtID, autodID)
values
('Peeter Surr22', '2002-12-30', '5835735', 192, 0, 2, 1);

select * from inimene join elukoht
ON inimene.elukohtID=elukoht.elukohtID;

select i.nimi, i.sunniaeg, a.autoNR, a.mudell, a.mark, a.v_aasta
from inimene i join autod a
ON i.elukohtID=a.autodID;
