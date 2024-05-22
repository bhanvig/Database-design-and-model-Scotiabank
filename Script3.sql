#Branch KPIs
#Retrieve the accounts opened over the last year in both branches.

SELECT Account_number, Branch_ID, Date_opened from Account;

# (Which branch grew the most in the last quarter?)
#Employee hiring trajectory- growth per branch

SELECT COUNT(Employee_ID), Branch_ID
from Employee
group by Branch_ID;

Select Join_date, employee_ID, Branch_ID
from Employee;

#Customer density map per branch
SELECT Customer.Customer_ID, Customer.City, Customer.Postal_code,Account.Branch_ID
from  Account, Customer
where Customer.Customer_ID=Account.Cust_ID;


#Which branch has the most investments?  
SELECT SUM(Book_value), Branch_ID
from Investments, Account
where Investments.Account_number=Account.Account_number
group by Branch_ID;

#Which branch is selling more credit cards?
SELECT COUNT(Credit_card_number), branch_id
from Account, Credit_Card
where Account.Account_number=Credit_Card.Account_number
group by branch_id;

# Number of Transactions per branch (label)
select COUNT(Transaction_id), Branch_ID
from Transactions, Account
where Account.Account_number=Transactions.Account_number
group by Branch_ID;



#Customer portfolio:
#Categorize customer base by using demographic indicators like credit score, salary, Job_Sector

#Customers who have taken loans and their job sectors
select Job_Sector, Customer.Customer_ID, Loan_ID
from Customer,Employments,Loans
where Customer.Customer_ID=Employments.Customer_ID and Customer.Customer_ID=Loans.Customer_ID;

  
#Customer credit score, balance, job sector
select Job_Sector, Customer.Customer_ID, credit_score,  balance
from Customer,Employments, Account
where Customer.Customer_ID=Employments.Customer_ID and Customer.Customer_ID=Account.Cust_ID;


#Retrieve Customers by age group
SELECT Customer.Customer_ID, FLOOR(DATEDIFF(CURRENT_DATE, DoB) / 365.25) AS Age, Job_Sector
FROM  Customer, Employments where Customer.Customer_ID=Employments.Customer_ID;



#Investment Portfolio
#We made a consolidated table so that we can compare the each investment type for different types of users categorized by age, job_sector
# ,salary.

SELECT i.Book_value, i.Creation_date, i.Account_number, e.Salary, e.Job_Sector, FLOOR(DATEDIFF(CURRENT_DATE, cust.DoB) / 365.25) AS Age,
       CASE WHEN c.Investment_account_number IS NOT NULL THEN 'Crypto'
            WHEN g.Investment_account_number IS NOT NULL THEN 'GIC'
            WHEN m.Investment_account_number IS NOT NULL THEN 'Mutual Funds'
            ELSE 'Unknown' END AS Investment_Type
FROM Investments i
LEFT JOIN Crypto c ON i.Investment_account_number = c.Investment_account_number
LEFT JOIN GIC g ON i.Investment_account_number = g.Investment_account_number
LEFT JOIN Mutual_Funds m ON i.Investment_account_number = m.Investment_account_number
INNER JOIN Account ON Account.Account_number = i.Account_number
INNER JOIN Employments e ON Account.Cust_ID = e.Customer_ID
INNER JOIN Customer cust ON Account.Cust_ID= cust.Customer_ID;