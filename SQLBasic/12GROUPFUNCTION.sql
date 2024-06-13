-- 그룹 함수
SELECT  MAX(SALARY),
        MIN(SALARY),
        SUM(SALARY),
        AVG(SALARY),
        COUNT(SALARY)
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';

-- MIN, MAX 는 날짜와 문자에도 적용됩니다.
SELECT  MIN(HIRE_DATE),
        MAX(HIRE_DATE),
        MIN(FIRST_NAME),
        MAX(LAST_NAME)
FROM EMPLOYEES;

-- COUNT 두가지 사용방법
SELECT  COUNT(*),               -- 전체 행 수
        COUNT(COMMISSION_PCT),   -- COMMISSION_PCT 중 NULL 이 아닌 값의 행 수
        COUNT(DISTINCT DEPARTMENT_ID)
FROM EMPLOYEES;
-- 조건절과 같이 사용 가능
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

-- 그룹 함수는 일반 COLUMN 이랑 같이 사용 불가
SELECT  FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;
-- 그룹 함수 뒤에 OVER() 를 붙이면, 전체 행에 해당 값을 반환하여 일반 COLUMN 과 같이 사용 가능
SELECT  FIRST_NAME, 
        AVG(SALARY) OVER(), 
        COUNT(*)    OVER(), 
        SUM(SALARY) OVER() 
FROM EMPLOYEES;

-----------------------------------------------------------------------
-- GROUP BY
-- 그룹 별로 그룹함수 사용. WHERE 절과 ORDER 절 사이에 적습니다.
-- 일반 COLUMN 은 GROUP BY 절에 쓰인 것만 같이 사용 가능
SELECT   DEPARTMENT_ID,
         SUM(SALARY),
         AVG(SALARY),
         MIN(SALARY),
         MAX(SALARY),
         COUNT(*)
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- GROUP 화 시킨 COLUMN 만 구문에 적을 수 있습니다.
SELECT   DEPARTMENT_ID,
         FIRST_NAME
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID; -- 에러

-- GROUP BY 절은 2개 이상 중첩가능
SELECT   DEPARTMENT_ID,
         JOB_ID,
         TO_CHAR(SUM(SALARY) * 1300, 'L999,999,999')  AS 부서_직무_급여합,
         TO_CHAR(ROUND(AVG(SALARY * 1300), -1), 'L999,999,999') AS 부서_직무_평균급여,
         TO_CHAR(MAX(SALARY * 1300), 'L999,999,999') AS 부서_직무_최대급여,
         TO_CHAR(MIN(SALARY * 1300), 'L999,999,999') AS 부서_직무_최소급여,
         CONCAT(COUNT(*), '명') AS 부서_직무_인원수,
         COUNT(*) OVER() AS 전체행수,
         RANK() OVER(ORDER BY AVG(SALARY) DESC) AS 평균급여순위 -- RANK 절의 OVER 정렬에 그룹함수 사용 가능
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID -- 부서 ID 별 같은 JOB_ID 의 그룹함수 결과 값 반환
ORDER BY 부서_직무_평균급여 DESC; -- ORDER 절은 그룹 함수 사용 가능

-- 그룹 함수 구문 (SUM, MAX 등) 은 WHERE 절에 사용 불가
-- WHERE 절은 그룹화 시키기 전의 조건을 적는 곳이다.
-- GROUP 함수의 조건은 HAVING 절 에서 사용.
SELECT   DEPARTMENT_ID, 
         SUM(SALARY),
         AVG(SALARY)
FROM     EMPLOYEES 
WHERE    AVG(SALARY) > 5000 -- 오류 발생
GROUP BY DEPARTMENT_ID;