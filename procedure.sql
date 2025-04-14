create database procedureSergejev;
use procedureSergejev;

create table filmid(
filmID int primary key identity(1,1),
filmNimi varchar(30) unique,
filmPikkus int,
rezisoor varchar(30));
select * from filmid;
insert into filmid(filmNimi, filmPikkus, rezisoor)
VALUES
('Minecraft',120,'Jared Hess');

--protseduur, mis lisab uus film ja kohe näitav tabelis (insert, select)
create procedure lisaFilm
@nimi varchar(30),
@pikkus int,
@rezisoor varchar(30)
AS
BEGIN
INSERT INTO filmid(filmNimi, filmPikkus, rezisoor)
values (@nimi, @pikkus, @rezisoor);
select * from filmid;
end;
exec lisaFilm 'Bob ja Bobek', 120, 'testtest';

drop procedure lisaFilm;

--protseduur, mis kustutab filmi filmID järgi (delete, select)
create procedure kustutaFilm
@id int
AS
BEGIN
SELECT * from filmid;
delete from filmid where filmid=@id;
select * from filmid;
end;

--kutse
exec kustutaFilm 1;
