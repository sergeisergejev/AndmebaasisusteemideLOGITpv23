--Trigerid
--SQL Triger (trigger) - protsess, mille abil tema sisse kirjutatud tegevused automaatselt käivitatakse
--INSERT; UPDATE; DELETE
--trigerid mis jägivad antud tegevused tabelites ja kirjutavad logi tabeli mida nad jälgisid
create database trigerLOGIT;
use trigerLOGIT;

create table toode(
toodeID int primary key identity(1,1),
toodeNimetus varchar(25),
toodeHind decimal(5,2))
create table logi(
id int primary key identity(1,1),
tegevus varchar(25),
kuupaev datetime,
andmed text)

--insert triger, mis jälgib andmete lisamine toode tabelisse
create trigger toodelisamine
on toode
for insert
as
insert into logi(tegevus, kuupaev, andmed)
select 'toode on lisatud',
GETDATE(),
inserted.toodeNimetus
from inserted;

--kontroll
insert into toode(toodeNimetus, toodeHind)
values ('Coca Cola', 2.20);

select * from toode;
select * from logi;

--delete triger, mis jälgib toode kustutamine tabelis
create trigger toodekustutamine
on toode
for delete
as
insert into logi(tegevus, kuupaev, andmed)
select 'Toode on kustutatud',
GETDATE(),
deleted.toodeNimetus
from deleted;
--kontroll
delete from toode
where toodeID=3
select * from toode;
select * from logi;

--update triger, mis jälgib toode uuendamine tabelis
create trigger toodeuuendamine
on toode
for update
as
insert into logi(tegevus, kuupaev, andmed)
select 'Toode on uuendatud',
GETDATE(),
concat('Vanad andmed - ',deleted.toodeNimetus, ', ',deleted.toodeHind,'\nUued andmed - ', inserted.toodeNimetus,', ', inserted.toodeHind, '| tegi kasutaja ', SYSTEM_USER)
from deleted inner join inserted
on deleted.toodeID=inserted.toodeID;
--kontroll
update toode set toodeHind=3.00
where toodeNimetus='Fanta';
select * from toode;
select * from logi;

-------------------------------------------------------------------------------------------------

create database sergejevlogitpv;
use sergejevlogitpv;

create table firma (
firmaID int not null primary key identity(1,1),
firmanimi varchar(20) unique,
aadress varchar(20),
telefon varchar(20)
);

create table praktikajuhendaja (
praktikajuhendajaID int not null primary key identity(1,1),
eesnimi varchar(20),
perekonnanimi varchar(20),
sunniaeg date,
telefon varchar(20),
);

create table praktikabaas (
praktikabaasID int not null primary key identity(1,1),
firmaID int,
praktikatingimused varchar(50),
arvutiprogramm varchar(20),
juhendajaID int,
foreign key (firmaID) references firma(firmaID),
foreign key (juhendajaID) references praktikajuhendaja(praktikajuhendajaID)
);

create table praktikajuhendaja (
	eesnimi VARCHAR(50),
	perekonnanimi VARCHAR(50),
	sunniaeg DATE,
	telefon VARCHAR(50)
);
insert into praktikajuhendaja (eesnimi, perekonnanimi, sunniaeg, telefon) values ('Sheila-kathryn', 'Clayborn', '1988-11-07', '8373179244');
insert into praktikajuhendaja (eesnimi, perekonnanimi, sunniaeg, telefon) values ('Jacquelynn', 'Blakeborough', '2000-02-10', '4011514984');
insert into praktikajuhendaja (eesnimi, perekonnanimi, sunniaeg, telefon) values ('Jeralee', 'Klaves', '1999-06-20', '6291671997');
insert into praktikajuhendaja (eesnimi, perekonnanimi, sunniaeg, telefon) values ('Binky', 'Loade', '2001-11-23', '2243829132');
insert into praktikajuhendaja (eesnimi, perekonnanimi, sunniaeg, telefon) values ('Estelle', 'Bollen', '1976-04-02', '7938322500');

select * from praktikajuhendaja;

insert into firma (firmanimi, aadress, telefon) values ('Viva', '148 Namekagon Pass', '1798750719');
insert into firma (firmanimi, aadress, telefon) values ('Aimbo', '9 Onsgard Pass', '1614710589');
insert into firma (firmanimi, aadress, telefon) values ('Avavee', '66 New Castle Center', '9078237200');
insert into firma (firmanimi, aadress, telefon) values ('Mydo', '5650 Pond Way', '9581332400');
insert into firma (firmanimi, aadress, telefon) values ('Mynte', '578 Tennessee Street', '5444162618');

select * from firma;

insert into praktikabaas (praktikatingimused, arvutiprogramm) values ('arvutikasutamise oskus', 'Microsoft Excel');
insert into praktikabaas (praktikatingimused, arvutiprogramm) values ('huvi valdkonna vastu', 'Adobe Photoshop');
insert into praktikabaas (praktikatingimused, arvutiprogramm) values ('valmisolek õppida', 'AutoCAD');
insert into praktikabaas (praktikatingimused, arvutiprogramm) values ('tähelepanu detailidele', 'Visual Studio Code');
insert into praktikabaas (praktikatingimused, arvutiprogramm) values ('aja juhtimise oskus', 'Blender');

select * from praktikabaas;

create table praktikabaas_logi (
id int not null primary key identity(1,1),
kasutaja varchar(20),
aeg datetime,
tegevus varchar(20),
andmed text
)

--insert triger
create trigger baasilisamine
on praktikabaas
for insert
as
insert into praktikabaas_logi(kasutaja, aeg, tegevus, andmed)
select SYSTEM_USER,
GETDATE(),
'praktikabaasis on lisatud',
concat('Lisatud: PraktikabaasID - ',inserted.praktikabaasID, ', Firmanimi - ',firma.firmanimi, ', Juhendaja eesnimi - ',praktikajuhendaja.eesnimi, ', Arvutiprogramm - ',inserted.arvutiprogramm, ', Praktikatingimused - '
inserted.firmanimi)
from inserted;

--update triger
create trigger baasiuuendamine
on praktikabaas
for update
as
insert into praktikabaas_logi(kasutaja, aeg, tegevus, andmed)
select system_user,
GETDATE(),
select 'Tabel on uuendatud',
concat(' / Vanad: PraktikabaasID - ', praktikabaasID, ', Firmanimi - ',
firma.firmanimi,' / Uued andmed: PraktikabaasID', praktikabaasID,', Firmanimi - ', 
firma.firmanimi, ' | tegi kasutaja ', SYSTEM_USER)
from deleted inner join inserted
on deleted.praktika=inserted.toodeID;


--kontroll

update toode set toodeHind=3.00
where toodeNimetus='Fanta';
select * from toode;
select * from logi;
