###TEST CASES###

#Account Table#
INSERT INTO SCOTIABANK.Account (Account_number, Balance, Acc_status, Date_opened, Account_manager_EID, Branch_ID, Cust_ID) VALUES ('10009985', '5000', '1', '2022-08-14', '210', '2', 'Z9CV3B1K');

#Customer Table#

INSERT INTO SCOTIABANK.Customer (Last_name, Customer_SIN, Email, DoB, Street_number, Street_name, Postal_code, Province, Country, City, Credit_score)
VALUES ('Johnson', '234567890', 'emily.johnson@example.com', '1985-09-09', '789', 'Elm Street', 'C7D8E9', 'O', 'C', 'Somecity', '650');

SELECT * FROM SCOTIABANK.Customer;
INSERT INTO SCOTIABANK.Customer (Customer_ID, First_name, Last_name, Customer_SIN, Email, DoB, Street_number, Street_name, Postal_code, Province, Country, City, Credit_score) VALUES ('L3SD9F6G', 'Olivia', 'Hernandez', '56789012', 'olivia.hernandez@hotmail.com', '1979-12-30', '174', 'Birch Avenue', 'S7K2J3', 'SK', 'CA', 'Saskatoon', '615');

DELETE FROM SCOTIABANK.Customer 
WHERE Customer_ID = 'A9Z5X1R4';

INSERT INTO SCOTIABANK.Customer (Last_name, Customer_SIN, Email, DoB, Street_number, Street_name, Postal_code, Province, Country, City, Credit_score)
VALUES ('Doe', '987654321', 'jane.doe@example.com', '1995-05-05', '123', 'Main Street', 'A1A1A1', 'ON', 'CA', 'Anytown', '250');

INSERT INTO SCOTIABANK.Customer (Last_name, Customer_SIN, Email, DoB, Street_number, Street_name, Postal_code, Province, Country, City, Credit_score)
VALUES ('Smith', '123456789', 'john.smith@example.com', '1980-01-01', '456', 'Oak Avenue', 'B2B2B2', 'BC', 'CA', 'Othertown', '900');


#Employments Table#
INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title)
VALUES ('Tech Innovations', 'NONEXIST1', 50000, 'Software Developer');

INSERT INTO SCOTIABANK.Employments (Company_name, Customer_ID, Salary, Job_title)
VALUES ('Global Tech', 'EXISTCUST2', 0, 'Network Engineer');

#Investments Table#
INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date)
VALUES ('INVTEST01', 12000, 12500, 100, '10008622', 'Hello');

INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date)
VALUES ('INVTEST02', '0', '12500', '100', '10008622', '2023-04-01');

INSERT INTO SCOTIABANK.Investments (Investment_account_number, Book_value, Market_value, Service_fees, Account_number, Creation_date)
VALUES ('INVTEST03', '12000', '12500', '-100', '10008622', '2023-04-01');


#GIC Table#
INSERT INTO SCOTIABANK.GIC (Investment_account_number, Interest_rate, Tenure)
VALUES ('INVNEG', -1, 12);


#Mutual Funds Table#
INSERT INTO SCOTIABANK.Mutual_Funds (Investment_account_number, Mf_type)
VALUES ('MFNEW1234', 'VeryLongMutualFundTypeExceedsLimit');

#Crypto Table#
INSERT INTO SCOTIABANK.Crypto (Investment_account_number, Crypto_type)
VALUES ('CRYP12345', 'ExcessivelyLongCryptoName');

#Debit Card Table#
INSERT INTO SCOTIABANK.Debit_Card (Debit_card_number, CVV, Expiry_date, Account_number)
VALUES ('1234567890123456', '12345', '2023-12-01', '10008622');

#Credit Card Table#
INSERT INTO SCOTIABANK.Credit_Card (Credit_card_number, CVV, Expiry_date, Card_type, Account_number)
VALUES ('12345678901234567', '123', '2025-12-31', 'Visa', '10008592');

#Savings#
INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate)
VALUES ('123456789', 1.5);

INSERT INTO SCOTIABANK.Savings (Account_number, Interest_rate)
VALUES ('10008612', '-0.5');

#Transactions#
INSERT INTO SCOTIABANK.Transactions (Transaction_ID, Amount, Transaction_description, Time_stamp, Account_number)
VALUES ('TXN99999', 'abc', 'Test Invalid Amount', '2023-03-19 10:00:00', '10008592');

#Chequing Table
INSERT INTO SCOTIABANK.Chequing (Account_number, Monthly_fee)
VALUES ('10008612', '-10');

#Loan Table#
INSERT INTO SCOTIABANK.Loans (Loan_ID, Loan_status, Interest_rate, Start_date, End_date, Loan_type, Amount, Customer_ID, Branch_ID)
VALUES ('6001', '1', '-5', '2023-04-01', '2028-04-01', 'Personal loan', '25000', 'B5VN1H3G', '1');

INSERT INTO SCOTIABANK.Loans (Loan_ID, Loan_status, Interest_rate, Start_date, End_date, Loan_type, Amount, Customer_ID, Branch_ID)
VALUES ('6002', '1', '4.5', '2023-04-01', '2028-04-01', 'Personal loan', '0', 'D4TM5H2S', '2');


