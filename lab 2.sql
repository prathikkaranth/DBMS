create database lab2;
use lab2;

create table branch(
branch_name varchar(30),
branch_city varchar(30),
assets REAL,
primary key(branch_name));

create table accounts(
accno int,
branch_name varchar(30),
balance REAL,
primary key(accno),
foreign key(branch_name)references Branch(branch_name));

create table depositor(
cust_name varchar(30),
accno int,
primary key(cust_name,accno));
alter table Depositor add foreign key(accno) references ACCOUNTS(accno);

create table bankcust(
cust_name varchar(30),
cust_street varchar(30),
city varchar(30),
primary key(cust_name));


create table loan(
loan_num int,
branch_name varchar(30),
amount real,
primary key(loan_num),
foreign key(branch_name)references Branch(branch_name));

insert into branch values ('SBI_Chamrajpet','Bangalore',50000),('SBI_ResidencyRoad','Bangalore',10000),
('SBI_ShivajiRoad','Bombay',20000),('SBI_ParlimentRoad','Delhi',10000),('SBI_Jantarmantar','Delhi',20000);

insert into ACCOUNTS values(1,'SBI_Chamrajpet',2000),(2,'SBI_ResidencyRoad',5000),(3,'SBI_ShivajiRoad',6000),
(4,'SBI_PArlimentRoad',9000),(5,'SBI_Jantarmantar',8000),(6,'SBI_ShivajiRoad',4000),(7,'SBI_ResidencyRoad',4000),
(8,'SBI_ResidencyRoad',4000),(9,'SBI_ResidencyRoad',3000),(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);

insert into BankCust values('Avinash','Bull_temple_road','Bangalore'),('Dinesh','Bannergatta_road','Bangalore'),
('Mohan','NationalCollege_road','Bangalore'),('Nikil','Akbar_road','Delhi'),('Ravi','Prithviraj_road','Delhi');

insert into Depositor values('Avinash',1),('Dinesh',2),('Nikil',4),('Ravi',5),('Avinash',8),('Nikil',9),('Dinesh',10),
('Nikil',11);

insert into loan values(1,'SBI_Chamrajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantar',5000);

select C.cust_name 
from BankCust C
where exists (
				select D.cust_name, count(D.cust_name)
                from depositor D,accounts BA
                where
                D.accno = BA.accno AND C.cust_name = D.cust_name AND BA.branch_name='SBI_ResidencyRoad' 
                group by D.cust_name
                having count(D.cust_name) >=2
                );
                
select BC.cust_name from BankCust BC
where not exists(
					select branch_name from branch where branch_city = 'Delhi'
                    not in
                    select BA.branch_name from depositor D , accounts BA
                    where D.accno = BA.accno AND BC.cust_name = D.cust_name
                    );
                    
delete from accounts 
where branch_name in (select branch_name 
					  from branch
                      where branch_city='Bombay');
select * from accounts;