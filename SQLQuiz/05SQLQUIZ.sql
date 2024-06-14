--���� 1.
--EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
--EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ� 
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��)
SELECT COUNT(*)
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
RIGHT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

SELECT COUNT(*)
FROM EMPLOYEES E
FULL JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 2.
--EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT 
    E.FIRST_NAME || LAST_NAME AS �̸�,
    D.DEPARTMENT_ID AS �μ�ID
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID = 200;

--���� 3.
--EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT * FROM EMPLOYEES;
SELECT * FROM JOBS;

SELECT 
    E.FIRST_NAME || E.LAST_NAME AS NAME,
    J.JOB_ID AS JOB_ID,
    J.JOB_TITLE AS JOB_TITLE
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOB_ID = J.JOB_ID
ORDER BY NAME;

--���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
SELECT * FROM JOB_HISTORY;

SELECT * 
FROM JOBS J
LEFT JOIN JOB_HISTORY H
ON J.JOB_ID = H.JOB_ID;


--���� 5.
--Steven King�� �μ����� ����ϼ���.
SELECT
    E.FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.FIRST_NAME || ' ' || E.LAST_NAME = 'Steven King';

--���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT * FROM EMPLOYEES E CROSS JOIN DEPARTMENTS D;

--���� 7.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)
SELECT 
    E.EMPLOYEE_ID AS �����ȣ,
    E.FIRST_NAME AS �̸�,
    E.SALARY AS �޿�,
    D.DEPARTMENT_NAME AS �μ���,
    L.STREET_ADDRESS AS �ٹ���
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
WHERE JOB_ID = 'SA_MAN';

--���� 8.
--employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.
SELECT E.*
FROM EMPLOYEES E
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
WHERE UPPER(J.JOB_TITLE) IN('STOCK MANAGER', 'STOCK CLERK');

--���� 9.
--departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT D.DEPARTMENT_NAME AS �μ���
FROM DEPARTMENTS D
LEFT JOIN EMPLOYEES E ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IS NULL;

--���� 10. 
--join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT 
    E1.FIRST_NAME AS ����̸�,
    E2.FIRST_NAME AS �Ŵ����̸�
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;

--���� 11. 
--EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
--����) �Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���
SELECT
    E1.FIRST_NAME AS ����̸�,
    E2.FIRST_NAME AS �Ŵ����̸�,
    E2.SALARY AS �Ŵ����޿�
FROM EMPLOYEES E2
LEFT JOIN EMPLOYEES E1 ON E2.EMPLOYEE_ID = E1.MANAGER_ID
WHERE E1.MANAGER_ID IS NOT NULL
ORDER BY �Ŵ����޿� DESC;

--���ʽ� ���� 12.
--���������̽�(William smith)�� ���޵�(�����)�� ���ϼ���.
SELECT
    CASE WHEN E2.MANAGER_ID IS NOT NULL AND E1.MANAGER_ID IS NOT NULL 
         THEN E3.FIRST_NAME || ' > ' ||
              E2.FIRST_NAME || ' > ' ||
              E1.FIRST_NAME
         WHEN E2.MANAGER_ID IS NOT NULL AND E1.MANAGER_ID IS NULL 
         THEN E3.FIRST_NAME || ' > ' ||
              E2.FIRST_NAME
         WHEN E2.MANAGER_ID IS NULL AND E1.MANAGER_ID IS NOT NULL
         THEN E2.FIRST_NAME || ' > ' || 
              E1.FIRST_NAME
         WHEN E2.MANAGER_ID IS NULL AND E1.MANAGER_ID IS NULL
         THEN E3.FIRST_NAME
         ELSE E3.FIRST_NAME || ' > ' || E1.FIRST_NAME
    END AS ���
FROM EMPLOYEES E3
LEFT JOIN EMPLOYEES E2 ON E3.EMPLOYEE_ID = E2.MANAGER_ID
LEFT JOIN EMPLOYEES E1 ON E2.EMPLOYEE_ID = E1.MANAGER_ID
ORDER BY E3.EMPLOYEE_ID;

-- WHERE UPPER(E1.FIRST_NAME || E1.LAST_NAME) = 'WILLIAMSMITH'; 



