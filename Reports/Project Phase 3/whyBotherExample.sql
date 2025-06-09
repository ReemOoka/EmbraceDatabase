create table pet (name varchar(45), owner_id INT, species varchar(45), birthdate varchar(10));

insert into pet (name, owner_id, species, birthdate)
	values ('Maya', 2, 'cat', '2011-02-31');
    
 select name, timestampdiff(year, birthdate, now()) as age from pet;