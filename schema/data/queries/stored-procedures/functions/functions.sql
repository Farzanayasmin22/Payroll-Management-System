-- Function: Calculate deduction based on attendance
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
