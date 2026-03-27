--------------------Count total employees
SELECT COUNT(*) FROM employees;

--------------------employee name and salary
SELECT name , salary FROM employees;

--------------------employee name whose salary > 30000
SELECT *
FROM employees
WHERE salary > 30000;

------------------Employee Names and their Departments
SELECT e.name as Name, d.dept_name as Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id; 

----------Top 10 employees with the highest salaries including their department and role
SELECT e.name , d.dept_name as Department , e.salary as Salary , r.role_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN roles r ON e.role_id  = r.role_id
ORDER BY e.salary DESC
LIMIT 10;

-------------Number of employees in each department
SELECT dept_name as Department , COUNT(*) as Total_employees
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

----------Employees whose salary is greater than the average salary of all employees
SELECT name , salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

--------Employee(s) who have the highest salary in the organization.
SELECT name , salary
FROM employees 
WHERE salary = (
	SELECT MAX(salary)
	FROM employees
);

-------Employees who have not taken any leave
SELECT name
FROM employees
WHERE id NOT IN (
	SELECT employee_id
	FROM leave_requests
);

-------employee who has the highest total salary deduction
SELECT e.id , e.name , SUM(s.deduction_amount) as total_salary_deduction
FROM employees e
LEFT JOIN salary_deduction s ON e.id = s.employee_id
GROUP BY e.id , e.name
ORDER BY total_salary_deduction ASC;


----------Final salary report with deduction
SELECT
	e.name ,
	e.salary ,
	calculate_deduction(e.id) AS deduction ,
	e.salary - calculate_deduction(e.id) AS final_salary
FROM employees e;

====================TESTING====================
-- Test procedure
CALL new_employee('Farsana', 60000, 4, 2);

-- Test trigger
UPDATE employees SET salary = 70000 WHERE id = 3;

-- Test deduction trigger
INSERT INTO attendance(employee_id, date, status)
VALUES(1, CURRENT_DATE, 'Absent');

-- Test function
SELECT calculate_deduction(15);
