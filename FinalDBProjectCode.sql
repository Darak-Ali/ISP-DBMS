create database ISP
CREATE TABLE Addresses (
    AddressID INT PRIMARY KEY IDENTITY(1,1),
    StreetAddress VARCHAR(255),
    City VARCHAR(255),
    District VARCHAR(255),
    ZipCode VARCHAR(255)
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(255),
    AddressID INT FOREIGN KEY REFERENCES Addresses(AddressID),
	EquipmentID INT Foreign KEY REFERENCES Equipment(EquipmentID)
);

CREATE TABLE Servicess (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName VARCHAR(255),
    ServiceDescription VARCHAR(255),
    MonthlyFee float
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ServiceID INT FOREIGN KEY REFERENCES Servicess(ServiceID),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Billing (
    BillingID INT PRIMARY KEY IDENTITY(1,1),
    SubscriptionID INT FOREIGN KEY REFERENCES Subscriptions(SubscriptionID),
    BillingDate DATE,
    AmountDue float,
    DueDate DATE
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    BillingID INT FOREIGN KEY REFERENCES Billing(BillingID),
    PaymentDate DATE,
    PaymentAmount float
);

CREATE TABLE Usage (
    UsageID INT PRIMARY KEY IDENTITY(1,1),
    SubscriptionID INT FOREIGN KEY REFERENCES Subscriptions(SubscriptionID),
    UsageDate DATE,
    DataUsed float,
	UsageBytes varchar(255)
);
CREATE TABLE Technicians (
    TechnicianID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    PhoneNumber VARCHAR(255),
	EquipmentID INT Foreign KEY REFERENCES Equipment(EquipmentID),
	OfficeID INT FOREIGN KEY REFERENCES ServiceOffices(OfficeID)
);

CREATE TABLE Issues (
    IssueID INT PRIMARY KEY IDENTITY(1,1),
   CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    IssueDescription VARCHAR(255),
    DateCreated DATE,
    DateResolved DATE,
	TechnicianID INT FOREIGN KEY REFERENCES Technicians(TechnicianID)
);



CREATE TABLE Equipment (
    EquipmentID INT PRIMARY KEY IDENTITY(1,1),
    EquipmentName VARCHAR(255),
    EquipmentDescription VARCHAR(255)
);



CREATE TABLE ServiceOffices (
   OfficeID INT PRIMARY KEY IDENTITY (1,1),
   City VARCHAR(255),
   ZipCode VARCHAR(255)
);

CREATE TABLE Promotions (
   PromotionID INT PRIMARY KEY IDENTITY(1,1),
   ServiceID INT FOREIGN KEY REFERENCES Servicess(ServiceID),
   PromotionName VARCHAR(255),
   PromotionDescription VARCHAR(255),
   StartDate DATE,
   EndDate DATE
);

CREATE TABLE Contracts (
   ContractID INT PRIMARY KEY IDENTITY(1,1),
   CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
   ServiceID INT FOREIGN KEY REFERENCES Servicess(ServiceID),
   StartDate DATE,
   EndDate DATE
);

----------------------------------------------------------------------ALTER-----------------------------------------------------------------------------

--DROP Queries
ALTER TABLE Customers
DROP COLUMN PhoneNumber;

ALTER TABLE Servicess
DROP COLUMN MonthlyFee;

ALTER TABLE Payments
DROP COLUMN PaymentAmount;

ALTER TABLE Billing
DROP COLUMN AmountDue;

ALTER TABLE Addresses
DROP COLUMN District;

ALTER TABLE Customers
DROP COLUMN Email;

ALTER TABLE Issues
DROP COLUMN IssueDescription;

ALTER TABLE Usage
DROP COLUMN UsageBytes;

ALTER TABLE Usage
DROP COLUMN DataUsed;

ALTER TABLE Equipment
DROP COLUMN EquipmentDescription;

ALTER TABLE Promotions
DROP COLUMN StartDate;

ALTER TABLE ServiceOffices
DROP COLUMN ZipCode;

ALTER TABLE Servicess
DROP COLUMN ServiceName;

ALTER TABLE Addresses
DROP COLUMN City;

ALTER TABLE Contracts
DROP COLUMN StartDate;


--ADD Queries
ALTER TABLE Customers
ADD PhoneNumber INT;
ALTER TABLE Servicess
ADD MonthlyFee float;
ALTER TABLE Payments
ADD PaymentAmount float;
ALTER TABLE Billing
ADD AmountDue float;
ALTER TABLE Addresses
ADD District VARCHAR(255);
ALTER TABLE Customers
ADD Email VARCHAR(255);
ALTER TABLE Issues
ADD IssueDescription VARCHAR(255);
ALTER TABLE Usage
ADD UsageBytes varchar(255);
ALTER TABLE Usage
ADD DataUsed FLOAT;
ALTER TABLE Equipment
ADD EquipmentDescription VARCHAR(255);
ALTER TABLE Promotions
ADD StartDate DATE;
ALTER TABLE ServiceOffices
ADD ZipCode VARCHAR(255);
ALTER TABLE Servicess
ADD ServiceName VARCHAR(255);
ALTER TABLE Addresses
ADD City VARCHAR(255);
ALTER TABLE Contracts
ADD StartDate DATE;

--DATATYPE__________________
ALTER TABLE ServiceOffices
ALTER COLUMN ZipCode INT;
ALTER TABLE Customers
ALTER COLUMN PhoneNumber INT;
ALTER TABLE Payments
ALTER COLUMN PaymnetAmount INT;
ALTER TABLE Promotions
ALTER COLUMN StartDate DATETIME;
ALTER TABLE  Billing
ALTER COLUMN AmountDue INT;
ALTER TABLE Usage
ALTER COLUMN DataUsed Decimal;
ALTER TABLE  Servicess
ALTER COLUMN MonthlyFee Decimal;
ALTER TABLE Issues
ALTER COLUMN IssueDescription VARCHAR(MAX);
ALTER TABLE Usage
ALTER COLUMN UsageBytes FLOAT;
ALTER TABLE Technicians
ALTER COLUMN PhoneNumber INT;

--RENAME-----------------------------
exec sp_rename 'Customers.PhoneNumber', 'CellNumber', 'COLUMN';
exec sp_rename 'Servicess.ServiceID', 'S_ID', 'COLUMN';
exec sp_rename 'Subscriptions.StartDate', 'DateStarted', 'COLUMN';
exec sp_rename 'Billing.BillingDate', 'Date_Of_Billing', 'COLUMN';
exec sp_rename 'Payments.PaymentAmount', 'P_Amount', 'COLUMN';
exec sp_rename 'Usage.UsageBytes', 'TotalBytesUsed', 'COLUMN';
exec sp_rename 'Issues.DateResolved', 'DateOfIssueResolved', 'COLUMN';
exec sp_rename 'Technicians.FirstName', 'TechnicianFirstName', 'COLUMN';
exec sp_rename 'ServiceOffices.ZipCode', 'PostalCode', 'COLUMN';
exec sp_rename 'Promotions.EndDate', 'EndDateOfPromotion', 'COLUMN';

--INSERT INTO--------------------
INSERT INTO Customers(FirstName,LastName,Email,PhoneNumber,AddressID,EquipmentID)
VALUES('Ali','Khan','Ali@gmail.com',0300965, 1,1)

INSERT INTO Servicess(ServiceName,ServiceDescription,MonthlyFee)
VALUES('XYZ','4Mb Network',2000)

INSERT INTO Subscriptions(CustomerID,ServiceID,StartDate,EndDate)
VALUES(1,1,GETDATE(),GETDATE())

INSERT INTO Billing(SubscriptionID,BillingDate,AmountDue,DueDate)
VALUES(1,GETDATE(),2000,GETDATE())

INSERT INTO Payments(BillingID,PaymentDate,PaymentAmount)
VALUES(1,GETDATE(),2000)

INSERT INTO Usage(SubscriptionID,UsageDate,DataUsed,UsageBytes)
VALUES(1,GETDATE(),24,'GB')

INSERT INTO Technicians(FirstName,LastName,PhoneNumber,EquipmentID,OfficeID)
VALUES('Kamran','Ali',0300213213,1,1)

INSERT INTO Addresses(StreetAddress,City,District,ZipCode )
VALUES('Street ABC','Bhalwal','Sargodha',40404)

INSERT INTO ServiceOffices(City,ZipCode)
VALUES('Lahore',40410)

INSERT INTO Contracts(CustomerID,ServiceID,StartDate,EndDate)
VALUES(1,1,GETDATE(),GETDATE())

---SELECT AND DISTINCT-------------------------

Select * from Customers 

SELECT FirstName, LastName 
FROM Customers;

SELECT * FROM Servicess
WHERE MonthlyFee > 2000;

SELECT COUNT(*) 
FROM Subscriptions;

SELECT AVG(MonthlyFee) 
FROM Servicess;

SELECT * FROM ServiceOffices
WHERE City = 'Lahore';

SELECT * FROM Customers 
WHERE PhoneNumber LIKE '%5';

SELECT * FROM Issues 
WHERE DateResolved IS NULL;

SELECT * FROM Issues 
WHERE TechnicianID = 2;

SELECT SUM(PaymentAmount) FROM Payments
WHERE PaymentDate BETWEEN '2023-01-01' AND '2023-12-31';

SELECT DISTINCT LastName
FROM Technicians;

SELECT DISTINCT City
FROM Addresses;

SELECT AVG(DISTINCT PaymentAmount)
FROM Payments;

SELECT SUM(DISTINCT MonthlyFee) 
FROM Servicess;
SELECT COUNT(DISTINCT City)
FROM Addresses;
SELECT DISTINCT City FROM Addresses 
WHERE ZipCode = '40410' OR ZipCode = '40404';
SELECT DISTINCT StartDate FROM Subscriptions 
WHERE EndDate IS NULL;
SELECT DISTINCT ZipCode FROM ServiceOffices
WHERE City = 'Lahore' OR City = 'Karachi';
SELECT DISTINCT PhoneNumber FROM Customers
WHERE FirstName = 'Ali' AND LastName = 'Khan';
SELECT DISTINCT BillingDate 
FROM Billing WHERE AmountDue > 4000;


--16--------MAX----------------------------------

SELECT MAX(MonthlyFee) AS MaxMonthlyFee
FROM Servicess;

SELECT MAX(AmountDue) AS MaxAmountDue
FROM Billing;

SELECT MAX(PaymentAmount) AS MaxPaymentAmount
FROM Payments;

SELECT MAX(DataUsed) AS MaxDataUsed
FROM Usage;

SELECT MAX(DateResolved) AS LatestResolutionDate
FROM Issues;

--Min

SELECT MIN(MonthlyFee) AS MinMonthlyFee
FROM Servicess;

SELECT MIN(AmountDue) AS MinAmountDue
FROM Billing;

SELECT MIN(PaymentAmount) AS MinPaymentAmount
FROM Payments;

SELECT MIN(DataUsed) AS MinDataUsed
FROM Usage;

SELECT MIN(DateResolved) AS EarliestResolutionDate
FROM Issues;

--------------------SUM
:
SELECT SUM(MonthlyFee) AS TotalMonthlyFee
FROM Servicess;

SELECT SUM(AmountDue) AS TotalAmountDue
FROM Billing;

SELECT SUM(PaymentAmount) AS TotalPaymentAmount
FROM Payments;

SELECT SUM(DataUsed) AS TotalDataUsed
FROM Usage;

SELECT SUM(DATEDIFF(day, DateCreated, DateResolved)) AS TotalDaysToResolve
FROM Issues;
----COUNT

SELECT COUNT(*) AS TotalServices
FROM Servicess;

SELECT COUNT(*) AS TotalBillings
FROM Billing;

SELECT COUNT(*) AS TotalPayments
FROM Payments;

SELECT COUNT(*) AS TotalUsageRecords
FROM Usage;

SELECT COUNT(*) AS TotalIssues
FROM Issues;
--AVG

SELECT AVG(MonthlyFee) AS AvgMonthlyFee
FROM Servicess;

SELECT AVG(AmountDue) AS AvgAmountDue
FROM Billing;

SELECT AVG(PaymentAmount) AS AvgPaymentAmount
FROM Payments;

SELECT AVG(DataUsed) AS AvgDataUsed
FROM Usage;

SELECT AVG(DATEDIFF(day, DateCreated, DateResolved)) AS AvgDaysToResolve
FROM Issues;
--17--------------------------------------------

SELECT SUM(MonthlyFee) AS TotalMonthlyFee
FROM Servicess
WHERE MonthlyFee > 50;

SELECT AVG(AmountDue) AS AvgAmountDue
FROM Billing
WHERE AmountDue < 100;

SELECT MAX(PaymentAmount) AS MaxPaymentAmount
FROM Payments
WHERE PaymentDate > '2022-01-01';

SELECT MIN(DataUsed) AS MinDataUsed
FROM Usage
WHERE UsageDate < '2022-01-01';
SELECT COUNT(*) AS TotalInternetIssues
FROM Issues
WHERE IssueDescription LIKE '%internet%';

SELECT ServiceName, SUM(MonthlyFee) AS TotalMonthlyFee
FROM Servicess
GROUP BY ServiceName;

SELECT BillingDate, AVG(AmountDue) AS AvgAmountDue
FROM Billing
GROUP BY BillingDate;

SELECT BillingID, MAX(PaymentAmount) AS MaxPaymentAmount
FROM Payments
GROUP BY BillingID;

SELECT SubscriptionID, MIN(DataUsed) AS MinDataUsed
FROM Usage
GROUP BY SubscriptionID;

SELECT CustomerID, COUNT(*) AS TotalIssues
FROM Issues
GROUP BY CustomerID;

SELECT ServiceName, SUM(MonthlyFee) AS TotalMonthlyFee
FROM Servicess
WHERE MonthlyFee > 50
GROUP BY ServiceName;

SELECT BillingDate, AVG(AmountDue) AS AvgAmountDue
FROM Billing
WHERE AmountDue < 100
GROUP BY BillingDate;

SELECT BillingID, MAX(PaymentAmount) AS MaxPaymentAmount
FROM Payments
WHERE PaymentDate > '2022-01-01'
GROUP BY BillingID;

SELECT SubscriptionID, MIN(DataUsed) AS MinDataUsed
FROM Usage
WHERE UsageDate < '2022-01-01'
GROUP BY SubscriptionID;

SELECT CustomerID, COUNT(*) AS TotalInternetIssues
FROM Issues
WHERE IssueDescription LIKE '%internet%'
GROUP BY CustomerID;

SELECT SUM(MonthlyFee) AS TotalMonthlyFee 
FROM Servicess 
WHERE MonthlyFee > 50 AND MonthlyFee < 100;

SELECT AVG(AmountDue) AS AvgAmountDue 
FROM Billing 
WHERE AmountDue < 100 OR AmountDue > 200;

SELECT MAX(PaymentAmount) AS MaxPaymentAmount 
FROM Payments 
WHERE PaymentDate > '2022-01-01' AND PaymentAmount < 500;
SELECT MIN(DataUsed) AS MinDataUsed 
FROM Usage 
WHERE UsageDate < '2022-01-01' AND DataUsed > 1;

SELECT COUNT(*) AS TotalInternetCableIssues 
FROM Issues 
WHERE IssueDescription LIKE '%internet%' OR IssueDescription LIKE '%cable%';

SELECT ServiceName, SUM(MonthlyFee) AS TotalMonthlyFee
FROM Servicess
WHERE MonthlyFee > 50 AND MonthlyFee < 100
GROUP BY ServiceName;

SELECT BillingDate, AVG(AmountDue) AS AvgAmountDue
FROM Billing
WHERE AmountDue < 100 OR AmountDue > 200
GROUP BY BillingDate;
SELECT BillingID, MAX(PaymentAmount) AS MaxPaymentAmount
FROM Payments
WHERE PaymentDate > '2022-01-01' AND PaymentAmount < 500
GROUP BY BillingID;
SELECT SubscriptionID, MIN(DataUsed) AS MinDataUsed
FROM Usage
WHERE UsageDate < '2022-01-01' AND DataUsed > 1
GROUP BY SubscriptionID;
SELECT CustomerID, COUNT(*) AS TotalInternetCableIssues
FROM Issues
WHERE IssueDescription LIKE '%internet%' OR IssueDescription LIKE '%cable%'
GROUP BY CustomerID;
SELECT SUM(MonthlyFee) AS TotalMonthlyFee 
FROM Servicess 
WHERE ServiceName LIKE 'A%';
SELECT AVG(AmountDue) AS AvgAmountDue 
FROM Billing 
WHERE YEAR(BillingDate) = 2022;
SELECT MAX(PaymentAmount) AS MaxPaymentAmount 
FROM Payments 
WHERE MONTH(PaymentDate) = 1;

SELECT MIN(DataUsed) AS MinDataUsed 
FROM Usage 
WHERE DATENAME(WEEKDAY, UsageDate) = 'Monday';

SELECT COUNT(*) AS TotalDecemberInternetIssues 
FROM Issues 
WHERE IssueDescription LIKE '%internet%' AND MONTH(DateCreated) = 12;

--Q12----------------------------------------------------------------

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Subscriptions);

SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (SELECT ServiceID FROM Subscriptions);

SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Billing);

SELECT BillingID
FROM Billing
WHERE BillingID IN (SELECT BillingID FROM Payments);

SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Usage);

SELECT CustomerID
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Issues);

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Subscriptions);

SELECT ServiceName
FROM Servicess
WHERE ServiceID NOT IN (SELECT ServiceID FROM Subscriptions);

SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Billing);

SELECT BillingID
FROM Billing
WHERE BillingID NOT IN (SELECT BillingID FROM Payments);

SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Usage);

SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Issues);

SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Subscriptions 
    WHERE ServiceID IN (
        SELECT ServiceID 
        FROM Servicess 
        WHERE MonthlyFee > 50)
    );

SELECT ServiceName 
FROM Servicess 
WHERE ServiceID IN (
    SELECT ServiceID 
    FROM Subscriptions 
    WHERE StartDate > '2022-01-01'
    );

SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
    SELECT SubscriptionID 
    FROM Billing 
    WHERE AmountDue > 100
    );

SELECT BillingID 
FROM Billing 
WHERE BillingID IN (
    SELECT BillingID 
    FROM Payments 
    WHERE PaymentAmount > 100
    );

SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
    SELECT SubscriptionID 
    FROM Usage 
    WHERE DataUsed > 1
    );

SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Issues 
    WHERE IssueDescription LIKE '%internet%'
    );
SELECT AVG(MonthlyFee) AS AvgMonthlyFeeForA 
FROM Servicess 
WHERE ServiceName LIKE 'A%';
SELECT SUM(AmountDue) AS TotalAmountDueFor2022 
FROM Billing 
WHERE YEAR(BillingDate) = 2022;
SELECT MAX(PaymentAmount) AS MaxPaymentAmountForJanuary 
FROM Payments 
WHERE MONTH(PaymentDate) = 1;
SELECT MIN(DataUsed) AS MinDataUsedForMonday 
FROM Usage 
WHERE DATENAME(WEEKDAY, UsageDate) = 'Monday';
SELECT COUNT(*) AS TotalDecemberInternetIssues 
FROM Issues 
WHERE IssueDescription LIKE '%internet%' AND MONTH(DateCreated) = 12;
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Subscriptions
    WHERE ServiceID IN (
        SELECT ServiceID
        FROM Servicess
        WHERE ServiceName LIKE 'A%'
        )
    );
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (
    SELECT ServiceID
    FROM Subscriptions
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Billing
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT BillingID
FROM Billing
WHERE BillingID IN (
    SELECT BillingID
    FROM Payments
    WHERE payments.PaymentID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Usage
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Issues 
    WHERE IssueDescription LIKE '%internet%' AND FirstName LIKE 'A%'
);
SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Subscriptions 
   WHERE ServiceID IN (
      SELECT ServiceID 
      FROM Servicess 
      WHERE ServiceName LIKE 'A%' AND MonthlyFee > 50)
);
--Q13-------------------------------------
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Subscriptions);
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (SELECT ServiceID FROM Subscriptions);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Billing);
SELECT BillingID
FROM Billing
WHERE BillingID IN (SELECT BillingID FROM Payments);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Usage);
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Issues);
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Subscriptions);
SELECT ServiceName
FROM Servicess
WHERE ServiceID NOT IN (SELECT ServiceID FROM Subscriptions);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Billing);
SELECT BillingID
FROM Billing
WHERE BillingID NOT IN (SELECT BillingID FROM Payments);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Usage);
SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Issues);
SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Subscriptions 
    WHERE ServiceID IN (
        SELECT ServiceID 
        FROM Servicess 
        WHERE MonthlyFee > 50)
    );
SELECT ServiceName 
FROM Servicess 
WHERE ServiceID IN (
    SELECT ServiceID 
    FROM Subscriptions 
    WHERE StartDate > '2022-01-01'
    );
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
    SELECT SubscriptionID 
    FROM Billing 
    WHERE AmountDue > 100
    );
SELECT BillingID 
FROM Billing 
WHERE BillingID IN (
    SELECT BillingID 
    FROM Payments 
    WHERE PaymentAmount > 100
    );
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
    SELECT SubscriptionID 
    FROM Usage 
    WHERE DataUsed > 1
    );
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Issues 
    WHERE IssueDescription LIKE '%internet%'
    );
SELECT AVG(MonthlyFee) AS AvgMonthlyFeeForA 
FROM Servicess 
WHERE ServiceName LIKE 'A%';
SELECT SUM(AmountDue) AS TotalAmountDueFor2022 
FROM Billing 
WHERE YEAR(BillingDate) = 2022;
SELECT MAX(PaymentAmount) AS MaxPaymentAmountForJanuary 
FROM Payments 
WHERE MONTH(PaymentDate) = 1;
SELECT MIN(DataUsed) AS MinDataUsedForMonday 
FROM Usage 
WHERE DATENAME(WEEKDAY, UsageDate) = 'Monday';
SELECT COUNT(*) AS TotalDecemberInternetIssues 
FROM Issues 
WHERE IssueDescription LIKE '%internet%' AND MONTH(DateCreated) = 12;
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Subscriptions
    WHERE ServiceID IN (
        SELECT ServiceID
        FROM Servicess
        WHERE ServiceName LIKE 'A%'
        )
    );
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (
    SELECT ServiceID
    FROM Subscriptions
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Billing
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT BillingID
FROM Billing
WHERE BillingID IN (
    SELECT BillingID
    FROM Payments
    WHERE Payments.PaymentID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Usage
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE FirstName LIKE 'A%'
        )
    );
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Issues 
    WHERE IssueDescription LIKE '%internet%' AND FirstName LIKE 'A%'
);
SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Subscriptions 
   WHERE ServiceID IN (
      SELECT ServiceID 
      FROM Servicess 
      WHERE ServiceName LIKE 'A%' AND MonthlyFee > 50)
);
--------------------------------------------------------
-------Q13
SELECT * FROM Customers WHERE AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'New York' AND ZipCode = '10001')
SELECT * FROM Subscriptions WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe')
SELECT * FROM Billing WHERE SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE StartDate >= '2022-01-01' AND EndDate <= '2022-12-31')
SELECT * FROM Payments WHERE BillingID IN (SELECT BillingID FROM Billing WHERE AmountDue > 100 AND DueDate < GETDATE())
SELECT * FROM Usage WHERE SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE ServiceID IN (SELECT ServiceID FROM Servicess WHERE ServiceName = 'Internet' AND MonthlyFee < 50))
SELECT * FROM Issues WHERE TechnicianID IN (SELECT TechnicianID FROM Technicians WHERE FirstName = 'Jane' AND LastName = 'Smith')
SELECT * FROM Equipment WHERE EquipmentID IN (SELECT EquipmentID FROM Issues WHERE DateResolved IS NOT NULL AND DateCreated > '2022-01-01')
SELECT * FROM ServiceOffices WHERE City IN (SELECT City FROM Addresses WHERE District = 'Manhattan' AND ZipCode LIKE '100%')
SELECT * FROM Promotions WHERE StartDate >= '2022-01-01' AND EndDate <= '2022-12-31' AND PromotionName IN (SELECT ServiceName FROM Servicess)
SELECT * FROM Contracts WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'Los Angeles' AND District = 'Hollywood'))


SELECT * FROM Customers WHERE AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'New York' OR ZipCode = '90210')
SELECT * FROM Subscriptions WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE FirstName = 'John' OR LastName = 'Doe')
SELECT * FROM Billing WHERE SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE StartDate >= '2022-01-01' OR EndDate <= '2022-12-31')
SELECT * FROM Payments WHERE BillingID IN (SELECT BillingID FROM Billing WHERE AmountDue > 100 OR DueDate < GETDATE())
SELECT * FROM Usage WHERE SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE ServiceID IN (SELECT ServiceID FROM Servicess WHERE ServiceName = 'Internet' OR MonthlyFee < 50))
SELECT * FROM Issues WHERE TechnicianID IN (SELECT TechnicianID FROM Technicians WHERE FirstName = 'Jane' OR LastName = 'Smith')
SELECT * FROM Equipment WHERE EquipmentID IN (SELECT EquipmentID FROM Issues WHERE DateResolved IS NOT NULL OR DateCreated > '2022-01-01')
SELECT * FROM ServiceOffices WHERE City IN (SELECT City FROM Addresses WHERE District = 'Manhattan' OR ZipCode LIKE '100%')
SELECT * FROM Promotions WHERE StartDate >= '2022-01-01' OR EndDate <= '2022-12-31' OR PromotionName IN (SELECT ServiceName FROM Servicess)
SELECT * FROM Contracts WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'Los Angeles' OR District = 'Hollywood'))


SELECT * FROM Customers WHERE NOT AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'New York' AND ZipCode = '10001')
SELECT * FROM Subscriptions WHERE NOT CustomerID IN (SELECT CustomerID FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe')
SELECT * FROM Billing WHERE NOT SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE StartDate >= '2022-01-01' AND EndDate <= '2022-12-31')
SELECT * FROM Payments WHERE NOT BillingID IN (SELECT BillingID FROM Billing WHERE AmountDue > 100 AND DueDate < GETDATE())
SELECT * FROM Usage WHERE NOT SubscriptionID IN (SELECT SubscriptionID FROM Subscriptions WHERE ServiceID IN (SELECT ServiceID FROM Servicess WHERE ServiceName = 'Internet' AND MonthlyFee < 50))
SELECT * FROM Issues WHERE NOT TechnicianID IN (SELECT TechnicianID FROM Technicians WHERE FirstName = 'Jane' AND LastName = 'Smith')
SELECT * FROM Equipment WHERE NOT EquipmentID IN (SELECT EquipmentID FROM Issues WHERE DateResolved IS NOT NULL AND DateCreated > '2022-01-01')
SELECT * FROM ServiceOffices WHERE NOT City IN (SELECT City FROM Addresses WHERE District = 'Manhattan' AND ZipCode LIKE '100%')
SELECT * FROM Promotions WHERE NOT StartDate >= '2022-01-01' AND NOT EndDate <= '2022-12-31' AND NOT PromotionName IN (SELECT ServiceName FROM Servicess)
SELECT * FROM Contracts WHERE NOT CustomerID IN (SELECT CustomerID FROM Customers WHERE AddressID IN (SELECT AddressID FROM Addresses WHERE City = 'Los Angeles' AND District = 'Hollywood'))

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Subscriptions
    WHERE ServiceID IN (
        SELECT ServiceID
        FROM Servicess
        WHERE ServiceName LIKE '%internet%'
        )
    );
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (
    SELECT ServiceID
    FROM Subscriptions
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Billing
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%'
        )
    );
SELECT BillingID
FROM Billing
WHERE BillingID IN (
    SELECT BillingID
    FROM Payments
    WHERE Payments.PaymentID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%'
        )
    );
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Usage
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%'
        )
    );
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Issues 
   WHERE IssueDescription LIKE '%internet%' AND LastName LIKE '%Smith%'
);
SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Subscriptions 
   WHERE ServiceID IN (
      SELECT ServiceID 
      FROM Servicess 
      WHERE ServiceName LIKE '%internet%' AND MonthlyFee > 50)
);
SELECT ServiceName 
FROM Servicess 
WHERE ServiceID IN (
   SELECT ServiceID 
   FROM Subscriptions 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND StartDate > '2022-01-01'
);
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
   SELECT SubscriptionID 
   FROM Billing 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND AmountDue > 100
);
SELECT BillingID 
FROM Billing 
WHERE BillingID IN (
   SELECT BillingID 
   FROM Payments 
   WHERE Payments.PaymentID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND PaymentAmount > 100
);
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
   SELECT SubscriptionID 
   FROM Usage 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND DataUsed > 1
);
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Issues 
   WHERE IssueDescription LIKE '%internet%' AND LastName LIKE '%Smith%' AND MONTH(DateCreated) = 12
);
SELECT FirstName, LastName 
FROM Customers 
WHERE CustomerID IN (
   SELECT CustomerID 
   FROM Subscriptions 
   WHERE ServiceID IN (
      SELECT ServiceID 
      FROM Servicess 
      WHERE ServiceName LIKE '%internet%' AND MonthlyFee > 50) AND StartDate > '2022-01-01'
);
SELECT ServiceName 
FROM Servicess 
WHERE ServiceID IN (
   SELECT ServiceID 
   FROM Subscriptions 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND StartDate > '2022-01-01' AND EndDate < '2023-01-01'
);
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
   SELECT SubscriptionID 
   FROM Billing 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND AmountDue > 100 AND YEAR(BillingDate) = 2022
);
SELECT BillingID 
FROM Billing 
WHERE BillingID IN (
   SELECT BillingID 
   FROM Payments 
   WHERE Payments.PaymentID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND PaymentAmount > 100 AND MONTH(PaymentDate) = 1
);
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
   SELECT SubscriptionID 
   FROM Usage 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND DataUsed > 1 AND DATENAME(WEEKDAY, UsageDate) = 'Monday'
);
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Issues
    WHERE IssueDescription LIKE '%internet%' AND LastName LIKE '%Smith%' AND MONTH(DateCreated) = 12 AND MONTH(DateResolved) = 1
);
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Subscriptions
    WHERE ServiceID IN (
        SELECT ServiceID
        FROM Servicess
        WHERE ServiceName LIKE '%internet%' AND MonthlyFee > 50) AND StartDate > '2022-01-01' AND EndDate < '2023-01-01'
);
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (
    SELECT ServiceID
    FROM Subscriptions
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%') AND StartDate > '2022-01-01' AND EndDate < '2023-01-01' AND MonthlyFee > 50
);
 SELECT BillingID
FROM Billing
WHERE BillingID IN (
    SELECT BillingID
    FROM Payments
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%') AND PaymentAmount > 100 AND MONTH(PaymentDate) = 1 AND MonthlyFee > 50
);SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Usage
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%') AND DataUsed > 1 AND DATENAME(WEEKDAY, UsageDate) = 'Monday' AND MonthlyFee > 50
);
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Issues
    WHERE IssueDescription LIKE '%internet%' AND LastName LIKE '%Smith%' AND MONTH(DateCreated) = 12 AND MONTH(DateResolved) = 1 AND MonthlyFee > 50
);
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Subscriptions
    WHERE ServiceID IN (
        SELECT ServiceID
        FROM Servicess
        WHERE ServiceName LIKE '%internet%' AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%') AND StartDate > '2022-01-01' AND EndDate < '2023-01-01'
);
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (
    SELECT ServiceID
    FROM Subscriptions
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%') AND StartDate > '2022-01-01' AND EndDate < '2023-01-01' AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%'
);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (
    SELECT SubscriptionID
    FROM Billing
    WHERE CustomerID IN (
        SELECT CustomerID
        FROM Customers
        WHERE LastName LIKE '%Smith%') AND AmountDue > 100 AND YEAR(BillingDate) = 2022 AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%'
);
SELECT BillingID 
FROM Billing 
WHERE BillingID IN (
   SELECT BillingID 
   FROM Payments 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND PaymentAmount > 100 AND MONTH(PaymentDate) = 1 AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%'
);
SELECT SubscriptionID 
FROM Subscriptions 
WHERE SubscriptionID IN (
   SELECT SubscriptionID 
   FROM Usage 
   WHERE CustomerID IN (
      SELECT CustomerID 
      FROM Customers 
      WHERE LastName LIKE '%Smith%') AND DataUsed > 1 AND DATENAME(WEEKDAY, UsageDate) = 'Monday' AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%'
);
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM Issues
    WHERE IssueDescription LIKE '%internet%' AND LastName LIKE '%Smith%' AND MONTH(DateCreated) = 12 AND MONTH(DateResolved) = 1 AND MonthlyFee > 50 AND ServiceDescription LIKE '%fast%'
);
-----------------------------------------------------
-----Q7
--where clause
SELECT FirstName, LastName
FROM Customers
WHERE City LIKE 'A%';

SELECT ServiceName
FROM Servicess
WHERE MonthlyFee > 50;
SELECT SubscriptionID
FROM Subscriptions
WHERE StartDate > '2022-01-01';
SELECT BillingID
FROM Billing
WHERE YEAR(BillingDate) = 2022;
SELECT SubscriptionID
FROM Subscriptions
WHERE EndDate < '2023-01-01';
SELECT CustomerID
FROM Customers
WHERE City LIKE 'A%';
SELECT FirstName, LastName
FROM Customers
WHERE NOT City LIKE 'A%';
SELECT ServiceName
FROM Servicess
WHERE MonthlyFee <= 50;
SELECT SubscriptionID
FROM Subscriptions
WHERE StartDate <= '2022-01-01';
SELECT BillingID
FROM Billing
WHERE NOT YEAR(BillingDate) = 2022;
SELECT SubscriptionID 
FROM Subscriptions 
WHERE EndDate >= '2023-01-01';
SELECT CustomerID 
FROM Customers 
WHERE NOT City LIKE 'A%';
SELECT FirstName, LastName 
FROM Customers 
WHERE City LIKE '%e';
SELECT ServiceName 
FROM Servicess 
WHERE MonthlyFee < 30;
SELECT SubscriptionID 
FROM Subscriptions 
WHERE StartDate < '2021-12-31';
SELECT BillingID 
FROM Billing 
WHERE MONTH(BillingDate) = 12;
SELECT SubscriptionID 
FROM Subscriptions 
WHERE EndDate > '2024-01-01';
SELECT CustomerID 
FROM Customers 
WHERE City LIKE '%n';
SELECT FirstName, LastName 
FROM Customers 
WHERE City LIKE '%ville%';
SELECT ServiceName 
FROM Servicess 
WHERE MonthlyFee BETWEEN 30 AND 50;


---------------------------------------------------
--Q7

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Subscriptions)
AND City LIKE 'A%';
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (SELECT ServiceID FROM Subscriptions)
AND MonthlyFee > 50;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Billing)
AND StartDate > '2022-01-01';
SELECT BillingID
FROM Billing
WHERE BillingID IN (SELECT BillingID FROM Payments)
AND YEAR(BillingDate) = 2022;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Usage)
AND EndDate < '2023-01-01';
SELECT CustomerID
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Issues)
AND City LIKE 'A%';
SELECT FirstName, LastName 
FROM Customers 
WHERE City LIKE 'A%' 
AND PhoneNumber LIKE '123%';
SELECT ServiceName 
FROM Servicess 
WHERE MonthlyFee > 50 
AND ServiceDescription LIKE '%fast%';
SELECT SubscriptionID 
FROM Subscriptions 
WHERE StartDate > '2022-01-01' 
AND EndDate < '2023-01-01';
SELECT BillingID 
FROM Billing 
WHERE YEAR(BillingDate) = 2022 
AND AmountDue > 100;
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Subscriptions)
OR City LIKE 'A%';
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (SELECT ServiceID FROM Subscriptions)
OR MonthlyFee > 50;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Billing)
OR StartDate > '2022-01-01';
SELECT BillingID
FROM Billing
WHERE BillingID IN (SELECT BillingID FROM Payments)
OR YEAR(BillingDate) = 2022;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Usage)
OR EndDate < '2023-01-01';
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Issues) 
OR City LIKE 'A%';
SELECT FirstName, LastName 
FROM Customers 
WHERE City LIKE 'A%' 
OR PhoneNumber LIKE '123%';
SELECT ServiceName 
FROM Servicess 
WHERE MonthlyFee > 50 
OR ServiceDescription LIKE '%fast%';
SELECT SubscriptionID 
FROM Subscriptions 
WHERE StartDate > '2022-01-01' 
OR EndDate < '2023-01-01';
SELECT BillingID 
FROM Billing 
WHERE YEAR(BillingDate) = 2022 
OR AmountDue > 100;

SELECT FirstName, LastName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Subscriptions);
SELECT ServiceName
FROM Servicess
WHERE ServiceID NOT IN (SELECT ServiceID FROM Subscriptions);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Billing);
SELECT BillingID
FROM Billing
WHERE BillingID NOT IN (SELECT BillingID FROM Payments);
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID NOT IN (SELECT SubscriptionID FROM Usage);
SELECT CustomerID 
FROM Customers 
WHERE CustomerID NOT IN (SELECT CustomerID FROM Issues);
SELECT FirstName, LastName 
FROM Customers 
WHERE NOT City LIKE 'A%';
SELECT ServiceName 
FROM Servicess 
WHERE NOT MonthlyFee > 50;
SELECT SubscriptionID 
FROM Subscriptions 
WHERE NOT StartDate > '2022-01-01';
SELECT BillingID 
FROM Billing 
WHERE NOT YEAR(BillingDate) = 2022;
-------------------------------------
--Q8 --order by 

SELECT FirstName, LastName
FROM Customers
ORDER BY LastName ASC;
SELECT ServiceName
FROM Servicess
ORDER BY MonthlyFee DESC;
SELECT SubscriptionID
FROM Subscriptions
ORDER BY StartDate ASC;
SELECT BillingID
FROM Billing
ORDER BY BillingDate DESC;
SELECT SubscriptionID
FROM Subscriptions
ORDER BY EndDate ASC;
SELECT CustomerID 
FROM Customers 
ORDER BY City DESC;
SELECT FirstName, LastName 
FROM Customers 
ORDER BY FirstName ASC, LastName ASC;
SELECT ServiceName 
FROM Servicess 
ORDER BY ServiceName DESC, MonthlyFee DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY StartDate ASC, EndDate ASC;
SELECT BillingID 
FROM Billing 
ORDER BY BillingDate DESC, AmountDue DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY EndDate ASC, MonthlyFee ASC;
SELECT CustomerID 
FROM Customers 
ORDER BY City DESC, LastName DESC;
SELECT FirstName, LastName 
FROM Customers 
ORDER BY PhoneNumber ASC;
SELECT ServiceName 
FROM Servicess 
ORDER BY ServiceDescription DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY MonthlyFee ASC, StartDate ASC;
SELECT BillingID 
FROM Billing 
ORDER BY AmountDue DESC, BillingDate DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY MonthlyFee ASC, EndDate ASC;
SELECT CustomerID 
FROM Customers 
ORDER BY LastName DESC, City DESC;
SELECT FirstName, LastName 
FROM Customers 
ORDER BY City ASC, PhoneNumber ASC;
SELECT ServiceName 
FROM Servicess 
ORDER BY MonthlyFee DESC, ServiceDescription DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY StartDate ASC, MonthlyFee ASC;
SELECT BillingID 
FROM Billing 
ORDER BY BillingDate DESC, AmountDue DESC;
SELECT SubscriptionID 
FROM Subscriptions 
ORDER BY EndDate ASC, StartDate ASC;
SELECT CustomerID
FROM Customers
ORDER BY City DESC, FirstName DESC;
SELECT FirstName, LastName
FROM Customers
ORDER BY LastName ASC, PhoneNumber ASC;
------------------------------
---Q9
SELECT FirstName, LastName
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Subscriptions)
AND City LIKE 'A%'
ORDER BY LastName ASC;
SELECT ServiceName
FROM Servicess
WHERE ServiceID IN (SELECT ServiceID FROM Subscriptions)
AND MonthlyFee > 50
ORDER BY MonthlyFee DESC;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Billing)
AND StartDate > '2022-01-01'
ORDER BY StartDate ASC;
SELECT BillingID
FROM Billing
WHERE BillingID IN (SELECT BillingID FROM Payments)
AND YEAR(BillingDate) = 2022
ORDER BY BillingDate DESC;
SELECT SubscriptionID
FROM Subscriptions
WHERE SubscriptionID IN (SELECT SubscriptionID FROM Usage)
AND EndDate < '2023-01-01'
ORDER BY EndDate ASC;
SELECT CustomerID 
FROM Customers 
WHERE CustomerID IN (SELECT CustomerID FROM Issues) 
AND City LIKE 'A%' 
ORDER BY City DESC;
SELECT FirstName, LastName 
FROM Customers 
WHERE City LIKE 'A%' 
AND PhoneNumber LIKE '123%' 
ORDER BY FirstName ASC, LastName ASC;
SELECT ServiceName 
FROM Servicess 
WHERE MonthlyFee > 50 
AND ServiceDescription LIKE '%fast%' 
ORDER BY ServiceName DESC, MonthlyFee DESC;
SELECT SubscriptionID 
FROM Subscriptions 
WHERE StartDate > '2022-01-01' 
AND EndDate < '2023-01-01' 
ORDER BY StartDate ASC, EndDate ASC;
SELECT BillingID 
FROM Billing 
WHERE YEAR(BillingDate) = 2022 
AND AmountDue > 100 
ORDER BY BillingDate DESC, AmountDue DESC;
------------------------------------------------------------------------------
--Q16

SELECT Customers.FirstName, Customers.LastName, Addresses.StreetAddress FROM Customers INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID
SELECT Subscriptions.SubscriptionID, Customers.FirstName, Customers.LastName FROM Subscriptions INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
SELECT Billing.BillingID, Subscriptions.SubscriptionID FROM Billing INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID
SELECT Payments.PaymentID, Billing.BillingID FROM Payments INNER JOIN Billing ON Payments.BillingID = Billing.BillingID
SELECT Usage.UsageID, Subscriptions.SubscriptionID FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID
SELECT Issues.IssueID, Technicians.FirstName, Technicians.LastName FROM Issues INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID
SELECT Equipment.EquipmentName, Issues.IssueDescription FROM Equipment INNER JOIN Issues ON Equipment.EquipmentID = Issues.EquipmentID
SELECT ServiceOffices.City, ServiceOffices.ZipCode FROM ServiceOffices INNER JOIN Addresses ON ServiceOffices.City = Addresses.City
SELECT Promotions.PromotionName, Servicess.ServiceName FROM Promotions INNER JOIN Servicess ON Promotions.PromotionName = Servicess.ServiceName
SELECT Contracts.ContractID, Customers.FirstName, Customers.LastName FROM Contracts INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID
SELECT Customers.FirstName, Customers.LastName, Servicess.ServiceName FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
SELECT Billing.BillingDate, Billing.AmountDue, Payments.PaymentAmount FROM Billing INNER JOIN Payments ON Billing.BillingID = Payments.BillingID
SELECT Usage.UsageDate, Usage.DataUsed, Subscriptions.StartDate FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID
SELECT Issues.IssueDescription, Technicians.FirstName, Technicians.LastName FROM Issues INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID
SELECT Equipment.EquipmentName, Equipment.EquipmentDescription, Issues.IssueDescription FROM Equipment INNER JOIN Issues ON Equipment.EquipmentID = Issues.EquipmentID
SELECT ServiceOffices.City, ServiceOffices.ZipCode, Addresses.StreetAddress FROM ServiceOffices INNER JOIN Addresses ON ServiceOffices.City = Addresses.City
SELECT Promotions.PromotionName, Promotions.PromotionDescription, Servicess.ServiceName FROM Promotions INNER JOIN Servicess ON Promotions.PromotionName = Servicess.ServiceName
SELECT Contracts.ContractID, Contracts.StartDate, Customers.FirstName FROM Contracts INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID
SELECT Billing.BillingDate, Billing.AmountDue, Payments.PaymentAmount FROM Billing INNER JOIN Payments ON Billing.BillingID = Payments.BillingID WHERE Payments.PaymentAmount > 100
SELECT Usage.UsageDate, Usage.DataUsed, Subscriptions.StartDate FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID WHERE Usage.DataUsed > 1000

------------------------------
------------------------------------------------------------------
--Q17
SELECT Customers.FirstName, Customers.LastName, Addresses.City FROM Customers INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID WHERE Customers.FirstName = 'John' AND Customers.LastName = 'Doe' ORDER BY Addresses.City;

SELECT Customers.FirstName, Customers.LastName, Servicess.ServiceName FROM Subscriptions INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Subscriptions.StartDate >= '2022-01-01' AND Subscriptions.EndDate <= '2022-12-31' ORDER BY Servicess.ServiceName;

SELECT Customers.FirstName, Customers.LastName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY SubscriptionCount DESC;

SELECT Servicess.ServiceName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY SubscriptionCount DESC;

SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID WHERE Issues.DateResolved IS NOT NULL GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY IssueCount DESC;

SELECT Billing.BillingDate, SUM(Billing.AmountDue) AS TotalAmountDue FROM Billing INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID WHERE Subscriptions.StartDate >= '2022-01-01' AND Subscriptions.EndDate <= '2022-12-31' GROUP BY Billing.BillingDate ORDER BY Billing.BillingDate;

SELECT ServiceOffices.City, COUNT(Customers.CustomerID) AS CustomerCount FROM ServiceOffices INNER JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode INNER JOIN Customers ON Addresses.AddressID = Customers.AddressID GROUP BY ServiceOffices.City ORDER BY CustomerCount DESC;

SELECT Servicess.ServiceName, SUM(Usage.DataUsed) AS TotalDataUsed FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Usage.UsageDate >= '2022-01-01' AND Usage.UsageDate <= '2022-12-31' GROUP BY Servicess.ServiceName ORDER BY TotalDataUsed DESC;

SELECT Customers.FirstName, Customers.LastName, COUNT(DISTINCT Billing.BillingID) AS BillingCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID GROUP BY Customers.FirstName, Customers.LastName ORDER BY BillingCount DESC;

SELECT Servicess.ServiceName, COUNT(DISTINCT Subscriptions.SubscriptionID) AS SubscriptionCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY SubscriptionCount DESC;

SELECT Technicians.FirstName, Technicians.LastName, SUM(DATEDIFF(day, Issues.DateCreated, Issues.DateResolved)) AS TotalResolutionTime FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID WHERE Issues.DateResolved IS NOT NULL GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY TotalResolutionTime;

SELECT ServiceOffices.City, COUNT(DISTINCT Addresses.AddressID) AS AddressCount FROM ServiceOffices LEFT JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode GROUP BY ServiceOffices.City ORDER BY AddressCount DESC;

SELECT Servicess.ServiceName, COUNT(DISTINCT Usage.UsageID) AS UsageCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Usage ON Subscriptions.SubscriptionID = Usage.SubscriptionID GROUP BY Servicess.ServiceName ORDER BY UsageCount DESC;

SELECT Customers.FirstName, Customers.LastName, SUM(Payments.PaymentAmount) - SUM(Billing.AmountDue) AS Balance FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Customers.FirstName, Customers.LastName ORDER BY Balance;

SELECT Servicess.ServiceName, SUM(Billing.AmountDue) - SUM(Payments.PaymentAmount) AS Balance FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Servicess.ServiceName ORDER BY Balance;

SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueDescription) AS IssueCount FROM Technicians inner JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID WHERE Issues.IssueDescription LIKE '%internet%' GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY IssueCount DESC;


SELECT ServiceOffices.City, AVG(Addresses.AddressID) AS AverageAddress FROM ServiceOffices inner JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode GROUP BY ServiceOffices.City ORDER BY AverageAddress DESC;

SELECT Servicess.ServiceName, AVG(Subscriptions.SubscriptionID) AS AverageSubscription FROM Servicess inner JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY AverageSubscription DESC;

SELECT Customers.FirstName, Customers.LastName, MAX(Billing.AmountDue) AS MaxAmountDue FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID GROUP BY Customers.FirstName, Customers.LastName ORDER BY MaxAmountDue DESC;

SELECT Customers.FirstName, Customers.LastName, Billing.AmountDue FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID WHERE Billing.DueDate <= '2022-12-31' ORDER BY Billing.AmountDue DESC;

SELECT Customers.FirstName, Customers.LastName, SUM(Payments.PaymentAmount) AS TotalPayments FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Customers.FirstName, Customers.LastName ORDER BY TotalPayments DESC;

SELECT Servicess.ServiceName, SUM(Billing.AmountDue) AS TotalAmountDue FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID GROUP BY Servicess.ServiceName ORDER BY TotalAmountDue DESC;

SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueID) AS OpenIssues FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID WHERE Issues.DateResolved IS NULL GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY OpenIssues DESC;

SELECT ServiceOffices.City, COUNT(Customers.CustomerID) AS CustomerCount FROM ServiceOffices INNER JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode INNER JOIN Customers ON Addresses.AddressID = Customers.AddressID WHERE Customers.FirstName LIKE '%a%' GROUP BY ServiceOffices.City ORDER BY CustomerCount DESC;

SELECT Servicess.ServiceName, AVG(Usage.DataUsed) AS AverageDataUsed FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Usage.UsageDate >= '2022-01-01' AND Usage.UsageDate <= '2022-12-31' GROUP BY Servicess.ServiceName ORDER BY AverageDataUsed DESC;

SELECT Customers.FirstName, Customers.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Customers LEFT JOIN Issues ON Customers.CustomerID = Issues.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY IssueCount DESC;

SELECT Technicians.FirstName, Technicians.LastName, AVG(DATEDIFF(day, Issues.DateCreated, Issues.DateResolved)) AS AverageResolutionTime FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID WHERE Issues.DateResolved IS NOT NULL GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY AverageResolutionTime;

SELECT ServiceOffices.City, COUNT(Customers.CustomerID) AS CustomerCount FROM ServiceOffices LEFT JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode LEFT JOIN Customers ON Addresses.AddressID = Customers.AddressID GROUP BY ServiceOffices.City ORDER BY CustomerCount DESC;

SELECT Servicess.ServiceName, MAX(Usage.DataUsed) AS MaxDataUsed FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Usage.UsageDate >= '2022-01-01' AND Usage.UsageDate <= '2022-12-31' GROUP BY Servicess.ServiceName ORDER BY MaxDataUsed DESC;

SELECT Customers.FirstName, Customers.LastName, COUNT(DISTINCT Subscriptions.ServiceID) AS ServiceCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY ServiceCount DESC;

SELECT Technicians.FirstName, Technicians.LastName, COUNT(DISTINCT Issues.CustomerID) AS CustomerCount FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY CustomerCount DESC;

SELECT ServiceOffices.City, SUM(Customers.CustomerID) AS CustomerSum FROM ServiceOffices inner JOIN Addresses ON ServiceOffices.ZipCode = Addresses.ZipCode LEFT JOIN Customers ON Addresses.AddressID = Customers.AddressID GROUP BY ServiceOffices.City ORDER BY CustomerSum DESC;

SELECT Servicess.ServiceName, COUNT(DISTINCT Subscriptions.CustomerID) AS CustomerCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY CustomerCount DESC;

-----------------------------------------
--full outer join 

SELECT * FROM Customers FULL OUTER JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT * FROM Customers FULL OUTER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT * FROM Servicess FULL OUTER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT * FROM Billing FULL OUTER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Payments FULL OUTER JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT * FROM Usage FULL OUTER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Issues FULL OUTER JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT * FROM Issues FULL OUTER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT * FROM Contracts FULL OUTER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT * FROM Contracts FULL OUTER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;
SELECT Customers.FirstName, Customers.LastName, Addresses.StreetAddress, Addresses.City FROM Customers FULL OUTER JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT Customers.FirstName, Customers.LastName, Subscriptions.StartDate, Subscriptions.EndDate FROM Customers FULL OUTER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT Servicess.ServiceName, Servicess.MonthlyFee, Subscriptions.StartDate, Subscriptions.EndDate FROM Servicess FULL OUTER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.StartDate, Subscriptions.EndDate FROM Billing FULL OUTER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingDate, Billing.AmountDue FROM Payments FULL OUTER JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT Usage.UsageDate, Usage.DataUsed, Usage.UsageBytes, Subscriptions.StartDate, Subscriptions.EndDate FROM Usage FULL OUTER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName FROM Issues FULL OUTER JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName FROM Issues FULL OUTER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT Contracts.StartDate, Contracts.EndDate, Customers.FirstName, Customers.LastName FROM Contracts FULL OUTER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT Contracts.StartDate, Contracts.EndDate, Servicess.ServiceName, Servicess.MonthlyFee FROM Contracts FULL OUTER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;




----------------
--Q19


SELECT * FROM Customers RIGHT JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT * FROM Customers RIGHT JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT * FROM Servicess RIGHT JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT * FROM Billing RIGHT JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Payments RIGHT JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT * FROM Usage RIGHT JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Issues RIGHT JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT * FROM Issues RIGHT JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT * FROM Contracts RIGHT JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT * FROM Contracts RIGHT JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;
SELECT Customers.FirstName, Customers.LastName, Addresses.StreetAddress, Addresses.City FROM Customers RIGHT JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT Customers.FirstName, Customers.LastName, Subscriptions.StartDate, Subscriptions.EndDate FROM Customers RIGHT JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT Servicess.ServiceName, Servicess.MonthlyFee, Subscriptions.StartDate, Subscriptions.EndDate FROM Servicess RIGHT JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.StartDate, Subscriptions.EndDate FROM Billing RIGHT JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingDate, Billing.AmountDue FROM Payments RIGHT JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT Usage.UsageDate, Usage.DataUsed, Usage.UsageBytes, Subscriptions.StartDate, Subscriptions.EndDate FROM Usage RIGHT JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName FROM Issues RIGHT JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName FROM Issues RIGHT JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT Contracts.StartDate, Contracts.EndDate, Customers.FirstName, Customers.LastName FROM Contracts RIGHT JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT Contracts.StartDate, Contracts.EndDate, Servicess.ServiceName, Servicess.MonthlyFee FROM Contracts RIGHT JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;

---------------------------------
--Q18

SELECT * FROM Customers LEFT JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT * FROM Customers LEFT JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT * FROM Servicess LEFT JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT * FROM Billing LEFT JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Payments LEFT JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT * FROM Usage LEFT JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT * FROM Issues LEFT JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT * FROM Issues LEFT JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT * FROM Contracts LEFT JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT * FROM Contracts LEFT JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;
SELECT Customers.FirstName, Customers.LastName, Addresses.StreetAddress, Addresses.City FROM Customers LEFT JOIN Addresses ON Customers.AddressID = Addresses.AddressID;
SELECT Customers.FirstName, Customers.LastName, Subscriptions.StartDate, Subscriptions.EndDate FROM Customers LEFT JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID;
SELECT Servicess.ServiceName, Servicess.MonthlyFee, Subscriptions.StartDate, Subscriptions.EndDate FROM Servicess LEFT JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID;
SELECT Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.StartDate, Subscriptions.EndDate FROM Billing LEFT JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingDate, Billing.AmountDue FROM Payments LEFT JOIN Billing ON Payments.BillingID = Billing.BillingID;
SELECT Usage.UsageDate, Usage.DataUsed, Usage.UsageBytes, Subscriptions.StartDate, Subscriptions.EndDate FROM Usage LEFT JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName FROM Issues LEFT JOIN Customers ON Issues.CustomerID = Customers.CustomerID;
SELECT Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName FROM Issues LEFT JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID;
SELECT Contracts.StartDate, Contracts.EndDate, Customers.FirstName, Customers.LastName FROM Contracts LEFT JOIN Customers ON Contracts.CustomerID = Customers.CustomerID;
SELECT Contracts.StartDate, Contracts.EndDate, Servicess.ServiceName, Servicess.MonthlyFee FROM Contracts LEFT JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID;





---------------------------------
--Q17inner join with logical opeartors 


SELECT Customers.FirstName, Customers.LastName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY SubscriptionCount DESC;
SELECT Servicess.ServiceName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY SubscriptionCount DESC;
SELECT Billing.BillingDate, SUM(Billing.AmountDue) AS TotalAmountDue FROM Billing INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID GROUP BY Billing.BillingDate ORDER BY TotalAmountDue DESC;
SELECT Payments.PaymentDate, SUM(Payments.PaymentAmount) AS TotalPaymentAmount FROM Payments INNER JOIN Billing ON Payments.BillingID = Billing.BillingID GROUP BY Payments.PaymentDate ORDER BY TotalPaymentAmount DESC;
SELECT Usage.UsageDate, SUM(Usage.DataUsed) AS TotalDataUsed FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID GROUP BY Usage.UsageDate ORDER BY TotalDataUsed DESC;
SELECT Issues.DateCreated, COUNT(Issues.IssueID) AS IssueCount FROM Issues INNER JOIN Customers ON Issues.CustomerID = Customers.CustomerID GROUP BY Issues.DateCreated ORDER BY IssueCount DESC;
SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Issues INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY IssueCount DESC;
SELECT Contracts.StartDate, COUNT(Contracts.ContractID) AS ContractCount FROM Contracts INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID GROUP BY Contracts.StartDate ORDER BY ContractCount DESC;
SELECT Servicess.ServiceName, COUNT(Contracts.ContractID) AS ContractCount FROM Contracts INNER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID GROUP BY Servicess.ServiceName ORDER BY ContractCount DESC;
SELECT Customers.FirstName, Customers.LastName, SUM(Billing.AmountDue) AS TotalAmountDue FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID GROUP BY Customers.FirstName, Customers.LastName ORDER BY TotalAmountDue DESC;
SELECT Servicess.ServiceName, SUM(Billing.AmountDue) AS TotalAmountDue FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID GROUP BY Servicess.ServiceName ORDER BY TotalAmountDue DESC;
SELECT Customers.FirstName, Customers.LastName, SUM(Payments.PaymentAmount) AS TotalPaymentAmount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Customers.FirstName, Customers.LastName ORDER BY TotalPaymentAmount DESC;
SELECT Servicess.ServiceName, SUM(Payments.PaymentAmount) AS TotalPaymentAmount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Servicess.ServiceName ORDER BY TotalPaymentAmount DESC;
SELECT Customers.FirstName, Customers.LastName, SUM(Usage.DataUsed) AS TotalDataUsed FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Usage ON Subscriptions.SubscriptionID = Usage.SubscriptionID GROUP BY Customers.FirstName, Customers.LastName ORDER BY TotalDataUsed DESC;
SELECT Servicess.ServiceName, SUM(Usage.DataUsed) AS TotalDataUsed FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Usage ON Subscriptions.SubscriptionID = Usage.SubscriptionID GROUP BY Servicess.ServiceName ORDER BY TotalDataUsed DESC;
SELECT Customers.FirstName, Customers.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Customers INNER JOIN Issues ON Customers.CustomerID = Issues.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY IssueCount DESC;
SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Technicians INNER JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY IssueCount DESC;
SELECT Customers.FirstName, Customers.LastName, COUNT(Contracts.ContractID) AS ContractCount FROM Customers INNER JOIN Contracts ON Customers.CustomerID = Contracts.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY ContractCount DESC;
SELECT Servicess.ServiceName, COUNT(Contracts.ContractID) AS ContractCount FROM Servicess INNER JOIN Contracts ON Servicess.ServiceID = Contracts.ServiceID GROUP BY Servicess.ServiceName ORDER BY ContractCount DESC;
SELECT Customers.FirstName, Customers.LastName, SUM(Billing.AmountDue - Payments.PaymentAmount) AS Balance FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Customers.FirstName, Customers.LastName HAVING SUM(Billing.AmountDue - Payments.PaymentAmount) > 0 ORDER BY Balance DESC;
SELECT Servicess.ServiceName, SUM(Billing.AmountDue - Payments.PaymentAmount) AS Balance FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Servicess.ServiceName HAVING SUM(Billing.AmountDue - Payments.PaymentAmount) > 0 ORDER BY Balance DESC;
SELECT Customers.FirstName, Customers.LastName, COUNT(DISTINCT Servicess.ServiceName) AS ServiceCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Subscriptions.EndDate IS NULL GROUP BY Customers.FirstName, Customers.LastName ORDER BY ServiceCount DESC;
SELECT Servicess.ServiceName, COUNT(DISTINCT Customers.CustomerID) AS CustomerCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID WHERE Subscriptions.EndDate IS NULL GROUP BY Servicess.ServiceName ORDER BY CustomerCount DESC;
SELECT Billing.BillingDate, SUM(CASE WHEN Payments.PaymentDate IS NULL THEN 1 ELSE 0 END) AS UnpaidBillCount FROM Billing LEFT JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Billing.BillingDate ORDER BY UnpaidBillCount DESC;
SELECT Billing.DueDate, SUM(CASE WHEN Payments.PaymentDate IS NULL THEN 1 ELSE 0 END) AS UnpaidBillCount FROM Billing LEFT JOIN Payments ON Billing.BillingID = Payments.BillingID WHERE Billing.DueDate < GETDATE() GROUP BY Billing.DueDate ORDER BY UnpaidBillCount DESC;
SELECT Issues.DateCreated, COUNT(CASE WHEN Issues.DateResolved IS NULL THEN 1 ELSE 0 END) AS OpenIssueCount FROM Issues GROUP BY Issues.DateCreated ORDER BY OpenIssueCount DESC;
SELECT Technicians.FirstName, Technicians.LastName, COUNT(CASE WHEN Issues.DateResolved IS NULL THEN 1 ELSE 0 END) AS OpenIssueCount FROM Technicians LEFT JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY OpenIssueCount DESC;
SELECT Contracts.StartDate, COUNT(CASE WHEN Contracts.EndDate IS NULL THEN 1 ELSE 0 END) AS ActiveContractCount FROM Contracts GROUP BY Contracts.StartDate ORDER BY ActiveContractCount DESC;
SELECT Servicess.ServiceName, COUNT(CASE WHEN Contracts.EndDate IS NULL THEN 1 ELSE 0 END) AS ActiveContractCount FROM Servicess LEFT JOIN Contracts ON Servicess.ServiceID = Contracts.ServiceID GROUP BY Servicess.ServiceName ORDER BY ActiveContractCount DESC;
SELECT Customers.FirstName, Customers.LastName, Payments.PaymentAmount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Billing ON Subscriptions.SubscriptionID = Billing.SubscriptionID INNER JOIN Payments ON Billing.BillingID = Payments.BillingID WHERE Payments.PaymentAmount > 100 ORDER BY Payments.PaymentAmount;


SELECT Customers.FirstName, Customers.LastName, Addresses.StreetAddress FROM Customers INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID WHERE Customers.FirstName = 'John' AND Customers.LastName = 'Doe'
SELECT Subscriptions.SubscriptionID, Customers.FirstName, Customers.LastName FROM Subscriptions INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID WHERE Subscriptions.StartDate >= '2022-01-01' AND Subscriptions.EndDate <= '2022-12-31'
SELECT Billing.BillingID, Subscriptions.SubscriptionID FROM Billing INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID WHERE Billing.AmountDue > 100 AND Billing.DueDate < GETDATE()
SELECT ServiceOffices.City, ServiceOffices.ZipCode FROM ServiceOffices INNER JOIN Addresses ON ServiceOffices.City = Addresses.City WHERE ServiceOffices.ZipCode LIKE '100%' OR Addresses.District = 'Manhattan'
SELECT Promotions.PromotionName, Servicess.ServiceName FROM Promotions INNER JOIN Servicess ON Promotions.PromotionName = Servicess.ServiceName WHERE Promotions.StartDate >= '2022-01-01' OR Promotions.EndDate <= '2022-12-31'
SELECT Contracts.ContractID, Customers.FirstName, Customers.LastName FROM Contracts INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID WHERE Contracts.StartDate >= '2022-01-01' OR Contracts.EndDate <= '2022-12-31'
SELECT Payments.PaymentID, Billing.BillingID FROM Payments INNER JOIN Billing ON Payments.BillingID = Billing.BillingID WHERE NOT (Payments.PaymentAmount > 100 AND Payments.PaymentDate < GETDATE())
SELECT Usage.UsageID, Subscriptions.SubscriptionID FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID WHERE NOT (Usage.DataUsed > 1000 AND Usage.UsageDate < GETDATE())
SELECT Issues.IssueID, Technicians.FirstName, Technicians.LastName FROM Issues INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID WHERE NOT (Issues.DateResolved IS NOT NULL AND Issues.DateCreated > '2022-01-01')

------------------------------------------
--Q21 stored procedure without parameters
CREATE procedure GetAllCustomers
AS
BEGIN
    SELECT * FROM Customers;
END;
CREATE PROCEDURE GetAllSubscriptions
AS
BEGIN
    SELECT * FROM Subscriptions;
END;
CREATE PROCEDURE GetAllServices
AS
BEGIN
    SELECT * FROM Servicess;
END;
CREATE PROCEDURE GetAllBilling
AS
BEGIN
    SELECT * FROM Billing;
END;
CREATE PROCEDURE GetAllPayments
AS
BEGIN
    SELECT * FROM Payments;
END;
CREATE PROCEDURE GetAllUsage
AS
BEGIN
    SELECT * FROM Usage;
END;
CREATE PROCEDURE GetAllIssues
AS
BEGIN
    SELECT * FROM Issues;
END;
CREATE PROCEDURE GetAllTechnicians
AS
BEGIN
    SELECT * FROM Technicians;
END;
CREATE PROCEDURE GetAllEquipment
AS
BEGIN
    SELECT * FROM Equipment;
END;
CREATE PROCEDURE GetCustomersWithSubscriptionsCountByServiceName @ServiceName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Servicess.ServiceName = @ServiceName GROUP BY Customers.FirstName, Customers.LastName ORDER BY SubscriptionCount DESC;
END;

CREATE PROCEDURE GetCustomersWithSubscriptionsCount
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY SubscriptionCount DESC;
END;
CREATE PROCEDURE GetServicesWithSubscriptionsCount
AS
BEGIN
    SELECT Servicess.ServiceName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID GROUP BY Servicess.ServiceName ORDER BY SubscriptionCount DESC;
END;
CREATE PROCEDURE GetBillingTotalAmountDueByDate
AS
BEGIN
    SELECT Billing.BillingDate, SUM(Billing.AmountDue) AS TotalAmountDue FROM Billing INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID GROUP BY Billing.BillingDate ORDER BY TotalAmountDue DESC;
END;
CREATE PROCEDURE GetPaymentsTotalAmountByDate
AS
BEGIN
    SELECT Payments.PaymentDate, SUM(Payments.PaymentAmount) AS TotalPaymentAmount FROM Payments INNER JOIN Billing ON Payments.BillingID = Billing.BillingID GROUP BY Payments.PaymentDate ORDER BY TotalPaymentAmount DESC;
END;
CREATE PROCEDURE GetUsageTotalDataUsedByDate
AS
BEGIN
    SELECT Usage.UsageDate, SUM(Usage.DataUsed) AS TotalDataUsed FROM Usage INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID GROUP BY Usage.UsageDate ORDER BY TotalDataUsed DESC;
END;
CREATE PROCEDURE GetIssuesCountByDateCreated
AS
BEGIN
    SELECT Issues.DateCreated, COUNT(Issues.IssueID) AS IssueCount FROM Issues INNER JOIN Customers ON Issues.CustomerID = Customers.CustomerID GROUP BY Issues.DateCreated ORDER BY IssueCount DESC;
END;
CREATE PROCEDURE GetTechniciansWithIssueCount
AS
BEGIN
    SELECT Technicians.FirstName, Technicians.LastName, COUNT(Issues.IssueID) AS IssueCount FROM Issues INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY IssueCount DESC;
END;

CREATE PROCEDURE GetCustomersWithContractCount
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, COUNT(Contracts.ContractID) AS ContractCount FROM Customers INNER JOIN Contracts ON Customers.CustomerID = Contracts.CustomerID GROUP BY Customers.FirstName, Customers.LastName ORDER BY ContractCount DESC;
END;
CREATE PROCEDURE GetServicesWithContractCount
AS
BEGIN
    SELECT Servicess.ServiceName, COUNT(Contracts.ContractID) AS ContractCount FROM Servicess INNER JOIN Contracts ON Servicess.ServiceID = Contracts.ServiceID GROUP BY Servicess.ServiceName ORDER BY ContractCount DESC;
END;

CREATE PROCEDURE GetCustomersWithActiveSubscriptionsCount
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, COUNT(DISTINCT Servicess.ServiceName) AS ServiceCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Subscriptions.EndDate IS NULL GROUP BY Customers.FirstName, Customers.LastName ORDER BY ServiceCount DESC;
END;
CREATE PROCEDURE GetServicesWithActiveSubscriptionsCount
AS
BEGIN
    SELECT Servicess.ServiceName, COUNT(DISTINCT Customers.CustomerID) AS CustomerCount FROM Servicess INNER JOIN Subscriptions ON Servicess.ServiceID = Subscriptions.ServiceID INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID WHERE Subscriptions.EndDate IS NULL GROUP BY Servicess.ServiceName ORDER BY CustomerCount DESC;
END;
CREATE PROCEDURE GetBillingUnpaidBillCountByBillingDate
AS
BEGIN
    SELECT Billing.BillingDate, SUM(CASE WHEN Payments.PaymentDate IS NULL THEN 1 ELSE 0 END) AS UnpaidBillCount FROM Billing LEFT JOIN Payments ON Billing.BillingID = Payments.BillingID GROUP BY Billing.BillingDate ORDER BY UnpaidBillCount DESC;
END;
CREATE PROCEDURE GetBillingUnpaidBillCountByDueDate
AS
BEGIN
    SELECT Billing.DueDate, SUM(CASE WHEN Payments.PaymentDate IS NULL THEN 1 ELSE 0 END) AS UnpaidBillCount FROM Billing LEFT JOIN Payments ON Billing.BillingID = Payments.BillingID WHERE Billing.DueDate < GETDATE() GROUP BY Billing.DueDate ORDER BY UnpaidBillCount DESC;
END;
CREATE PROCEDURE GetIssuesOpenIssueCountByDateCreated
AS
BEGIN
    SELECT Issues.DateCreated, COUNT(CASE WHEN Issues.DateResolved IS NULL THEN 1 ELSE 0 END) AS OpenIssueCount FROM Issues GROUP BY Issues.DateCreated ORDER BY OpenIssueCount DESC;
END;
CREATE PROCEDURE GetTechniciansWithOpenIssueCount
AS
BEGIN
    SELECT Technicians.FirstName, Technicians.LastName, COUNT(CASE WHEN Issues.DateResolved IS NULL THEN 1 ELSE 0 END) AS OpenIssueCount FROM Technicians LEFT JOIN Issues ON Technicians.TechnicianID = Issues.TechnicianID GROUP BY Technicians.FirstName, Technicians.LastName ORDER BY OpenIssueCount DESC;
END;



---------------------
--Q22

CREATE PROCEDURE GetCustomerByID @CustomerID INT
AS
BEGIN
    SELECT * FROM Customers WHERE CustomerID = @CustomerID;
END;
CREATE PROCEDURE GetAddressByID @AddressID INT
AS
BEGIN
    SELECT * FROM Addresses WHERE AddressID = @AddressID;
END;
CREATE PROCEDURE GetSubscriptionByID @SubscriptionID INT
AS
BEGIN
    SELECT * FROM Subscriptions WHERE SubscriptionID = @SubscriptionID;
END;

CREATE PROCEDURE GetBillingByID @BillingID INT
AS
BEGIN
    SELECT * FROM Billing WHERE BillingID = @BillingID;
END;
CREATE PROCEDURE GetPaymentByID @PaymentID INT
AS
BEGIN
    SELECT * FROM Payments WHERE PaymentID = @PaymentID;
END;
CREATE PROCEDURE GetUsageByID @UsageID INT
AS
BEGIN
    SELECT * FROM Usage WHERE UsageID = @UsageID;
END;
CREATE PROCEDURE GetIssueByID @IssueID INT
AS
BEGIN
    SELECT * FROM Issues WHERE IssueID = @IssueID;
END;
CREATE PROCEDURE GetTechnicianByID @TechnicianID INT
AS
BEGIN
    SELECT * FROM Technicians WHERE TechnicianID = @TechnicianID;
END;
CREATE PROCEDURE GetEquipmentByID @EquipmentID INT
AS
BEGIN
    SELECT * FROM Equipment WHERE EquipmentID = @EquipmentID;
END;
CREATE PROCEDURE GetCustomersWithSubscriptionsCountByServiceNamee @ServiceName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, COUNT(Subscriptions.SubscriptionID) AS SubscriptionCount FROM Customers INNER JOIN Subscriptions ON Customers.CustomerID = Subscriptions.CustomerID INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID WHERE Servicess.ServiceName = @ServiceName GROUP BY Customers.FirstName, Customers.LastName ORDER BY SubscriptionCount DESC;
END;

CREATE PROCEDURE spInsertAddress @StreetAddress VARCHAR(255), @City VARCHAR(255), @District VARCHAR(255), @ZipCode VARCHAR(255) AS BEGIN INSERT INTO Addresses (StreetAddress, City, District, ZipCode) VALUES (@StreetAddress, @City, @District, @ZipCode) END;

CREATE PROCEDURE spInsertCustomer @FirstName VARCHAR(255), @LastName VARCHAR(255), @Email VARCHAR(255), @PhoneNumber VARCHAR(255), @AddressID INT AS BEGIN INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, AddressID) VALUES (@FirstName, @LastName, @Email, @PhoneNumber, @AddressID) END;

CREATE PROCEDURE spInsertService @ServiceName VARCHAR(255), @ServiceDescription VARCHAR(255), @MonthlyFee float AS BEGIN INSERT INTO Servicess (ServiceName, ServiceDescription, MonthlyFee) VALUES (@ServiceName, @ServiceDescription, @MonthlyFee) END;

CREATE PROCEDURE spInsertSubscription @CustomerID INT, @ServiceID INT, @StartDate DATE, @EndDate DATE AS BEGIN INSERT INTO Subscriptions (CustomerID, ServiceID, StartDate, EndDate) VALUES (@CustomerID, @ServiceID, @StartDate, @EndDate) END;

CREATE PROCEDURE spInsertBilling @SubscriptionID INT, @BillingDate DATE, @AmountDue float, @DueDate DATE AS BEGIN INSERT INTO Billing (SubscriptionID, BillingDate, AmountDue, DueDate) VALUES (@SubscriptionID,@BillingDate,@AmountDue,@DueDate) END;

CREATE PROCEDURE spInsertPayment @BillingID INT,@PaymentDate DATE,@PaymentAmount float AS BEGIN INSERT INTO Payments (BillingID ,PaymentDate ,PaymentAmount ) VALUES (@BillingID ,@PaymentDate ,@PaymentAmount ) END;

CREATE PROCEDURE spInsertUsage  @SubscriptionID INT,@UsageDate DATE,@DataUsed float,@UsageBytes varchar(255) AS BEGIN INSERT INTO Usage (SubscriptionID ,UsageDate ,DataUsed ,UsageBytes ) VALUES (@SubscriptionID ,@UsageDate ,@DataUsed ,@UsageBytes ) END;

CREATE PROCEDURE spInsertTechnician  @FirstName VARCHAR(255),@LastName VARCHAR(255),@PhoneNumber VARCHAR(255) AS BEGIN INSERT INTO Technicians (FirstName ,LastName ,PhoneNumber ) VALUES (@FirstName ,@LastName ,@PhoneNumber ) END;

CREATE PROCEDURE spInsertIssue  @CustomerID INT,@IssueDescription VARCHAR(255),@DateCreated DATE,@DateResolved DATE,@TechnicianID INT AS BEGIN INSERT INTO Issues (CustomerID ,IssueDescription ,DateCreated ,DateResolved ,TechnicianID ) VALUES (@CustomerID ,@IssueDescription ,@DateCreated ,@DateResolved ,@TechnicianID ) END;

CREATE PROCEDURE spInsertEquipment  @EquipmentName VARCHAR(255),@EquipmentDescription VARCHAR(255) AS BEGIN INSERT INTO Equipment (EquipmentName ,EquipmentDescription ) VALUES (@EquipmentName ,@EquipmentDescription ) END;

CREATE PROCEDURE spInsertServiceOffice  @City VARCHAR(255),@ZipCode VARCHAR(255) AS BEGIN INSERT INTO ServiceOffices (City ,ZipCode ) VALUES (@City ,@ZipCode ) END;

CREATE PROCEDURE spInsertPromotion  @PromotionName VARCHAR(255),@PromotionDescription VARCHAR(255),@StartDate DATE,@EndDate DATE AS BEGIN INSERT INTO Promotions (PromotionName,PromotionDescription ,StartDate ,EndDate ) VALUES (@PromotionName,@PromotionDescription,@StartDate,@EndDate) END;

CREATE PROCEDURE spInsertContract  @CustomerID INT,@ServiceID INT,@StartDate DATE,@EndDate DATE AS BEGIN INSERT INTO Contracts (CustomerID ,ServiceID ,StartDate ,EndDate ) VALUES (@CustomerID,@ServiceID,@StartDate,@EndDate) END;

CREATE PROCEDURE spUpdateAddress  @AddressId INT,@StreetAddress VARCHAR(255),@City VARCHAR(255),@District VARCHAR(255),@ZipCode VARCHAR(255) AS BEGIN UPDATE Addresses SET StreetAddress = COALESCE(@StreetAddress, StreetAddress), City = COALESCE(@City,City), District = COALESCE(@District,District), ZipCode = COALESCE(@ZipCode,ZipCode) WHERE AddressId = COALESCE(@AddressId,NULL);END;

CREATE PROCEDURE spUpdateCustomer  @CustomerId INT,@FirstName VARCHAR(255),@LastName VARCHAR(255),@Email VARCHAR(255),@PhoneNumber VARCHAR(255),@AddressId INT AS BEGIN UPDATE Customers SET FirstName = COALESCE(@FirstName, FirstName), LastName = COALESCE(@LastName,LastName), Email = COALESCE(@Email,Email), PhoneNumber = COALESCE(@PhoneNumber,PhoneNumber), AddressId = COALESCE(@AddressId,AddressId) WHERE CustomerId = COALESCE(@CustomerId,NULL);END;




------------------------------------------------------------

CREATE TABLE AuditAddresses (
    AddressID INT ,
    StreetAddress VARCHAR(255),
    City VARCHAR(255),
    District VARCHAR(255),
    ZipCode VARCHAR(255),
	AuditAction varchar(255)
);
CREATE TABLE AuditCustomers (
    CustomerID INT ,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(255),
	AuditAction varchar(255)
);

CREATE TABLE AuditServicess (
    ServiceID INT ,
    ServiceName VARCHAR(255),
    ServiceDescription VARCHAR(255),
    MonthlyFee float,AuditAction varchar(255)
);

CREATE TABLE AuditSubscriptions (
    SubscriptionID INT ,
    StartDate DATE,
    EndDate DATE,AuditAction varchar(255)
);

CREATE TABLE AuditBilling (
    BillingID INT ,
    BillingDate DATE,
    AmountDue float,
    DueDate DATE,AuditAction varchar(255)
);

CREATE TABLE AuditPayments (
    PaymentID int,
    PaymentDate DATE,
    PaymentAmount float,AuditAction varchar(255)
);

CREATE TABLE AuditUsage (
    UsageID INT ,
    UsageDate DATE,
    DataUsed float,
	UsageBytes varchar(255),AuditAction varchar(255)
);
CREATE TABLE AuditTechnicians (
    TechnicianID INT ,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    PhoneNumber VARCHAR(255),AuditAction varchar(255)
);

CREATE TABLE AuditIssues (
    IssueID INT ,
    IssueDescription VARCHAR(255),
    DateCreated DATE,
    DateResolved DATE,
	AuditAction varchar(255)
);



CREATE TABLE AuditEquipment (
    EquipmentID INT ,
    EquipmentName VARCHAR(255),
    EquipmentDescription VARCHAR(255),AuditAction varchar(255)
);



CREATE TABLE AuditServiceOffices (
   OfficeID INT ,
   City VARCHAR(255),
   ZipCode VARCHAR(255),AuditAction varchar(255)
);

CREATE TABLE AuditPromotions (
   PromotionID INT PRIMARY KEY IDENTITY(1,1),
   PromotionName VARCHAR(255),
   PromotionDescription VARCHAR(255),
   StartDate DATE,
   EndDate DATE,AuditAction varchar(255)
);

CREATE TABLE AuditContracts (
   ContractID INT ,
   EndDate DATE,AuditAction varchar(255)
);
----------------------------------------
CREATE TRIGGER trgAfterInsert
ON Customers
AFTER INSERT
AS
BEGIN

   DECLARE @FirstName VARCHAR(255);
   DECLARE @LastName VARCHAR(255);
  DECLARE  @Email VARCHAR(255);
  DECLARE @PhoneNumber VARCHAR(255);
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
	SELECT @FirstName = i.FirstName FROM inserted i;
	SELECT @LastName = i.LastName FROM inserted i;
	SELECT @Email = i.Email FROM inserted i;
	SELECT @PhoneNumber = i.PhoneNumber FROM inserted i;
    INSERT INTO AuditCustomers (    CustomerID  ,
    FirstName ,
    LastName ,
    Email ,
    PhoneNumber )
    VALUES (@CustomerID, @FirstName,@LastName,@Email,@PhoneNumber);
END;

CREATE TRIGGER trgAfterInsertAddresses
ON Addresses
AFTER INSERT
AS
BEGIN
    DECLARE @AddressID INT;
	   
     DECLARE @StreetAddress VARCHAR(255);
     DECLARE @City VARCHAR(255);
     DECLARE @District VARCHAR(255)
     DECLARE @ZipCode VARCHAR(255)
    SELECT @AddressID = i.AddressID,@StreetAddress=i.StreetAddress ,@City=i.City,@District=i.District,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditAddresses( AddressID  ,
    StreetAddress ,
    City ,
    District ,
    ZipCode )
    VALUES (@AddressID,@StreetAddress ,@City,@District,@ZipCode);
END;

CREATE TRIGGER trgAfterInsertServicess
ON Servicess
AFTER INSERT
AS
BEGIN
    DECLARE @ServiceID INT;
	DECLARE @ServiceName VARCHAR(255);
    DECLARE @ServiceDescription VARCHAR(255);
    DECLARE @MonthlyFee float
    SELECT @ServiceID = i.ServiceID ,@ServiceName=i.ServiceName,@ServiceDescription=i.ServiceDescription,@MonthlyFee=i.MonthlyFee from inserted i;
    INSERT INTO AuditServicess( ServiceID  ,
    ServiceName ,
    ServiceDescription ,
    MonthlyFee )
    VALUES (@ServiceID, @ServiceName,@ServiceDescription,@MonthlyFee);
END;

CREATE TRIGGER trgAfterInsertSubscriptions
ON Subscriptions
AFTER INSERT
AS
BEGIN
    DECLARE @SubscriptionID INT;
	DECLARE @StartDate DATE;
    DECLARE @EndDate DATE
    SELECT @SubscriptionID = i.SubscriptionID ,@StartDate=i.StartDate,@EndDate=i.EndDate from inserted i;
    INSERT INTO AuditSubscriptions (SubscriptionID ,
    StartDate ,
    EndDate )
    VALUES (@SubscriptionID,@StartDate,@EndDate);
END;

CREATE TRIGGER trgAfterInsertBilling
ON Billing
AFTER INSERT
AS
BEGIN
    DECLARE @BillingID INT;
	DECLARE @BillingDate DATE;
    DECLARE @AmountDue float;
    DECLARE @DueDate DATE
    SELECT @BillingID = i.BillingID ,@BillingDate=i.BillingDate ,@AmountDue=i.AmountDue,@DueDate=i.DueDate FROM inserted i;
    INSERT INTO AuditBilling (BillingID  ,
    BillingDate ,
    AmountDue ,
    DueDate)
    VALUES (@BillingID, @BillingDate,@AmountDue,@DueDate);
END;

CREATE TRIGGER trgAfterInsertPayments
ON Payments
AFTER INSERT
AS
BEGIN
    DECLARE @PaymentID INT;
	 DECLARE @PaymentDate DATE;
    DECLARE @PaymentAmount float
    SELECT @PaymentID = i.PaymentID,@PaymentDate=i.PaymentDate ,@PaymentAmount=i.PaymentAmount from inserted i;
    INSERT INTO AuditPayments ( PaymentID ,
    PaymentDate ,
    PaymentAmount)
    VALUES (@PaymentID,@PaymentDate,@PaymentAmount );
END;

CREATE TRIGGER trgAfterInsertUsage
ON Usage
AFTER INSERT
AS
BEGIN
    DECLARE @UsageID INT;
	 DECLARE @UsageDate DATE;
    DECLARE @DataUsed float;
	DECLARE @UsageBytes varchar(255)
    SELECT @UsageID = i.UsageID,@UsageDate=i.UsageDate,@DataUsed=i.DataUsed,@UsageBytes=i.UsageBytes FROM inserted i;
    INSERT INTO AuditUsage ( UsageID  ,
    UsageDate ,
    DataUsed ,
	UsageBytes)
    VALUES (@UsageID, @UsageDate,@DataUsed,@UsageBytes);
END;


CREATE TRIGGER trgAfterInsertTechnicians
ON Technicians
AFTER INSERT
AS
BEGIN
    DECLARE @TechnicianID INT,@FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @PhoneNumber VARCHAR(255);
    SELECT @TechnicianID = i.TechnicianID ,@FirstName=i.FirstName ,@LastName=i.LastName,@PhoneNumber=i.PhoneNumber  from inserted i;
    INSERT INTO AuditTechnicians
    VALUES (@TechnicianID, @FirstName,@LastName,@PhoneNumber);
END;


CREATE TRIGGER trgAfterInsertIssues
ON Issues 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @IssueID INT ,@IssueDescription VARCHAR(255),
    @DateCreated DATE,
    @DateResolved DATE; 
   SELECT @IssueID = i.IssueID,@IssueDescription=i.IssueDescription,@DateCreated=i.DateCreated,@DateResolved=i.DateResolved FROM inserted i; 
   INSERT INTO AuditIssues 
   VALUES (@IssueID, @IssueDescription,@DateCreated,@DateResolved); 
END; 



CREATE TRIGGER trgAfterInsertServiceOffices
ON ServiceOffices
AFTER INSERT
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode);
END;

CREATE TRIGGER trgAfterInsertPromotions
ON Promotions
AFTER INSERT
AS
BEGIN
    DECLARE @PromotionID INT, @PromotionName VARCHAR(255),
   @PromotionDescription VARCHAR(255),
   @StartDate DATE,
   @EndDate DATE;
    SELECT @PromotionID = i.PromotionID,@PromotionName= i.PromotionName,@PromotionDescription= i.PromotionDescription,@StartDate= i.StartDate,@EndDate= i.EndDate FROM inserted i;
    INSERT INTO AuditPromotions 
    VALUES (@PromotionID, @PromotionName,@PromotionDescription,@StartDate,@EndDate);
END;

CREATE TRIGGER trgAfterInsertContracts
ON Contracts
AFTER INSERT
AS
BEGIN
    DECLARE @ContractID INT,@EndDate DATE;
    SELECT @ContractID = i.ContractID,@EndDate=i.EndDate FROM inserted i;
    INSERT INTO AuditContracts
    VALUES (@ContractID, @EndDate);
END;

CREATE TRIGGER trgAfterInsertCustomersAudit
ON Customers
AFTER INSERT
AS
BEGIN
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
    INSERT INTO AuditCustomers (CustomerID, auditaction)
    VALUES (@CustomerID, 'Inserted new customer');
END;
drop trigger trgAfterInsertCustomersAudit

CREATE TRIGGER trgAfterInsertAddressesAudit
ON Addresses
AFTER INSERT
AS
BEGIN
    DECLARE @AddressID INT;
    SELECT @AddressID = i.AddressID FROM inserted i;
    INSERT INTO AuditAddresses (AddressID, AuditAction)
    VALUES (@AddressID, 'Inserted new address');
END;


CREATE TRIGGER trgAfterInsertServicessAudit
ON Servicess 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @ServiceID INT; 
   SELECT @ServiceID = i.ServiceID FROM inserted i; 
   INSERT INTO AuditServicess (ServiceID, AuditAction) 
   VALUES (@ServiceID, 'Inserted new service'); 
END; 
CREATE TRIGGER trgAfterInsertSubscriptionsAudit 
ON Subscriptions 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @SubscriptionID INT; 
   SELECT @SubscriptionID = i.SubscriptionID FROM inserted i; 
   INSERT INTO AuditSubscriptions (SubscriptionID, AuditAction) 
   VALUES (@SubscriptionID, 'Inserted new subscription'); 
END; 
 
CREATE TRIGGER trgAfterInsertBillingAudit 
ON Billing 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @BillingID INT; 
   SELECT @BillingID = i.BillingID FROM inserted i; 
   INSERT INTO AuditBilling(BillingID, AuditAction) 
   VALUES (@BillingID, 'Inserted new billing'); 
END; 

 
CREATE TRIGGER trgAfterInsertPaymentsAudit 
ON Payments 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @PaymentID INT; 
   SELECT @PaymentID = i.PaymentID FROM inserted i; 
   INSERT INTO AuditPayments(PaymentID, AuditAction) 
   VALUES (@PaymentID, 'Inserted new payment'); 
END;

CREATE TRIGGER trgAfterInsertUsageAudit 
ON Usage 
AFTER INSERT 
AS 
BEGIN 
   DECLARE @UsageID INT; 
   SELECT @UsageID = i.UsageID FROM inserted i; 
   INSERT into AuditUsage(UsageID, AuditAction) 
   VALUES (@UsageID, 'Inserted new usage'); 
END;

CREATE TRIGGER trgrInsertServiceOffices
ON ServiceOffices
AFTER INSERT
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode,'New office added');
END;




--Q29
--SINGLE ROW FUNCTION


SELECT UPPER(FirstName) FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT UPPER(LastName) FROM Customers WHERE FirstName = 'Jane' OR LastName = 'Smith';
SELECT UPPER(Email) FROM Customers WHERE NOT FirstName = 'Bob';
SELECT UPPER(FirstName) FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT UPPER(City) FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT UPPER(District) FROM Addresses WHERE NOT City = 'New York';
SELECT UPPER(ServiceName) FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%internet%';
SELECT UPPER(ServiceDescription) FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT UPPER(CONVERT(varchar, StartDate, 101)) FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT UPPER(CONVERT(varchar, EndDate, 101)) FROM Subscriptions WHERE NOT CustomerID = 3;



SELECT LOWER(FirstName) FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT LOWER(LastName) FROM Customers WHERE FirstName = 'Jane' OR LastName = 'Smith';
SELECT LOWER(Email) FROM Customers WHERE NOT FirstName = 'Bob';
SELECT LOWER(FirstName) FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT LOWER(City) FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT LOWER(District) FROM Addresses WHERE NOT City = 'New York';
SELECT LOWER(ServiceName) FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%internet%';
SELECT LOWER(ServiceDescription) FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT LOWER(CONVERT(varchar, StartDate, 101)) FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT LOWER(CONVERT(varchar, EndDate, 101)) FROM Subscriptions WHERE NOT CustomerID = 3;

SELECT LEN(FirstName) FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT LEN(LastName) FROM Customers WHERE FirstName = 'Jane' OR LastName = 'Smith';
SELECT LEN(Email) FROM Customers WHERE NOT FirstName = 'Bob';
SELECT LEN(PhoneNumber) FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT LEN(City) FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT LEN(District) FROM Addresses WHERE NOT City = 'New York';
SELECT LEN(ServiceName) FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%internet%';
SELECT LEN(ServiceDescription) FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT LEN(CONVERT(varchar, StartDate, 101)) FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT LEN(CONVERT(varchar, EndDate, 101)) FROM Subscriptions WHERE NOT CustomerID = 3;


SELECT SUBSTRING(FirstName, 1, 3) FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT SUBSTRING(LastName, 2, 4) FROM Customers WHERE FirstName = 'Jane' OR LastName = 'Smith';
SELECT SUBSTRING(Email, 1, 5) FROM Customers WHERE NOT FirstName = 'Bob';
SELECT SUBSTRING(PhoneNumber, 4, 3) FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT SUBSTRING(City, 1, 3) FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT SUBSTRING(District, 2, 4) FROM Addresses WHERE NOT City = 'New York';
SELECT SUBSTRING(ServiceName, 1, 5) FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%internet%';
SELECT SUBSTRING(ServiceDescription, 6, 10) FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT SUBSTRING(CONVERT(varchar, StartDate, 101), 1, 5) FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT SUBSTRING(CONVERT(varchar, EndDate, 101), 6, 4) FROM Subscriptions WHERE NOT CustomerID = 3;

SELECT SUBSTRING(FirstName, 1, 3) AS ShortName FROM Customers;
SELECT SUBSTRING(LastName, 1, 3) AS ShortName FROM Customers;
SELECT SUBSTRING(Email, 1, 5) AS ShortEmail FROM Customers;
SELECT SUBSTRING(PhoneNumber, 1, 3) AS AreaCode FROM Customers;
SELECT SUBSTRING(StreetAddress, 1, 10) AS ShortAddress FROM Addresses;
SELECT SUBSTRING(City, 1, 3) AS ShortCity FROM Addresses;
SELECT SUBSTRING(District, 1, 3) AS ShortDistrict FROM Addresses;
SELECT SUBSTRING(ZipCode, 1, 5) AS ShortZip FROM Addresses;
SELECT SUBSTRING(ServiceName, 1, 3) AS ShortService FROM Servicess;
SELECT SUBSTRING(ServiceDescription, 1, 10) AS ShortDescription FROM Servicess;
--
SELECT SUBSTRING(EquipmentName, 1, 3) AS ShortEquipment FROM Equipment;
SELECT SUBSTRING(EquipmentDescription, 1, 10) AS ShortDescription FROM Equipment;
SELECT SUBSTRING(PromotionName, 1, 3) AS ShortPromotion FROM Promotions;
SELECT SUBSTRING(PromotionDescription, 1, 10) AS ShortDescription FROM Promotions;
SELECT SUBSTRING(City, 1, 3) AS ShortCity FROM ServiceOffices;

-------------------------

--Q30
--single row function
SELECT TRIM(FirstName) FROM Customers WHERE FirstName = 'John' AND LastName = 'Doe';
SELECT TRIM(LastName) FROM Customers WHERE FirstName = 'Jane' OR LastName = 'Smith';
SELECT TRIM(Email) FROM Customers WHERE NOT FirstName = 'Bob';
SELECT TRIM(PhoneNumber) FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT TRIM(City) FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT TRIM(District) FROM Addresses WHERE NOT City = 'New York';
SELECT TRIM(ServiceName) FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%internet%';
SELECT TRIM(ServiceDescription) FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT TRIM(StartDate) FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT TRIM(EndDate) FROM Subscriptions WHERE NOT CustomerID = 3;
SELECT TRIM(BillingDate) FROM Billing WHERE SubscriptionID = 4 AND AmountDue > 100;
SELECT TRIM(AmountDue) FROM Billing WHERE DueDate < GETDATE() OR BillingID = 5;
SELECT TRIM(PaymentDate) FROM Payments WHERE BillingID = 6 AND PaymentAmount < 50;
SELECT TRIM(PaymentAmount) FROM Payments WHERE NOT PaymentDate > GETDATE();
SELECT TRIM(DataUsed) FROM Usage WHERE SubscriptionID = 7 AND UsageDate BETWEEN '2022-01-01' AND '2022-12-31';
SELECT TRIM(UsageBytes) FROM Usage WHERE NOT SubscriptionID = 8;
SELECT TRIM(FirstName) FROM Technicians WHERE PhoneNumber LIKE '%123%';
SELECT TRIM(LastName) FROM Technicians WHERE NOT FirstName = 'Tom';
SELECT TRIM(IssueDescription) FROM Issues WHERE CustomerID = 9 AND DateResolved IS NULL;
SELECT TRIM(DateCreated) FROM Issues WHERE NOT TechnicianID = 10;

SELECT ROUND(MonthlyFee, 0) FROM Servicess WHERE ServiceName = 'Internet' AND ServiceDescription LIKE '%high speed%';
SELECT ROUND(AmountDue, 1) FROM Billing WHERE SubscriptionID = 1 OR BillingDate > GETDATE();
SELECT ROUND(PaymentAmount, 2) FROM Payments WHERE NOT BillingID = 2;
SELECT ROUND(DataUsed, 0) FROM Usage WHERE SubscriptionID = 3 AND UsageDate BETWEEN '2022-01-01' AND '2022-12-31';
SELECT ROUND(CAST(UsageBytes AS float), 1) FROM Usage WHERE NOT SubscriptionID = 4;
SELECT ROUND((SELECT SUM(MonthlyFee) FROM Servicess), 0) WHERE EXISTS (SELECT ServiceID FROM Servicess WHERE ServiceName = 'Cable TV');
SELECT ROUND(AVG(MonthlyFee), 1) FROM Servicess WHERE ServiceDescription LIKE '%unlimited%';
SELECT ROUND(MAX(MonthlyFee), 2) FROM Servicess WHERE ServiceName = 'Phone' OR ServiceDescription LIKE '%unlimited calls%';
SELECT ROUND(MIN(MonthlyFee), 0) FROM Servicess WHERE NOT ServiceName = 'Internet';
SELECT ServiceName, ROUND(AVG(MonthlyFee), 1) FROM Servicess GROUP BY ServiceName;
SELECT CustomerID, ROUND(AVG(DataUsed), 1) FROM Usage GROUP BY CustomerID;
SELECT ROUND(SUM(AmountDue), 2) FROM Billing WHERE DueDate < GETDATE();
SELECT ServiceName, ROUND(MonthlyFee, -1) FROM Servicess;
SELECT ROUND(AVG(MonthlyFee), 0) FROM Servicess;
SELECT ROUND(123.456, 2);


SELECT REPLACE(FirstName, 'a', 'o') FROM Customers WHERE FirstName = 'Jane' AND LastName = 'Doe';
SELECT REPLACE(LastName, 's', 'z') FROM Customers WHERE FirstName = 'John' OR LastName = 'Smith';
SELECT REPLACE(Email, '@', '#') FROM Customers WHERE NOT FirstName = 'Bob';
SELECT REPLACE(PhoneNumber, '-', '') FROM Customers WHERE FirstName = 'Alice' AND LastName = 'Johnson';
SELECT REPLACE(City, 'New', 'Old') FROM Addresses WHERE ZipCode = '12345' OR StreetAddress = '123 Main St';
SELECT REPLACE(District, 'East', 'West') FROM Addresses WHERE NOT City = 'New York';
SELECT REPLACE(ServiceName, 'Internet', 'Web') FROM Servicess WHERE MonthlyFee > 50 AND ServiceDescription LIKE '%high speed%';
SELECT REPLACE(ServiceDescription, 'unlimited', 'limited') FROM Servicess WHERE MonthlyFee < 30 OR ServiceName = 'Cable TV';
SELECT REPLACE(CONVERT(varchar, StartDate, 101), '/', '-') FROM Subscriptions WHERE CustomerID = 1 AND ServiceID = 2;
SELECT REPLACE(CONVERT(varchar, EndDate, 101), '/', '.') FROM Subscriptions WHERE NOT CustomerID = 3;
SELECT REPLACE(CONVERT(varchar, BillingDate, 101), '/', ',') FROM Billing WHERE SubscriptionID = 4 AND AmountDue > 100;
SELECT REPLACE(CONVERT(varchar, AmountDue), '.', ',') FROM Billing WHERE DueDate < GETDATE() OR BillingID = 5;
SELECT REPLACE(CONVERT(varchar, PaymentDate, 101), '/', '|') FROM Payments WHERE BillingID = 6 AND PaymentAmount < 50;
SELECT REPLACE(CONVERT(varchar, PaymentAmount), '.', ':') FROM Payments WHERE NOT PaymentDate > GETDATE();
SELECT REPLACE(CONVERT(varchar, DataUsed), '.', '_') FROM Usage WHERE SubscriptionID = 7 AND UsageDate BETWEEN '2022-01-01' AND '2022-12-31';


TRUNCATE TABLE Addresses;
TRUNCATE TABLE Customers;
TRUNCATE TABLE Servicess;
TRUNCATE TABLE Subscriptions;
TRUNCATE TABLE Billing;
TRUNCATE TABLE Payments;
TRUNCATE TABLE Usage;
TRUNCATE TABLE Technicians;
TRUNCATE TABLE Issues;
TRUNCATE TABLE Equipment;


------------------------------------------
--Transaction 
BEGIN TRANSACTION;
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES ('John', 'Doe', 'john.doe@email.com', '123-456-7890');
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Customers SET PhoneNumber = '098-765-4321' WHERE CustomerID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Customers WHERE CustomerID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Servicess (ServiceName, ServiceDescription, MonthlyFee) VALUES ('Internet', 'High speed internet', 50);
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Servicess SET MonthlyFee = 60 WHERE ServiceID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Servicess WHERE ServiceID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Subscriptions (CustomerID, ServiceID, StartDate, EndDate) VALUES (1, 1, '2022-01-01', '2022-12-31');
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Subscriptions SET EndDate = '2023-12-31' WHERE SubscriptionID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Subscriptions WHERE SubscriptionID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Billing (SubscriptionID, BillingDate, AmountDue, DueDate) VALUES (1, '2022-01-01', 50, '2022-02-01');
COMMIT;
ROLLBACK;

BEGIN TRANSACTION;
INSERT INTO Payments (BillingID, PaymentDate, PaymentAmount) VALUES (1, '2022-02-01', 50);
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Payments SET PaymentAmount = 60 WHERE PaymentID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Payments WHERE PaymentID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Usage (SubscriptionID, UsageDate, DataUsed) VALUES (1, '2022-01-01', 1024);
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Usage SET DataUsed = 2048 WHERE UsageID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Usage WHERE UsageID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Technicians (FirstName, LastName, PhoneNumber) VALUES ('John', 'Doe', '123-456-7890');
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
UPDATE Technicians SET PhoneNumber = '098-765-4321' WHERE TechnicianID = 1;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
DELETE FROM Technicians WHERE TechnicianID = 2;
COMMIT;
ROLLBACK;
BEGIN TRANSACTION;
INSERT INTO Issues (CustomerID, IssueDescription, DateCreated) VALUES (1, 'Internet not working', '2022-01-01');
COMMIT;
ROLLBACK;
--------------------------------------------------


BEGIN TRY
    INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES ('John', 'Doe', 'john.doe@email.com', '123-456-7890');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Customers SET PhoneNumber = '098-765-4321' WHERE CustomerID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Customers WHERE CustomerID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    INSERT INTO Servicess (ServiceName, ServiceDescription, MonthlyFee) VALUES ('Internet', 'High speed internet', 50);
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Servicess SET MonthlyFee = 60 WHERE ServiceID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Servicess WHERE ServiceID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    INSERT INTO Subscriptions (CustomerID, ServiceID, StartDate, EndDate) VALUES (1, 1, '2022-01-01', '2022-12-31');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Subscriptions SET EndDate = '2023-12-31' WHERE SubscriptionID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Subscriptions WHERE SubscriptionID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    INSERT INTO Billing (SubscriptionID, BillingDate, AmountDue, DueDate) VALUES (1, '2022-01-01', 50, '2022-02-01');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Billing SET AmountDue = 60 WHERE BillingID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Billing WHERE BillingID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;


BEGIN TRY
    INSERT INTO Payments (BillingID, PaymentDate, PaymentAmount) VALUES (1, '2022-02-01', 50);
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Payments SET PaymentAmount = 60 WHERE PaymentID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Payments WHERE PaymentID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    INSERT INTO Usage (SubscriptionID, UsageDate, DataUsed) VALUES (1, '2022-01-01', 1024);
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Usage SET DataUsed = 2048 WHERE UsageID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    DELETE FROM Usage WHERE UsageID = 2;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    INSERT INTO Technicians (FirstName, LastName, PhoneNumber) VALUES ('John', 'Doe', '123-456-7890');
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;
BEGIN TRY
    UPDATE Technicians SET PhoneNumber = '098-765-4321' WHERE TechnicianID = 1;
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH;




CREATE TRIGGER trgAfterdelete
ON Customers
AFTER delete
AS
BEGIN

   DECLARE @FirstName VARCHAR(255);
   DECLARE @LastName VARCHAR(255);
  DECLARE  @Email VARCHAR(255);
  DECLARE @PhoneNumber VARCHAR(255);
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
	SELECT @FirstName = i.FirstName FROM inserted i;
	SELECT @LastName = i.LastName FROM inserted i;
	SELECT @Email = i.Email FROM inserted i;
	SELECT @PhoneNumber = i.PhoneNumber FROM inserted i;
	
    INSERT INTO AuditCustomers (    CustomerID  ,
    FirstName ,
    LastName ,
    Email ,
    PhoneNumber,AuditAction )
    VALUES (@CustomerID, @FirstName,@LastName,@Email,@PhoneNumber,'Customer deleted');
END;

CREATE TRIGGER trgAfterdeleteAddresses
ON Addresses
AFTER delete
AS
BEGIN
    DECLARE @AddressID INT;
	   
     DECLARE @StreetAddress VARCHAR(255);
     DECLARE @City VARCHAR(255);
     DECLARE @District VARCHAR(255)
     DECLARE @ZipCode VARCHAR(255)
    SELECT @AddressID = i.AddressID,@StreetAddress=i.StreetAddress ,@City=i.City,@District=i.District,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditAddresses( AddressID  ,
    StreetAddress ,
    City ,
    District ,
    ZipCode ,AuditAction)
    VALUES (@AddressID,@StreetAddress ,@City,@District,@ZipCode,'Address deleted');
END;

CREATE TRIGGER trgAfterdeleteServicess
ON Servicess
AFTER delete
AS
BEGIN
    DECLARE @ServiceID INT;
	DECLARE @ServiceName VARCHAR(255);
    DECLARE @ServiceDescription VARCHAR(255);
    DECLARE @MonthlyFee float
    SELECT @ServiceID = i.ServiceID ,@ServiceName=i.ServiceName,@ServiceDescription=i.ServiceDescription,@MonthlyFee=i.MonthlyFee from inserted i;
    INSERT INTO AuditServicess( ServiceID  ,
    ServiceName ,
    ServiceDescription ,
    MonthlyFee, AuditAction )
    VALUES (@ServiceID, @ServiceName,@ServiceDescription,@MonthlyFee,'Service deleted');
END;

CREATE TRIGGER trgAfterdeleteSubscriptions
ON Subscriptions
AFTER delete
AS
BEGIN
    DECLARE @SubscriptionID INT;
	DECLARE @StartDate DATE;
    DECLARE @EndDate DATE
    SELECT @SubscriptionID = i.SubscriptionID ,@StartDate=i.StartDate,@EndDate=i.EndDate from inserted i;
    INSERT INTO AuditSubscriptions (SubscriptionID ,
    StartDate ,
    EndDate ,AuditAction)
    VALUES (@SubscriptionID,@StartDate,@EndDate,'Subscription deleted');
END;

CREATE TRIGGER trgAfterdeleteBilling
ON Billing
AFTER delete
AS
BEGIN
    DECLARE @BillingID INT;
	DECLARE @BillingDate DATE;
    DECLARE @AmountDue float;
    DECLARE @DueDate DATE
    SELECT @BillingID = i.BillingID ,@BillingDate=i.BillingDate ,@AmountDue=i.AmountDue,@DueDate=i.DueDate FROM inserted i;
    INSERT INTO AuditBilling (BillingID  ,
    BillingDate ,
    AmountDue ,
    DueDate,AuditAction)
    VALUES (@BillingID, @BillingDate,@AmountDue,@DueDate,'Billing deleted');
END;

CREATE TRIGGER trgAfterdeletePayments
ON Payments
AFTER delete
AS
BEGIN
    DECLARE @PaymentID INT;
	 DECLARE @PaymentDate DATE;
    DECLARE @PaymentAmount float
    SELECT @PaymentID = i.PaymentID,@PaymentDate=i.PaymentDate ,@PaymentAmount=i.PaymentAmount from inserted i;
    INSERT INTO AuditPayments ( PaymentID ,
    PaymentDate ,
    PaymentAmount,AuditAction)
    VALUES (@PaymentID,@PaymentDate,@PaymentAmount,'Payment  deleted' );
END;

CREATE TRIGGER trgAfterdeleteeUsage
ON Usage
AFTER delete
AS
BEGIN
    DECLARE @UsageID INT;
	 DECLARE @UsageDate DATE;
    DECLARE @DataUsed float;
	DECLARE @UsageBytes varchar(255)
    SELECT @UsageID = i.UsageID,@UsageDate=i.UsageDate,@DataUsed=i.DataUsed,@UsageBytes=i.UsageBytes FROM inserted i;
    INSERT INTO AuditUsage ( UsageID  ,
    UsageDate ,
    DataUsed ,
	UsageBytes,AuditAction)
    VALUES (@UsageID, @UsageDate,@DataUsed,@UsageBytes,'Usage deleted');
END;

CREATE TRIGGER trgAftedeleteTechnicians
ON Technicians
AFTER delete
AS
BEGIN
    DECLARE @TechnicianID INT,@FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @PhoneNumber VARCHAR(255);
    SELECT @TechnicianID = i.TechnicianID ,@FirstName=i.FirstName ,@LastName=i.LastName,@PhoneNumber=i.PhoneNumber  from inserted i;
    INSERT INTO AuditTechnicians
    VALUES (@TechnicianID, @FirstName,@LastName,@PhoneNumber,'technician deleted');
END;


CREATE TRIGGER trgAfterdeleteIssues
ON Issues 
AFTER delete
AS 
BEGIN 
   DECLARE @IssueID INT ,@IssueDescription VARCHAR(255),
    @DateCreated DATE,
    @DateResolved DATE; 
   SELECT @IssueID = i.IssueID,@IssueDescription=i.IssueDescription,@DateCreated=i.DateCreated,@DateResolved=i.DateResolved FROM inserted i; 
   INSERT INTO AuditIssues 
   VALUES (@IssueID, @IssueDescription,@DateCreated,@DateResolved,'issue deleted'); 
END; 

CREATE TRIGGER trgAfterdeleteServiceOffices
ON ServiceOffices
AFTER delete
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode,'issue deleted');
END;


CREATE TRIGGER trgAfterdeletePromotions
ON Promotions
AFTER delete
AS
BEGIN
    DECLARE @PromotionID INT, @PromotionName VARCHAR(255),
   @PromotionDescription VARCHAR(255),
   @StartDate DATE,
   @EndDate DATE;
    SELECT @PromotionID = i.PromotionID,@PromotionName= i.PromotionName,@PromotionDescription= i.PromotionDescription,@StartDate= i.StartDate,@EndDate= i.EndDate FROM inserted i;
    INSERT INTO AuditPromotions 
    VALUES (@PromotionID, @PromotionName,@PromotionDescription,@StartDate,@EndDate,'Promotion deleted');
END;

CREATE TRIGGER trgAfterdeleteContracts
ON Contracts
AFTER delete
AS
BEGIN
    DECLARE @ContractID INT,@EndDate DATE;
    SELECT @ContractID = i.ContractID,@EndDate=i.EndDate FROM inserted i;
    INSERT INTO AuditContracts
    VALUES (@ContractID, @EndDate,'contract deleted');
END;

CREATE TRIGGER trgAfterdeleteCustomersAudit
ON Customers
AFTER delete
AS
BEGIN
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
    INSERT INTO AuditCustomers (CustomerID, auditaction)
    VALUES (@CustomerID, 'deleted customer');
END;

CREATE TRIGGER trgAfterdeleteAddressesAudit
ON Addresses
AFTER delete
AS
BEGIN
    DECLARE @AddressID INT;
    SELECT @AddressID = i.AddressID FROM inserted i;
    INSERT INTO AuditAddresses (AddressID, AuditAction)
    VALUES (@AddressID, 'deleted address');
END;

CREATE TRIGGER trgAfterdeleteServicessAudit
ON Servicess 
AFTER delete
AS 
BEGIN 
   DECLARE @ServiceID INT; 
   SELECT @ServiceID = i.ServiceID FROM inserted i; 
   INSERT INTO AuditServicess (ServiceID, AuditAction) 
   VALUES (@ServiceID, 'service deleted'); 
END; 

CREATE TRIGGER trgAfterdeleteSubscriptionsAudit 
ON Subscriptions 
AFTER delete
AS 
BEGIN 
   DECLARE @SubscriptionID INT; 
   SELECT @SubscriptionID = i.SubscriptionID FROM inserted i; 
   INSERT INTO AuditSubscriptions (SubscriptionID, AuditAction) 
   VALUES (@SubscriptionID, 'subscription delete'); 
END; 

CREATE TRIGGER trgAfterdeleteBillingAudit 
ON Billing 
AFTER delete
AS 
BEGIN 
   DECLARE @BillingID INT; 
   SELECT @BillingID = i.BillingID FROM inserted i; 
   INSERT INTO AuditBilling(BillingID, AuditAction) 
   VALUES (@BillingID, 'billing deleted'); 
END; 


CREATE TRIGGER trgAfterdeletePaymentsAudit 
ON Payments 
AFTER delete
AS 
BEGIN 
   DECLARE @PaymentID INT; 
   SELECT @PaymentID = i.PaymentID FROM inserted i; 
   INSERT INTO AuditPayments(PaymentID, AuditAction) 
   VALUES (@PaymentID, 'payment delete'); 
END;

CREATE TRIGGER trgAfterdeleteUsageAudit 
ON Usage 
AFTER delete
AS 
BEGIN 
   DECLARE @UsageID INT; 
   SELECT @UsageID = i.UsageID FROM inserted i; 
   INSERT into AuditUsage(UsageID, AuditAction) 
   VALUES (@UsageID, 'usage deleted'); 
END;

CREATE TRIGGER trgrdeleteServiceOffices
ON ServiceOffices
AFTER delete
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode,'office deleted');
END;







CREATE TRIGGER trgAfterupdate
ON Customers
AFTER update
AS
BEGIN

   DECLARE @FirstName VARCHAR(255);
   DECLARE @LastName VARCHAR(255);
  DECLARE  @Email VARCHAR(255);
  DECLARE @PhoneNumber VARCHAR(255);
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
	SELECT @FirstName = i.FirstName FROM inserted i;
	SELECT @LastName = i.LastName FROM inserted i;
	SELECT @Email = i.Email FROM inserted i;
	SELECT @PhoneNumber = i.PhoneNumber FROM inserted i;
	
    INSERT INTO AuditCustomers (    CustomerID  ,
    FirstName ,
    LastName ,
    Email ,
    PhoneNumber,AuditAction )
    VALUES (@CustomerID, @FirstName,@LastName,@Email,@PhoneNumber,'Customer updated');
END;

CREATE TRIGGER trgAfterupdateAddresses
ON Addresses
AFTER update
AS
BEGIN
    DECLARE @AddressID INT;
	   
     DECLARE @StreetAddress VARCHAR(255);
     DECLARE @City VARCHAR(255);
     DECLARE @District VARCHAR(255)
     DECLARE @ZipCode VARCHAR(255)
    SELECT @AddressID = i.AddressID,@StreetAddress=i.StreetAddress ,@City=i.City,@District=i.District,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditAddresses( AddressID  ,
    StreetAddress ,
    City ,
    District ,
    ZipCode ,AuditAction)
    VALUES (@AddressID,@StreetAddress ,@City,@District,@ZipCode,'Address updated');
END;

CREATE TRIGGER trgAfterupdateServicess
ON Servicess
AFTER update
AS
BEGIN
    DECLARE @ServiceID INT;
	DECLARE @ServiceName VARCHAR(255);
    DECLARE @ServiceDescription VARCHAR(255);
    DECLARE @MonthlyFee float
    SELECT @ServiceID = i.ServiceID ,@ServiceName=i.ServiceName,@ServiceDescription=i.ServiceDescription,@MonthlyFee=i.MonthlyFee from inserted i;
    INSERT INTO AuditServicess( ServiceID  ,
    ServiceName ,
    ServiceDescription ,
    MonthlyFee, AuditAction )
    VALUES (@ServiceID, @ServiceName,@ServiceDescription,@MonthlyFee,'Service Updated');
END;

CREATE TRIGGER trgAfterupdateSubscriptions
ON Subscriptions
AFTER update
AS
BEGIN
    DECLARE @SubscriptionID INT;
	DECLARE @StartDate DATE;
    DECLARE @EndDate DATE
    SELECT @SubscriptionID = i.SubscriptionID ,@StartDate=i.StartDate,@EndDate=i.EndDate from inserted i;
    INSERT INTO AuditSubscriptions (SubscriptionID ,
    StartDate ,
    EndDate ,AuditAction)
    VALUES (@SubscriptionID,@StartDate,@EndDate);
END;

CREATE TRIGGER trgAfterupdateBilling
ON Billing
AFTER update
AS
BEGIN
    DECLARE @BillingID INT;
	DECLARE @BillingDate DATE;
    DECLARE @AmountDue float;
    DECLARE @DueDate DATE
    SELECT @BillingID = i.BillingID ,@BillingDate=i.BillingDate ,@AmountDue=i.AmountDue,@DueDate=i.DueDate FROM inserted i;
    INSERT INTO AuditBilling (BillingID  ,
    BillingDate ,
    AmountDue ,
    DueDate,AuditAction)
    VALUES (@BillingID, @BillingDate,@AmountDue,@DueDate,'Billing Updated');
END;

CREATE TRIGGER trgAfterupdatePayments
ON Payments
AFTER update
AS
BEGIN
    DECLARE @PaymentID INT;
	 DECLARE @PaymentDate DATE;
    DECLARE @PaymentAmount float
    SELECT @PaymentID = i.PaymentID,@PaymentDate=i.PaymentDate ,@PaymentAmount=i.PaymentAmount from inserted i;
    INSERT INTO AuditPayments ( PaymentID ,
    PaymentDate ,
    PaymentAmount,AuditAction)
    VALUES (@PaymentID,@PaymentDate,@PaymentAmount,'Payment  updated' );
END;

CREATE TRIGGER trgAfterupdateUsage
ON Usage
AFTER update
AS
BEGIN
    DECLARE @UsageID INT;
	 DECLARE @UsageDate DATE;
    DECLARE @DataUsed float;
	DECLARE @UsageBytes varchar(255)
    SELECT @UsageID = i.UsageID,@UsageDate=i.UsageDate,@DataUsed=i.DataUsed,@UsageBytes=i.UsageBytes FROM inserted i;
    INSERT INTO AuditUsage ( UsageID  ,
    UsageDate ,
    DataUsed ,
	UsageBytes,AuditAction)
    VALUES (@UsageID, @UsageDate,@DataUsed,@UsageBytes,'Usage Updated');
END;


CREATE TRIGGER trgAfterupdateTechnicians
ON Technicians
AFTER update
AS
BEGIN
    DECLARE @TechnicianID INT,@FirstName VARCHAR(255),
    @LastName VARCHAR(255),
    @PhoneNumber VARCHAR(255);
    SELECT @TechnicianID = i.TechnicianID ,@FirstName=i.FirstName ,@LastName=i.LastName,@PhoneNumber=i.PhoneNumber  from inserted i;
    INSERT INTO AuditTechnicians
    VALUES (@TechnicianID, @FirstName,@LastName,@PhoneNumber,'technician updated');
END;

CREATE TRIGGER trgAfterupdateIssues
ON Issues 
AFTER update
AS 
BEGIN 
   DECLARE @IssueID INT ,@IssueDescription VARCHAR(255),
    @DateCreated DATE,
    @DateResolved DATE; 
   SELECT @IssueID = i.IssueID,@IssueDescription=i.IssueDescription,@DateCreated=i.DateCreated,@DateResolved=i.DateResolved FROM inserted i; 
   INSERT INTO AuditIssues 
   VALUES (@IssueID, @IssueDescription,@DateCreated,@DateResolved,'issue updated'); 
END; 

CREATE TRIGGER trgAfterupdateServiceOffices
ON ServiceOffices
AFTER update
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode,'issue updated');
END;

CREATE TRIGGER trgAfterupdatePromotions
ON Promotions
AFTER update
AS
BEGIN
    DECLARE @PromotionID INT, @PromotionName VARCHAR(255),
   @PromotionDescription VARCHAR(255),
   @StartDate DATE,
   @EndDate DATE;
    SELECT @PromotionID = i.PromotionID,@PromotionName= i.PromotionName,@PromotionDescription= i.PromotionDescription,@StartDate= i.StartDate,@EndDate= i.EndDate FROM inserted i;
    INSERT INTO AuditPromotions 
    VALUES (@PromotionID, @PromotionName,@PromotionDescription,@StartDate,@EndDate,'Promotion updated');
END;

CREATE TRIGGER trgAfterupdateContracts
ON Contracts
AFTER update
AS
BEGIN
    DECLARE @ContractID INT,@EndDate DATE;
    SELECT @ContractID = i.ContractID,@EndDate=i.EndDate FROM inserted i;
    INSERT INTO AuditContracts
    VALUES (@ContractID, @EndDate,'contract updated');
END;

CREATE TRIGGER trgAfterupdateCustomersAudit
ON Customers
AFTER update
AS
BEGIN
    DECLARE @CustomerID INT;
    SELECT @CustomerID = i.CustomerID FROM inserted i;
    INSERT INTO AuditCustomers (CustomerID, auditaction)
    VALUES (@CustomerID, 'updated new customer');
END;
drop trigger trgAfterInsertCustomersAudit
CREATE TRIGGER trgAfterupdateAddressesAudit
ON Addresses
AFTER update
AS
BEGIN
    DECLARE @AddressID INT;
    SELECT @AddressID = i.AddressID FROM inserted i;
    INSERT INTO AuditAddresses (AddressID, AuditAction)
    VALUES (@AddressID, 'updated new address');
END;

CREATE TRIGGER trgAfterupdateServicessAudit
ON Servicess 
AFTER update 
AS 
BEGIN 
   DECLARE @ServiceID INT; 
   SELECT @ServiceID = i.ServiceID FROM inserted i; 
   INSERT INTO AuditServicess (ServiceID, AuditAction) 
   VALUES (@ServiceID, 'updated new service'); 
END; 
 
CREATE TRIGGER trgAfterupdateSubscriptionsAudit 
ON Subscriptions 
AFTER update
AS 
BEGIN 
   DECLARE @SubscriptionID INT; 
   SELECT @SubscriptionID = i.SubscriptionID FROM inserted i; 
   INSERT INTO AuditSubscriptions (SubscriptionID, AuditAction) 
   VALUES (@SubscriptionID, 'updated new subscription'); 
END; 

CREATE TRIGGER trgAfterupdateBillingAudit 
ON Billing 
AFTER update
AS 
BEGIN 
   DECLARE @BillingID INT; 
   SELECT @BillingID = i.BillingID FROM inserted i; 
   INSERT INTO AuditBilling(BillingID, AuditAction) 
   VALUES (@BillingID, 'updated new billing'); 
END; 

CREATE TRIGGER trgAfterupdatePaymentsAudit 
ON Payments 
AFTER update 
AS 
BEGIN 
   DECLARE @PaymentID INT; 
   SELECT @PaymentID = i.PaymentID FROM inserted i; 
   INSERT INTO AuditPayments(PaymentID, AuditAction) 
   VALUES (@PaymentID, 'updated new payment'); 
END;
CREATE TRIGGER trgAfterupdateUsageAudit 
ON Usage 
AFTER update 
AS 
BEGIN 
   DECLARE @UsageID INT; 
   SELECT @UsageID = i.UsageID FROM inserted i; 
   INSERT into AuditUsage(UsageID, AuditAction) 
   VALUES (@UsageID, 'update new usage'); 
END;



CREATE TRIGGER trgrupdateServiceOffices
ON ServiceOffices
AFTER update
AS
BEGIN
    DECLARE @OfficeID INT, 
   @City VARCHAR(255),
   @ZipCode VARCHAR(255);
    SELECT @OfficeID = i.OfficeID,@City=i.City,@ZipCode=i.ZipCode FROM inserted i;
    INSERT INTO AuditServiceOffices
    VALUES (@OfficeID, @City,@ZipCode,'updated office status');
END;

------------------------------------------------------------------
--Q23


CREATE PROCEDURE GetCustomersByCityOrLastName
    @City VARCHAR(255),
    @LastName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Addresses.City
    FROM Customers
    INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID
    WHERE Addresses.City = @City OR Customers.LastName = @LastName
END;


CREATE PROCEDURE GetCustomersByFirstAndLastName
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName
    FROM Customers
    WHERE Customers.FirstName = @FirstName AND Customers.LastName = @LastName
END;
CREATE PROCEDURE GetCustomersByCityOrZipCode
    @City VARCHAR(255),
    @ZipCode VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Addresses.City, Addresses.ZipCode
    FROM Customers
    INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID
    WHERE Addresses.City = @City OR Addresses.ZipCode = @ZipCode
END;
CREATE PROCEDURE GetCustomersByServiceName
    @ServiceName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Servicess.ServiceName = @ServiceName
END;
CREATE PROCEDURE GetSubscriptionsByStartDateAndEndDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT Subscriptions.SubscriptionID, Subscriptions.StartDate, Subscriptions.EndDate, Customers.FirstName, Customers.LastName, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Subscriptions.StartDate >= @StartDate AND Subscriptions.EndDate <= @EndDate
END;
CREATE PROCEDURE GetTechniciansByFirstOrLastName
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255)
AS
BEGIN
    SELECT Technicians.FirstName, Technicians.LastName
    FROM Technicians
    WHERE Technicians.FirstName = @FirstName OR Technicians.LastName = @LastName
END;
CREATE PROCEDURE GetIssuesByCustomerIDAndIssueDescription
    @CustomerID INT,
    @IssueDescription VARCHAR(255)
AS
BEGIN
    SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName 
    FROM Issues 
    INNER JOIN Customers ON Issues.CustomerID = Customers.CustomerID 
    WHERE Issues.CustomerID = @CustomerID AND Issues.IssueDescription LIKE '%' + @IssueDescription + '%'
END;
CREATE PROCEDURE GetEquipmentByEquipmentName 
   @EquipmentName VARCHAR(255) 
AS 
BEGIN 
   SELECT Equipment.EquipmentName, Equipment.EquipmentDescription 
   FROM Equipment 
   WHERE Equipment.EquipmentName = @EquipmentName 
END; 
CREATE PROCEDURE GetServiceOfficesByCityOrZipCode 
   @City VARCHAR(255), 
   @ZipCode VARCHAR(255) 
AS 
BEGIN 
   SELECT ServiceOffices.OfficeID, ServiceOffices.City, ServiceOffices.ZipCode 
   FROM ServiceOffices 
   WHERE ServiceOffices.City = @City OR ServiceOffices.ZipCode = @ZipCode 
END; 
CREATE PROCEDURE GetPromotionsByPromotionNameOrStartDate 
   @PromotionName VARCHAR(255), 
   @StartDate DATE 
AS 
BEGIN 
   SELECT Promotions.PromotionID, Promotions.PromotionName, Promotions.PromotionDescription, Promotions.StartDate, Promotions.EndDate 
   FROM Promotions 
   WHERE Promotions.PromotionName = @PromotionName OR Promotions.StartDate >= @StartDate 
END; 
CREATE PROCEDURE GetContractsByCustomerIDOrServiceID 
   @CustomerID INT,
   @ServiceID INT  
AS 
BEGIN 
   SELECT Contracts.ContractID, Contracts.StartDate, Contracts.EndDate, Customers.FirstName, Customers.LastName, Servicess.ServiceName  
   FROM Contracts  
   INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID  
   INNER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID  
   WHERE Contracts.CustomerID = @CustomerID OR Contracts.ServiceID = @ServiceID  
END; 
CREATE PROCEDURE GetBillingBySubscriptionIDAndDueDate
    @SubscriptionID INT,
    @DueDate DATE
AS
BEGIN
    SELECT Billing.BillingID, Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.SubscriptionID
    FROM Billing
    INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Billing.SubscriptionID = @SubscriptionID AND Billing.DueDate <= @DueDate
END;
CREATE PROCEDURE GetPaymentsByBillingIDAndPaymentDate
    @BillingID INT,
    @PaymentDate DATE
AS
BEGIN
    SELECT Payments.PaymentID, Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingID
    FROM Payments
    INNER JOIN Billing ON Payments.BillingID = Billing.BillingID
    WHERE Payments.BillingID = @BillingID AND Payments.PaymentDate <= @PaymentDate
END;
CREATE PROCEDURE GetUsageBySubscriptionIDAndUsageDate
    @SubscriptionID INT,
    @UsageDate DATE
AS
BEGIN
    SELECT Usage.UsageID, Usage.UsageDate, Usage.DataUsed, Subscriptions.SubscriptionID
    FROM Usage
    INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Usage.SubscriptionID = @SubscriptionID AND Usage.UsageDate <= @UsageDate
END;
CREATE PROCEDURE GetIssuesByTechnicianIDAndDateResolved
    @TechnicianID INT,
    @DateResolved DATE
AS
BEGIN
    SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName 
    FROM Issues 
    INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID 
    WHERE Issues.TechnicianID = @TechnicianID AND (Issues.DateResolved <= @DateResolved OR Issues.DateResolved IS NULL)
END;
CREATE PROCEDURE GetCustomersByAddressIDOrEmail 
   @AddressID INT,
   @Email VARCHAR(255) 
AS 
BEGIN 
   SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Email, Addresses.StreetAddress 
   FROM Customers 
   INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID 
   WHERE Customers.AddressID = @AddressID OR Customers.Email = @Email 
END; 


CREATE PROCEDURE GetCustomersByPhoneNumberOrEmail
    @PhoneNumber VARCHAR(255),
    @Email VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Customers.PhoneNumber, Customers.Email
    FROM Customers
    WHERE Customers.PhoneNumber = @PhoneNumber OR Customers.Email = @Email
END;
CREATE PROCEDURE GetSubscriptionsByServiceIDAndStartDate
    @ServiceID INT,
    @StartDate DATE
AS
BEGIN
    SELECT Subscriptions.SubscriptionID, Subscriptions.StartDate, Subscriptions.EndDate, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Subscriptions.ServiceID = @ServiceID AND Subscriptions.StartDate >= @StartDate
END;
CREATE PROCEDURE GetTechniciansByFirstAndLastName
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255)
AS
BEGIN
    SELECT Technicians.FirstName, Technicians.LastName
    FROM Technicians
    WHERE Technicians.FirstName = @FirstName AND Technicians.LastName = @LastName
END;
CREATE PROCEDURE GetIssuesByCustomerIDOrIssueDescription
    @CustomerID INT,
    @IssueDescription VARCHAR(255)
AS
BEGIN
    SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName 
    FROM Issues 
    INNER JOIN Customers ON Issues.CustomerID = Customers.CustomerID 
    WHERE Issues.CustomerID = @CustomerID OR Issues.IssueDescription LIKE '%' + @IssueDescription + '%'
END;
CREATE PROCEDURE GetEquipmentByEquipmentNameOrEquipmentDescription 
   @EquipmentName VARCHAR(255),
   @EquipmentDescription VARCHAR(255) 
AS 
BEGIN 
   SELECT Equipment.EquipmentName, Equipment.EquipmentDescription 
   FROM Equipment 
   WHERE Equipment.EquipmentName = @EquipmentName OR Equipment.EquipmentDescription LIKE '%' + @EquipmentDescription + '%' 
END; 
CREATE PROCEDURE GetServiceOfficesByCityOrOfficeID 
   @City VARCHAR(255), 
   @OfficeID INT 
AS 
BEGIN 
   SELECT ServiceOffices.OfficeID, ServiceOffices.City, ServiceOffices.ZipCode 
   FROM ServiceOffices 
   WHERE ServiceOffices.City = @City OR ServiceOffices.OfficeID = @OfficeID 
END; 
CREATE PROCEDURE GetPromotionsByPromotionNameOrEndDate 
   @PromotionName VARCHAR(255), 
   @EndDate DATE 
AS 
BEGIN 
   SELECT Promotions.PromotionID, Promotions.PromotionName, Promotions.PromotionDescription, Promotions.StartDate, Promotions.EndDate 
   FROM Promotions 
   WHERE Promotions.PromotionName = @PromotionName OR Promotions.EndDate <= @EndDate 
END; 
CREATE PROCEDURE GetContractsByServiceIDOrEndDate  
   @ServiceID INT,
   @EndDate DATE  
AS 
BEGIN 
   SELECT Contracts.ContractID, Contracts.StartDate, Contracts.EndDate, Servicess.ServiceName  
   FROM Contracts  
   INNER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID  
   WHERE Contracts.ServiceID = @ServiceID OR Contracts.EndDate <= @EndDate  
END; 
CREATE PROCEDURE GetBillingBySubscriptionIDAndBillingDate
    @SubscriptionID INT,
    @BillingDate DATE
AS
BEGIN
    SELECT Billing.BillingID, Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.SubscriptionID
    FROM Billing
    INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Billing.SubscriptionID = @SubscriptionID AND Billing.BillingDate <= @BillingDate
END;
CREATE PROCEDURE GetPaymentsByBillingIDAndPaymentAmount
    @BillingID INT,
    @PaymentAmount FLOAT
AS
BEGIN
    SELECT Payments.PaymentID, Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingID
    FROM Payments
    INNER JOIN Billing ON Payments.BillingID = Billing.BillingID
    WHERE Payments.BillingID = @BillingID AND Payments.PaymentAmount >= @PaymentAmount
END;
CREATE PROCEDURE GetUsageBySubscriptionIDAndDataUsed
    @SubscriptionID INT,
    @DataUsed FLOAT
AS
BEGIN
    SELECT Usage.UsageID, Usage.UsageDate, Usage.DataUsed, Subscriptions.SubscriptionID
    FROM Usage
    INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Usage.SubscriptionID = @SubscriptionID AND Usage.DataUsed >= @DataUsed
END;
CREATE PROCEDURE GetIssuesByTechnicianIDOrDateCreated
    @TechnicianID INT,
    @DateCreated DATE
AS
BEGIN
    SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName 
    FROM Issues 
    INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID 
    WHERE Issues.TechnicianID = @TechnicianID OR Issues.DateCreated >= @DateCreated
END;
CREATE PROCEDURE GetCustomersByAddressIDOrPhoneNumber 
   @AddressID INT,
   @PhoneNumber VARCHAR(255) 
AS 
BEGIN 
   SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.PhoneNumber, Addresses.StreetAddress 
   FROM Customers 
   INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID 
   WHERE Customers.AddressID = @AddressID OR Customers.PhoneNumber = @PhoneNumber 
END; 
CREATE PROCEDURE GetCustomersByLastNameOrEmail
    @LastName VARCHAR(255),
    @Email VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Customers.Email
    FROM Customers
    WHERE Customers.LastName = @LastName OR Customers.Email = @Email
END;
CREATE PROCEDURE GetSubscriptionsByCustomerIDAndServiceID
    @CustomerID INT,
    @ServiceID INT
AS
BEGIN
    SELECT Subscriptions.SubscriptionID, Subscriptions.StartDate, Subscriptions.EndDate, Customers.FirstName, Customers.LastName, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Subscriptions.CustomerID = @CustomerID AND Subscriptions.ServiceID = @ServiceID
END;


CREATE PROCEDURE GetCustomersByFirstAndLastNameOrderByFirstName
    @FirstName VARCHAR(255),
    @LastName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName
    FROM Customers
    WHERE Customers.FirstName = @FirstName AND Customers.LastName = @LastName
    ORDER BY Customers.FirstName
END;
CREATE PROCEDURE GetCustomersByCityOrZipCodeOrderByLastName
    @City VARCHAR(255),
    @ZipCode VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Addresses.City, Addresses.ZipCode
    FROM Customers
    INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID
    WHERE Addresses.City = @City OR Addresses.ZipCode = @ZipCode
    ORDER BY Customers.LastName
END;
CREATE PROCEDURE GetCustomersByServiceNameOrderByLastName
    @ServiceName VARCHAR(255)
AS
BEGIN
    SELECT Customers.FirstName, Customers.LastName, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Servicess.ServiceName = @ServiceName
    ORDER BY Customers.LastName
END;
CREATE PROCEDURE GetSubscriptionsByStartDateAndEndDateOrderByStartDate
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT Subscriptions.SubscriptionID, Subscriptions.StartDate, Subscriptions.EndDate, Customers.FirstName, Customers.LastName, Servicess.ServiceName
    FROM Subscriptions
    INNER JOIN Customers ON Subscriptions.CustomerID = Customers.CustomerID
    INNER JOIN Servicess ON Subscriptions.ServiceID = Servicess.ServiceID
    WHERE Subscriptions.StartDate >= @StartDate AND Subscriptions.EndDate <= @EndDate
    ORDER BY Subscriptions.StartDate
END;
CREATE PROCEDURE GetTechniciansByFirstOrLastNameOrderByFirstName 
   @FirstName VARCHAR(255), 
   @LastName VARCHAR(255) 
AS 
BEGIN 
   SELECT Technicians.FirstName, Technicians.LastName 
   FROM Technicians 
   WHERE Technicians.FirstName = @FirstName OR Technicians.LastName = @LastName 
   ORDER BY Technicians.FirstName 
END; 
CREATE PROCEDURE GetIssuesByCustomerIDAndIssueDescriptionOrderByDateCreated 
   @CustomerID INT,
   @IssueDescription VARCHAR(255) 
AS 
BEGIN 
   SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Customers.FirstName, Customers.LastName  
   FROM Issues  
   INNER JOIN Customers ON Issues.CustomerID = Customers.CustomerID  
   WHERE Issues.CustomerID = @CustomerID AND Issues.IssueDescription LIKE '%' + @IssueDescription + '%' 
   ORDER BY Issues.DateCreated 
END; 
CREATE PROCEDURE GetEquipmentByEquipmentNameOrEquipmentDescriptionOrderByEquipmentName  
   @EquipmentName VARCHAR(255),
   @EquipmentDescription VARCHAR(255)  
AS  
BEGIN  
   SELECT Equipment.EquipmentName, Equipment.EquipmentDescription  
   FROM Equipment  
   WHERE Equipment.EquipmentName = @EquipmentName OR Equipment.EquipmentDescription LIKE '%' + @EquipmentDescription + '%'  
   ORDER BY Equipment.EquipmentName  
END;  
CREATE PROCEDURE GetServiceOfficesByCityOrOfficeIDOrderByCity  
   @City VARCHAR(255),  
   @OfficeID INT  
AS  
BEGIN  
   SELECT ServiceOffices.OfficeID, ServiceOffices.City, ServiceOffices.ZipCode  
   FROM ServiceOffices  
   WHERE ServiceOffices.City = @City OR ServiceOffices.OfficeID = @OfficeID  
   ORDER BY ServiceOffices.City  
END;  
CREATE PROCEDURE GetPromotionsByPromotionNameOrStartDateOrderByStartDate  
   @PromotionName VARCHAR(255),  
   @StartDate DATE  
AS  
BEGIN  
   SELECT Promotions.PromotionID, Promotions.PromotionName, Promotions.PromotionDescription, Promotions.StartDate, Promotions.EndDate  
   FROM Promotions  
   WHERE Promotions.PromotionName = @PromotionName OR Promotions.StartDate >= @StartDate  
   ORDER BY Promotions.StartDate  
END;  
CREATE PROCEDURE GetContractsByCustomerIDOrServiceIDOrderByStartDate   
   @CustomerID INT,
   @ServiceID INT   
AS   
BEGIN   
   SELECT Contracts.ContractID, Contracts.StartDate, Contracts.EndDate, Customers.FirstName, Customers.LastName, Servicess.ServiceName   
   FROM Contracts   
   INNER JOIN Customers ON Contracts.CustomerID = Customers.CustomerID   
   INNER JOIN Servicess ON Contracts.ServiceID = Servicess.ServiceID   
   WHERE Contracts.CustomerID = @CustomerID OR Contracts.ServiceID = @ServiceID   
   ORDER BY Contracts.StartDate   
END;  
CREATE PROCEDURE GetBillingBySubscriptionIDAndDueDateOrderByAmountDue
    @SubscriptionID INT,
    @DueDate DATE
AS
BEGIN
    SELECT Billing.BillingID, Billing.BillingDate, Billing.AmountDue, Billing.DueDate, Subscriptions.SubscriptionID
    FROM Billing
    INNER JOIN Subscriptions ON Billing.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Billing.SubscriptionID = @SubscriptionID AND Billing.DueDate <= @DueDate
    ORDER BY Billing.AmountDue
END;
CREATE PROCEDURE GetPaymentsByBillingIDAndPaymentDateOrderByPaymentAmount
    @BillingID INT,
    @PaymentDate DATE
AS
BEGIN
    SELECT Payments.PaymentID, Payments.PaymentDate, Payments.PaymentAmount, Billing.BillingID
    FROM Payments
    INNER JOIN Billing ON Payments.BillingID = Billing.BillingID
    WHERE Payments.BillingID = @BillingID AND Payments.PaymentDate <= @PaymentDate
    ORDER BY Payments.PaymentAmount
END;
CREATE PROCEDURE GetUsageBySubscriptionIDAndUsageDateOrderByDataUsed
    @SubscriptionID INT,
    @UsageDate DATE
AS
BEGIN
    SELECT Usage.UsageID, Usage.UsageDate, Usage.DataUsed, Subscriptions.SubscriptionID
    FROM Usage
    INNER JOIN Subscriptions ON Usage.SubscriptionID = Subscriptions.SubscriptionID
    WHERE Usage.SubscriptionID = @SubscriptionID AND Usage.UsageDate <= @UsageDate
    ORDER BY Usage.DataUsed
END;
CREATE PROCEDURE GetIssuesByTechnicianIDAndDateResolvedOrderByDateResolved 
   @TechnicianID INT,
   @DateResolved DATE 
AS 
BEGIN 
   SELECT Issues.IssueID, Issues.IssueDescription, Issues.DateCreated, Issues.DateResolved, Technicians.FirstName, Technicians.LastName  
   FROM Issues  
   INNER JOIN Technicians ON Issues.TechnicianID = Technicians.TechnicianID  
   WHERE Issues.TechnicianID = @TechnicianID AND (Issues.DateResolved <= @DateResolved OR Issues.DateResolved IS NULL) 
   ORDER BY Issues.DateResolved 
END; 
CREATE PROCEDURE GetCustomersByAddressIDOrEmailOrderByFirstName  
   @AddressID INT,
   @Email VARCHAR(255)  
AS  
BEGIN  
   SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Email, Addresses.StreetAddress  
   FROM Customers  
   INNER JOIN Addresses ON Customers.AddressID = Addresses.AddressID  
   WHERE Customers.AddressID = @AddressID OR Customers.Email = @Email  
   ORDER BY Customers.FirstName  
END;  