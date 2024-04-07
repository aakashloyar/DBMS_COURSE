-- 1- a
select I.ID,I.name,count(Distinct TS.course_id) most_no_of_distinct_course
from teaches TS
JOIN 
Instructor I on I.id=TS.ID 
group by I.ID
order by most_no_of_distinct_course desc
limit 3

-- 1- b
select I.ID,I.name,count(Distinct TS.course_id) most_no_of_distinct_course
from teaches TS
JOIN 
Instructor I on I.id=TS.ID 
JOIN 
course C on C.course_id=TS.course_id
where I.dept_name='Statistics'
group by I.ID
order by most_no_of_distinct_course desc
limit 3


--2
select I.id,I.name,I.salary,I.dept_name,C.course_ID,C.course_id, C.title,S.sec_id,TS.semester,TS.year,COUNT(Distinct T.id) Total_enrollment
from instructor I
JOIN Teaches TS ON  TS.id=I.id
JOIN Course C ON C.course_id=TS.course_id
JOIN Takes T ON C.course_id=T.course_id
JOIN Section S ON  S.sec_id=TS.sec_id
where I.id in (
	select I.id
	from Instructor I
	order by I.salary desc
	limit 1
)
group by I.id,I.name,I.salary,I.dept_name,C.course_ID,C.course_id, C.title,S.sec_id,TS.semester,TS.year
order by C.course_id asc,TS.year asc,TS.semester asc;


--3
SELECT SEC.course_id,C.title,C.dept_name,I.name,COUNT(DISTINCT T.ID) AS Total_Number_of_Registered_Students,SEC.sec_id,SEC.semester,SEC.year,SEC.time_slot_id
FROM section SEC
JOIN
    teaches TS ON SEC.course_id = TS.course_id
    AND SEC.sec_id = TS.sec_id
    AND SEC.semester = TS.semester
    AND SEC.year = TS.year
JOIN
    takes T ON SEC.course_id = T.course_id
    AND SEC.sec_id = T.sec_id
    AND SEC.semester = T.semester
    AND SEC.year = T.year		
JOIN instructor I ON I.id=TS.id	
JOIN course C ON SEC.course_id = C.course_id
WHERE SEC.course_id = '362'
GROUP BY SEC.course_id,C.title,C.dept_name,I.name,SEC.sec_id,SEC.semester,SEC.year,SEC.time_slot_id
ORDER BY SEC.year desc;


-- 4
Select  Count(S.id) count_out_of_department_student_registration
from section SEC
JOIN 
    takes T ON SEC.course_id=T.course_id
	AND SEC.semester=T.semester
	AND SEC.year=T.year
	AND SEC.sec_id=T.sec_id
JOIN course C ON SEC.course_id = C.course_id	
JOIN student S ON T.ID = S.ID
where C.course_id='319' and SEC.year='2003' and C.dept_name!=S.dept_name;

--5
select S.id, S.name, S.dept_name,sum(C.credits) Total_no_of_credits
from takes T
JOIN student S ON S.id=T.id
JOIN course C ON C.course_id=T.course_id
group by S.id
order by Total_no_of_credits desc,name asc
limit 3;


--6
select Distinct C.course_id, C.title 
from course C
where C.course_id not in (
	select S.course_id
	from section S
	where year=2003 or year=2004
)
order by C.course_id asc;



--7
select TS.course_id,C.title,I.name,TS.year
from Teaches TS 
JOIN Instructor I ON I.id=TS.id
JOIN Course C ON C.course_id=TS.course_id
where TS.course_id not in 
(select TS.course_id
from Teaches TS
where TS.year!=(select MAX(TS.year)
from Teaches TS)
group by course_id
order by TS.course_id asc)
group by TS.course_id,C.title,I.name,TS.year
order by TS.course_id;

--8
select  C.course_id, C.title
from course C
where LENGTH(C.title) > 15 AND LOWER(C.title) LIKE '%sys%'
order by C.course_id asc;



--9
select dept_name, avg(salary) high_avg_salary
from instructor
group by dept_name
order by high_avg_salary desc
limit 1;


--10
select I.id, I.name,I.dept_name
from instructor I
where I.id in (
	select TS.id
	from Teaches TS
	where TS.year=2003
	group by TS.id
	HAVING
		COUNT(TS.course_id) = 1
) or I.id NOT in (
	select TS.id
	from Teaches TS
	where TS.year=2003
	group by TS.id
)
group by I.id
order by I.id asc;






