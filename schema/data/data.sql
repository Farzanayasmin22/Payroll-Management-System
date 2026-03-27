INSERT INTO departments(dept_name)
VALUES('HR') , ('IT') , ('Finance') , ('Marketing') , ('Sales');

INSERT INTO roles(role_name)
VALUES('Manager') , ('Developer') , ('Analyst') , ('Executive') , ('Intern');
SELECT * FROM employees;
------------------------------------------------------------------
INSERT INTO employees(name , salary , dept_id , role_id)
SELECT
	name ,
	(random() * 30000 + 20000)::INT,
	(random() * 4 + 1)::INT,
	(random() * 4 + 1)::INT
FROM unnest(ARRAY[
	'Aisha','Rahul','Fathima','Arjun','Sneha',
    'Nikhil','Meera','Kiran','Anjali','Rohit',
    'Divya','Akash','Neha','Vishnu','Sana',
    'Farhan','Priya','Aman','Reshma','Karthik',
    'Adil','Naveen','Shifa','Varun','Lekha',
    'Harsha','Deepa','Irfan','Salman','Anu',
    'Riya','Gokul','Junaid','Ashwin','Tanya',
    'Zoya','Manu','Sreya','Faiz','Abhinav',
    'Noor','Rakesh','Pooja','Sameer','Liya',
    'Arifa','Dev','Mithun','Hiba','Nimisha'
]) AS name;

SELECT * FROM employees;
-----------------------------------------------------------------
INSERT INTO attendance(employee_id , date , status)
SELECT
	e.id,
	CURRENT_DATE - (g || 'days')::INTERVAL,
	CASE
		WHEN random() > 0.2 THEN 'Present'
		ELSE 'Absent'
	END
FROM employees e
CROSS JOIN generate_series(1,30) AS g;

SELECT * FROM attendance;
----------------------------------------------------------------------
INSERT INTO leave_requests(employee_id , from_date , to_date , status)
SELECT
	id,
	CURRENT_DATE - INTERVAL '10 Days',
	CURRENT_DATE - INTERVAL '7 Days',
	CASE 
		WHEN random() > 0.5 THEN 'Approved'
		ELSE 'Rejected'
	END
FROM employees
WHERE random() > 0.6;

SELECT * FROM leave_requests;
