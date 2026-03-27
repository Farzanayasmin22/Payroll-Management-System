--------------------Count total employees
SELECT COUNT(*) FROM employees;

--------------------employee name and salary
SELECT name , salary FROM employees;

--------------------employee name and salary
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

---------Stored procedure to insert a new employee
CREATE OR REPLACE PROCEDURE new_employee(
	p_name VARCHAR,
	p_salary Numeric,
	p_dept_id INT,
	p_role_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO employees(name , salary , dept_id , role_id)
	VALUES(p_name , p_salary , p_dept_id , p_role_id);
END;
$$;
CALL new_employee('Farsana' , 60000 , 4 , 2);

--Trigger to automatically log salary changes whenever an employee’s salary is updated.
CREATE OR REPLACE FUNCTION update_salary_trigger()
RETURNS TRIGGER AS $$
BEGIN
	IF OLD.salary <> NEW.salary THEN
		INSERT INTO salary_log(employee_id , old_salary , new_salary)
		VALUES(NEW.id , OLD.salary , NEW.salary);
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_after_update
AFTER UPDATE OF salary ON employees
FOR EACH ROW
EXECUTE FUNCTION update_salary_trigger();

UPDATE employees
SET salary = 70000
WHERE id = 3;

SELECT * FROM salary_log;

--trigger to automatically insert salary deduction when an employee is marked absent.
CREATE OR REPLACE FUNCTION trigger_salary_deduction()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.status = 'Absent' THEN
		INSERT INTO salary_deduction(employee_id , deduction_amount)
		VALUES(NEW.employee_id , 500);
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_salary_deduction
AFTER INSERT ON attendance
FOR EACH ROW
EXECUTE FUNCTION trigger_salary_deduction();

INSERT INTO attendance(employee_id , date , status)
VALUES(1 , CURRENT_DATE , 'Absent'),(2 , CURRENT_DATE , 'Absent');


SELECT * FROM salary_deduction;

------function to calculate deduction based on attendance.
CREATE OR REPLACE FUNCTION calculate_deduction(emp_id INT)
RETURNS NUMERIC AS $$
DECLARE present_days INT;
BEGIN
	SELECT COUNT(*) INTO present_days
	FROM attendance 
	WHERE employee_id = emp_id AND status = 'Present';

	IF present_days < 20 THEN
		return (20 - present_days) * 500;
	ELSE
		RETURN 0;
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT calculate_deduction(15);

----------Final salary report with deduction
SELECT
	e.name ,
	e.salary ,
	calculate_deduction(e.id) AS deduction ,
	e.salary - calculate_deduction(e.id) AS final_salary
FROM employees e;
	
