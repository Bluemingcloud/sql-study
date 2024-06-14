--���� 1.
--��� ���̺��� JOB_ID�� ��� ���� ���ϼ���.
--��� ���̺��� JOB_ID�� ������ ����� ���ϼ���. ������ ��� ������ �������� �����ϼ���.
--�ÿ� ���̺��� JOB_ID�� ���� ���� �Ի����� ���ϼ���. JOB_ID�� �������� �����ϼ���.
SELECT
    JOB_ID AS ����,
    COUNT(*) AS �����,
    ROUND(AVG(SALARY), 2) AS �������
FROM 
    EMPLOYEES
GROUP BY
    JOB_ID
ORDER BY 
    ������� DESC;
    
SELECT
    JOB_ID AS ����,
    COUNT(*) AS �����,
    MIN(HIRE_DATE) AS ��������Ի���
FROM 
    EMPLOYEES
GROUP BY
    JOB_ID
ORDER BY 
    JOB_ID DESC;

--���� 2.
--��� ���̺��� �Ի� �⵵ �� ��� ���� ���ϼ���.
SELECT 
    TO_CHAR(HIRE_DATE, 'YYYY') AS �Ի�⵵,
    COUNT(*) AS �����
FROM
    EMPLOYEES
GROUP BY 
    TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY 
    �Ի�⵵;

--���� 3.
--�޿��� 1000 �̻��� ������� �μ��� ��� �޿��� ����ϼ���. �� �μ� ��� �޿��� 2000�̻��� �μ��� ���
SELECT
    DEPARTMENT_ID AS �μ�,
    ROUND(AVG(SALARY), 2) AS ��ձ޿�,
    COUNT(*)
FROM 
    EMPLOYEES
WHERE
    SALARY >= 1000
GROUP BY
    DEPARTMENT_ID
HAVING 
    AVG(SALARY) >= 2000
ORDER BY
    DEPARTMENT_ID;
    

--���� 4.
--��� ���̺��� commission_pct(Ŀ�̼�) �÷��� null�� �ƴ� �������
--department_id(�μ���) salary(����)�� ���, �հ�, count�� ���մϴ�.
--���� 1) ������ ����� Ŀ�̼��� �����Ų �����Դϴ�.
--���� 2) ����� �Ҽ� 2° �ڸ����� ���� �ϼ���.
SELECT * FROM EMPLOYEES;
SELECT 
    DEPARTMENT_ID AS �μ�,
    TRUNC(AVG(SALARY * (1 + COMMISSION_PCT)), 2) AS �������,
    SUM(SALARY * (1 + COMMISSION_PCT)) AS �����հ�,
    COUNT(*) AS �����
FROM
    EMPLOYEES
WHERE 
    COMMISSION_PCT IS NOT NULL
GROUP BY 
    DEPARTMENT_ID
ORDER BY
    DEPARTMENT_ID;


--���� 5.
--�μ����̵� NULL�� �ƴϰ�, �Ի����� 05�⵵ �� ������� �μ� �޿���հ�, �޿��հ踦 ��ձ��� ���������մϴ�
--����) ����� 10000�̻��� �����͸�
SELECT
    DEPARTMENT_ID,
    ROUND(AVG(SALARY), 2) AS �޿����,
    SUM(SALARY) AS �޿��հ�
FROM 
    EMPLOYEES
WHERE 
    DEPARTMENT_ID IS NOT NULL AND HIRE_DATE LIKE '05%'
GROUP BY 
    DEPARTMENT_ID
HAVING
    AVG(SALARY) >= 10000
ORDER BY
    �޿���� DESC;

--���� 6.
--������ ������, ���հ踦 ����ϼ���
SELECT
    DECODE(GROUPING(JOB_ID),1, '�հ�', JOB_ID) AS JOB_ID,
    SUM(SALARY)
FROM 
    EMPLOYEES
GROUP BY
    ROLLUP(JOB_ID);
    
--���� 7.
--�μ���, JOB_ID�� �׷��� �Ͽ� ��Ż, �հ踦 ����ϼ���.
--GROUPING() �� �̿��Ͽ� �Ұ� �հ踦 ǥ���ϼ���

SELECT
    DECODE(GROUPING(DEPARTMENT_ID), 1, '�հ�', DEPARTMENT_ID) AS DEPARTMENT_ID,
    DECODE(GROUPING(JOB_ID), 1, '�Ұ�', JOB_ID) AS JOB_ID,
    COUNT(*) AS TOTAL,
    SUM(SALARY) AS "SUM"
FROM
    EMPLOYEES
GROUP BY
    ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY
    "SUM";


