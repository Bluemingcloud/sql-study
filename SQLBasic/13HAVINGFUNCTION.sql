-- HAVING 절
-- GROUP 의 조건
SELECT   DEPARTMENT_ID,
         SUM(SALARY),
         COUNT(*)
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING   SUM(SALARY) >= 50000 OR COUNT(*) >= 5;

SELECT   JOB_ID,
         ROUND(AVG(SALARY), 2)
FROM     EMPLOYEES
WHERE    JOB_ID NOT LIKE 'SA%'
GROUP BY JOB_ID
HAVING   AVG(SALARY) > 8000
ORDER BY AVG(SALARY);

SELECT   DEPARTMENT_ID,
         JOB_ID,
         ROUND(AVG(SALARY), 2) AS 급여평균,
         COUNT(*) AS 사원수,
         COUNT(COMMISSION_PCT) AS 커미션인원,
         RANK() OVER(ORDER BY(AVG(SALARY)) DESC) AS 급여평균직업순위
FROM     EMPLOYEES
WHERE    JOB_ID NOT LIKE '%MAN%'
GROUP BY DEPARTMENT_ID,
         JOB_ID
HAVING   AVG(SALARY) >= 5000
ORDER BY AVG(SALARY) DESC;

-- 부서아이디가 NULL 이 아닌 데이터중에서
-- 입사일 05년도인 사람들의 급여평균, 급여합
-- 평균급여는 5000 이상인 데이터만, 부서아이디로 내림차순
SELECT   DEPARTMENT_ID,
         ROUND(AVG(SALARY), 2) AS 급여평균,
         SUM(SALARY) AS 급여합
FROM     EMPLOYEES
WHERE    DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY DEPARTMENT_ID
HAVING   AVG(SALARY) >= 5000
ORDER BY DEPARTMENT_ID DESC;


         