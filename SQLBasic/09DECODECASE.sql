-- DECODE 
-- IF ~ ELSE IF ~ ELSE 와 같은 기능
SELECT DECODE('A', 'A', 'A입니다') AS RESULT1, -- IF 문
       DECODE('X', 'A', 'A입니다', 'A가 아닙니다') AS RESULT2, -- IF ELSE 문
       DECODE('C', 'A', 'A입니다'
                 , 'B', 'B입니다'
                 , 'C', 'C입니다'
                 , '모두 아닙니다'
                 ) AS RESULT3 -- IF ELSE IF ELSE 문
FROM DUAL; 

SELECT * FROM EMPLOYEES;
SELECT JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                    , 'AD_VP', SALARY * 1.2
                    , 'FI_MGR', SALARY * 1.3
                    , SALARY
                    ) AS 급여
FROM EMPLOYEES;
 
-- CASE ~ WHEN ~ THEN ~ END
-- DECODE 와 같은 기능
SELECT JOB_ID, SALARY,
       CASE JOB_ID WHEN 'IT_PROG'  THEN SALARY * 1.1
                   WHEN 'AD_VP'    THEN SALARY * 1.2
                   WHEN 'FI_MGR'   THEN SALARY * 1.3
                   ELSE SALARY
       END AS 급여
FROM EMPLOYEES;

SELECT JOB_ID, SALARY,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.1
            WHEN JOB_ID = 'AD_VP'   THEN SALARY * 1.2
            WHEN JOB_ID = 'FI_MGR'  THEN SALARY * 1.3
            ELSE SALARY
       END AS 급여
FROM EMPLOYEES;
    