create schema animal;

create table animal.Animals (
    breed varchar(50),
    animalId int,
    primary key(animalId)
);

create table animal.Mammals (
    eating varchar
) inherits (animal.Animals); 

create table animal.Pet (
    name varchar,
    age int,
    Oname varchar(50),
    Vname varchar(50),
    foreign key(Oname) references animal.Onwer,
    foreign key(Vname) references animal.Vaterinarian
) inherits (animal.Animals);

create table animal.Canidae (
    lifeExpantency int
) inherits (animal.Mammals, animal.Pet);

create table animal.Onwer (
    Oname varchar(50),
    primary key(Oname)
);

create table animal.Vaterinarian (
    Vname varchar(50),
    gender varchar(10),
    primary key(Vname)
);


insert into animal.Canidae Values
('pug', 1, 'Omnivore', 'Locus', 1, 'Nick', 'Tracy', 10),
('Alaskan Malamute' , 2, 'Omnivore', 'Sijia', 5, 'Carbon', 'Tracy', 15),
('Australian Shepherd', 3, 'Carnivore', '9', 3, 'Tedd', 'Tim', 14),
('Australian Shepherd', 4, 'Carnivore', '12', 2, 'Tedd', 'Tim', 14),
('Shiba inu', 5, 'Omnivore', 'Haru', 9, 'Hayato', 'Takeshi', 13),
('Miniature Bull Terrier', 6, 'Carnivore', 'Topaz', 1, 'Mary', 'Tracy', 13),
('golden retriever', 7, 'Omnivore', 'Buddy', 3, 'Tanner', 'Takeshi', 16);

insert into animal.Onwer Values 
('Locus'), ('Carbon'), ('Tedd'), ('Hayato'), ('Mary'), ('Tanner');

insert into animal.Vaterinarian Values 
('Tracy', 'W'), ('Tim', 'M'), ('Takeshi', 'M');

select name, lifeExpantency
from animal.Canidae; 

select animalid, breed, lifeExpantency
from animal.Canidae;

select breed, name, eating, lifeExpantency
from animal.Canidae
where age > 5;

select animalId, breed
from only animal.Animals;