create table MANAGER(
    id_manager int not null,
    nume_manager varchar(30),
    procent_cerut int,
    constraint procent100 check(procent_cerut < 101),
    primary key (id_manager)
);

create table ACTOR(
    id_actor int not null,
    id_manager int not null,
    nume_actor varchar(20),
    prenume_actor varchar(20),
    gen varchar(7),
    constraint gen_chk check (gen = 'barbat' or gen = 'femeie'),
    primary key (id_actor),
    foreign key (id_manager)
    references MANAGER(id_manager) on delete cascade
);

create table STUDIO(
    id_studio int not null,
    nume_studio varchar(30),
    valoare float default 0,
    numar_angajati int default 0,
    primary key (id_studio)
);

create table REGIZOR(
    id_regizor int not null,
    nume_regizor varchar(20)not null,
    prenume_regizor varchar(20)not null,
    primary key (id_regizor)
);

create table ECHIPA_PRODUCTIE(
    id_echipa int not null,
    id_studio int not null,
    id_regizor int not null,
    buget float default 0,
    primary key (id_echipa),
    foreign key (id_studio)
    references STUDIO(id_studio) on delete cascade,
    foreign key (id_regizor)
    references REGIZOR(id_regizor) on delete cascade
);

create table CONTRACT(
    id_echipa int not null,
    id_actor int not null,
    perioada_contractuala int default 0,
    primary key (id_echipa, id_actor),
    foreign key (id_echipa)
    references ECHIPA_PRODUCTIE(id_echipa) on delete cascade,
    foreign key (id_actor)
    references ACTOR(id_actor) on delete cascade
);

create table PREMIU(
    id_premiu int not null,
    id_echipa int not null,
    denumire varchar(20),
    categorie varchar(20),
    primary key (id_premiu),
    foreign key (id_echipa)
    references ECHIPA_PRODUCTIE(id_echipa) on delete cascade
);

create table FILM(
    id_film int not null,
    id_echipa int not null,
    titlu varchar(255),
    profit float,
    durata float,
    data_aparitie date not null,
    gen varchar(30),
    primary key (id_film),
    foreign key (id_echipa)
    references ECHIPA_PRODUCTIE(id_echipa) on delete cascade
);

create table TARA(
    id_tara int not null,
    nume_tara varchar(15),
    cod_iso varchar(15),
    primary key (id_tara)
);

create table TARA_VIZIONARII(
    id_tara int not null,
    id_film int not null,
    primary key (id_tara, id_film),
    foreign key (id_tara)
    references TARA(id_tara) on delete cascade,
    foreign key (id_film)
    references FILM(id_film) on delete cascade
);

create table LIMBA(
    id_limba int not null,
    denumire_limba varchar(15),
    tip varchar(10),
    primary key (id_limba)
);

create table LIMBA_VORBITA(
    id_limba int not null,
    id_film int not null,
    primary key (id_limba, id_film),
    foreign key (id_limba)
    references LIMBA(id_limba) on delete cascade,
    foreign key (id_film)
    references FILM(id_film) on delete cascade
);

create table LOCATIE(
    id_locatie int not null,
    nume_locatie varchar(15),
    numar_locatie int,
    primary key (id_locatie)
);

create table LOCATIE_FILMARI(
    id_locatie int not null,
    id_film int not null,
    primary key (id_locatie, id_film),
    foreign key (id_locatie)
    references LOCATIE(id_locatie) on delete cascade,
    foreign key (id_film)
    references FILM(id_film) on delete cascade
);

create table CRITIC(
    id_critic int not null,
    nume_critic varchar(15),
    nota_film int,
    constraint nota_chk check(nota_film > 0 and nota_film < 11),
    primary key (id_critic)
);

create table RECENZIE(
    id_critic int not null,
    id_film int not null,
    primary key (id_critic, id_film),
    foreign key (id_critic)
    references CRITIC(id_CRITIC) on delete cascade,
    foreign key (id_film)
    references FILM(id_film) on delete cascade
);

alter table CRITIC
add (id_critic int not null,
     nume_critic varchar(15),
     data_nastere date,
     primary key (id_critic)
    );
    
alter table RECENZIE
add(id_critic int not null,
    id_film int not null,
    nota_film int,
    constraint nota_chk check(nota_film > 0 and nota_film < 11),
    primary key (id_critic, id_film),
    foreign key (id_critic)
    references CRITIC(id_CRITIC) on delete cascade,
    foreign key (id_film)
    references FILM(id_film) on delete cascade
    );

commit;

insert into manager
values(1001, 'Rich Ross', 15);
insert into manager
values(1002, 'Thierry Fremaux', 10);
insert into manager
values(1003, 'Sharon Osbourne', 25);
insert into manager
values(1004, 'Mike Shinoda', 20);
insert into manager
values(1005, 'Simon Fuller', 5);

insert into actor
values(101,1001,'DiCaprio', 'Leonardo', 'barbat');
insert into actor
values(102,1001,'Pitt', 'Brad', 'barbat');
insert into actor
values(103,1004,'Portman', 'Natalie', 'femeie');
insert into actor
values(104,1003,'Keaton', 'Diane', 'femeie');
insert into actor
values(105,1003,'Holland', 'Tom', 'barbat');

insert into regizor
values(201,'Nolan','Christofer');
insert into regizor
values(202,'Lynch','David');
insert into regizor
values(203,'Tarantino','Quentin');
insert into regizor
values(204,'Martin','Scorsese');
insert into regizor
values(205,'Spielberg','Steven');

insert into studio
values (4001,'Disney',20000000, 3000);
insert into studio
values (4002,'Universal Studios',34000000, 4000);
insert into studio
values (4003,'Paramount',17000000, 2300);
insert into studio
values (4004,'Fox',30000000, 2800);
insert into studio
values (4005,'Warner Brothers',50000000, 4400);

insert into echipa_productie
values(10001,4002,204, 5000000);
insert into echipa_productie
values(10002,4001,205, 9000000);
insert into echipa_productie
values(10003,4003,202, 3500000);
insert into echipa_productie
values(10004,4005,201, 7000000);
insert into echipa_productie
values(10005,4004,203, 2000000);

insert into contract
values(10001, 101, 120);
insert into contract
values(10001, 102, 100);
insert into contract
values(10001, 103, 130);
insert into contract
values(10002, 105, 90);
insert into contract
values(10004, 102, 30);
insert into contract
values(10004, 103, 60);
insert into contract
values(10004, 105, 50);
insert into contract
values(10005, 101, 80);
insert into contract
values(10005, 104, 70);
insert into contract
values(10005, 102, 55);

insert into premiu
values (11,10001, 'Oscar', 'Best Movie');
insert into premiu
values (12,10001, 'Oscar', 'Best Actor');
insert into premiu
values (13,10004, 'Golden Globe', 'Best Actor');
insert into premiu
values (14,10004, 'Oscar', 'Best Director');
insert into premiu
values (15,10003, 'Golden Globe', 'Best Movie');

insert into film
values (301,10002, 'Spiderman', 60000000, 2.5, '25-DEC-2021', 'Fantasy');
insert into film
values (302,10002, 'Spiderman 2', 40000000, 3, '10-MAY-2022', 'Fantasy');
insert into film
values (303,10004, 'Tenet', 50000000, 3, '22-NOV-2020', 'SF');
insert into film
values (304,10001, 'The Departed', 25000000, 3.5, '6-SEP-2006', 'Thriller');
insert into film
values (305,10003, 'Once upon a time in Hollywood', 10000000, 2.5, '30-OCT-2019', 'Drama');

insert into limba
values (6001, 'Engleza', 'vorbit');
insert into limba
values (6002, 'Engleza', 'subtitrat');
insert into limba
values (6003, 'Spaniola', 'dublat');
insert into limba
values (6004, 'Spaniola', 'subtitrat');
insert into limba
values (6005, 'Romana', 'subtitrat');

insert into locatie
values (3001, 'Sunset Blvd',1);
insert into locatie
values (3002, 'Santa Monica',5);
insert into locatie
values (3003, 'Harlem',6);
insert into locatie
values (3004, '5th Ave',3);
insert into locatie
values (3005, 'Central Park',12);

insert into critic
values(1, 'Andr? Bazin','18-APR-1918');
insert into critic
values(2, 'Roger Ebert','18-JUN-1942');
insert into critic
values(3, 'Andrew Sarris','31-OCT-1928');
insert into critic
values(4, 'Pauline Kael','19-JUN-1919');
insert into critic
values(5, 'J. Hoberman','14-MAR-1948');

insert into tara
values(157, 'Romania', 'ISO 3166-2:RO');
insert into tara
values(158, 'Franta', 'ISO 3166-2:FR');
insert into tara
values(159, 'UK', 'ISO 3166-2:GB');
insert into tara
values(160, 'Spania', 'ISO 3166-2:ES');
insert into tara
values(161, 'SUA', 'ISO 3166-2:US');

insert into locatie_filmari
values(3001, 305);
insert into locatie_filmari
values(3001, 301);
insert into locatie_filmari
values(3001, 302);
insert into locatie_filmari
values(3002, 305);
insert into locatie_filmari
values(3005, 303);
insert into locatie_filmari
values(3005, 304);
insert into locatie_filmari
values(3003, 303);
insert into locatie_filmari
values(3003, 301);
insert into locatie_filmari
values(3004, 303);
insert into locatie_filmari
values(3003, 304);

insert into limba_vorbita
values(6001,301);
insert into limba_vorbita
values(6001,302);
insert into limba_vorbita
values(6001,303);
insert into limba_vorbita
values(6001,304);
insert into limba_vorbita
values(6001,305);
insert into limba_vorbita
values(6005,301);
insert into limba_vorbita
values(6005,302);
insert into limba_vorbita
values(6005,303);
insert into limba_vorbita
values(6005,304);
insert into limba_vorbita
values(6005,305);

insert into recenzie
values(1,304,9);
insert into recenzie
values(1,305,8);
insert into recenzie
values(2,304,10);
insert into recenzie
values(3,301,7);
insert into recenzie
values(3,302,6);
insert into recenzie
values(3,303,9);
insert into recenzie
values(4,305,9);
insert into recenzie
values(4,301,8);
insert into recenzie
values(5,304,10);
insert into recenzie
values(5,303,9);

insert into tara_vizionarii
values(161,301);
insert into tara_vizionarii
values(161,302);
insert into tara_vizionarii
values(161,303);
insert into tara_vizionarii
values(161,304);
insert into tara_vizionarii
values(161,305);
insert into tara_vizionarii
values(159,303);
insert into tara_vizionarii
values(157,301);
insert into tara_vizionarii
values(157,302);
insert into tara_vizionarii
values(157,305);
insert into tara_vizionarii
values(158,304);

--exercitiul 12

-- actorii care joaca in filme aparute dupa 2018 ordonate descrescator dupa buget
select a.prenume_actor, a.nume_actor, f.titlu, e.buget
from actor a join contract c on(a.id_actor = c.id_actor)
             join echipa_productie e on (c.id_echipa = e.id_echipa)
             join film f on (e.id_echipa = f.id_echipa)           
where (select to_char( sysdate, 'yyyy')
              from dual)-4 < to_char(f.data_aparitie, 'yyyy')
order by e.buget desc;

-- toate filmele care au luat macar o nota de peste 7 de la un critic nascut dupa 1920
select titlu, durata, data_aparitie
from film 
where titlu in (select f.titlu
                from film f join recenzie r on (f.id_film = r.id_film)
                            join critic c1 on (r.id_critic = c1.id_critic)
                where r.nota_film > 7 and r.nota_film in(select  r.nota_film
                                                         from critic c2 join recenzie r on (r.id_critic = c2.id_critic)
                                                         where to_char(c2.data_nastere, 'yyyy')> 1920 ));
                                                         
--toate filmele in care joaca Brad Pitt
select titlu, data_aparitie
from film tabel1
where id_film in (select id_film
                  from film   
                  where tabel1.id_echipa in (select c.id_echipa
                                             from contract c join actor a on (c.id_actor = a.id_actor)
                                                             join echipa_productie e on(e.id_echipa = c.id_echipa)
                                             where lower(a.prenume_actor) = 'brad' and upper(a.nume_actor) = 'PITT'));

--toti actorii care au in cel mai lung contract 100 sau mai multe zile de filmari                
select   decode (a.nume_actor,'DiCaprio', 'Leonardo DiCaprio',
                     'Pitt', 'Brad Pitt',
                     'Portman', 'Natalie Portman',
                     'Nume Actor') "NumeActor" , max(c.perioada_contractuala)as perioada_maxima
from contract c join actor a on (c.id_actor = a.id_actor)
                join echipa_productie e on(c.id_echipa = e.id_echipa)
group by a.nume_actor
having  max(c.perioada_contractuala) >= 100;
 
 
--toti actorii pentru care procentul cerut de manager este maximul procentelor cerute de toti managerii)    
with procent_maxim(maxim) as (
select max(NVL(procent_cerut, 0))
from manager) 
select case
    when a.nume_actor = 'DiCaprio' then 'Leonardo DiCaprio'
    when a.nume_actor = 'Pitt' then 'Brad Pitt'
    when a.nume_actor = 'Portman' then 'Natalie Portman'
    when a.nume_actor = 'Keaton' then 'Diane Keaton'
    when a.nume_actor = 'Holland' then 'Tom Holland'
    else 'Nume Actor'
end as actor
from actor a join manager m on(m.id_manager = a.id_manager), procent_maxim
where m.procent_cerut = procent_maxim.maxim;


--exercitiul 12

alter table actor
add data_nastere date;
update actor
set data_nastere = '01-JUN-1996'
where nume_actor = 'Holland';
alter table actor
drop column data_nastere;


--exercitiul 13
create sequence actor_id_seq
    minvalue 1
    maxvalue 99999
    start with 1
    increment by 1
    nocycle;


create table ACTOR(
    id_actor int not null,
    id_manager int not null,
    nume_actor varchar(20),
    prenume_actor varchar(20),
    gen varchar(7),
    constraint gen_chk check (gen = 'barbat' or gen = 'femeie'),
    primary key (id_actor),
    foreign key (id_manager)
    references MANAGER(id_manager) on delete cascade
);

insert into actor
values (actor_id_seq.nextval,1002,'Robbie', 'Margot', 'femeie');


--exercitiul 14

create or replace view view_film as
    select id_film, id_echipa, titlu, profit, durata, data_aparitie, gen
    from film
    where profit >= 40000000
    with check option;

insert into view_film (id_film, id_echipa, titlu, profit,durata, data_aparitie, gen)
values(306, 10005, 'Joker', 45000000, 2.5, '19-OCT-2019', 'Drama');
rollback;


--exercitiul 15

create index imdb on film (titlu, data_aparitie);

--exercitiul 16

select nume_actor, titlu, buget, data_aparitie, profit 
from actor left outer join contract using(id_actor)
           left outer join echipa_productie using(id_echipa) 
           left outer join film using(id_echipa);

--totate locatiile in care s-a filmat un film cu profit de 60000000 varianta1
select distinct(id_locatie)
from locatie_filmari lf
where not exists
    (select id_film
    from film f
    where profit = 60000000
    and not exists
        (select id_film
        from locatie_filmari lf2
        where f.id_film = lf2.id_film
        and lf2.id_locatie = lf.id_locatie));




--totate locatiile in care s-a filmat un film cu profit de 60000000 varianta2
select id_locatie
from locatie_filmari
where id_film in
    (select id_film
    from film
    where profit = 60000000)
group by id_locatie
having count(id_film)=
       (select count(*)
        from film
        where profit = 60000000);

