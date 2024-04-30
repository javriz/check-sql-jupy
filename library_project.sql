-- Active: 1706330407016@@127.0.0.1@3306@library
select * from books
### /*1)List customers who have overdue books*/

SELECT c.first_name, c.last_name, c.email, i.due_date
FROM customers AS c
JOIN issued_books AS i ON c.id = i.customer_id
WHERE i.due_date < CURRENT_DATE;

### /*2)List the most popular books (most issued)*/

SELECT b.title, COUNT(i.book_id) AS total_issued
FROM issued_books AS i
JOIN books AS b ON i.book_id=b.id
GROUP BY b.title 
ORDER BY total_issued DESC;

/*3)List customers who have never issued a book*/

SELECT * 
FROM customers
WHERE id NOT IN(SELECT customer_id FROM issued_books);

## another way
use library;
select c.first_name
from customers as c
left join issued_books as i
on c.id=i.customer_id
where i.book_id is null;



