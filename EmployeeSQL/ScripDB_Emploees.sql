-- In practice to drop tables while testing
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Department CASCADE;
DROP TABLE IF EXISTS Department_Employees;
DROP TABLE IF EXISTS Department_Manager;
DROP TABLE IF EXISTS Salaries;
DROP TABLE IF EXISTS Titles;


-- Create the tables for the data (six cvs files)
--Table for file 'employees.csv'
CREATE TABLE Employees (
    Employee_Id int   NOT NULL,
    birth_date date   NOT NULL,
    first_name varchar(100)   NOT NULL,
    last_name varchar(100)   NOT NULL,
    gender varchar(1)   NOT NULL,
    hire_data date   NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (
        Employee_Id
     )
);

--Table for file 'departments.csv'
CREATE TABLE Department (
    Department_Id varchar(4)   NOT NULL,
    department_name varchar(100)   NOT NULL,
    CONSTRAINT pk_Department PRIMARY KEY (
        Department_Id
     )
);

--Table for file 'dep_emp.csv'
CREATE TABLE Department_Employees (
    Employee_Id int   NOT NULL,
    Department_Id varchar(4)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Table for file 'dep_manager.csv'
CREATE TABLE Department_Manager (
    Department_Id varchar(4)   NOT NULL,
	Employee_Id int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Table for file 'salaries.csv'
CREATE TABLE Salaries (
    Employee_Id int   NOT NULL,
    Salary int   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

--Table for file 'titles.csv'
CREATE TABLE Titles (
    Employee_Id int   NOT NULL,
    title varchar(100)   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL
);

-- Creating forent key  to the following tables (principal key are "Employee_Id" and "Department_Id")
ALTER TABLE Department_Employees ADD CONSTRAINT fk_Department_Employees_Employee_Id FOREIGN KEY(Employee_Id)
REFERENCES Employees (Employee_Id);

ALTER TABLE Department_Employees ADD CONSTRAINT fk_Department_Employees_Department_Id FOREIGN KEY(Department_Id)
REFERENCES Department (Department_Id);

ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_Employee_Id FOREIGN KEY(Employee_Id)
REFERENCES Employees (Employee_Id);

ALTER TABLE Department_Manager ADD CONSTRAINT fk_Department_Manager_Department_Id FOREIGN KEY(Department_Id)
REFERENCES Department (Department_Id);

ALTER TABLE Salaries ADD CONSTRAINT fk_Salaries_Employee_Id FOREIGN KEY(Employee_Id)
REFERENCES Employees (Employee_Id);

ALTER TABLE Titles ADD CONSTRAINT fk_Titles_Employee_Id FOREIGN KEY(Employee_Id)
REFERENCES Employees (Employee_Id);

-- Import data and selecting data to check

SELECT * FROM Employees;
SELECT * FROM Department;
SELECT * FROM Department_Employees;
SELECT * FROM Department_Manager;
SELECT * FROM Salaries;
SELECT * FROM Titles;

-- Data Analysis
--List the following details of each employee: employee number, last name, first name, gender and salary

SELECT Employees.Employee_Id, Employees.last_name, Employees.first_name, Employees.gender,
Salaries.Salary
FROM Employees
INNER JOIN Salaries ON
Employees.Employee_Id = Salaries.Employee_Id;

--List employees who were hired in 1986

SELECT 
	Employee_Id, 
	last_name, 
	first_name,
	hire_data
FROM  Employees
WHERE EXTRACT(YEAR FROM hire_data)='1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment date

SELECT 
    Department_Manager.Department_Id,
	Department.department_name,
	Department_Manager.Employee_Id,
	Employees.last_name,
	Employees.first_name,
    Department_Manager.from_date,
    Department_Manager.to_date
FROM Department_Manager
INNER JOIN Department ON
Department_Manager.Department_Id=Department.Department_Id
INNER JOIN Employees ON
Department_Manager.Employee_Id=Employees.Employee_Id;

--List the department of each employee with the following information: employee number, last name, first name, and department name

SELECT 
	Department_Employees.Employee_Id,
	Employees.last_name,
	Employees.first_name,
	Department.department_name
FROM Department_Employees
INNER JOIN Department  ON
Department_Employees.Department_Id=Department.Department_Id
INNER JOIN Employees ON
Department_Employees.Employee_Id=Employees.Employee_Id;

--List all employees whose first name is "Hercules" and last names begin with "B"

SELECT 
	Employee_Id, 
	last_name, 
	first_name
FROM  Employees
WHERE Employees.first_name='Hercules'
AND Employees.last_name LIKE 'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name
SELECT 
	Department_Employees.Employee_Id,
	Employees.last_name,
	Employees.first_name,
	Department.department_name
FROM Department_Employees
INNER JOIN Department  ON
Department_Employees.Department_Id=Department.Department_Id
INNER JOIN Employees ON
Department_Employees.Employee_Id=Employees.Employee_Id
WHERE 
Department.department_name='Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name
SELECT 
	Department_Employees.Employee_Id,
	Employees.last_name,
	Employees.first_name,
	Department.department_name
FROM Department_Employees
INNER JOIN Department  ON
Department_Employees.Department_Id=Department.Department_Id
INNER JOIN Employees ON
Department_Employees.Employee_Id=Employees.Employee_Id
WHERE 
Department.department_name='Sales' OR 
Department.department_name='Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name
SELECT 
	last_name, 
	COUNT(last_name)
FROM  Employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

--Query to bonus part

SELECT
	Titles.title,
	ROUND(AVG(Salaries.Salary),2) as Averange
FROM Titles
INNER JOIN Salaries ON
Titles.Employee_Id = Salaries.Employee_Id
GROUP BY Titles.title;

-- Epilogeue Employer_number='499942'
SELECT 
	Department_Employees.Employee_Id,
	Employees.last_name,
	Employees.first_name,
	Department_Employees.from_date,
	Department_Employees.to_date,
	Department.department_name,
	Titles.title
FROM Department_Employees
INNER JOIN Department  ON
Department_Employees.Department_Id=Department.Department_Id
INNER JOIN Employees ON
Department_Employees.Employee_Id=Employees.Employee_Id
INNER JOIN Titles ON
Department_Employees.Employee_Id=Titles.Employee_Id
WHERE Employees.Employee_Id='499942';



