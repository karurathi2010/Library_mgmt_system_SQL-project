# Library_mgmt_system_SQL-project
### Project Overview: Library Management System Using SQL
The Library Management System (LMS) project aims to create an efficient database-driven solution for managing the activities and operations of a library. The system covers a wide range of functionalities that ensure seamless handling of books, members, employees, rentals, returns, and overdue books. The project includes a series of SQL tasks that address basic database operations (CRUD), complex queries, data analysis, and advanced SQL operations.

![image](https://github.com/user-attachments/assets/0da3dab9-9ba1-49c4-8529-7814d87f31b3)

### Objectives:
The primary goal of this project is to manage and track library resources, including books, members, and employee activities. The system will allow users to:
* Track and manage book inventory.
* Track member activities, including book issuance and returns.
* Generate useful reports for branch managers, employees, and administrators.
* Ensure proper data integrity and streamline library operations.

## Project Structure
### 1.Database Setup
![ERD (1)](https://github.com/user-attachments/assets/2433ccfd-ebb9-42dd-893c-d90facb8f179)

## 1. CRUD Operations
 #### Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
![image](https://github.com/user-attachments/assets/8d2fb75c-cf33-47ce-86fb-ca6823aabb06)

#### Task 2: Update an Existing Member's Address
![image](https://github.com/user-attachments/assets/45c93fe6-3a95-4db1-b2c5-95eae1ee99ab)

#### Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
![image](https://github.com/user-attachments/assets/e8b70eea-f6f9-422c-8753-fded500d5bdc)

#### Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
![image](https://github.com/user-attachments/assets/45dda772-077b-4e62-aef1-a1e375bf267c)

#### Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
![image](https://github.com/user-attachments/assets/ca1a2626-ee37-4242-9ac8-615471d8df25)

## CTAS (Create Table As Select)
#### Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
![image](https://github.com/user-attachments/assets/a1529053-acc3-4e4f-a542-37270db840e2)

## Data Analysis & Findings
The following SQL queries were used to address specific questions:

#### Task 7. Retrieve All Books in a Specific Category:
![image](https://github.com/user-attachments/assets/b7a4f8c9-6eab-412a-a493-d223c4664409)

#### Task 8: Find Total Rental Income by Category:
![image](https://github.com/user-attachments/assets/ddf2ff9f-fbe6-44ee-b3d5-eb76d9d99e91)

#### Task 9 List Members Who Registered in the Last 180 Days:
![image](https://github.com/user-attachments/assets/94df8486-fbb4-48fa-8bb6-413596d66e6d)

#### Task 10 List Employees with Their Branch Manager's Name and their branch details:
![image](https://github.com/user-attachments/assets/87c97ad3-ecbc-463f-ac3b-f19bdf115653)

#### Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
![image](https://github.com/user-attachments/assets/a9344f51-cf32-4be0-bd14-a0317f5287b1)

#### Task 12: Retrieve the List of Books Not Yet Returned
![image](https://github.com/user-attachments/assets/dc03e088-6161-4d2a-95b1-115559690003)

#### Task 13: Identify Members with Overdue Books
##### Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue
![image](https://github.com/user-attachments/assets/e11411e2-a8c3-4378-b94e-881d447c9139)

#### Task 14: Update Book Status on Return
##### Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
![image](https://github.com/user-attachments/assets/5a16f96f-0845-4dd2-aed9-f2412f3e133b)

#### Task 15: Branch Performance Report
##### Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
![image](https://github.com/user-attachments/assets/1cf6e393-e14f-42d7-8771-54ea5e6d1f8d)

#### Task 16: CTAS: Create a Table of Active Members
##### Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
![image](https://github.com/user-attachments/assets/b75f9823-1968-4e4f-8279-181e701a3795)

#### Task 17: Find Employees with the Most Book Issues Processed
![image](https://github.com/user-attachments/assets/0b4e3733-5a98-40d8-b99c-ea2a82542f70)

#### Task 19: Stored Procedure 
##### Objective: Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
![image](https://github.com/user-attachments/assets/61ecf67e-6e79-41bb-8d8e-b81ba29e3918)

## Conclusion:
The Library Management System project provides a comprehensive solution for managing a library's book inventory, member activities, and employee performance. Through SQL queries, we efficiently handle CRUD operations, complex data analysis, and advanced reporting tasks, making it an ideal choice for libraries to automate their operations.















