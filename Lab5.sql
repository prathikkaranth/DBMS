create table actor(Act_id integer primary key, Act_Name varchar(30), Act_Gender varchar(10));
desc actor;
create table director(Dir_id integer primary key, Dir_Name varchar(30), Dir_Phone varchar(10));
desc director;
create table movies(Mov_id integer primary key, Mov_Title varchar(30), Mov_Year date, Mov_Lang varchar(10),Dir_id integer,foreign key(Dir_id) references director(Dir_id));
desc movies;
create table movie_cast(Act_id integer, Mov_id integer,role varchar(10),primary key(Mov_id,Act_id),foreign key(Mov_id) references movies(Mov_id),foreign key(Act_id) references actor(Act_id));
desc movie_cast;
create table rating(Mov_id integer,Rev_stars integer, primary key(Mov_id),foreign key(Mov_id) references movies(Mov_id))0;
desc rating;
select * from actor;
insert into actor values('&Act_id','&Act_name','&Act_gender');
commit;
insert into director values('&Dir_id','&Dir_name','&Dir_phone');
commit;
select * from director;
insert into movies values('&Mov_id','&Mov_Title','&Mov_Year','&Mov_Lang','&Dir_id');
commit;
select * from movies;
insert into movie_cast values('&Act_id','&Mov_id','&role');
commit;
select * from movie_cast;
insert into rating values('&Mov_id','&Rev_stars');
commit;
select * from rating;

SELECT Mov_Title
FROM movies
WHERE Dir_id IN (SELECT Dir_id
FROM director
WHERE Dir_name='hitchcock');

SELECT Mov_title
FROM movies m,movie_cast mv
WHERE m.Mov_id=mv.Mov_id AND Act_id IN (SELECT Act_id
FROM movie_cast GROUP BY Act_id
HAVING COUNT (Act_id)>1)
GROUP BY Mov_Title
HAVING COUNT(*)>1;

SELECT Act_Name,Mov_Title,Mov_year
FROM actor a
JOIN movie_cast c
ON a.Act_id=c.Act_id
JOIN movies m
ON c.Mov_id=m.Mov_id
WHERE m.Mov_year NOT BETWEEN '01-jan-00' AND '31-dec-2015';

SELECT Mov_title,MAX(Rev_stars)
FROM movies
INNER JOIN rating USING (Mov_id)
GROUP BY Mov_title
HAVING MAX (Rev_stars)>0
ORDER BY Mov_title;

UPDATE rating
SET Rev_stars=5
WHERE Mov_id IN (SELECT Mov_id FROM movies
WHERE Dir_id IN (SELECT Dir_id
FROM director
WHERE Dir_name='speilberg'));

SELECT * FROM rating;