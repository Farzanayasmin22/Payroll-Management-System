-- Insert departments
INSERT INTO departments(dept_name)
VALUES ('HR'), ('IT'), ('Finance'), ('Marketing'), ('Sales');

-- Insert roles
INSERT INTO roles(role_name)
VALUES ('Manager'), ('Developer'), ('Analyst'), ('Executive'), ('Intern');

-- Insert employees
INSERT INTO employees(name, salary, dept_id, role_id)
SELECT 
    name,
    (random() * 30000 + 20000)::INT,
    (random() * 5 + 1)::INT,
    (random() * 5 + 1)::INT
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
