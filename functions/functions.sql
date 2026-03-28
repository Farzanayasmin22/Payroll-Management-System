-- Function to Calculate deduction based on attendance
CREATE OR REPLACE FUNCTION calculate_deduction(emp_id INT)
RETURNS NUMERIC AS $$
DECLARE present_days INT;
BEGIN
    SELECT COUNT(*) INTO present_days
    FROM attendance
    WHERE employee_id = emp_id AND status = 'Present';

    IF present_days < 20 THEN
        RETURN (20 - present_days) * 500;
    ELSE
        RETURN 0;
    END IF;
END;
$$ LANGUAGE plpgsql;


-- Function to generate payroll of an employee
CREATE OR REPLACE FUNCTION generate_payroll(emp_id INT)
RETURNS NUMERIC AS $$
DECLARE
    base_salary NUMERIC;
    total_deduction NUMERIC;
    net_salary NUMERIC;
BEGIN
    SELECT salary INTO base_salary
    FROM employees
    WHERE id = emp_id;

    IF base_salary IS NULL THEN
        RAISE EXCEPTION 'Employee with ID % does not exist', emp_id;
    END IF;

    SELECT COALESCE(SUM(deduction_amount), 0)
    INTO total_deduction
    FROM salary_deduction
    WHERE employee_id = emp_id;

    net_salary := base_salary - total_deduction;

    INSERT INTO payroll(
        employee_id,
        total_salary,
        total_deductions,
        net_salary
    )
    VALUES (
        emp_id,
        base_salary,
        total_deduction,
        net_salary
    );

    RETURN net_salary;
END;
$$ LANGUAGE plpgsql;
