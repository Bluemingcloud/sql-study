-- VIEW
-- ��� �������� �����͸� ���� ���� ���ؼ� �̸� ������ �������̺� �Դϴ�.
-- ���� ���Ǵ� �÷��� �����ϸ�, ������ �����մϴ�.
-- ��� ���������� �����Ͱ� ����� ���� �ƴϰ�, �������̺��� ������� �� �������̺� �̶�� �����ϸ� �˴ϴ�.

SELECT * FROM EMP_DETAILS_VIEW; -- �̸� ������� �ִ� ��
SELECT * FROM USER_SYS_PRIVS; -- ������ ���� Ȯ��

-- �ܼ� VIEW 
-- �ϳ��� ���̺�� ������ ��
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID AS EMP_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           JOB_ID,
           SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 60
);

SELECT * FROM VIEW_EMP;

-- ���� VIEW
-- �ΰ� �̻��� ���̺�� ������ ��
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT E.EMPLOYEE_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           J.JOB_TITLE,
           D.DEPARTMENT_NAME    
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
);

-- �並 �̿��ϸ� �����͸� �ս��� ��ȸ�� �� ����.
SELECT JOB_TITLE, COUNT(*) AS ����� 
FROM VIEW_EMP_JOB
GROUP BY JOB_TITLE;

-- ���� ����
-- OR REPLACE
CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS (
    SELECT E.EMPLOYEE_ID,
           FIRST_NAME || ' ' || LAST_NAME AS NAME,
           J.JOB_TITLE,
           J.MAX_SALARY, -- ����
           J.MIN_SALARY,
           D.DEPARTMENT_NAME    
    FROM EMPLOYEES E
    JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
);

SELECT * FROM VIEW_EMP_JOB;

-- ���� ����
-- DROP VIEW
DROP VIEW VIEW_EMP_JOB;

-- �ܼ� ��� �並 ���ؼ� INSERT, UPDATE�� �����ѵ�, ������׵��� �ֽ��ϴ�.
-- ���� ��� INSERT, UPDATE �Ұ�
SELECT * FROM VIEW_EMP;
-- ���� COLUMN�� ��� INSERT �� ��� �Ұ� (EMP_ID, NAME COLUMN)
INSERT INTO VIEW_EMP VALUES(108, 'HONG', 'IT_PROG', 10000); -- virtual column not allowed here
-- ���� ���̺��� NOT NULL ���࿡ ����Ǳ� ������ INSERT �Ұ�
INSERT INTO VIEW_EMP(JOB_ID, SALARY) VALUES ('IT_PROG', 10000); -- cannot insert NULL into ...

-- VIEW �� �ɼ�
-- WITH CHECK OPTION (WHERE ���� �ִ� �÷��� ������ ����)
-- WITH READ ONLY (SELECT �� ���)
CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID,
           FIRST_NAME,
           EMAIL,
           JOB_ID,
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60, 70, 80)
) WITH READ ONLY;

UPDATE VIEW_EMP SET DEPARTMENT_ID = 10 WHERE EMPLOYEE_ID = 103; -- cannot perform a DML operation on a read-only view

CREATE OR REPLACE VIEW VIEW_EMP
AS (
    SELECT EMPLOYEE_ID,
           FIRST_NAME,
           EMAIL,
           JOB_ID,
           DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60, 70, 80)
) WITH CHECK OPTION;
UPDATE VIEW_EMP SET DEPARTMENT_ID = 10 WHERE EMPLOYEE_ID = 103; -- view WITH CHECK OPTION where-clause violation
--------------------------------------------------------------------------------
-- FROM ���� ����ϴ� ������ �ζ��� ��� ��� ���� ���̺��� �� �̴�.