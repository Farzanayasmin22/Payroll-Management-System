# 💼 Payroll Management System (PostgreSQL)

## 📌 Project Overview
This project is a **Payroll Management System** designed using PostgreSQL.  
It demonstrates database design concepts including schema creation, data handling, queries, stored procedures, triggers, and functions.

---

## 🗂️ Database Structure

The project is organized into multiple modules:

- **schema/** → Table creation (structure)
- **data/** → Insert sample data
- **queries/** → SQL queries (joins, subqueries, reports)
- **procedures/** → Stored procedures
- **functions/** → Custom SQL functions
- **triggers/** → Automation logic (logging & deductions)
- **er_diagram/** → ER Diagram of the database

---

## Tables Used

- Employees
- Departments
- Roles
- Attendance
- Leave Requests
- Salary Deduction
- Salary Log

---

## ⚙️ Features Implemented

### 🔹 1. Joins
- Employee with department and role
- Salary reports

### 🔹 2. Subqueries
- Employees earning above average salary
- Highest salary employee

### 🔹 3. Aggregations
- Employee count per department
- Total salary deductions

### 🔹 4. Stored Procedure
- Insert new employee dynamically

### 🔹 5. Triggers
- Automatically log salary updates
- Automatically deduct salary when absent

### 🔹 6. Functions
- Calculate salary deduction based on attendance

---

## 📊 Sample Queries

- Retrieve employee details with department
- Top 10 highest paid employees
- Employees with no leave records
- Final salary calculation after deduction

---

## 🖼️ ER Diagram

![ER Diagram](er_diagram/er_diagram.png)

---

##  Key Concepts Covered

- Relational Database Design
- Primary & Foreign Keys
- Joins & Subqueries
- Triggers & Automation
- Stored Procedures
- Functions

---

## Conclusion

This project demonstrates a complete **real-world payroll system** with structured data handling, automation, and analytical queries.

---

## 💼 Designed and Developed By
Farsana Yasmin
