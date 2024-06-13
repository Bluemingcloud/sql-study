-- �׷� �Լ�
SELECT  MAX(SALARY),
        MIN(SALARY),
        SUM(SALARY),
        AVG(SALARY),
        COUNT(SALARY)
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';

-- MIN, MAX �� ��¥�� ���ڿ��� ����˴ϴ�.
SELECT  MIN(HIRE_DATE),
        MAX(HIRE_DATE),
        MIN(FIRST_NAME),
        MAX(LAST_NAME)
FROM EMPLOYEES;

-- COUNT �ΰ��� �����
SELECT  COUNT(*),               -- ��ü �� ��
        COUNT(COMMISSION_PCT),   -- COMMISSION_PCT �� NULL �� �ƴ� ���� �� ��
        COUNT(DISTINCT DEPARTMENT_ID)
FROM EMPLOYEES;
-- �������� ���� ��� ����
SELECT MAX(COMMISSION_PCT) FROM EMPLOYEES WHERE DEPARTMENT_ID = 80;

-- �׷� �Լ��� �Ϲ� COLUMN �̶� ���� ��� �Ұ�
SELECT  FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;
-- �׷� �Լ� �ڿ� OVER() �� ���̸�, ��ü �࿡ �ش� ���� ��ȯ�Ͽ� �Ϲ� COLUMN �� ���� ��� ����
SELECT  FIRST_NAME, 
        AVG(SALARY) OVER(), 
        COUNT(*)    OVER(), 
        SUM(SALARY) OVER() 
FROM EMPLOYEES;

-----------------------------------------------------------------------
-- GROUP BY
-- �׷� ���� �׷��Լ� ���. WHERE ���� ORDER �� ���̿� �����ϴ�.
-- �Ϲ� COLUMN �� GROUP BY ���� ���� �͸� ���� ��� ����
SELECT   DEPARTMENT_ID,
         SUM(SALARY),
         AVG(SALARY),
         MIN(SALARY),
         MAX(SALARY),
         COUNT(*)
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- GROUP ȭ ��Ų COLUMN �� ������ ���� �� �ֽ��ϴ�.
SELECT   DEPARTMENT_ID,
         FIRST_NAME
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID; -- ����

-- GROUP BY ���� 2�� �̻� ��ø����
SELECT   DEPARTMENT_ID,
         JOB_ID,
         TO_CHAR(SUM(SALARY) * 1300, 'L999,999,999')  AS �μ�_����_�޿���,
         TO_CHAR(ROUND(AVG(SALARY * 1300), -1), 'L999,999,999') AS �μ�_����_��ձ޿�,
         TO_CHAR(MAX(SALARY * 1300), 'L999,999,999') AS �μ�_����_�ִ�޿�,
         TO_CHAR(MIN(SALARY * 1300), 'L999,999,999') AS �μ�_����_�ּұ޿�,
         CONCAT(COUNT(*), '��') AS �μ�_����_�ο���,
         COUNT(*) OVER() AS ��ü���,
         RANK() OVER(ORDER BY AVG(SALARY) DESC) AS ��ձ޿����� -- RANK ���� OVER ���Ŀ� �׷��Լ� ��� ����
FROM     EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID -- �μ� ID �� ���� JOB_ID �� �׷��Լ� ��� �� ��ȯ
ORDER BY �μ�_����_��ձ޿� DESC; -- ORDER ���� �׷� �Լ� ��� ����

-- �׷� �Լ� ���� (SUM, MAX ��) �� WHERE ���� ��� �Ұ�
-- WHERE ���� �׷�ȭ ��Ű�� ���� ������ ���� ���̴�.
-- GROUP �Լ��� ������ HAVING �� ���� ���.
SELECT   DEPARTMENT_ID, 
         SUM(SALARY),
         AVG(SALARY)
FROM     EMPLOYEES 
WHERE    AVG(SALARY) > 5000 -- ���� �߻�
GROUP BY DEPARTMENT_ID;