-- 1: Count total number of employees
SELECT COUNT(*) FROM employees;

-- 2: Retrieve employee names and salaries
SELECT name, salary FROM employees;

-- 3: Employees with salary greater than 30000
SELECT *
FROM employees
WHERE salary > 30000;

-- 4: Employee names with their departments
SELECT e.name AS Name, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 5: Top 10 highest paid employees with department and role
SELECT e.name, d.dept_name AS Department, e.salary AS Salary, r.role_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN roles r ON e.role_id = r.role_id
ORDER BY e.salary DESC
LIMIT 10;

-- 6: Number of employees in each department
SELECT d.dept_name AS Department, COUNT(e.id) AS Total_employees
FROM departments d
LEFT JOIN employees e ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 7: Employees earning above average salary
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 8: Employee(s) with highest salary
SELECT name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 9: Employees who have not taken any leave
SELECT name
FROM employees
WHERE id NOT IN (SELECT employee_id FROM leave_requests);

-- 10: Employee with highest total salary deduction
SELECT e.id, e.name, SUM(s.deduction_amount) AS total_salary_deduction
FROM employees e
LEFT JOIN salary_deduction s ON e.id = s.employee_id
GROUP BY e.id, e.name
ORDER BY total_salary_deduction DESC;

-- 11: Employees with More Than 5 Absences
SELECT e.name , COUNT(*) AS absent_days
FROM attendance a
JOIN employees e ON a.employee_id = e.id
WHERE a.status = 'Absent'
GROUP BY e.name
HAVING COUNT(*) > 5
ORDER BY absent_days DESC;

-- 12: Employees with No Deductions AND No Leave
SELECT e.name
FROM employees e
WHERE e.id NOT IN (
	SELECT employee_id
	FROM salary_deduction
) AND e.id NOT IN (
	SELECT employee_id
	FROM leave_requests
);

-- 13: Highest postition employees and their ranking
SELECT
	name ,
	salary ,
	DENSE_RANK() OVER(ORDER BY salary DESC) AS rank
FROM employees;

-- 14: Final salary after deduction
SELECT
    e.name,
    e.salary,
    calculate_deduction(e.id) AS deduction,
    e.salary - calculate_deduction(e.id) AS final_salary
FROM employees e;


-- 15: Payroll Report
SELECT
    e.name,
    d.dept_name,
    r.role_name,
    p.total_salary,
    p.total_deductions,
    p.net_salary,
    p.generated_at
FROM employees e
LEFT JOIN payroll p ON p.employee_id = e.id
LEFT JOIN departments d ON d.dept_id = e.dept_id
LEFT JOIN roles r ON r.role_id = e.role_id
ORDER BY p.generated_at DESC;

==========================TESTING=============================

-- Test procedure
CALL new_employee('Farsana', 60000, 4, 2);

-- Test salary log trigger
UPDATE employees SET salary = 70000 WHERE id = 3;
SELECT * FROM salary_log;

-- Test absence trigger
INSERT INTO attendance(employee_id, date, status)
VALUES(1, CURRENT_DATE, 'Absent');

SELECT * FROM salary_deduction;

-- Test function
SELECT calculate_deduction(15);


SELECT generate_payroll(1);
SELECT generate_payroll(35);
SELECT generate_payroll(21);

SELECT * FROM payroll;
