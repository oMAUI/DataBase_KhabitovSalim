#1
SELECT st.name, st.surname, hb.name
FROM students st, hobby hb, stud_hobby sh
WHERE sh.students_id = st.id AND sh.hobby_id = hb.id

#2
SELECT st.name, st.surname, sh.datestart
FROM students st, stud_hobby sh
WHERE st.id = sh.students_id AND sh.datefinish IS NULL
ORDER BY sh.datestart
LIMIT 1

3
SELECT DISTINCT st.score, st.name, st.surname, st.databirth
FROM students st
INNER JOIN
(
SELECT SUM(hb.risk) as st.r_summ, sh.students_id
FROM hobby hb,
stud_hobby sh
WHERE hb.id= sh.hobby_id AND sh.datefinish IS NULL
GROUP BY sh.students_id
)
ON st.id = st.students_id
AND st.r_summ > 9
WHERE st.score >
(
SELECT AVG(score)::numeric(3,2)
FROM students
)

#4
SELECT st.name, st.surname, st.groupstud, st.databirth, tt.monthes, tt.name
FROM students st
INNER JOIN
(SELECT (to_char(sh.datefinish, 'MM')::numeric(10,0) + to_char(sh.datefinish, 'YYYY')::numeric(10,0) * 12) - (to_char(sh.datefinish, 'MM')::numeric(10,0) + to_char(sh.datestart, 'YYYY')::numeric(10,0) * 12) as monthes, sh.students_id, hb.name
FROM stud_hobby sh, hobby hb
WHERE hb.id = sh.id) tt
ON tt.students_id = st.id

#5
SELECT st.name, st.surname, st.groupstud, st.databirth
FROM students st
INNER JOIN
(SELECT count(sh.hobby_id), sh.students_id
FROM stud_hobby sh, hobby hb
WHERE hb.id = sh.hobby_id
GROUP BY sh.students_id
HAVING count(sh.hobby_id) > 1) tt
ON tt.students_id = st.id
WHERE 3 = ((to_char('2024-03-19'::date, 'YYYY')::int * 12 * 30 + to_char('2024-03-19'::date, 'MM')::int * 30 + to_char('2024-03-19'::date, 'DD')::int) - (to_char(st.databirth, 'YYYY')::int * 12 * 30 + to_char(st.databirth, 'MM')::int * 30 + to_char(st.databirth, 'DD')::int))/ 30 / 12

#6
SELECT DISTINCT st.groupstud, avg(st.score)::numeric(3,2)
FROM students st
INNER JOIN(SELECT DISTINCT sh.students_id
FROM stud_hobby sh, hobby hb
WHERE sh.hobby_id = hb.id AND sh.datefinish IS NULL) tt
ON tt.students_id = st.id
GROUP BY st.groupstud

#7
SELECT hb.name, hb.risk, -1 * (to_char(tt.dlit, 'YYYY')::numeric(5,0) * 12 + to_char(tt.dlit, 'MM')::numeric(5,0)) + (to_char(now(), 'YYYY')::numeric(5,0) * 12 + to_char(now(),'MM')::numeric(5,0))
FROM hobby hb
INNER JOIN(
SELECT sh.hobby_id, min(sh.datestart) as dlit, sh.students_id
FROM stud_hobby sh
GROUP BY sh.students_id, sh.hobby_id
HAVING sh.students_id = 3
LIMIT 1) tt
ON tt.hobby_id = hb.id

#8
SELECT hb.name
FROM students st
INNER JOIN stud_hobby sh on sh.students_id = st.id
INNER JOIN hobby hb on hb.id = sh.hobby_id
WHERE st.score = (SELECT max(st.score)
FROM students st)

#9
SELECT hb.name
FROM hobby hb
INNER JOIN stud_hobby sh on sh.hobby_id = hb.id AND sh.datefinish IS NULL
INNER JOIN students st on st.id = sh.students_id
WHERE SUBSTRING(st.groupstud::varchar, 1,1) = '2' AND st.score >= 3 AND st.score < 4

#10
SELECT SUBSTRING(st.groupstud::varchar,1,1) as course
FROM students st
INNER JOIN(SELECT SUBSTRING(st.groupstud::varchar,1,1) as course, count(st.id) as countofstd
FROM students st
INNER JOIN(SELECT sh.students_id, count(sh.hobby_id)
FROM stud_hobby sh
WHERE sh.datefinish IS NULL
GROUP BY sh.students_id
HAVING count(sh.students_id) > 1) tt
ON tt.students_id = st.id
GROUP BY SUBSTRING(st.groupstud::varchar,1,1)) ttend
ON SUBSTRING(st.groupstud::varchar,1,1) = ttend.course
INNER JOIN(SELECT SUBSTRING(st.groupstud::varchar,1,1) as course, count(st.id) as countofstd
FROM students st
GROUP BY SUBSTRING(st.groupstud::varchar,1,1)) ttnext
ON SUBSTRING(st.groupstud::varchar,1,1) = ttnext.course
WHERE ttnext.countofstd / 2 + ttnext.countofstd % 2 <= ttend.countofstd
GROUP BY SUBSTRING(st.groupstud::varchar,1,1)

#11
SELECT DISTINCT st.groupstud
FROM students st
INNER JOIN(SELECT st.groupstud, count(st.id) as countofstd, sum(st.score)
FROM students st
WHERE st.score >= 4
GROUP BY st.groupstud) tt
ON st.groupstud = tt.groupstud
INNER JOIN(SELECT st.groupstud, count(st.id) as countofstd
FROM students st
GROUP BY st.groupstud) ttt
ON st.groupstud = ttt.groupstud
WHERE ttt.countofstd / 100 * 60 <= ttt.countofstd

#12
SELECT count(sh.students_id), SUBSTRING(st.groupstud::varchar, 1,1)
FROM stud_hobby sh, students st
WHERE sh.datefinish IS NULL AND
 
sh.students_id = st.id
GROUP BY SUBSTRING(st.groupstud::varchar,1,1)

#13
SELECT st.id, st.name, st.surname, st.databirth, SUBSTRING(st.groupstud::varchar,1,1) as course
FROM students st
WHERE st.score = 5
EXCEPT SELECT DISTINCT stb.id, stb.name, stb.surname, stb.databirth, SUBSTRING(stb.groupstud::varchar,1,1) as course
FROM stud_hobby sh, students stb
WHERE stb.id = sh.students_id AND sh.datefinish IS NULL
ORDER BY course, databirth

#14

CREATE OR REPLACE VIEW Student_5yearhobby AS
SELECT st.*
FROM students st, stud_hobby sh
WHERE st.id = sh.students_id AND sh.datefinish IS NULL AND (to_char('2025-05-10'::date, 'YYYY')::int * 12 * 30 + to_char('2025-05-10'::date, 'MM')::int * 30 + to_char('2025-05-10'::date, 'DD')::int - to_char(sh.datestart, 'YYYY')::int * 12 * 30 + to_char(sh.datestart, 'MM')::int * 30 + to_char(sh.datestart, 'DD')::int) / 30 / 12 >= 5

#15

SELECT hb.name, tt.countOfHobby
FROM hobby hb
INNER JOIN
(SELECT count(sh.students_id) as countOfHobby, sh.hobby_id
FROM stud_hobby sh
WHERE sh.datefinish IS NULL
GROUP BY sh.hobby_id) tt
ON tt.hobby_id = hb.id

#16

SELECT hb.name
FROM hobby hb
INNER JOIN
(SELECT count(sh.students_id) as countOfHobby, sh.hobby_id
FROM stud_hobby sh
GROUP BY sh.hobby_id) tt
ON tt.hobby_id = hb.id
ORDER BY tt.countOfHobby DESC
LIMIT 1

#17

SELECT DISTINCT st.*
FROM students st, stud_hobby sh
INNER JOIN
(
SELECT hb.name, hb.id
FROM hobby hb
INNER JOIN
(SELECT count(sh.students_id) as countOfHobby, sh.hobby_id
FROM stud_hobby sh
GROUP BY sh.hobby_id) tt
ON tt.hobby_id = hb.id
ORDER BY tt.countOfHobby DESC
LIMIT 1
) tt
ON sh.hobby_id = tt.id
WHERE sh.students_id = st.id

#18

SELECT DISTINCT hb.id
FROM hobby hb
WHERE hb.risk = (SELECT max(risk)
FROM hobby)
LIMIT 3

#19

SELECT st.name,st.surname
FROM students st
INNER JOIN
(SELECT DISTINCT sh.students_id, extract(day from (justify_days(now() - sh.datestart))) as countOfHobby
FROM stud_hobby sh
WHERE sh.datefinish IS NULL
ORDER BY countOfHobby DESC) tt
ON tt.students_id = st.id
ORDER BY countOfHobby DESC LIMIT 10

#20

SELECT DISTINCT st.groupstud
FROM students st
INNER JOIN(
SELECT st.name,st.surname, st.id
FROM students st
INNER JOIN
(SELECT DISTINCT sh.students_id, extract(day from (justify_days(now() - sh.datestart))) as countOfHobby
FROM stud_hobby sh
WHERE sh.datefinish IS NULL
ORDER BY countOfHobby DESC) tt
ON tt.students_id = st.id
ORDER BY countOfHobby DESC LIMIT 10
) tt
ON tt.id = st.id

#21

CREATE OR REPLACE VIEW ST_score_down AS
SELECT st.id, st.name, st.surname
FROM students st
ORDER BY st.score DESC