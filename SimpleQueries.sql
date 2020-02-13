--Retrieve BankName and Security for all banks in Chicago that have more than 9000 accounts
SELECT BankName, Security FROM Banks
WHERE City=’Chicago’ AND NoAccounts > 9000;

--Retrieve BankName of all banks where Calamity Jane has an account. The answer should list every bank at most once.
SELECT DISTINCT BankName FROM HasAccounts
LEFT JOIN Robbers ON HasAccounts.RobberId = Robbers.RobberId
WHERE Robbers.Nickname = 'Calamity Jane';

--Retrieve BankName and City of bank branches that have no branch in Chicogo. 
--The answer should be sorted in inreasing order of the number of accounts.
SELECT BankName, City FROM Banks
WHERE City != 'Chicago' ORDER BY NoAccounts ASC;

--Retrieve RobberId, Nickname and individual total "earnings". 
--The answer should be sorted in decreasing order of the total earnings.
SELECT RobberId, Nickname, SUM(Share) AS Total_Earnings FROM Robbers 
NATURAL JOIN Accomplices 
GROUP BY RobberId
ORDER BY SUM(Share) DESC;

--Retrieve RobberId, NickName, and the Number of Years in Prison for all robbers who were in prison for more than three years.
SELECT RobberId, Nickname, NoYears FROM Robbers
WHERE NoYears > 3;

--Retrieve RobberId, NickName and the Number of Years not spent in prison for all robebrs who spent more than half of their life in prison.
SELECT RobberId, Nickname, (Age-NoYears) as NoYears_not_in_Prison FROM Robbers
WHERE NoYears > (Age/2);
