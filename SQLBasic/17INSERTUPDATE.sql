-- INSERT
-- TABLE �� ������ �߰�
-- TABLE ������ ������ Ȯ���ϴ� ���
DESC DEPARTMENTS;

-- ù��° ���
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);
SELECT * FROM DEPARTMENTS;

-- DML ���� Ʈ������� �׻� ��ϵȴ�. 
-- ���� TABLE �� ����� ���� �ƴϱ� ������ �ǵ����Ⱑ �����ϴ�.
ROLLBACK;

-- �ι�° ���
-- COLUMN �� �� ��������
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'Developer', 1700);
SELECT * FROM DEPARTMENTS;

-- INSERT ������ ���������� �˴ϴ�
-- INSERT �������� (������)
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME) VALUES(
    (SELECT MAX(DEPARTMENT_ID) + 10 FROM DEPARTMENTS), 'Developer');
SELECT * FROM DEPARTMENTS;

-- INSERT �������� (������)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- TABLE ���� ����
SELECT * FROM EMPS; -- �� ���̺�. �������̺��� Ư�� �����͸� �۴� ���󺸱�

DESC EMPS;
INSERT INTO EMPS(EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');

COMMIT; -- Ʈ������� �ݿ���. ������ ����

--------------------------------------------------------------------------------
-- UPDATE
SELECT * FROM EMPS;

-- UPDATE ������ ����ϱ� ������ SELECT �� �ش� ���� ������ ������ Ȯ���ϰ�, ������Ʈ ó���ؾ��մϴ�.
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;
UPDATE EMPS SET SALARY = 1000, COMMISSION_PCT = 0.1
WHERE EMPLOYEE_ID = 148; -- KEY �� ���ǿ� ���°� �Ϲ����Դϴ�.

UPDATE EMPS SET SALARY = NVL(SALARY, 0) + 1000 WHERE EMPLOYEE_ID >= 145;

-- UPDATE ������ ����������
-- ù��° (������)
SELECT * FROM EMPS;
UPDATE EMPS SET SALARY = (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100) WHERE EMPLOYEE_ID = 148;
SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;
ROLLBACK;

-- �ι�° (������)
UPDATE EMPS
SET (SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) 
= (SELECT SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100)
WHERE EMPLOYEE_ID = 148;
SELECT * FROM EMPS;

-- ����° (WHERE ������ ���)
SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
UPDATE EMPS
SET SALARY = 1000
WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
--------------------------------------------------------------------------------
-- DELETE
-- Ʈ������� �ֱ� ������, �����ϱ� ���� �ݵ�� SELECT������ ���� ���ǿ� �ش��ϴ� �����͸� Ȯ���ϴ� ������ ������!
SELECT * FROM EMPS WHERE EMPLOYEE_ID = 148;

DELETE FROM EMPS WHERE EMPLOYEE_ID = 148; -- KEY�� ���ؼ� ����� ���� ����.
SELECT * FROM EMPS;
ROLLBACK;

-- DELETE ���� �������� ��� ����
DELETE FROM EMPS WHERE EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);
SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

-- DELETE ���� ���� ����Ǵ� ���� �ƴϴ�
-- ���̺��� ��������(FK) ������ ������ �ִٸ�, �������� �ʴ´�. (�������Ἲ ����)
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;

DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 100; -- EMPLOYEES ���̺��� ������� Ű��

--------------------------------------------------------------------------------
-- MERGE
-- Ÿ�����̺� �����Ͱ� ������ UPDATE, ������ INSERT ������ �����ϴ� ����

-- ù��° ���
SELECT * FROM EMPS;

MERGE INTO EMPS A -- Ÿ�����̺�
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG') B -- ��ĥ���̺�
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID) -- ������ Ű
WHEN MATCHED THEN -- ��ġ�ϴ� ���
    UPDATE SET A.SALARY = B.SALARY,
               A.COMMISSION_PCT = B.COMMISSION_PCT,
               A.HIRE_DATE = SYSDATE 
               -- ... ����
WHEN NOT MATCHED THEN -- ��ġ���� �ʴ� ���
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID) 
    VALUES (B.EMPLOYEE_ID, B.LAST_NAME, B.EMAIL, B.HIRE_DATE, B.JOB_ID);
ROLLBACK;
SELECT * FROM EMPS;

-- �ι�° ���
-- ������������ �ٸ����̺��� �������°� �ƴ϶�, DUAL�� ����� ���� ���� ���� �� �ִ�.
MERGE INTO EMPS A
USING DUAL
ON (A.EMPLOYEE_ID = 107) -- ����
WHEN MATCHED THEN -- ��ġ�ϸ�
    UPDATE SET A.SALARY = 10000,
               A.COMMISSION_PCT = 0.1,
               A.DEPARTMENT_ID = 100
WHEN NOT MATCHED THEN -- ��ġ���� ������
    INSERT (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES (107, 'HONG', 'EXAMPLE', SYSDATE, 'DBA');

ROLLBACK;
SELECT * FROM EMPS;
--------------------------------------------------------------------------------
DROP TABLE EMPS; -- TABLE ����

-- CTAS 
-- ���̺� ���� ����
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES); -- �����ͱ��� ����
SELECT * FROM EMPS;

CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1 = 2); -- ������ ����
