
SELECT * FROM employees;

-- SQL에서 제일 먼저 실행되는 건 FROM절이다.(from > where > select) 그래서 먼저 써주는 것도 자동완성에 좋음.
-- WHERE절 사용해서 비교 (데이터 값은 대,소문자를 구분한다.) 필터 같은 느낌
SELECT 
	first_name, last_name, job_id
FROM employees
WHERE job_id = 'IT_PROG';


--
SELECT
	*
FROM employees
WHERE last_name = 'King';


--AND 는 둘 다 조건을 만족해야 true
SELECT
	*
FROM employees
WHERE salary >= 15000
AND salary < 20000;


--
SELECT
	*
FROM employees
WHERE hire_date = '1994-08-17'; -- 날짜는 ISO 형식(하이픈 연결)


-- 데이터의 행 제한 (BETWEEN, IN, LIKE)
SELECT
	*
FROM
	employees
WHERE salary BETWEEN 15000 AND 20000;


-- 날짜도BETWEEN 연산 가능!
SELECT
	*
FROM
	employees
WHERE hire_date BETWEEN '1990-01-01' AND '1992-12-31';


-- IN 연산자 (특정 값들과 비교할 때 사용 - 둘중 하나라도 만족하느냐)
SELECT
	*
FROM employees
WHERE job_id IN('IT_PROG', 'AD_VP');



SELECT
	*
FROM employees
WHERE manager_id IN(101,102,103);


-- LIKE dustks (지정 문자열 포함 여부)
-- 앞에 W 포함
SELECT 
	first_name, last_name, hire_date
FROM employees
WHERE first_name LIKE 'W%';

-- 뒤에 t 포함
SELECT 
	first_name, last_name, hire_date
FROM employees
WHERE first_name LIKE '%t';

-- 아무데나 t포함 - 앞 뒤로 %
SELECT 
	first_name, last_name, hire_date
FROM employees
WHERE first_name LIKE '%t%';

-- 날짜 타입에서 LIKE 사용 시에는 날짜타입을 문자열로 변경하는 TO_CHAR 사용
-- TO_CHAR(날짜컬럼, 형태)
SELECT 
	first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YY-DD-MM') LIKE '94%';

-- PostgreSQL 스타
SELECT 
	first_name, last_name, hire_date
FROM employees
WHERE hire_date::TEXT LIKE '1994%';


-- IS NULL
SELECT
	*
FROM employees
WHERE commission_pct = IS NULL;

SELECT
	*
FROM employees
WHERE commission_pct = IS NOT NULL;


-- AND가 OR보다 연 순서가 빠르다.
SELECT
	*
FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;


-- 연산의 순서를 위로 끌어올릴 때 소괄호를 사용
-- 이런 사소한 차이가 조회의 결과를 바꿔준다.
SELECT
	*
FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')	-- && || 자바에서 이런 기호랑 똑같음
AND salary >= 6000;

-- 데이터의 정렬 (SELECT 구문의 가장 마지막에 배치, 실행도 가장 마지막에 실행)
--ASC : 오름차 ( 안 써도 기본적용 오름차이다)
SELECT
	*
FROM employees
ORDER BY hire_date;	-- 오름차(ASC 어센딩) | 내림차(DESC) 디센딩

--
SELECT
	*
FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name DESC;	-- 맨마지막에 작성하고 실제로 실행도 맨 마지막에 된다.

--
SELECT
	first_name,
	salary * 12 AS 연봉
FROM employees
ORDER BY first_name DESC;










