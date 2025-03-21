SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;

-- 1. Create a New Book Record -- 

INSERT INTO books VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

--2: Update an Existing Member's Address.

UPDATE members
SET member_address='125 Oak St'
WHERE member_id='C103';

--3: Delete a Record from the Issued Status Table 

DELETE FROM issued_status
WHERE issued_id='IS121'

--4: Retrieve All Books Issued by a Specific Employee 
SELECT issued_book_name FROM issued_status
WHERE issued_emp_id='E101';

--5:List Members Who Have Issued More Than One Book.
SELECT issued_member_id,COUNT(*)
FROM issued_status
GROUP BY issued_member_id
HAVING COUNT(*)>1;

-- 6: Create Summary Tables:

CREATE TABLE book_issued_cnt AS
SELECT b.isbn, b.book_title, COUNT(ist.issued_id) AS issue_count
FROM issued_status as ist
JOIN books as b
ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title

SELECT * FROM book_issued_cnt;

--7. Retrieve All Books in a Specific Category:

SELECT book_title FROM books
WHERE category='Classic';

--8: Find Total Rental Income by Category:

SELECT category,SUM(rental_price) AS total_rental_income
FROM books
GROUP BY category;

--9:List Members Who Registered in the Last 180 Days:
SELECT * FROM members
WHERE reg_date >= (SELECT MAX(reg_date) FROM members) - INTERVAL '180 days';

--10:List Employees with Their Branch Manager's Name and their branch details:

ALTER TABLE branch
RENAME COLUMN " manager_id" TO manager_id;

SELECT e1.emp_name,e2.emp_name AS managers,b.manager_id,e1.position,e1.salary
FROM employees e1
JOIN branch b
ON e1.branch_id=b.branch_id
JOIN employees e2
ON e2.emp_id=b.manager_id;

-- 11. Create a Table of Books with Rental Price Above a Certain Threshold:

CREATE TABLE expensive_books AS
SELECT book_title FROM books 
WHERE rental_price >7;

--12: Retrieve the List of Books Not Yet Returned

SELECT I.issued_book_name,I.issued_id
FROM issued_status I
LEFT JOIN return_status R
ON I.issued_id=R.Issued_id
WHERE R.issued_id IS NULL;

-- 13: Identify Members with Overdue Books
--Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, 
--book title, issue date, and days overdue.

SELECT b.book_title,m.member_name,m.member_id,i.issued_date,
CURRENT_DATE -i.issued_date AS over_due_days
FROM books b
JOIN issued_status i
ON b.isbn=i.issued_book_isbn
JOIN members m
ON i.issued_member_id=m.member_id
LEFT JOIN return_status r
ON i.issued_id=r.issued_id
WHERE CURRENT_DATE-i.issued_date>30
AND r.return_date IS NULL
ORDER BY 3;

--14: Update Book Status on Return
--Write a query to update the status of books in the books table to "Yes" when they are returned 
--(based on entries in the return_status table)

UPDATE books b
SET status = CASE
               WHEN r.return_date IS NULL THEN 'yes'
               ELSE 'no'
             END
FROM issued_status i
LEFT JOIN return_status r ON i.issued_id = r.issued_id
WHERE b.isbn = i.issued_book_isbn;

CREATE TABLE book_status AS
SELECT b.*,
CASE
 WHEN r.return_date IS NULL THEN 'yes'
 ELSE 'no'
END
FROM books b
JOIN issued_status i
ON b.isbn=i.issued_book_isbn
LEFT JOIN return_status r
ON i.issued_id=r.issued_id;

-- Task 15: Branch Performance Report
--Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, 
--and the total revenue generated from book rentals.
CREATE TABLE branch_performance AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
    SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN 
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1, 2;

SELECT * FROM branch_performance;

--Task 16: CTAS: Create a Table of Active Members
--Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one 
--book in the last 2 months.

CREATE TABLE active_members AS
SELECT DISTINCT m.member_id,m.member_name 
FROM members m
JOIN issued_status i
ON m.member_id=i.issued_member_id
WHERE i.issued_date >= (SELECT MAX(issued_date)FROM issued_status)- INTERVAL '60 DAYS';

SELECT * FROM active_members;


-- Task 17: Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. 
--Display the employee name, number of books processed, and their branch.

SELECT e.emp_id,e.emp_name,b.branch_address,COUNT(i.issued_id) issued_books
FROM employees e
JOIN branch b
ON e.branch_id=b.branch_id
JOIN issued_status i
ON e.emp_id=i.issued_emp_id
GROUP BY 1,2,3
ORDER BY COUNT(i.issued_id) DESC;

--18: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system. 
--Description: Write a stored procedure that updates the status of a book in the library based on its issuance. 
--The procedure should function as follows: The stored procedure should take the book_id as an input parameter. 
--The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, 
--and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), 
--the procedure should return an error message indicating that the book is currently not available.

CREATE OR REPLACE PROCEDURE issue_book(
    p_issued_id VARCHAR(10), 
    p_issued_member_id VARCHAR(30), 
    p_issued_book_isbn VARCHAR(30), 
    p_issued_emp_id VARCHAR(10)
)
LANGUAGE plpgsql
AS
$$
DECLARE
   
    v_status VARCHAR(10);
BEGIN
    
    SELECT 
        status 
    INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;

    IF v_status = 'yes' THEN
        
        INSERT INTO issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
        VALUES (p_issued_id, p_issued_member_id, CURRENT_DATE, p_issued_book_isbn, p_issued_emp_id);

        
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;

       
        RAISE NOTICE 'Book records added successfully for book ISBN: %', p_issued_book_isbn;

    ELSE
       
        RAISE NOTICE 'Sorry, the book you have requested is unavailable. Book ISBN: %', p_issued_book_isbn;
    END IF;
END;
$$;

CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('"IS106"', 'C106', '978-0-330-25864-8', 'E104');
