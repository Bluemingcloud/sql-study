--���� 1.
--DEPTS���̺��� �����͸� �����ؼ� �����ϼ���.
--DEPTS���̺��� ������ INSERT �ϼ���.
DROP TABLE DEPTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPTS;

INSERT INTO DEPTS VALUES(280, '����', NULL, 1800);
INSERT INTO DEPTS VALUES(290, 'ȸ���', NULL, 1800);
INSERT INTO DEPTS VALUES(300, '����', 301, 1800);
INSERT INTO DEPTS VALUES(310, '�λ�', 302, 1800);
INSERT INTO DEPTS VALUES(320, '����', 303, 1700);

--���� 2.
--DEPTS���̺��� �����͸� �����մϴ�
SELECT * FROM DEPTS;
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Support';
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT bank'
WHERE DEPARTMENT_NAME = 'IT Support';

--2. department_id�� 290�� �������� manager_id�� 301�� ����
SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 290;
UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
SELECT * FROM DEPTS WHERE DEPARTMENT_NAME = 'IT Helpdesk';
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT Help', MANAGER_ID = 303, LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';
SELECT * FROM DEPTS;

--4. 290, 300, 310, 320 �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���.
SELECT * FROM DEPTS;
SELECT * FROM DEPTS WHERE DEPARTMENT_ID IN(290, 300, 310, 320);
UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID IN(290, 300, 310, 320);

--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
SELECT * FROM DEPTS;
--1. �μ��� �����θ� ���� �ϼ���
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPTS WHERE DEPARTMENT_NAME = '����';
-- DEPARTMENT_ID = 320
SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 320;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 320;

--2. �μ��� NOC�� �����ϼ���
SELECT DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC';
-- DEPARTMENT_ID = 220
SELECT * FROM DEPTS WHERE DEPARTMENT_ID = 220;
DELETE FROM DEPTS WHERE DEPARTMENT_ID = 220;

--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� ������ ������.
SELECT * FROM DEPTS WHERE DEPARTMENT_ID > 200;
DELETE FROM DEPTS WHERE DEPARTMENT_ID > 200;
SELECT * FROM DEPTS;

--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
UPDATE DEPTS SET MANAGER_ID = 100 WHERE MANAGER_ID IS NOT NULL;
SELECT * FROM DEPTS;

--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�, �������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO DEPTS A
USING(SELECT * FROM DEPARTMENTS) B
ON (A.DEPARTMENT_ID = B.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET A.DEPARTMENT_NAME = B.DEPARTMENT_NAME,
               A.MANAGER_ID = B.MANAGER_ID,
               A.LOCATION_ID = B.LOCATION_ID    
WHEN NOT MATCHED THEN
    INSERT (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
    VALUES (B.DEPARTMENT_ID, B.DEPARTMENT_NAME, B.MANAGER_ID, B.LOCATION_ID);

SELECT * FROM DEPTS;

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
CREATE TABLE JOBS_IT AS(SELECT * FROM JOBS WHERE MIN_SALARY > 6000);
--2. jobs_it ���̺� �Ʒ� �����͸� �߰��ϼ���
INSERT INTO JOBS_IT VALUES('IT_DEV', '����Ƽ������', 6000, 20000);
INSERT INTO JOBS_IT VALUES('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
INSERT INTO JOBS_IT VALUES('SEC_DEV', '���Ȱ�����', 6000, 19000);
SELECT * FROM JOBS_IT;
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
MERGE INTO JOBS_IT A
USING(SELECT * FROM JOBS) B
ON (A.JOB_ID = B.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET A.MIN_SALARY = B.MIN_SALARY,
               A.MAX_SALARY = B.MAX_SALARY
           WHERE A.MIN_SALARY > 0
WHEN NOT MATCHED THEN
    INSERT (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
    VALUES (B.JOB_ID, B.JOB_TITLE, B.MIN_SALARY, B.MAX_SALARY);

SELECT * FROM JOBS_IT;

COMMIT;


