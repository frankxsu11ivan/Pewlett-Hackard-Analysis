---Del 1
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
t.title, t.from_date, t.to_date 
INTO r_titles FROM employees AS e
INNER JOIN titles as t
ON e.emp_no = t.emp_no 

SELECT * FROM r_titles
where birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no

SELECT * FROM r_titles;

-- challenge starter code Use Dictinct with Orderby to remove duplicate rows
---unique_titles == u_titles
---retirement_titles == r_titles
DEL 1 export matches table in challenge.

---Step#8 Distinct On
SELECT DISTINCT ON (emp_no) emp_no,
first_name,last_name,title
INTO u_titles
FROM r_titles
ORDER BY emp_no, title DESC
;

SELECT * FROM u_titles;

-- Count number of employee by job titles who are retiring
SELECT COUNT (ut.emp_no), ut.title
INTO retiring_titles
FROM u_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

---Del 2 query to create a Mentorship Eligibility 
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date,
d_e.from_date, d_e.to_date,t.title
INTO mentorship_eligibility FROM employees AS e
INNER JOIN dept_emp as d_e ON (e.emp_no = d_e.emp_no)
INNER JOIN titles as t ON (e.emp_no = t.emp_no) 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (d_e.to_date = '9999-01-01');

SELECT * FROM mentorship_eligibility;

-- create table of CURRENT eligible employees , sorted by employee number and filtered by birthdate. 
SELECT DISTINCT ON (emp_no) emp_no,
first_name, last_name, from_date, to_date, title
INTO m_eligibilty
FROM mentorship_eligibility
ORDER BY emp_no ASC;

SELECT * FROM m_eligibilty;

-- Next generation employees counted by titles
SELECT COUNT (m_elig.emp_no), m_elig.title
INTO available_titles
FROM m_eligibilty as m_elig
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM available_titles;