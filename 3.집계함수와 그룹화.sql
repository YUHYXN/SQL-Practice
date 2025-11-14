

-- 집계 함수 (aggregate finction)
-- AVG, MAX, MiN, SUM, COUNT
-- 여러행을 묶어서 한 번에 함수를 적용
-- 그룹화를 따로 하지 않는다면 그룹은 테이블 전체가 된다.
SELECT
	AVG(salary),
	MAX(salary),
	MIN(salary),
	SUM(salary),
	COUNT(salary)
FROM employees;

-- 모든 컬럼의 카운트를 세어줘
SELECT count(*) FROM employees;	-- 총 행의 데이터
SELECT count(first_name) FROM employees;
SELECT count(commission_pct) FROM employees; -- null이 아닌 행의 수
SELECT count(manager_id) FROM employees; -- null은 카운팅 되지않습니다.


SELECT * FROM employees;

-- 그룹화된 곳 안에서 id,avg,count를 확인하겠다.
-- 부서별
SELECT 
	department_id,
	AVG(salary),
	count(*)
FROM employees
GROUP BY department_id;


-- 집계함수는 단독적으로 사용할 때는 테이블 전체가 그룹의 대상이 되지만,
-- 일반 컬럼과 동시에 출력할 순 없다. 반드시 일반 컬럼을 그룹화 해야한다.
SELECT 
	department_id,
	AVG(salary),
	count(*)
FROM employees; -- 에러


-- GROUP BY절을 사용할 때, GROUP절에 묶이지 않은 컬럼은 조회할 수 없다.
SELECT 
	job_id,
	department_id,
	AVG(salary),
	count(*)
FROM employees
GROUP BY department_id;	-- 에


-- GROUP BY절의 사용된 컬럼 외에는 조회가 불가능하다.
-- GROUP BY절 2개 이상 사용.
SELECT 
	job_id,
	department_id,
	AVG(salary),
	count(*)
FROM employees
GROUP BY department_id, job_id;;	-- job_id도 추가를 해줘야한다.	


SELECT
	department_id,
	SUM(salary),
	AVG(salary)
FROM employees
WHERE SUM(salary) > 100000	-- 안됨 그룹화의 조건이 안됨
GROUP BY department_id;

-- group by를 통해서 그룹화 할 때, 조건을 지정할 경우 HAVING을 사용하는 것이다.
-- 참고로 WHERE은 일반조건이다.
SELECT
	department_id,
	SUM(salary),
	AVG(salary)
FROM employees
GROUP BY department_id
HAVING SUM(salary) > 100000;


-- 부서 아이디가 50 이상인 사원을 그룹화 시키고,
-- 그룹 급여 평균이 5000 이상만 조회.
-- SQL 실행 순서 : from > where > group by > having > select > order by *******************************
SELECT 
	department_id,
	SUM(salary),
	AVG(salary) AS 평균급여
FROM employees
WHERE department_id >= 50	-- 그룹화 이전의 일반조건
GROUP BY department_id
HAVING AVG(salary) > 5000	-- 그룹화의 조건
ORDER BY 평균급여 DESC;

/*
 	사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
	department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
	조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
	조건 2) 평균은 소수 2째 자리에서 절사 하세요.
	
 */
select
	department_id,
	TRUNC(AVG(salary + salary*commission_pct), 2) AS avg_saraly,	-- 소수점으로 나눌 값, 소수점 몇에서 자를지 자릿수
	SUM(salary + salary*commission_pct) AS total,
	COUNT(*)
FROM employees
WHERE commission_pct IS NOT NULL -- null이 아닌 
GROUP BY department_id;









