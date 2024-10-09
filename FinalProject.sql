create database DBAgency
use DBAgency

/* CREATION*/

/* Table: Agency*/
CREATE TABLE Agency (AgtCode CHAR(5) PRIMARY KEY,AgtName VARCHAR(25) NOT NULL, AgtAddress VARCHAR(30) NOT NULL, AgtTel1 VARCHAR(13) CHECK (AgtTel1 LIKE '[(0-9)][(0-9)][(0-9)]%'),  AgtTel2 VARCHAR(13) CHECK (AgtTel2 LIKE '[(0-9)][(0-9)][(0-9)]%'));

/*Table: Client*/
CREATE TABLE Client (Client_ID CHAR(10) PRIMARY KEY NOT NULL,    AgencyCode CHAR(5) REFERENCES Agency(AgtCode),CliLastName VARCHAR(25) NOT NULL,CliFirstName VARCHAR(25) NOT NULL, CliAddress VARCHAR(30) NOT NULL,ClientTel VARCHAR(14) CHECK (ClientTel LIKE '[(0-9)][(0-9)][(0-9)]%') );

-- Table: Account
CREATE TABLE Account (Client_ID CHAR(10) REFERENCES Client(Client_ID),AccType CHAR(1) CHECK (AccType IN ('C', 'S', 'V')),OpenDate DATETIME NOT NULL,Balance MONEY );
    
--Table Transactions
CREATE TABLE Transactions (Client_ID CHAR(10)REFERENCES Client(Client_ID), AccType CHAR(1)CHECK (AccType IN ('C', 'S', 'V')) ,TransDate DATETIME NOT NULL,TransType CHAR(1) CHECK (TransType IN ('R', 'D')),Amount MONEY CHECK (Amount >= 0));








/* Insert values into table Agency*/
INSERT INTO AGENCY VALUES ('A0001', 'Agency Centre-Ville', '1 Place Ville-Marie', '(514)999-9999', '(514)999-9998')
INSERT INTO AGENCY VALUES ('A0002', 'Agency Rive-Sud', '25 Bd Tachereau', '(450)444-4443', '(450)434-4444')
INSERT INTO AGENCY VALUES ('A0003', 'Agency Laval', '3000 Rue Saguenay', '(450)333-3333', '(450)333-3331')
INSERT INTO AGENCY VALUES ('A0004', 'Agency NDG', '145 Rue Pivot', '(514)744-6767', '(222)222-2222')



/*insert values into table client*/
insert into client values('C100111001',	'A0001'	,'Tremblay'	,'Sophie',	'12 Rue St-Denis #7',	'(514)765-9899')
insert into client values('C100111002',	'A0001',	'Choquette',	'Alain',	'145 Av Papineau #15',	'(514)235-1314)')
insert into client values('C100111003'	,'A0001',	'Nassim',	'Ali'	,'2345 place Ardenne'	,'(450)445-5676')
insert into client values('C100112001',	'A0002'	,'Maggs',	'Steve',	'101 Rue Marlo #12',	'(450)345-6767')
insert into client values('C100113002'	,'A0003'	,'Bonvi',	'Betty',	'10 Rue Bolero'	,'(450)332-2222')
insert into client values('C100113003'	,'A0003'	,'Thran Ti',	'Quan',	'104 Rue Saguenay'	,'(450)340-8907')

/*insert values into table account*/
insert into Account values('C100111001',	'C',	'1996-10-10',	'5000')
insert into Account values('C100111001',	'S'	,'1996-11-20'	,'3000')
insert into Account values('C100111002',	'C'	,'1997-03-13'	,'12300')
insert into Account values('C100111003',	'C'	,'1998-12-23'	,'1200')
insert into Account values('C100111003',	'V',	'1998-10-09',	'5000')
insert into Account values('C100112001',	'C'	,'1998-09-15'	,'7600')
insert into Account values('C100113002',	'C'	,'1998-03-24'	,'1300')
insert into Account values('C100113003',	'C'	,'1995-12-04'	,'4500')

/*insert values into table Transactions*/
insert into transactions values('C100111001',	'C',	'1997-12-13',	'R',	'60')
insert into transactions values('C100111001',	'C',	'1997-12-20',	'D'	,'800')
insert into transactions values('C100111001',	'S'	,'1997-12-15',	'D'	,'300')
insert into transactions values('C100111001',	'S',	'1997-12-23',	'R',	'100')
insert into transactions values('C100111002',	'C',	'1997-03-20',	'D'	,'1000')
insert into transactions values('C100111002',	'C',	'1997-03-25',	'R'	,'40')
insert into transactions values('C100111002',	'C'	,'1997-05-20'	,'D'	,'500')
insert into transactions values('C100111002',	'C'	,'1997-08-20'	,'R'	,'80')
insert into transactions values('C100111003',	'C'	,'1998-12-25'	,'D'	,'1000')
insert into transactions values('C100111003',	'C'	,'1999-10-01'	,'R',	'100')
insert into transactions values('C100111003',	'C'	,'1999-12-01'	,'D',	'100')
insert into transactions values('C100111003',	'V'	,'1998-09-11'	,'R',	'100')
insert into transactions values('C100111003',	'V'	,'1998-10-12'	,'D',	'70')
insert into transactions values('C100111003',	'V'	,'1998-11-13'    ,'D',	'30')
insert into transactions values('C100113002',	'C'	,'1999-02-04'	,'D'	,'1000')



/*SELECTION*/

/*1*/
select agtcode as AgentCode,agtname as Name,agtaddress as Address,Agttel1 as Telephone1,Agttel2 as Telephone2 from Agency
select Client_ID,AgencyCode,clilastname as LastName,clifirstname as FirstName,cliaddress as Address,clienttel as Telephone from Client
select Client_ID,AccType as AccountType,OpenDate,Balance from Account
select Client_ID,AccType as AccountType,Transdate as TransactionDate,Amount from Transactions
/*2*/
SELECT c.Client_ID , c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", CASE a.AccType WHEN 'C' THEN 'Chequing Account' WHEN 'S' THEN 'Savings Account'  WHEN 'V' THEN 'Visa Account' ELSE 'Unknown Account Type' END AS "Account Type" FROM CLIENT c JOIN  ACCOUNT a ON c.Client_ID = a.Client_ID;
/*3*/
SELECT c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", t.TransDate AS "Transaction Date", t.AccType AS "Account Type", t.TransType AS "Type of Transaction" FROM CLIENT c  JOIN Transactions t ON c.Client_ID = t.Client_ID;
/*4*/
SELECT DISTINCT c.Client_ID , c.CliLastName AS "Last Name", c.CliFirstName AS "First Name"FROM CLIENT c JOIN Transactions t ON c.Client_ID = t.Client_ID WHERE YEAR(t.TransDate) = 1999;

/*5*/
SELECT c.CliLastName AS "Last Name",c.CliFirstName AS "First Name",t.TransType , COUNT(t.TransType) AS "Number of Transactions", SUM(t.Amount) AS "Total Of Amount Of Transactions"FROM CLIENT c JOIN Transactions t ON c.Client_ID = t.Client_ID GROUP BY c.Client_ID, c.CliLastName, c.CliFirstName, t.TransType;

/*6*/
SELECT a.AccType AS "AccType", SUM(CASE WHEN YEAR(t.TransDate) = 1997 AND t.TransType = 'C' THEN t.Amount ELSE 0 END) AS "1997 Credit", SUM(CASE WHEN YEAR(t.TransDate) = 1997 AND t.TransType = 'D' THEN t.Amount ELSE 0 END) AS "1997 Debit", SUM(CASE WHEN YEAR(t.TransDate) = 1998 AND t.TransType = 'C' THEN t.Amount ELSE 0 END) AS "1998 Credit", SUM(CASE WHEN YEAR(t.TransDate) = 1998 AND t.TransType = 'D' THEN t.Amount ELSE 0 END) AS "1998 Debit", SUM(CASE WHEN YEAR(t.TransDate) = 1999 AND t.TransType = 'C' THEN t.Amount ELSE 0 END) AS "1999 Credit",SUM(CASE WHEN YEAR(t.TransDate) = 1999 AND t.TransType = 'D' THEN t.Amount ELSE 0 END) AS "1999 Debit"FROM ACCOUNT a LEFT JOIN  Transactions t ON a.Client_ID = t.Client_ID WHERE YEAR(t.TransDate) BETWEEN 1997 AND 1999 GROUP BY a.AccType ORDER BY  a.AccType;

/*7*/
SELECT c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", a.Balance AS "Checking Account Balance"FROM CLIENT c JOIN ACCOUNT a ON c.Client_ID = a.Client_ID WHERE a.AccType = 'C' AND a.Balance > (SELECT AVG(Balance) FROM ACCOUNT WHERE AccType = 'C');

/*8*/
UPDATE ACCOUNT SET Balance = Balance * POWER(1 + 0.003, DATEDIFF(MONTH, OpenDate, GETDATE()))WHERE AccType = 'S';
select * from Account

/*9*/
UPDATE ACCOUNT SET Balance = a.Balance FROM ACCOUNT a LEFT JOIN (SELECT Client_ID, SUM(Amount) AS TotalTransactionAmount FROM Transactions GROUP BY Client_ID) t ON a.Client_ID = t.Client_ID;

/*10*/
CREATE VIEW AgencyCentre AS SELECT  c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", a.AccType AS "Account Type", a.Balance AS "Account Balance" FROM CLIENT c JOIN ACCOUNT a ON c.Client_ID = a.Client_ID WHERE c.AgencyCode = 'A0001';

CREATE VIEW AgencyLaval AS SELECT c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", a.AccType AS "Account Type", a.Balance AS "Account Balance" FROM CLIENT c JOIN ACCOUNT a ON c.Client_ID = a.Client_ID WHERE c.AgencyCode = 'A0002';

CREATE VIEW AgencyRiveSud AS SELECT c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", a.AccType AS "Account Type", a.Balance AS "Account Balance" FROM  CLIENT c JOIN  ACCOUNT a ON c.Client_ID = a.Client_ID WHERE  c.AgencyCode = 'A0003';

CREATE VIEW AgencyNDG AS SELECT c.CliLastName AS "Last Name", c.CliFirstName AS "First Name", a.AccType AS "Account Type", a.Balance AS "Account Balance" FROM CLIENT c JOIN ACCOUNT a ON c.Client_ID = a.Client_ID WHERE c.AgencyCode = 'A0004';

select * from AgencyCentre 
select * from AgencyLaval 
select * from AgencyRivesud 
select * from AgencyNDG

/*11*/
SELECT Client_ID, CliLastName AS "Last Name", CliFirstName AS "First Name" FROM CLIENT WHERE Client_ID NOT IN (SELECT DISTINCT Client_ID FROM Transactions);
