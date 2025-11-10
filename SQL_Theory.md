-- ==========================================
-- SQL ASSIGNMENT (ECommerceDB)
-- Assignment Code: DA-AG-014
-- Introduction to SQL and Advanced Functions | Assignment | Theritical
-- ==========================================

**Theoritical Questions:**

Question 1:
Explain the fundamental differences between DDL, DML, and DQL commands in SQL. Provide one example for each type of command.
Answer:
1. DDL (Data Definition Language):
Defines and modifies the structure of database objects (tables, schemas, etc.).

Common Commands: CREATE, ALTER, DROP

Example:
```
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2)
);
```
2. DML (Data Manipulation Language):
Used to modify data stored in database tables.

Common Commands: INSERT, UPDATE, DELETE

Example:
```
INSERT INTO Employees (EmpID, EmpName, Salary)
VALUES (1, 'Alice', 55000.00);
```
3. DQL (Data Query Language):
Used to retrieve data from the database.

Common Command: SELECT

Example:
```
SELECT EmpName, Salary FROM Employees;
```
Question 2:
What is the purpose of SQL constraints? Name and describe three common types of constraints, providing a simple scenario where each would be useful.

Answer:
SQL constraints ensure the accuracy, reliability, and integrity of data in a table.

- **PRIMARY KEY:** 	Ensures each record is unique and not NULL.	**Example:** Each employee must have a unique ID.
- **FOREIGN KEY:**	Maintains referential integrity between related tables.**Example:**	Orders table referencing Customers table.
- **UNIQUE:**	Ensures all values in a column are unique.**Example:**	Email address in Users table must be unique.

Example:
```
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE,
    CityID INT,
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);
```
Question 3:

Explain the difference between LIMIT and OFFSET clauses in SQL. How would you use them together to retrieve the third page of results, assuming each page has 10 records?

Answer:

- LIMIT: Specifies the number of records to return.

- OFFSET: Skips a specified number of rows before returning results.
Example:

To get page 3 (records 21–30):
```
SELECT * 
FROM Products
LIMIT 10 OFFSET 20;
```
Question 4:

What is a Common Table Expression (CTE) in SQL, and what are its main benefits? Provide a simple SQL example demonstrating its usage.

Answer:
A CTE (Common Table Expression) is a temporary result set defined within a query using the WITH keyword.
It improves query readability, reusability, and modularity.

Benefits:

Simplifies complex subqueries

Improves query readability

Allows recursive queries

Example:
```
WITH SalesPerCustomer AS (
    SELECT CustomerID, SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
)
SELECT c.CustomerName, s.TotalSpent
FROM Customers c
JOIN SalesPerCustomer s ON c.CustomerID = s.CustomerID
ORDER BY s.TotalSpent DESC;
```
Question 5:

Describe the concept of SQL Normalization and its primary goals. Briefly explain the first three normal forms (1NF, 2NF, 3NF).

Answer:
Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity.

**Goals:**
- Eliminate data redundancy

- Ensure data dependencies are logical

- Simplify maintenance

| Normal Form | Definition                                                       | Example                                                 |
| ----------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| **1NF**     | Each cell holds a single value; no repeating groups.             | Split comma-separated phone numbers into separate rows. |
| **2NF**     | 1NF + every non-key attribute depends on the entire primary key. | Remove partial dependency in composite keys.            |
| **3NF**     | 2NF + no transitive dependency (non-key → non-key).              | Move derived attributes to separate table.              |
