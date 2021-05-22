SELECT st.name, st.surname
FROM students st
WHERE score BETWEEN
4 AND 5;

SELECT st.name, st.surname
FROM students st
WHERE score >= 4 AND score <=5;

SELECT *
FROM students st
WHERE groupstud::varchar(500) like '2255';

SELECT *
FROM students st
ORDER BY groupstud ASC, name ASC;

SELECT *
FROM students st
WHERE score >= 4
ORDER BY score DESC;

SELECT ho.name, ho.risk
FROM hobby ho
WHERE name like 'Football' or name like 'Hockey';

SELECT st.id, ho.id
FROM students st, hobby ho
WHERE st.name like 'ivan';

SELECT sth.students_id, sth.hobby_id
FROM stud_hobby sth
WHERE datestart BETWEEN '01.01.2021'::DATE AND '02.15.2021'::DATE AND datefinish isNULL;

SELECT *
FROM students
WHERE score >= 4.5
ORDER BY score DESC
LIMIT 3

SELECT *
FROM hobby ho
ORDER BY risk Desc
LIMIT 3;