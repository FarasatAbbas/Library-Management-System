Create Database Library6;
use Library6;
-- Create tables
CREATE TABLE Authors (
  Author_id INT PRIMARY KEY,
  Author_name VARCHAR(255) NOT NULL
);

CREATE TABLE Librarians (
  Librarian_id INT PRIMARY KEY,
  Librarian_name VARCHAR(125) NOT NULL,
  Phone VARCHAR(20),
  Address VARCHAR(255),
  Email VARCHAR(255)
);

CREATE TABLE Publishers (
  Publisher_id INT PRIMARY KEY,
  Publisher_name VARCHAR(255) NOT NULL,
  Address VARCHAR(255),
  Phone_number VARCHAR(20),
  Email VARCHAR(255)
);

CREATE TABLE Books (
  Book_id INT PRIMARY KEY,
  Title VARCHAR(255) NOT NULL,
  Author_id INT,
  Publisher_id INT,
  Publication_year INT,
  Category VARCHAR(255),
  ISBN VARCHAR(20),
  Total_copies INT,
  Available_copies INT,
  Price DECIMAL(10, 2),
  FOREIGN KEY (Author_id) REFERENCES Authors(Author_id),
  FOREIGN KEY (Publisher_id) REFERENCES Publishers(Publisher_id)
);

CREATE TABLE Members (
  Member_id INT PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Address VARCHAR(255),
  Phone_number VARCHAR(20),
  Email VARCHAR(255)
);

CREATE TABLE Transactions (
  Transaction_id INT PRIMARY KEY,
  Book_id INT,
  Member_id INT,
  Librarian_id INT,
  Transaction_date DATE,
  Due_date DATE NOT NULL,
  Return_date DATE,
  FOREIGN KEY (Book_id) REFERENCES Books(Book_id),
  -- FOREIGN KEY (Member_id) REFERENCES Members(Member_id),
  FOREIGN KEY (Librarian_id) REFERENCES Librarians(Librarian_id) 
);

CREATE TABLE Fines (
  Fine_id INT PRIMARY KEY,
  Transaction_id INT,
  Fine_amount DECIMAL(10, 2),
  FOREIGN KEY (Transaction_id) REFERENCES Transactions(Transaction_id)
);





-- Insert sample data


INSERT INTO Authors (Author_id, Author_name)
VALUES (1, 'Einstien Stimula'),
       (2, 'Newtons Dewon'),
       (3, 'Jabir Bin Huyan');

INSERT INTO Books (Book_id, Title, Author_id, Publication_year, Category, ISBN, Total_copies, Available_copies, Price)
VALUES 
(1, 'To Kill a Mockingbird', 1, 1960, 'Fiction', '978-0-06-112008-4', 100, 90, 12.99),
(2, 'Think and grow Rich', 2, 1949, 'Finanace', '978-0-452-28423-4', 80, 70, 10.99),
(3, 'Pride and Prejudice', 3, 1813, 'Romance', '978-1-85326-000-5', 120, 110, 8.99);


INSERT INTO Members (Member_id, Name, Address, Phone_number, Email)
VALUES 
(1, 'Jane Doe', '123 Main St, Anytown', '123-456-7890', 'jane.doe@example.com'),
(2, 'John Smith', '456 Elm St, Anycity', '987-654-3210', 'john.smith@example.com'),
(3, 'Alice Johnson', '789 Oak St, Anyvillage', '111-222-3333', 'alice.johnson@example.com');


INSERT INTO Transactions (Transaction_id, Book_id, Member_id, Transaction_date, Due_date, Return_date)
VALUES 
(1, 1, 1, '2023-05-01', '2024-05-25', NULL),
(2, 2, 2, '2023-05-02', '2023-05-16', NULL),
(3, 3, 3, '2023-05-03', '2023-05-17', NULL);

INSERT INTO Publishers (Publisher_id, Publisher_name, Address, Phone_number, Email)
VALUES 
(1, 'John Casedo', '123 Main St, Anytown', '123-456-7890', 'Casedo@example.com'),
(2, 'Lory Marwin', '456 Elm St, Anycity', '987-654-3210', 'Marwin@example.com'),
(3, 'JOhn Joe', '789 Oak St, Anyvillage', '111-222-3333', 'Joe@example.com');

INSERT INTO Fines (Fine_id, Transaction_id, Fine_amount)
VALUES 
(1, 1, 2.50),
(2, 2, 3.00),
(3, 3, 4.50);
UPDATE Transactions
SET Due_date='2024-05-25'
where Transaction_id=1;

SELECT * FROM books;
select * from members;
select Address from members;
select * from Fines;
select Title From Books where Book_id=1;

select Fine_amount From Fines where Fine_id=3;

SELECT b.Title, a.Author_name
FROM Books b
INNER JOIN Authors a ON b.Author_id = a.Author_id;

-- Reteive the name of borrower and title of book
SELECT m.Name, b.Title
FROM Members m
INNER JOIN Transactions t ON m.Member_id = t.Member_id
INNER JOIN Books b ON t.Book_id = b.Book_id;

-- Ftech Name of memeber and amount of fine applies
SELECT m.Name, f.Fine_amount
FROM Members m
INNER JOIN Transactions t ON m.Member_id = t.Member_id
INNER JOIN Fines f ON t.Transaction_id = f.Transaction_id;

-- left join
SELECT m.Name, b.Title
FROM Members m
LEFT JOIN Transactions t ON m.Member_id = t.Member_id
LEFT JOIN Books b ON t.Book_id = b.Book_id;
-- Fetch transactions where books are overdue
SELECT t.Transaction_id, b.Title AS Book_Title, m.Name AS Member_Name, t.Transaction_date, t.Due_date, t.Return_date
FROM Transactions t
INNER JOIN Books b ON t.Book_id = b.Book_id
INNER JOIN Members m ON t.Member_id = m.Member_id
WHERE t.Due_date < CURDATE() AND t.Return_date IS NULL;

-- Fetch transactions for a specific member:
SELECT t.Transaction_id, b.Title AS Book_Title, m.Name AS Member_Name, t.Transaction_date, t.Due_date, t.Return_date
FROM Transactions t
INNER JOIN Books b ON t.Book_id = b.Book_id
INNER JOIN Members m ON t.Member_id = m.Member_id
WHERE m.Member_id = 3;

DROP DATABASE Library6;