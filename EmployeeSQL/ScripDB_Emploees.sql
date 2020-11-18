-- In practice to drop tables while testing
DROP TABLE IF EXISTS "Employees" CASCADE;

DROP TABLE IF EXISTS "Department" CASCADE;

DROP TABLE IF EXISTS "Department_Employees";
DROP TABLE IF EXISTS "Department_Manager";
DROP TABLE IF EXISTS "Salaries";
DROP TABLE IF EXISTS "Titles";


-- Create the tables for the data (six cvs files)

CREATE TABLE "Employees" (
    "Employee_Id" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(100)   NOT NULL,
    "last_name" varchar(100)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_data" date   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Employee_Id"
     )
);

CREATE TABLE "Department" (
    "Department_Id" varchar(4)   NOT NULL,
    "department_name" varchar(100)   NOT NULL,
    CONSTRAINT "pk_Department" PRIMARY KEY (
        "Department_Id"
     )
);

CREATE TABLE "Department_Employees" (
    "Employee_Id" int   NOT NULL,
    "Department_Id" varchar(4)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Department_Manager" (
    "Department_Id" varchar(4)   NOT NULL,
	"Employee_Id" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Salaries" (
    "Employee_Id" int   NOT NULL,
    "Salary" money   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "Titles" (
    "Employee_Id" int   NOT NULL,
    "title" varchar(100)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_Employee_Id" FOREIGN KEY("Employee_Id")
REFERENCES "Employees" ("Employee_Id");

ALTER TABLE "Department_Employees" ADD CONSTRAINT "fk_Department_Employees_Department_Id" FOREIGN KEY("Department_Id")
REFERENCES "Department" ("Department_Id");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_Employee_Id" FOREIGN KEY("Employee_Id")
REFERENCES "Employees" ("Employee_Id");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_Department_Id" FOREIGN KEY("Department_Id")
REFERENCES "Department" ("Department_Id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Employee_Id" FOREIGN KEY("Employee_Id")
REFERENCES "Employees" ("Employee_Id");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_Employee_Id" FOREIGN KEY("Employee_Id")
REFERENCES "Employees" ("Employee_Id");

-- Import data and selecting data to check

SELECT * FROM "Employees";
SELECT * FROM "Department";
SELECT * FROM "Department_Employees";
SELECT * FROM "Department_Manager";
SELECT * FROM "Salaries";
SELECT * FROM "Titles";

-- Data Analysis
--List the following details of each employee: employee number, last name, first name, gender and salary



--List employees who were hired in 1986

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment date

--List the department of each employee with the following information: employee number, last name, first name, and department name

--List all employees whose first name is "Hercules" and last names begin with "B"

--List all employees in the Sales department, including their employee number, last name, first name, and department name

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name

