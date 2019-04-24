
--//////////////////////////////////  SELECTING DATA  //////////////////////////////////////

--Employess who are Technicians AND Female
SELECT * FROM HumanResources.Employee 
WHERE
JobTitle  like '%Technician%' AND Gender = 'F'
GO

--Employess who are Sales Reps AND Born in 1968
SELECT * FROM HumanResources.Employee 
WHERE
JobTitle  like '%Sales Rep%' AND Year(BirthDate) = 1968

--Employees born in the first quarter of the year AND born between 1950 and 160 AND have more than 50 sickleavehours
SELECT * FROM HumanResources.Employee
	WHERE MONTH(BirthDate) BETWEEN 1 AND 3
INTERSECT
SELECT * FROM HumanResources.Employee
	WHERE YEAR(BirthDate) BETWEEN '1950' AND '1960'
INTERSECT
SELECT * FROM HumanResources.Employee
	WHERE SickLeaveHours > 50

