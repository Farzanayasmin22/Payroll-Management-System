## PAYROLL-MANAGEMENT-SYSTEM Schema

DROP TABLE IF EXISTS salary_log;
DROP TABLE IF EXISTS salary_deduction;
DROP TABLE IF EXISTS leave_requests;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS departments;


CREATE TABLE departments(
	dept_id SERIAL PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL
);

CREATE TABLE roles(
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	salary NUMERIC CHECK (salary > 0),
	dept_id INT REFERENCES departments(dept_id),
	role_id INT REFERENCES roles(role_id)
);

CREATE TABLE attendance(
	 attendence_id SERIAL PRIMARY KEY,
	 employee_id INT REFERENCES employees(id) ON DELETE CASCADE,
	 date DATE NOT NULL,
	 status VARCHAR(50) CHECK (status IN ('Present' , 'Absent'))
);

CREATE TABLE leave_requests(
	leave_id SERIAL PRIMARY KEY,
	employee_id INT REFERENCES employees(id),
	from_date DATE,
	to_date DATE,
	status VARCHAR(20)
);

CREATE TABLE salary_deduction(
	deduction_id SERIAL PRIMARY KEY,
	employee_id INT REFERENCES employees(id),
	deduction_amount NUMERIC,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE salary_log(
	log_id SERIAL PRIMARY KEY,
	employee_id INT REFERENCES employees(id),
	old_salary NUMERIC,
	new_salary NUMERIC,
	changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

