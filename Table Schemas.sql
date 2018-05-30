CREATE TABLE Banks(
BankName VARCHAR(100),
City VARCHAR(100),
NoAccounts INTEGER CONSTRAINT accountchk
  CHECK (NoAccounts >= 0),
Security VARCHAR(100),
	PRIMARY KEY(BankName, City)
);

 CREATE TABLE Robberies(
	BankName VARCHAR(100),
	City VARCHAR(100),
	Date DATE,
	Amount DOUBLE PRECISION CONSTRAINT amountchk
		CHECK (Amount >= 0),
	FOREIGN KEY(BankName, City) 
REFERENCES Banks(BankName, City)
ON DELETE SET NULL
ON UPDATE SET NULL
CONSTRAINT uniqRobbery UNIQUE (BankName,City,Date)
);

 CREATE TABLE Plans(
	BankName VARCHAR(100),
	City VARCHAR(100),
	NoRobbers INTEGER CONSTRAINT robberchk
		CHECK (NoRobbers >= 0),
	PlannedDate DATE NOT NULL,
FOREIGN KEY(BankName, City) 
REFERENCES Banks(BankName, City)
ON DELETE CASCADE
ON UPDATE CASCADE
);


CREATE TABLE Robbers(
	RobberId SERIAL,
	Nickname VARCHAR(100),
	Age INTEGER CONSTRAINT agechk
CHECK (Age >= 0),
	NoYears INTEGER CONSTRAINT yrchk
		CHECK (NoYears >= 0 AND NoYears < Age),
	PRIMARY KEY(RobberId)
);

CREATE TABLE Skills(
	SkillId SERIAL,
	Description VARCHAR(100) NOT NULL,
	PRIMARY KEY(SkillId)
	CONSTRAINT uniqDescr UNIQUE (Description)
);

CREATE TABLE HasSkills(
	RobberId INTEGER,
	SkillId INTEGER,
	Preference INTEGER CONSTRAINT preferencechk
		CHECK (Preference >= 0),
	Grade VARCHAR(100),
	FOREIGN KEY(RobberId) 
REFERENCES Robbers(RobberId)
ON DELETE CASCADE,
	FOREIGN KEY(SkillId) 
REFERENCES Skills(SkillId)
ON DELETE CASCADE
CONSTRAINT uniqPref UNIQUE (RobberId, Preference)
);


CREATE TABLE HasAccounts(
	RobberId INTEGER,
	BankName VARCHAR(100),
	City VARCHAR(100),
	FOREIGN KEY(RobberId) 
REFERENCES Robbers(RobberId)
ON DELETE CASCADE,
	FOREIGN KEY(BankName, City) 
REFERENCES Banks(BankName, City)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE Accomplices(
	RobberId INTEGER,
	BankName VARCHAR(100),
	City VARCHAR(100),
	RobberyDate DATE,
	Share DOUBLE PRECISION CONSTRAINT sharechk
		CHECK (Share >= 0),
	FOREIGN KEY(RobberId) 
REFERENCES Robbers(RobberId)
ON DELETE SET NULL,
	FOREIGN KEY(BankName, City) 
REFERENCES Banks(BankName, City)
ON DELETE CASCADE
ON UPDATE CASCADE
);
