-- Trigger 1: Log salary changes
CREATE OR REPLACE FUNCTION update_salary_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_log(employee_id, old_salary, new_salary)
        VALUES(OLD.id, OLD.salary, NEW.salary);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_after_update
AFTER UPDATE OF salary ON employees
FOR EACH ROW
EXECUTE FUNCTION update_salary_trigger();


-- Trigger 2: Insert salary-deduction when absent
CREATE OR REPLACE FUNCTION trigger_salary_deduction()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Absent' THEN
        INSERT INTO salary_deduction(employee_id, deduction_amount)
        VALUES(NEW.employee_id, 500);
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_salary_deduction
AFTER INSERT ON attendance
FOR EACH ROW
EXECUTE FUNCTION trigger_salary_deduction();
