create table Student(
snum integer,
snamevarchar(30),
    major varchar(30),
lvlvarchar(30),
    age integer, primary key(snum));

create table Faculty(
    fid integer,
fnamevarchar(30),
deptid integer,
    primary key(fid));

create table Class(
cnamevarchar(30),
meetat timestamp,
    room varchar(30),
    fid integer,
    primary key(cname),
    foreign key(fid) references Faculty(fid));


create table Enrolled(
snum integer,
cnamevarchar(30),
    primary key(snum),
    foreign key(snum) references Student(snum),
    foreign key(cname) references Class(cname));



insert into Student values(01, 'SumanthKV', 'CSE', 'SR', 10);
insert into Student values(02, 'Dhoni', 'CSE', 'SR', 20);
insert into Student values(03, 'Kohli', 'IS', 'FR', 30);
insert into Student values(04, 'Rohith', 'ECE', 'FR', 40);



select * from Student;



insert into Faculty values(101, 'Namratha', 1);
insert into Faculty values(&fid, '&fname', &depid);


insert into Class values('&cname', '&meetat', '&room', &fid);

select * from Class;



insert into Enrolled values(&snum, '&cname');

select * from Enrolled;

select * from Student, Faculty, Enrolled where lvl = 'SR' and fname = 'Namratha';