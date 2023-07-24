DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts (
        FirstName varchar(255),
        LastName varchar(255),
        Address varchar(255),
        AccountType varchar(255),
        Balance varchar(10)
        );

INSERT INTO Accounts VALUES ('Joe', 'Bloggs', '1 The Avenue, California, USA', 'Platinum', '100.45');
INSERT INTO Accounts VALUES ('Sarah', 'Peters', '2 The Street, London, England', 'Standard', '10021.56');
INSERT INTO Accounts VALUES ('Phil', 'Power', '3 The Lane, Auckland, New Zealand', 'Student', '-200.45');