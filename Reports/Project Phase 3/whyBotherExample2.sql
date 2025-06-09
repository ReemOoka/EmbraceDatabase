create table pet2 (name varchar(45), owner_id INT, species varchar(45), birthdate datetime);

insert into pet2 (name, owner_id, species, birthdate)
	values ('Maya', 2, 'cat', '2010-12-31 01:15:00');
    
 select name, timestampdiff(year, birthdate, now()) as age from pet2;