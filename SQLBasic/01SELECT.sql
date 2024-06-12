SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM JOBS;

-- Ư�� �÷��� ��ȸ�ϱ�
-- ���ڿ� ��¥�� ���ʿ�, ���ڴ� �����ʿ� ǥ�õ˴ϴ�.
SELECT FIRST_NAME, HIRE_DATE, EMAIL, SALARY FROM EMPLOYEES;

-- �÷��� �ڸ������� ���� �Ǵ� ��¥�� ������ �˴ϴ�.
SELECT FIRST_NAME, SALARY, SALARY + SALARY * 0.1 FROM EMPLOYEES;

-- �÷� �̸��� ������ �� �ֽ��ϴ�.
-- ��Ī
-- AS �� ������ ���������� ǥ���ϴ� ���� ��õ
-- "" �ε� ǥ���� �� ������ ��õ���� �ʴ´�.
SELECT FIRST_NAME AS �̸�, SALARY AS �޿�, SALARY + SALARY * 0.1 "�����޿�" FROM EMPLOYEES;

-- NULL ǥ�� Ȯ��
-- PK �� EMPLOYEE_ID, FK �� DEPARTMENT_ID
SELECT * FROM EMPLOYEES;

-- ���ڿ��� ǥ��
-- ���ڿ� ���� ||, ���ڿ� �߰� '', ���ڿ� �ȿ� ' ����� '' �Է�
SELECT 'HELLO' || ' WORLD' FROM EMPLOYEES;
SELECT FIRST_NAME || '���� �޿��� ' || SALARY || '$ �Դϴ�' AS �޿� FROM EMPLOYEES;

-- DISTINCT �ߺ����� Ű����
-- SELECT ������ �ٴ´�.
SELECT DEPARTMENT_ID FROM EMPLOYEES;
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;

-- ROWID ���ڵ尡 ����� ��ġ ����
-- ROWNUM ��ȸ�� ����
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID FROM EMPLOYEES;
SELECT EMPLOYEE_ID, FIRST_NAME, ROWNUM FROM EMPLOYEES;
