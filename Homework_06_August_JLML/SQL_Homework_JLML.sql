-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT * FROM departments; 
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.first_name,  employees.last_name, employees.gender, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no= salaries.emp_no;

-- 2. List employees who were hired in 1986
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1987-01-01';

-- 3. List the manager of each department with the following information: department number, department name,
--    the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_manager.dept_no,
depts.dept_name,
dept_manager.emp_no, 
employees.last_name, 
employees.first_name, 
dept_manager.from_date,
dept_manager.to_date
FROM "departments" AS depts
LEFT JOIN dept_manager
ON depts.dept_no = dept_manager.dept_no
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- 4. List the department of each employee with the following information: employee number, last name, 
--    first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, depts.dept_name
FROM "departments" AS depts
LEFT JOIN dept_emp
ON depts.dept_no = dept_emp.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT *
FROM employees
WHERE first_name= 'Hercules' and last_name LIKE 'B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, depts.dept_name
FROM "departments" AS depts
LEFT JOIN dept_emp
ON depts.dept_no = dept_emp.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE depts.dept_name = 'Sales';

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, 
--    first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, depts.dept_name
FROM "departments" AS depts
LEFT JOIN dept_emp
ON depts.dept_no = dept_emp.dept_no
LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE depts.dept_name IN ('Sales', 'Development');

-- 8. In descending order, list the frequency count of employee last names, i.e., 
--    how many employees share each last name.
SELECT last_name, COUNT(emp_no) AS cuenta FROM employees
GROUP BY last_name
ORDER BY "cuenta" DESC
LIMIT 5;





