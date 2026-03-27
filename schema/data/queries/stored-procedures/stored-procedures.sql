-- Procedure: Insert a new employee
CREATE OR REPLACE PROCEDURE new_employee(
    p_name VARCHAR,
    p_salary NUMERIC,
    p_dept_id INT,
    p_role_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO employees(name, salary, dept_id, role_id)
    VALUES(p_name, p_salary, p_dept_id, p_role_id);
END;
$$;
