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

-- 11: Final salary after deduction
SELECT
    e.name,
    e.salary,
    calculate_deduction(e.id) AS deduction,
    e.salary - calculate_deduction(e.id) AS final_salary
FROM employees e;

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
