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

