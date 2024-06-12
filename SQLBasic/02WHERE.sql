-- WHERE 조건절
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David';
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID <> 90; -- <> 같지않다
SELECT * FROM EMPLOYEES WHERE HIRE_DATE = '06/03/07'; -- 날짜 비교도 문자열로
SELECT * FROM EMPLOYEES WHERE HIRE_DATE > '06/03/01'; -- 날짜도 대소비교 가능

-- BETWEEN AND 연산자
SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 5000 AND 10000;
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31';

-- IN 연산자
-- 정확히 일치하는 데이터를 나타내준다.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (50, 60, 70);
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'ST_MAN');

-- LIKE 연산자
-- 값을 포함하는 데이터를 나타내준다.
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '03%';  -- 03 으로 시작하는 데이터
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03';  -- 03 으로 끝나는 데이터
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%03%'; -- 03 이 포함된 데이터
SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN%';   -- MAN 이 포함된 데이터
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '_a%'; -- 두번째 글자가 a
SELECT * FROM EMPLOYEES WHERE EMAIL LIKE '___S%';    -- 네번째 글자가 S

-- IS NULL, IS NOT NULL : Null 값 찾기
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT = NULL;        -- 데이터 안나옴
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;       -- 보너스가 없는 사람
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;   -- 보너스가 있는 사람

-- AND, OR : AND 가 OR 보다 빠름
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'FI_MGR');
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR';
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR SALARY >= 5000; -- 다른 값도 가능
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' AND SALARY >= 5000;

SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR' AND SALARY >= 6000; -- AND 동작 후 OR 동작
SELECT * FROM EMPLOYEES WHERE (JOB_ID = 'IT_PROG' OR JOB_ID = 'FI_MGR') AND SALARY >= 6000; -- 소괄호 먼저 동작

-- NOT : 부정의 의미. 연산 키워드와 같이 사용됨
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID NOT IN (50, 60); -- 부서 ID 가 50, 60 이 아닌 사람
SELECT * FROM EMPLOYEES WHERE JOB_ID NOT LIKE '%MAN%'; -- 직업명에 MAN 이 포함되지 않은 사람
SELECT * FROM EMPLOYEES WHERE SALARY NOT BETWEEN 5000 AND 10000;
