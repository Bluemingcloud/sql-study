-- DECODE 
-- IF ~ ELSE IF ~ ELSE �� ���� ���
SELECT DECODE('A', 'A', 'A�Դϴ�') AS RESULT1, -- IF ��
       DECODE('X', 'A', 'A�Դϴ�', 'A�� �ƴմϴ�') AS RESULT2, -- IF ELSE ��
       DECODE('C', 'A', 'A�Դϴ�'
                 , 'B', 'B�Դϴ�'
                 , 'C', 'C�Դϴ�'
                 , '��� �ƴմϴ�'
                 ) AS RESULT3 -- IF ELSE IF ELSE ��
FROM DUAL; 

SELECT * FROM EMPLOYEES;
SELECT JOB_ID, SALARY,
       DECODE(JOB_ID, 'IT_PROG', SALARY * 1.1
                    , 'AD_VP', SALARY * 1.2
                    , 'FI_MGR', SALARY * 1.3
                    , SALARY
                    ) AS �޿�
FROM EMPLOYEES;
 
-- CASE ~ WHEN ~ THEN ~ END
-- DECODE �� ���� ���
SELECT JOB_ID, SALARY,
       CASE JOB_ID WHEN 'IT_PROG'  THEN SALARY * 1.1
                   WHEN 'AD_VP'    THEN SALARY * 1.2
                   WHEN 'FI_MGR'   THEN SALARY * 1.3
                   ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;

SELECT JOB_ID, SALARY,
       CASE WHEN JOB_ID = 'IT_PROG' THEN SALARY * 1.1
            WHEN JOB_ID = 'AD_VP'   THEN SALARY * 1.2
            WHEN JOB_ID = 'FI_MGR'  THEN SALARY * 1.3
            ELSE SALARY
       END AS �޿�
FROM EMPLOYEES;
    