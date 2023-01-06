# Russian_women_figure_skating_MySQL
This is a database of Russian women figure skaters and their achievements on international competitions throughout their career made by DDL and DML in MySQL.

This information system represents preview of all personal information about Russian women figure skaters and their achievements in the international competitions throughout their career.

Information system meet the following conditions:
-	Each skater should have an information about their first and last name, date and place of birth, their height and start of their figure skating career. 
-	Each skater can have several coaches and only one training club at a time. Skaters can change clubs as well as coaches throughout their career. if the skater is already retired, then his last coaching staff and club should be listed as current. 
-	Personal details about coaches should provide data about their first and last name, date of birth together with start of their coach career and coach function. Each coach should have only one function.
-	Information about club should contain name of the club, location, and year it was established. Year when the club was established can be unknown.
-	Each skater should have at least three programs during the season – Short program, Free skate and Exhibition program. They can change programs during the season, but one program should be skated by only one skater in the season. One program can be used by skater as both competition and exhibition.
-	Each skater can compete on many international competitions that being hold by different cities and countries. Each skater performs short program and free skate during the competition and getting scored based on their performance. Exhibition programs are not evaluated, and top 5 skaters by the results of the competition perform them on the show after the end of the competition.
-	During each competition each skater perform numerous jumps during both their short program and free skate and all jumps are getting scored. Each jump has a base value that can be increased or decreased according to its performance. Each skater can jump the same jump twice or more during each type of program.
-	All information should be stored only in English.

