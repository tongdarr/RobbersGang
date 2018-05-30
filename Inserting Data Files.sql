\copy Banks FROM Desktop/Pro1/banks_18.data 



CREATE TABLE temp(                                                                                 
Nickname VARCHAR(100),                                                                                           
Age INTEGER,                                                                                                     
NoYears INTEGER                                                                                                  
);

\copy temp FROM Desktop/Pro1/robbers_18.data; 

INSERT INTO Robbers (Nickname, Age, NoYears)                                                           
SELECT Nickname, Age, NoYears FROM temp;

DROP TABLE temp;



CREATE TABLE temp(                                                                    
Nickname VARCHAR(100), 
BankName VARCHAR(100),                                                                    
City VARCHAR(100)                                                                                                
);

\copy temp (Nickname, BankName, City) FROM Desktop/Pro1/hasaccounts_18.data; 

INSERT INTO hasAccounts (RobberId, BankName, City)
SELECT RobberId, BankName, City FROM temp NATURAL JOIN Robbers;

DROP TABLE temp;



CREATE TABLE temp(                                                                                 
Nickname VARCHAR(100),
BankName VARCHAR(100),
City VARCHAR(100),
RobberyDate DATE,
Share DOUBLE PRECISION                                                                                              
);

\copy temp (Nickname, BankName, City, RobberyDate, Share) FROM Desktop/Pro1/accomplices_18.data; 

INSERT INTO Accomplices (RobberId, BankName, City, RobberyDate, Share)
SELECT RobberId, BankName, City, RobberyDate, Share FROM temp NATURAL JOIN Robbers;

DROP TABLE temp;



CREATE TABLE temp(                                                                                 
Nickname VARCHAR(100),
Description VARCHAR(100),
Preference INTEGER CONSTRAINT preferencechk
		CHECK (Preference >= 0),
	Grade VARCHAR(100)                                                                               
);

\copy temp (Nickname, Description, Preference, Grade) FROM Desktop/Pro1/hasskills_18.data; 

INSERT INTO Skills (Description)
SELECT DISTINCT Description FROM temp;

INSERT INTO hasSkills(RobberId, SkillId, Preference, Grade)
SELECT RobberId, SkillId, Preference, Grade FROM (temp LEFT JOIN Skills ON temp.Description = Skills.Description) LEFT JOIN Robbers ON temp.Nickname = Robbers.Nickname;

DROP TABLE temp;



\copy Plans (BankName, City, PlannedDate, NoRobbers) FROM Desktop/Pro1/plans_18.data; 



\copy Robberies (BankName, City, Date, Amount) FROM Desktop/Pro1/robberies_18.data; 
