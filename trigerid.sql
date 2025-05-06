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
