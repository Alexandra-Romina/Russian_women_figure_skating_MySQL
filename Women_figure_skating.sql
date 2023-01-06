/* Following 17 statements create database and tables for it */

-- 1. Create the database (schema)
create schema Women_Figure_Skating charset latin1;

-- 2. Use the DB
use Women_Figure_Skating;

-- 3. Create table BirthCity
Create table BirthCity
(
	BirthCity_ID integer auto_increment,
    BirthCity_name varchar(25) not null unique,
	primary key (BirthCity_ID)
);

 -- 4. Create table Skater
Create table Skater
(
	skater_ID varchar(10), 
    skater_First_name varchar(25) not null,
    skater_Last_name varchar(35) not null,
    skater_DOB date not null,
	skater_Birth_city integer not null,
    skater_Start_year integer not null,
    skater_Height decimal (3,2) not null,
    primary key (skater_ID),
    foreign key (skater_Birth_city) references BirthCity(BirthCity_ID)
    );

-- 5. Create table CoachFunction
Create table CoachFunction
(
	CoachFunction_ID integer auto_increment,
    CoachFunction_name varchar(40) not null unique,
    primary key (CoachFunction_ID)
);


-- 6. Create table Coach
Create table Coach
(
	coach_ID varchar(10),
    coach_First_name varchar(25) not null,
    coach_Last_name varchar(35) not null,
    coach_DOB date not null,
	coach_Start_career integer,
    coach_Function integer not null,
    primary key (coach_ID),
    foreign key ( coach_Function) references CoachFunction(CoachFunction_ID)
);


-- 7. Create table Relation table Skater --> Coach
Create table SkaterCoach (
	SkaterCoach_ID integer auto_increment,
	skater_ID varchar(10) not null,
    coach_ID varchar(10) not null,
    CurrentPastCoach varchar(1) not null,
    check (CurrentPastCoach = 'C' or CurrentPastCoach = 'P'),
    primary key (SkaterCoach_ID), 
    foreign key (skater_ID) references Skater(skater_ID),
    foreign key (coach_ID) references Coach(coach_ID),
    unique (skater_ID, coach_ID)
);

-- 8. Create table Program
Create table Program
(
	program_ID integer auto_increment,
    program_name varchar(40) not null,
    program_type varchar(2) not null,
    check (program_type in ('SP', 'FS', 'EP')),
    season varchar(9) not null,
    skater_ID varchar(10) not null,
	primary key (program_ID),
    foreign key (skater_ID) references Skater(skater_ID),
    unique (program_name, season, skater_ID)
);

-- 9. Create table Location
Create table Location
(
	location_ID integer auto_increment,
    location_name varchar(25) not null unique,
	primary key (location_ID)
);


-- 10. Create table Club
Create table Club
(
	club_ID integer auto_increment,
    club_name varchar(35) not null unique,
    club_location integer not null,
    club_YearEstablished integer,
    primary key (club_ID),
    foreign key(club_location) references Location(location_ID)
);

-- 11. Create table Relation table Skater --> Club
Create table SkaterClub 
(
	SkaterCLub_ID integer auto_increment,
	skater_ID varchar(10) not null,
    club_ID integer not null,
    CurrentPastCoach varchar(1) not null,
    check (CurrentPastCoach = 'C' or CurrentPastCoach = 'P'),
    primary key (SkaterCLub_ID), 
    foreign key (skater_ID) references Skater(skater_ID),
    foreign key (club_ID) references Club(club_ID),
    unique (skater_ID, club_ID)
);

-- 12. Create table PlaceCity;
Create table PlaceCity
(
	PlaceCity_ID integer auto_increment,
    PlaceCity_Name varchar(25) not null unique,
	primary key (PlaceCity_ID)
);

-- 13. Create table PlaceCountry
Create table PlaceCountry
(
	PlaceCountry_ID integer auto_increment,
    PlaceCountry_Name varchar(25) not null unique,
	primary key (PlaceCountry_ID)
);

-- 14. Create table Competition
Create table Competition
(
	Competition_ID integer auto_increment,
    Competition_Name varchar(50) not null unique,
    Competition_PlaceCity integer not null,
    Competition_PlaceCountry integer not null,
    Competition_Year integer not null,
	primary key (Competition_ID),
    foreign key (Competition_PlaceCity) references PlaceCity(PlaceCity_ID),
    foreign key (Competition_PlaceCountry) references PlaceCountry(PlaceCountry_ID)
);


-- 15. Create table Relation table Skater --> Competition
Create table SkaterCompetition (
	SkaterCompetition_ID integer auto_increment,
	skater_ID varchar(10) not null,
    competition_ID integer not null,
    ScoreShortProgram decimal(4,2),
    RankShortProgram integer ,
    ScoreFreeSkate decimal(5,2),
    RankFreeSkate integer ,
    OverallRankingResult integer,
    primary key (SkaterCompetition_ID), 
    foreign key (skater_ID) references Skater(skater_ID),
    foreign key (competition_ID) references Competition(Competition_ID),
	unique (skater_ID, competition_ID, RankShortProgram, RankFreeSkate, OverallRankingResult)
);

-- 16. Create table Jumps
Create table Jumps
(
	jump_ID integer not null auto_increment,
    jump_abbreviation varchar(15) not null,
    jump_Name varchar(55) not null,
    jump_BaseValue decimal(3,1),
 	primary key (jump_ID),
    unique (jump_abbreviation, jump_Name)
);

-- 17. Create table Relation table Jumps --> SkaterCompetition
Create table CompetitonJumpScore
(
	CompetitionJump_ID integer not null auto_increment,
    SkaterCompetition_ID integer not null,
    jump_ID integer not null,
    jump_Score decimal (4,2),
    program_type varchar(2) not null,
    check (program_type in ('SP', 'FS', 'EP')),
 	primary key (CompetitionJump_ID),
    foreign key(SkaterCompetition_ID) references SkaterCompetition(SkaterCompetition_ID),
	foreign key(jump_ID) references Jumps(jump_ID),
    unique (SkaterCompetition_ID, jump_id, jump_Score )
);


/* Now let's insert some information into the tables. The limit of 10 records per table were used */

-- 1. Birth City
    
insert into BirthCity (BirthCity_name) values 
	('Ryazan'),
	('Moscow'), 
	('Kazan'), 
	('Glazov'), 
	('Arkhangelsk'), 
	('Norilsk'), 
	('Sevastopol'), 
	('Saint Petersburg'), 
	('Dzhamku'), 
	('Metipol');
 

-- 2. Skater
insert into skater values 
	('1ALTRU2008', 'Alexandra', 'Trusova', '2004-06-23', 1, 2008, 1.58 ),
	('2ANSCH2007', 'Anna', 'Shcherbakova', '2004-03-28', 2, 2007, 1.58),
    ('3KAVAL2006', 'Kamila', 'Valieva', '2006-04-26', 3, 2009, 1.60),
    ('4SOAKA2011', 'Sofia', 'Akateva', '2007-07-07', 2, 2011, 1.51),
    ('5ELTUK1996', 'Elizaveta', 'Tuktamysheva', '1996-12-17', 4, 2000, 1.57),
    ('6SOMUR2006', 'Sofia', 'Muravieva', '2006-08-04', 2, 2009, 1.55),
    ('7SOSAM2011', 'Sofia', 'Samodelkina', '2007-02-18', 2, 2011, 1.59),
    ('8VEZHI2008', 'Veronika', 'Zhilina', '2008-05-15', 5, 2011, 1.42),
    ('9ADPET2007', 'Adeliia', 'Petrosian', '2007-06-05', 2, 2011, 1.40),
    ('10AlKO2003', 'Alena', 'Kostornaia', '2003-08-24', 2, 2007, 1.58);


-- 3. Coach Function

insert into coachfunction (CoachFunction_name) values 
	('head coach'),
	 ('technical content coach'),
     ('choreographer'),
     ('off-ice choreographer'),
     ('jump coach'),
     ('spin coach'),
     ('off-ice training coach'),
     ('power training coach'),
     ('children coach'),
     ('slip coach');

-- 4. Coach 

insert into coach  values 
	('1SVSOK6587', 'Svetlana', 'Sokolovskaya', '1965-12-10', 1987, 1 ),
	('2ETTUT7400', 'Eteri', 'Tutberidze', '1974-02-24', 2000, 1),
	('3SEDUD7003', 'Sergei', 'Dudakov', '1970-01-13', 2003, 2),
	('4DAGLE9114', 'Daniil', 'Gleikhengauz', '1991-06-03', 2014, 3),
	('5AlMIS4170', 'Alexei', 'Mishin', '1941-03-08', 1970, 1),
	('6TAPRO7305', 'Tatyana', 'Prokofieva', '1973-04-15', 2005, 3),
	('7EVPLU8217', 'Evgeni', 'Plushenko', '1982-11-03', 2017, 1),
	('8ILAVE7304', 'Ilia', 'Averbukh', '1973-12-18', 2004, 3),
	('9MASTA9718', 'Maria', 'Stavitskaia', '1997-09-01', 2018, 3),
	('10ELBU6384', 'Elena', 'Buianova', '1963-05-21', 1984, 1);


-- 5. Skater --> Coach

insert into SkaterCoach (skater_ID, coach_ID, CurrentPastCoach) values 
	('1ALTRU2008', '1SVSOK6587', 'C'),
	('1ALTRU2008', '2ETTUT7400', 'P'),
    ('1ALTRU2008', '3SEDUD7003', 'P'),
    ('1ALTRU2008', '4DAGLE9114', 'P'),
    ('2ANSCH2007', '2ETTUT7400', 'C'),
    ('2ANSCH2007', '3SEDUD7003', 'C'),
    ('2ANSCH2007', '4DAGLE9114', 'C'),
    ('5ELTUK1996', '5AlMIS4170', 'C'),
    ('5ELTUK1996', '6TAPRO7305', 'C'),
    ('6SOMUR2006', '7EVPLU8217', 'C');
    
-- 6. Program

insert into program (program_name, program_type,season,skater_ID) values 
	('Frida', 'SP', '2021-2022', '1ALTRU2008'),
    ('Cruella', 'FS', '2021-2022', '1ALTRU2008'),
    ('Wonder Woman', 'EP', '2021-2022', '1ALTRU2008'),
    ('The Songs of Distant Earth', 'SP', '2021-2022', '2ANSCH2007'),
    ('Everybody Wants to Rule the World', 'EP', '2020-2021', '2ANSCH2007'),
    ('In Memoriam', 'SP', '2021-2022', '3KAVAL2006'),
    ('Girl on a Ball', 'SP', '2018-2019', '3KAVAL2006'),
    ('Loneliness', 'FS', '2022-2023', '5ELTUK1996'),
    ('I Put a Spell on You', 'SP', '2022-2023', '1ALTRU2008'),
    ('I Put a Spell on You', 'EP', '2015-2016', '5ELTUK1996');
    
-- 7. Location

insert into location (location_name) values 
	('Moscow'),
    ('Saint Petersburg'),
    ('Ekaterinburg'),
    ('Kazan'),
    ('Samara'),
    ('Perm'),
    ('Sochi'),
    ('Glazov'),
    ('Arkhangelsk'),
    ('Norilsk');
    
-- 8. Club

insert into club (club_name, club_location, club_YearEstablished) values 
	('CSKA Moscow', 1, 1911),
    ('Sambo 70_Khrustalny', 1, 2003),
    ('FS Academy of Evgeni Plushenko', 1, 2017),
    ('Olympic School Zvezdni Led', 2, 2014),
    ('Tamara Moskvina Figure Skating Club', 2, 2017),
    ('Olympic School St. Petersburg', 2, 1967),
    ('Vorobievye Gory', 1, 1992),
    ('Olympic School Moskvich', 1, 1961),
    ('Youth School No. 8 "Locomotive" ', 3, 2008),
    ('SC Snow Leopards', 1, 2015 );
    
-- 9. Skater --> Club

insert into skaterclub (skater_ID, club_ID, CurrentPastCoach) values 
	('1ALTRU2008', 1, 'C'),
    ('1ALTRU2008', 2, 'P'),
    ('1ALTRU2008', 3, 'P'),
    ('2ANSCH2007', 2, 'C'),
    ('3KAVAL2006', 2, 'C'),
    ('4SOAKA2011', 2, 'C'),
    ('5ELTUK1996', 4, 'C'),
    ('6SOMUR2006', 3, 'C'),
    ('8VEZHI2008', 2, 'P'),
    ('8VEZHI2008', 3, 'C');
	

-- 10. Place City

insert into placecity (PlaceCity_Name) values 
	('Beijing'),
    ('Stockholm'),
	('Tallinn'),
	('Graz'),
	('Turin'),
	('Sofia'),
	('Zagreb'),
    ('Nagoya'),
    ('Shanghai'),
	('Budapest');
 
 
 -- 11. Place Country

insert into placecountry (PlaceCountry_Name) values 
	('China'),
    ('Sweden'),
	('Estonia'),
	('Austria'),
	('Italy'),
	('Bulgaria'),
	('Croatia '),
    ('Japan'),
    ('Hungary'),
	('Switzerland');
    
    
 -- 12. Place Competition

insert into competition (Competition_Name, Competition_PlaceCity, Competition_PlaceCountry, Competition_Year) values 
	('2022 Winter Olympics', 1, 1, 2022),
    ('2021 World Figure Skating Championships', 2, 2, 2021),
    ('2022 European Figure Skating Championships', 3, 3, 2022),
    ('2020 European Figure Skating Championships', 4, 4, 2020),
    ('2019-20 Grand Prix of Figure Skating Final ', 5, 5, 2019),
    ('2018 World Junior Figure Skating Championships', 6, 6, 2018),
    ('2019 World Junior Figure Skating Championships', 7, 7, 2019),
    ('2017-18 Grand Prix of Figure Skating Final', 8, 8, 2017),
    ('2015 World Figure Skating Championships', 9, 1, 2015),
    ('2015 European Figure Skating Championships', 2, 2, 2015);
    
    
-- 13. Skater --> Competition

insert into skatercompetition (skater_ID, competition_ID, ScoreShortProgram, RankShortProgram, ScoreFreeSkate, RankFreeSkate, OverallRankingResult) values 
	('1ALTRU2008', 1, 74.6, 4, 177.13, 1, 2),
    ('1ALTRU2008', 2, 64.82, 12, 152.28, 1, 3),
    ('1ALTRU2008', 3, 75.13, 3, 159.23, 3, 3),
    ('2ANSCH2007', 1, 80.2, 2, 175.75, 2, 1),
    ('2ANSCH2007', 2, 81.00, 1, 152.17, 2, 1),
    ('3KAVAL2006', 1, 82.16, 1, 141.93, 5, 4),
    ('3KAVAL2006', 3, 90.45, 1, 168.61, 1, 1),
    ('5ELTUK1996', 2, 78.86, 3, 141.60, 3, 2),
	('5ELTUK1996', 9, 77.62, 1, 132.74, 1, 1),
	('5ELTUK1996', 10, 69.02, 2, 141.38, 1, 1);
    
    
-- 14. Jumps

insert into jumps (jump_abbreviation, jump_Name, jump_BaseValue) values 
	('2A', 'Double Axel', 3.3),
	('3A', 'Triple Axel', 8.0),
	('3F', 'Triple Flip', 5.5),
	('4F', 'Quadruple Flip', 11.0),
	('3Lz', 'Triple Lutz', 5.9),
	('4Lz', 'Quadruple Lutz', 11.5),
	('3Lz+3Lo', 'Cascade of Triple Lutz and Triple Loop', 11.8),
	('3Lo', 'Triple Loop', 4.9),
	('3T', 'Triple Toe loop', 4.2),
	('4Lz+3T', 'Cascade of Quadruple Lutz and Triple Toe loop', 15.7);


-- 15. Jumps --> SkaterCompetition

insert into competitonjumpscore (SkaterCompetition_ID, jump_ID, jump_Score, program_type) values
	(1, 10, 19.9, 'FS'),
    (1, 4, 13.2, 'FS'),
    (1, 2, 3.2, 'SP'),
    (2, 1, 4.38, 'SP'),
    (4, 3, 7.19, 'SP'),
    (4, 5, 8.34, 'FS'),
    (5, 7, 14.07, 'SP'),
    (6, 2, 5.26, 'SP'),
    (6, 8, 6.3, 'FS'),
    (7, 2, 11.54, 'SP');
	
    
    /* You can use following sql statements to view information in the tables */

Select * from birthcity;
Select * from skater;
Select * from coachfunction;
Select * from coach;
Select * from skatercoach;
Select * from program;
Select * from location;
Select * from club;
Select * from skaterclub;
Select * from placecity;
Select * from placecountry;
Select * from competitonjumpscore;
Select * from skatercompetition;
Select * from jumps;
Select * from competitonjumpscore;


/* This is a small demo of how this database can be used.
I draw your attention to the fact that the conditions of 10 records per table caused many null values.
Because of this, the 'where' clause was used to cut all null values */

-- Skater_Competiton View - store information about skater performance (including jump score) during international competitions

Create view Skater_Competition  as -- this how this information would look like until normalization
	Select 
		skater.skater_ID 'Skater ID',
		skater.skater_First_name 'Skater First Name',
		skater.skater_Last_name 'Skater Last Name', 
		competition.Competition_Name 'Competition Name',
        placecity.PlaceCity_Name 'City of the Competition',
		placecountry.PlaceCountry_Name 'Country of the Competition',
		competition.Competition_Year 'Year of the Competition',
        skatercompetition.ScoreShortProgram 'Score for Short Program',
        skatercompetition.RankShortProgram 'Rank after Short Program',
        skatercompetition.ScoreFreeSkate 'Score for Free Skate',
        skatercompetition.RankFreeSkate 'Rank after Free Skate',
        skatercompetition.OverallRankingResult 'Overall Rank',
        jumps.jump_Name 'Name of the Jump',
        competitonjumpscore.jump_Score 'Score for the Jump',
        jumps.jump_BaseValue 'Jump Base value',
        Case 
			 when jumps.jump_BaseValue > competitonjumpscore.jump_Score Then 'Fall'
			 WHEN jumps.jump_BaseValue < competitonjumpscore.jump_Score Then 'Landed'
		End as IfFall
	from skater
		Left Join skatercompetition on skater.skater_ID = skatercompetition.skater_ID
        Left Join competition on skatercompetition.competition_ID = competition.competition_ID 
        Left Join placecity on competition.Competition_PlaceCity = placecity.PlaceCity_ID
        Left Join placecountry on competition.Competition_PlaceCountry = placecountry.PlaceCountry_ID
        Left Join competitonjumpscore on skatercompetition.SkaterCompetition_ID = competitonjumpscore.SkaterCompetition_ID
        Left Join jumps on competitonjumpscore.jump_ID = jumps.jump_ID
		where jump_Name is not null 
        order by skater.skater_ID;

select * from Skater_Competition;
    
  