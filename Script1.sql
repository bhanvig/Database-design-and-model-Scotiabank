#CREATE DATABASE AND TABLES QUERIES

CREATE SCHEMA `SCOTIABANK`;

use SCOTIABANK;

#Setting the foreign key checks to 0 so that we can create tables without the foreign key constraint error.
SET foreign_key_checks = 0;

CREATE TABLE Customer 
(	Customer_ID	CHAR(8)		NOT NULL UNIQUE,
	First_name	VARCHAR(15)	NOT NULL,
	Last_name	VARCHAR(15)	NOT NULL,
	Customer_SIN		CHAR(8)		NOT NULL UNIQUE,
	Email	VARCHAR(30)		NOT NULL UNIQUE,	
	DoB		DATE		NOT NULL,
    Street_number	int	NOT NULL,
    Street_name	VARCHAR (30)	NOT NULL,
    Postal_code	CHAR (6) NOT NULL,
    Province	CHAR (2)	NOT NULL,
    Country		CHAR (2)	NOT NULL,
    City	VARCHAR (30)	NOT NULL,
    Credit_score		CHAR(3)	NOT NULL CHECK (300 < Credit_score < 850),
	PRIMARY KEY (Customer_ID) 
);

CREATE TABLE Employments
(	Company_name	VARCHAR(30) NOT NULL,
	Customer_ID		CHAR(8) NOT NULL UNIQUE,
    Salary	FLOAT NOT NULL CHECK (Salary > 0),
    Job_title	VARCHAR(20),
    Job_sector VARCHAR(20),
    PRIMARY KEY (Customer_ID, Company_name),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) 
);

CREATE TABLE Account
(	Account_number	CHAR(8) NOT NULL UNIQUE,
	Balance		INT NOT NULL,
    Acc_status		BOOL,
    Date_opened	DATE,
    Account_manager_EID	CHAR(8) NOT NULL,
    Branch_ID	CHAR(8)		NOT NULL,
    Cust_ID CHAR (8) NOT NULL UNIQUE,
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_manager_EID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
    FOREIGN KEY (Cust_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Branch
(	Branch_ID	CHAR(8) NOT NULL UNIQUE,
	Address		VARCHAR(70),
    Street_number	INT	NOT NULL,
    Street_name	VARCHAR (30)	NOT NULL,
    Postal_code	CHAR (6) NOT NULL,
    Province	CHAR (2)	NOT NULL,
    Country		CHAR (2)	NOT NULL,
    City	VARCHAR (30)	NOT NULL,
    Phone_number CHAR(10)	NOT NULL,
    Manager_EID		CHAR(8)	UNIQUE,
    PRIMARY KEY (Branch_ID),
    FOREIGN KEY (Manager_EID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Employee
(	Employee_ID	CHAR(8) NOT NULL UNIQUE,
	Employee_role	VARCHAR(20)	NOT NULL,
    First_name	VARCHAR(20) NOT NULL,
    Last_name	VARCHAR(20)	NOT NULL,
    Join_date	DATE	NOT NULL,
    Salary	FLOAT NOT NULL CHECK (Salary > 0), 
    Branch_ID	CHAR(8)	NOT NULL,
    PRIMARY KEY (Employee_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID)
);


CREATE TABLE Transactions
(	Transaction_ID	CHAR(8) NOT NULL UNIQUE,
	Amount	INT NOT NULL,
    Transaction_description		VARCHAR(50),
    Time_stamp	DATETIME NOT NULL,
    Account_number 	CHAR(8)	NOT NULL,
    PRIMARY KEY (Transaction_ID),
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
);


CREATE TABLE Loans
(	Loan_ID	CHAR(8) NOT NULL UNIQUE,
	Loan_status	BOOL	NOT NULL,
    Interest_rate	FLOAT NOT NULL CHECK(Interest_rate>=0),
    Start_date	DATE	NOT NULL,
    End_date	DATE	NOT NULL,
    Loan_type	VARCHAR(15)	NOT NULL,
    Amount INT	NOT NULL CHECK(Amount>0),
    Customer_ID		CHAR(8)		NOT NULL UNIQUE,
    Branch_ID		CHAR(8)		NOT NULL,
    PRIMARY KEY (Loan_ID),
    FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

CREATE TABLE Chequing
(	Account_number CHAR(8)	NOT NULL UNIQUE,
	Monthly_fee FLOAT NOT NULL CHECK(Monthly_fee >=0),
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
);

CREATE TABLE Savings
(	Account_number CHAR(8)	NOT NULL UNIQUE,
	Interest_rate FLOAT NOT NULL CHECK(Interest_rate>=0),
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
);

CREATE TABLE Credit_Card
(
	Credit_card_number CHAR(16) NOT NULL UNIQUE,
    CVV CHAR(3) NOT NULL,
    Expiry_date DATE NOT NULL,
    Card_type VARCHAR(20) NOT NULL, 
    Account_number CHAR(8)	NOT NULL,
    PRIMARY KEY (Credit_card_number),
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
    
);

CREATE TABLE Debit_Card
(
	Debit_card_number CHAR(16) NOT NULL UNIQUE,
    CVV CHAR(3) NOT NULL,
    Expiry_date DATE NOT NULL,
    Account_number CHAR(8)	NOT NULL,
    PRIMARY KEY (Debit_card_number),
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
    
);

CREATE TABLE Investments
(
	Investment_account_number CHAR(8) NOT NULL UNIQUE,
    Creation_date date NOT NULL,
    Book_value FLOAT NOT NULL CHECK(Book_value>0), 
    Market_value FLOAT NOT NULL, 
    Service_fees FLOAT NOT NULL DEFAULT (10) CHECK(Service_fees>=0),
    Account_number CHAR(8) NOT NULL,
    FOREIGN KEY (Account_number) REFERENCES	Account(Account_number)
);

CREATE TABLE GIC
(
	Investment_account_number CHAR(8) NOT NULL UNIQUE,
    Interest_rate FLOAT NOT NULL CHECK (Interest_rate>=0), 
    Tenure INT NOT NULL, 
    FOREIGN KEY (Investment_account_number) REFERENCES	Investments(Investment_account_number)
);

CREATE TABLE Mutual_Funds
(
	Investment_account_number CHAR(8) NOT NULL UNIQUE,
    Mf_type VARCHAR(20) NOT NULL,
    FOREIGN KEY (Investment_account_number) REFERENCES	Investments(Investment_account_number)
);

CREATE TABLE Crypto
(
	Investment_account_number CHAR(8) NOT NULL UNIQUE,
    Crypto_type VARCHAR(20) NOT NULL,
    FOREIGN KEY (Investment_account_number) REFERENCES	Investments(Investment_account_number)
);

SET foreign_key_checks = 1;


#INSERT DATA QUERIES

####CUSTOMER TABLE####
INSERT INTO SCOTIABANK.Customer (Customer_ID, First_name, Last_name, Customer_SIN, Email, DoB, Street_number, Street_name, Postal_code, Province, Country, City, Credit_score) 
VALUES 
('A7BM2K4J', 'Charlotte', 'Lee', '09123456', 'charlotte.lee@gmail.com', '1979-10-13', 866, 'Elm Circle', 'T2P5M5', 'AB', 'CA', 'Calgary', 618),
('B5VN1H3G', 'Benjamin', 'Walker', '19234567', 'benjamin.walker@hotmail.com', '1967-04-28', 349, 'Oak Road', 'R2C0A1', 'MB', 'CA', 'Winnipeg', 634),
('D4TM5H2S', 'Alexander', 'Young', '31456789', 'alexander.young@gmail.com', '1994-12-18', 450, 'Spruce Street', 'B3J2N5', 'NS', 'CA', 'Halifax', 705),
('E2UN6J4K', 'Grace', 'Hill', '42567890', 'grace.hill@hotmail.com', '1978-07-26', 1211, 'Pine Ridge Road', 'R3L0L5', 'MB', 'CA', 'Winnipeg', 650),
('F1VM8L6Q', 'Natalie', 'Ramirez', '53678901', 'natalie.ramirez@gmail.com', '1988-02-14', 789, 'Maple Drive', 'G1R4P3', 'QC', 'CA', 'Quebec', 680),
('F4JL2D8P', 'Mia', 'Roberts', '12345678', 'mia.roberts@hotmail.com', '1983-05-24', 129, 'Pine Road', 'H0H0H0', 'QC', 'CA', 'Montreal', 620),
('G6JK8L0P', 'Noah', 'Brown', '23456789', 'noah.brown@gmail.com', '1989-07-30', 768, 'Maple Avenue', 'B1A1A1', 'NS', 'CA', 'Halifax', 660),
('G9XL3B7D', 'Zachary', 'Baker', '64789012', 'zachary.baker@hotmail.com', '1990-10-31', 132, 'Beechwood Drive', 'T5J3M7', 'AB', 'CA', 'Edmonton', 665),
('H3FJ5M1R', 'Emma', 'Garcia', '34567890', 'emma.garcia@hotmail.com', '1978-11-12', 550, 'Elm Road', 'V6B4N5', 'BC', 'CA', 'Vancouver', 590),
('H7YM2K9F', 'Lucas', 'Wright', '75890123', 'lucas.wright@gmail.com', '1983-03-22', 304, 'Cherry Lane', 'S7N2A8', 'SK', 'CA', 'Saskatoon', 692),
('I4KP9N2U', 'Liam', 'Martinez', '45678901', 'liam.martinez@gmail.com', '1990-09-05', 324, 'Cedar Lane', 'T5K2L3', 'AB', 'CA', 'Edmonton', 710),
('I5ZN1H8G', 'Hannah', 'Martin', '86901234', 'hannah.martin@hotmail.com', '1976-11-11', 556, 'Elm Court', 'V8X1H5', 'BC', 'CA', 'Victoria', 730),
('J3WM9L5R', 'Evelyn', 'Clark', '97012345', 'evelyn.clark@gmail.com', '1975-08-15', 890, 'Willow Avenue', 'A1C5K4', 'NL', 'CA', 'St. Johns', 615),
('K2UN3J7T', 'Gabriel', 'Rodriguez', '08123456', 'gabriel.rodriguez@hotmail.com', '1982-05-09', 1234, 'Cedar Street', 'L4W1A2', 'ON','CA', 'Mississauga', 670),
('L3SD9F6G', 'Olivia', 'Hernandez', '56789012', 'olivia.hernandez@hotmail.com', '1979-12-30', 174, 'Birch Avenue', 'S7K2J3', 'SK', 'CA', 'Saskatoon', 615),
('M9QN4T5R', 'William', 'Lopez', '67890123', 'william.lopez@gmail.com', '1968-08-15', 800, 'Pine Street', 'R3B2T9', 'MB', 'CA', 'Winnipeg', 640),
('N6YH8V3C', 'Sophia', 'Gonzalez', '78901234', 'sophia.gonzalez@hotmail.com', '1992-03-22', 920, 'Oak Lane', 'C1A5M4', 'PE', 'CA', 'Charlottetown', 698),
('O4LF5G2H', 'Ethan', 'Perez', '89012345', 'ethan.perez@gmail.com', '1981-06-18', 407, 'Chestnut Road', 'A2A2A2', 'NL', 'CA', 'St. Johns', 587),
('P2TG4S1J', 'Isabella', 'Sanchez', '90123456', 'isabella.sanchez@hotmail.com', '1974-01-29', 115, 'Spruce Drive', 'X1A1A1', 'NT', 'CA', 'Yellowknife', 672),
('Q1RM3F6B', 'Michael', 'Ramirez', '01234567', 'michael.ramirez@gmail.com', '1984-10-09', 658, 'Elm Avenue', 'Y1A2B3', 'YT', 'CA', 'Whitehorse', 603),
('R5DV2J0L', 'Ava', 'Anderson', '10234567', 'ava.anderson@hotmail.com', '1996-04-12', 289, 'Beech Street', 'J1A2B3', 'QC', 'CA', 'Quebec', 720),
('S3HG6K8N', 'Matthew', 'Thomas', '21345678', 'matthew.thomas@gmail.com', '1975-07-19', 963, 'Cedar Boulevard', 'K2B5M3', 'ON', 'CA', 'Ottawa', 568),
('T7CK1F4M', 'Madison', 'Jackson', '32456789', 'madison.jackson@hotmail.com', '1987-11-23', 812, 'Walnut Street', 'V3H4K5', 'BC', 'CA', 'Vancouver', 610),
('U8EB2L5Q', 'David', 'White', '43567890', 'david.white@gmail.com', '1980-12-15', 437, 'Pine Ridge', 'M3J8H5', 'ON', 'CA', 'Toronto', 699),
('U8ZD3H5J', 'James', 'Wilson', '87654321', 'james.wilson@gmail.com', '1971-03-11', 402, 'Oak Street', 'K1A0B1', 'ON', 'CA', 'Ottawa', 580),
('V6JW3H7D', 'Elizabeth', 'Harris', '54678901', 'elizabeth.harris@hotmail.com', '1993-02-28', 529, 'Maple Lane', 'S4P3Y2', 'SK', 'CA', 'Regina', 582),
('W4KG2F8S', 'Joseph', 'Martinez', '65789012', 'joseph.martinez@gmail.com', '1969-05-31', 611, 'Birch Street', 'H2Z1A4', 'QC', 'CA', 'Montreal', 638),
('X2HN5L9T', 'Emily', 'Clark', '76890123', 'emily.clark@hotmail.com', '1976-09-17', 284, 'Chestnut Lane', 'L5N4G2', 'ON', 'CA', 'Mississauga', 605),
('Y1DF4G6U', 'Daniel', 'Rodriguez', '87901234', 'daniel.rodriguez@gmail.com', '1991-08-20', 730, 'Willow Avenue', 'V8N1A3', 'BC', 'CA', 'Victoria', 689),
('Z9CV3B1K', 'Oliver', 'Lewis', '98012345', 'oliver.lewis@hotmail.com', '1985-01-05', 159, 'Cedar Path', 'E4P3R6', 'NB', 'CA', 'Fredericton', 672);

####BRANCH TABLE####
INSERT INTO SCOTIABANK.Branch (Branch_ID, Address, Street_number, Street_name, Postal_code, Province, Country, City, Phone_number) VALUES 
('1', '3446 YONGE STREET', '3446', 'YONGE STREET', 'M4N2N2', 'ON', 'CA', 'Toronto', '6478569922'),
('2', '100 City Center road', '100', 'City Center road', 'L5B2C9', 'ON', 'CA', 'Toronto', '9851214455');

####EMPLOYEE TABLE####
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (101, 'Cashier', 'Ana', 'Reznik', '2020-01-20', 50000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (102, 'Branch manager', 'Planak', 'Li', '2020-02-16', 80000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (103, 'Personal banker', 'Paul', 'Chiu', '2020-01-20', 70000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (104, 'Personal banker', 'Nina', 'Tong', '2020-02-02', 71000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (105, 'Personal banker', 'Kitty', 'Forman', '2020-02-03', 72000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (106, 'Loan officer', 'Liam', 'Hunting', '2020-02-05', 75000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (201, 'Cashier', 'Moana', 'Jung', '2021-02-15', 45000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (202, 'Branch manager', 'Ulong', 'Rank', '2021-02-20', 82000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (203, 'Personal banker', 'Hank', 'Muller', '2021-02-22', 73000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (204, 'Personal banker', 'Flora', 'Maine', '2021-03-18', 85000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (205, 'Personal banker', 'Mark', 'Jacob', '2021-08-30', 80000, 1);
INSERT INTO SCOTIABANK.Employee (Employee_ID, Employee_role, First_name, Last_name, Join_date, Salary, Branch_ID) VALUES (206, 'Loan officer', 'Justin', 'Tim', '2021-03-15', 77000, 1);

#ADD TO BRANCH TABLE#
UPDATE SCOTIABANK.Branch
SET Manager_EID = '102'
WHERE Branch_ID = '1';
UPDATE SCOTIABANK.Branch
SET Manager_EID = '202'
WHERE Branch_ID = '2';

####ACCOUNT TABLE####
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008592', 3000, 1, '2022-01-15', '102', '1', 'A7BM2K4J');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008593', 4000, 1, '2022-02-22', '103', '1', 'B5VN1H3G');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008594', 2500, 1, '2022-03-18', '104', '1', 'D4TM5H2S');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008595', 3500, 1, '2022-04-03', '202', '2', 'E2UN6J4K');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008596', 2800, 1, '2022-05-07', '203', '2', 'F1VM8L6Q');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008597', 3200, 1, '2022-06-14', '204', '2', 'F4JL2D8P');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008598', 3700, 1, '2022-07-20', '105', '1', 'G6JK8L0P');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008599', 2900, 1, '2022-08-25', '205', '2', 'G9XL3B7D');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008600', 4100, 1, '2022-09-09', '102', '1', 'H3FJ5M1R');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008601', 2600, 1, '2022-10-13', '103', '1', 'H7YM2K9F');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008602', 3200, 1, '2022-11-21', '104', '1', 'I4KP9N2U');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008603', 3700, 1, '2022-12-05', '202', '2', 'I5ZN1H8G');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008604', 2900, 1, '2022-01-28', '203', '2', 'J3WM9L5R');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008605', 4100, 1, '2022-02-03', '204', '2', 'K2UN3J7T');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008606', 5600, 1, '2022-03-17', '105', '1', 'L3SD9F6G');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008607', 3200, 1, '2022-04-29', '102', '1', 'M9QN4T5R');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008608', 5700, 1, '2022-05-12', '103', '1', 'N6YH8V3C');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008609', 2900, 1, '2022-06-25', '104', '1', 'O4LF5G2H');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008610', 4100, 1, '2022-07-30', '202', '2', 'P2TG4S1J');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008611', 2600, 1, '2022-08-04', '203', '2', 'Q1RM3F6B');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008612', 50000, 1, '2022-09-19', '204', '2', 'R5DV2J0L');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008613', 3700, 1, '2022-10-22', '105', '1', 'S3HG6K8N');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008614', 2900, 1, '2022-11-30', '102', '1', 'T7CK1F4M');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008615', 4100, 1, '2022-12-10', '103', '1', 'U8EB2L5Q');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008616', 26000, 1, '2022-01-05', '104', '1', 'U8ZD3H5J');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008617', 3200, 1, '2022-02-11', '202', '2', 'V6JW3H7D');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008618', 3700, 1, '2022-03-24', '203', '2', 'W4KG2F8S');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008619', 3000, 1, '2022-04-15', '105', '1', 'X2HN5L9T');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008620', 35000, 1, '2022-05-22', '202', '2', 'Y1DF4G6U');
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10008621', 3200, 1, '2022-06-18', '203', '2', 'Z9CV3B1K');

####CHEQUEING TABLE####
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008593', '110');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008594', '120');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008595', '130');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008596', '140');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008597', '150');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008598', '160');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008599', '170');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008600', '180');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008601', '190');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008602', '200');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008603', '210');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008604', '220');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008605', '230');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008606', '240');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008607', '250');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008608', '260');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008609', '270');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008610', '280');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008611', '290');
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee) VALUES ('10008612', '300');

####INVESTMENTS TABLE####
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00001', 10000.00, 11000.00, 100.00, '10008592', '2022-02-02');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00002', 15000.00, 16500.00, 150.00, '10008593', '2022-02-10');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00003', 20000.00, 22000.00, 200.00, '10008594', '2022-03-05');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00004', 25000.00, 27500.00, 250.00, '10008595', '2022-04-12');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00005', 30000.00, 33000.00, 300.00, '10008596', '2022-05-20');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00006', 35000.00, 38500.00, 350.00, '10008597', '2022-06-15');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00007', 40000.00, 44000.00, 400.00, '10008598', '2022-07-08');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00008', 45000.00, 49500.00, 450.00, '10008599', '2022-08-11');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00009', 50000.00, 55000.00, 500.00, '10008600', '2022-09-25');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00010', 55000.00, 60500.00, 550.00, '10008601', '2022-10-17');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00011', 60000.00, 66000.00, 600.00, '10008602', '2022-11-30');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00012', 65000.00, 71500.00, 650.00, '10008603', '2022-01-14');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00013', 70000.00, 77000.00, 700.00, '10008604', '2022-02-03');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00014', 75000.00, 82500.00, 750.00, '10008605', '2022-03-27');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00015', 80000.00, 88000.00, 800.00, '10008606', '2022-04-19');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00016', 85000.00, 93500.00, 850.00, '10008607', '2022-05-08');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00017', 90000.00, 99000.00, 900.00, '10008608', '2022-02-02');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00018', 95000.00, 104500.00, 950.00, '10008609', '2022-02-10');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00019', 100000.00, 110000.00, 1000.00, '10008610', '2022-03-05');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00020', 105000.00, 115500.00, 1050.00, '10008611', '2022-04-12');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00021', 110000.00, 121000.00, 1100.00, '10008612', '2022-05-20');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00022', 115000.00, 126500.00, 1150.00, '10008613', '2022-06-15');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00023', 120000.00, 132000.00, 1200.00, '10008614', '2022-07-08');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00024', 125000.00, 137500.00, 1250.00, '10008615', '2022-08-11');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00025', 130000.00, 143000.00, 1300.00, '10008616', '2022-09-25');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00026', 135000.00, 148500.00, 1350.00, '10008617', '2022-10-17');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00027', 140000.00, 154000.00, 1400.00, '10008618', '2022-11-30');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00028', 145000.00, 159500.00, 1450.00, '10008619', '2022-01-14');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00029', 150000.00, 165000.00, 1500.00, '10008620', '2022-02-03');
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date) VALUES ('INV00030', 155000.00, 170500.00, 1550.00, '10008621', '2022-03-27');


####CREDIT_CARD TABLE####
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000857900000001', '789', '2025-07-14', 'Visa', '10008597');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000858900000001', '654', '2026-02-18', 'American Express', '10008598');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000859900000002', '234', '2023-09-23', 'Mastercard', '10008599');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000860000000001', '789', '2025-04-05', 'Visa', '10008600');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000860200000001', '234', '2023-08-28', 'Mastercard', '10008602');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1000860300000001', '789', '2025-06-13', 'Visa', '10008603');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('1245365345224287', '121', '2025-10-28', 'Visa', '10008592');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('2568345123874563', '456', '2024-08-15', 'Mastercard', '10008593');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('3658741239658741', '789', '2026-03-20', 'American Express', '10008593');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('3658741239658742', '234', '2023-03-22', 'Visa', '10008594');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('3658741239658743', '789', '2025-06-13', 'Mastercard', '10008595');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('3658741239658744', '456', '2026-03-20', 'Visa', '10008596');
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number) VALUES ('3658741239658745', '234', '2023-11-17', 'American Express', '10008596');

####CRYPTO TABLE####
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00001', 'Bitcoin (BTC)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00002', 'Ethereum (ETH)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00003', 'Ripple (XRP)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00004', 'Litecoin (LTC)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00005', 'Cardano (ADA)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00006', 'Polkadot (DOT)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00007', 'Bitcoin (BTC)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00008', 'Ethereum (ETH)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00009', 'Ripple (XRP)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00010', 'Litecoin (LTC)');
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type) VALUES ('INV00011', 'Cardano (ADA)');

####DEBIT_CARD TABLE####
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536566', '213', '2026-11-07', '10008593');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536567', '214', '2026-12-08', '10008594');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536568', '215', '2027-01-09', '10008595');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536569', '216', '2027-02-10', '10008596');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536570', '217', '2027-03-11', '10008597');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536571', '218', '2027-04-12', '10008598');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536572', '219', '2027-05-13', '10008599');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536573', '220', '2027-06-14', '10008600');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536574', '221', '2027-07-15', '10008601');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536575', '222', '2027-08-16', '10008602');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536576', '223', '2027-09-17', '10008603');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536577', '224', '2027-10-18', '10008604');
INSERT INTO `SCOTIABANK`.`Debit_Card` (`Debit_card_number`, `CVV`, `Expiry_date`, `Account_number`) VALUES ('1212552264536578', '225', '2027-11-19', '10008605');

####EMPLOYMENTS TABLE####
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Acme Corp', 'A7BM2K4J', 75000, 'Analyst', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Globex Inc', 'B5VN1H3G', 32000, 'Consultant', 'Finance');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Initech LLC', 'D4TM5H2S', 48000, 'Sales Assoc.', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Umbrella Corp', 'E2UN6J4K', 58000, 'Proj Manager', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Soylent Corp', 'F1VM8L6Q', 83000, 'Developer', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Vehement Capital', 'F4JL2D8P', 95000, 'Fin Analyst', 'Finance');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Massive Dynamic', 'G6JK8L0P', 40000, 'Scientist', 'Education');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Hooli', 'G9XL3B7D', 69500, 'Mkt Director', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Pied Piper', 'H3FJ5M1R', 37000, 'Prod Manager', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Bluth Company', 'H7YM2K9F', 157000, 'CFO', 'Finance');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Sterling Cooper', 'I4KP9N2U', 67500, 'Copywriter', 'Education');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Wayne Enterprises', 'I5ZN1H8G', 85000, 'HR Manager', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Dunder Mifflin', 'J3WM9L5R', 43000, 'Sales Rep.', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Cyberdyne Systems', 'K2UN3J7T', 62000, 'Sys Analyst', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Oscorp Industries', 'L3SD9F6G', 39000, 'Biologist', 'Education');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Wonka Industries', 'M9QN4T5R', 54000, 'Creat Director', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Stark Industries', 'N6YH8V3C', 89000, 'Engineer', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Skynet Systems', 'O4LF5G2H', 103000, 'AI Spec', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Waystar Royco', 'P2TG4S1J', 46000, 'Attorney', 'Federal');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Spacely Sprockets', 'Q1RM3F6B', 58000, 'Ops Manager', 'Education');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Cogswell Cogs', 'R5DV2J0L', 30500, 'Mech Engineer', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('BiffCo Enterprises', 'S3HG6K8N', 50000, 'Comm Spec', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Gringotts Bank', 'T7CK1F4M', 72000, 'Bank Manager', 'Finance');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Kwik-E-Mart', 'U8EB2L5Q', 31000, 'Store Mgr', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Acme Corp', 'U8ZD3H5J', 55000, 'Logis Coord', 'Retail');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Globex Inc', 'V6JW3H7D', 63000, 'Prod Dev', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Initech LLC', 'W4KG2F8S', 48000, 'IT Support', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Umbrella Corp', 'X2HN5L9T', 77000, 'Lab Tech', 'IT');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Soylent Corp', 'Y1DF4G6U', 33000, 'Dietitian', 'Healthcare');
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title, Job_sector) VALUES ('Vehement Capital', 'Z9CV3B1K', 96000, 'Inv Banker', 'Finance');

####GIC TABLE###
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00012', 2.6, 12);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00013', 2.7, 16);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00014', 2.8, 7);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00015', 2.9, 9);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00016', 3.0, 14);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00017', 3.1, 18);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00018', 3.2, 22);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00019', 3.3, 3);
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure) VALUES ('INV00020', 3.4, 6);


####LOANS TABLE####
INSERT INTO SCOTIABANK.Loans (Loan_ID, Loan_status, Interest_rate, Start_date, End_date, Loan_type, Amount, Customer_ID, Branch_ID) 
VALUES 
('5002', '1', 5, '2022-08-15', '2025-09-15', 'Personal loan', '30000', 'B5VN1H3G', '2'),
('5003', '1', 6, '2022-07-20', '2026-07-20', 'Car loan', '25000', 'D4TM5H2S', '1'),
('5004', '1', 4.5, '2022-06-25', '2024-06-25', 'Education loan', '40000', 'E2UN6J4K', '2'),
('5005', '1', 5.5, '2022-05-30', '2025-05-30', 'Home loan', '60000', 'F1VM8L6Q', '1'),
('5006', '1', 4.2, '2022-04-12', '2027-04-12', 'Personal loan', '35000', 'F4JL2D8P', '1'),
('5007', '1', 6.2, '2022-03-18', '2025-03-18', 'Car loan', '20000', 'G6JK8L0P', '2'),
('5008', '1', 3.8, '2022-02-22', '2024-02-22', 'Education loan', '45000', 'G9XL3B7D', '2'),
('5009', '1', 5.7, '2022-01-25', '2026-01-25', 'Home loan', '55000', 'H3FJ5M1R', '1'),
('5010', '1', 4.3, '2021-12-30', '2024-12-30', 'Personal loan', '32000', 'H7YM2K9F', '1'),
('5011', '1', 6.5, '2021-11-05', '2025-11-05', 'Car loan', '23000', 'I4KP9N2U', '2'),
('5012', '1', 4.7, '2021-10-10', '2023-10-10', 'Education loan', '42000', 'I5ZN1H8G', '2'),
('5013', '1', 5.8, '2021-09-15', '2024-09-15', 'Home loan', '58000', 'J3WM9L5R', '1'),
('5014', '1', 4.1, '2021-08-20', '2023-08-20', 'Personal loan', '33000', 'K2UN3J7T', '1'),
('5015', '1', 6.3, '2021-07-25', '2025-07-25', 'Car loan', '21000', 'L3SD9F6G', '2'),
('5016', '1', 3.9, '2021-06-30', '2024-06-30', 'Education loan', '47000', 'M9QN4T5R', '2'),
('5017', '1', 5.9, '2021-06-05', '2026-06-05', 'Home loan', '62000', 'N6YH8V3C', '1'),
('5018', '1', 4.4, '2021-05-10', '2023-05-10', 'Personal loan', '34000', 'O4LF5G2H', '1'),
('5019', '1', 6.6, '2021-04-15', '2025-04-15', 'Car loan', '24000', 'P2TG4S1J', '2'),
('5020', '1', 4.8, '2021-03-20', '2023-03-20', 'Education loan', '43000', 'Q1RM3F6B', '2'),
('5021', '1', 6.7, '2021-02-25', '2026-02-25', 'Home loan', '57000', 'R5DV2J0L', '1'),
('5022', '1', 4.2, '2021-01-30', '2024-01-30', 'Personal loan', '31000', 'S3HG6K8N','1');

####MUTUAL_FUNDS TABLE####
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00021', 'Index Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00022', 'Balanced Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00023', 'Money Market');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00024', 'Sector Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00025', 'Equity Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00026', 'Bond Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00027', 'Index Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00028', 'Balanced Funds');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00029', 'Money Market');
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type) VALUES ('INV00030', 'Sector Funds');

####SAVINGS TABLE####
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008592', 2.5);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008593', 3.2);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008594', 2.8);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008595', 3.6);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008596', 3.1);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008597', 2.9);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008598', 3.8);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008599', 3.3);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008600', 3.5);
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate) VALUES ('10008601', 2.7);

####TRANSACTIONS TABLE####
INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000002', '35', 'BC Ferries-Vancouver', '2022-03-15 13:45:00', '10008593');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000003', '50', 'Old Port-Montreal', '2022-03-16 09:30:00', '10008594');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000004', '15', 'Niagara Falls-Ontario', '2022-03-17 14:10:00', '10008595');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000005', '28', 'Calgary Stampede-Alberta', '2022-03-18 16:20:00', '10008596');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000006', '42', 'CN Tower-Toronto', '2022-03-19 10:45:00', '10008597');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000007', '18', 'Stanley Park-Vancouver', '2022-03-20 12:30:00', '10008598');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000008', '37', 'St. Lawrence Market-Toronto', '2022-03-21 15:15:00', '10008599');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000009', '25', 'Whistler Ski Resort-BC', '2022-03-22 08:50:00', '10008600');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000010', '30', 'Banff National Park-Alberta', '2022-03-23 11:55:00', '10008601');

-- Add more INSERT statements for other transactions with different account numbers
INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000011', '19', 'Old Quebec City-Quebec', '2022-03-24 14:40:00', '10008602');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000012', '33', 'Rideau Canal-Ottawa', '2022-03-25 16:05:00', '10008603');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000013', '22', 'Lake Louise-Alberta', '2022-03-26 09:20:00', '10008604');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000014', '40', 'Whale Watching-British Columbia', '2022-03-27 10:55:00', '10008605');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000015', '27', 'PEI National Park-Prince Edward Island', '2022-03-28 13:30:00', '10008606');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000016', '45', 'Royal Ontario Museum-Toronto', '2022-03-29 15:45:00', '10008607');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000017', '32', 'Capilano Suspension Bridge-Vancouver', '2022-03-30 08:10:00', '10008608');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000018', '29', 'Mont Tremblant-Quebec', '2022-03-31 11:25:00', '10008609');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000019', '38', 'Peggys Cove-Nova Scotia', '2022-04-01 14:50:00', '10008610');

INSERT INTO `SCOTIABANK`.`Transactions` (`Transaction_ID`, `Amount`, `Transaction_description`, `Time_stamp`, `Account_number`) 
VALUES ('10000020', '21', 'Whales Bone-Ottawa', '2022-04-02 17:15:00', '10008611');

#ACCESS CONTROL QUERIES

USE mysql;

#Create Branch Manager user
CREATE USER 'branch_manager' IDENTIFIED BY 'iownthisbranch123';

#Create Account Manager user
CREATE USER 'account_manager' IDENTIFIED BY 'youcantsendmoney';

#Create Investment Specialist user
CREATE USER 'investment_specialist' IDENTIFIED BY 'cryptoforlife';

#Create HR user
CREATE USER 'hr' IDENTIFIED BY 'wearegoingtoletyougo';

GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Customer TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Account TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Debit_Card TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Credit_Card TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Loans TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Transactions TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Employee TO 'branch_manager';
GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Branch TO 'branch_manager';
GRANT SELECT ON SCOTIABANK.Investments TO 'branch_manager';

GRANT SELECT, INSERT, UPDATE ON SCOTIABANK.Customer TO 'account_manager';
GRANT SELECT, INSERT, UPDATE ON SCOTIABANK.Account TO 'account_manager';
GRANT SELECT, INSERT, UPDATE ON SCOTIABANK.Debit_Card TO 'account_manager';
GRANT SELECT, INSERT, UPDATE ON SCOTIABANK.Credit_Card TO 'account_manager';
GRANT SELECT, INSERT, UPDATE ON SCOTIABANK.Loans TO 'account_manager';
GRANT SELECT ON SCOTIABANK.Transactions TO 'account_manager';
GRANT SELECT ON SCOTIABANK.Investments TO 'account_manager';

GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Investments TO 'investment_specialist';
GRANT SELECT ON SCOTIABANK.Customer TO 'investment_specialist';
GRANT SELECT ON SCOTIABANK.Account TO 'investment_specialist';

GRANT SELECT, INSERT, UPDATE, DELETE ON SCOTIABANK.Employee TO 'hr';
GRANT SELECT ON SCOTIABANK.Branch TO 'hr';