--���� 1.
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
--EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
--EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���.
SELECT *,
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

SELECT *
FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG')
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
--���� 2.
--DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id(�μ����̵�) ��
--EMPLOYEES���̺��� department_id(�μ����̵�) �� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT * 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
--- EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
--- EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
--- Steven�� ������ �μ��� �ִ� ������� ������ּ���.
--- Steven�� �޿����� ���� �޿��� �޴� ������� ����ϼ���.
SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

SELECT * 
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'James');

SELECT * 
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');

SELECT * 
FROM EMPLOYEES
WHERE SALARY > ANY(SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven');


--���� 4.
--EMPLOYEES���̺� DEPARTMENTS���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT 
    E.EMPLOYEE_ID,
    E.FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
    E.DEPARTMENT_ID,
    D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY EMPLOYEE_ID;

--���� 5.
--���� 4�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME || ' ' || E.LAST_NAME AS NAME,
    E.DEPARTMENT_ID,
    (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMPLOYEE_ID;
--���� 6.
--DEPARTMENTS���̺� LOCATIONS���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, ��Ʈ��_��巹��, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT
    D.DEPARTMENT_ID,
    DEPARTMENT_NAME,
    STREET_ADDRESS,
    CITY
FROM DEPARTMENTS D 
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;

--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT * FROM LOCATIONS;
SELECT 
    D.DEPARTMENT_ID,
    DEPARTMENT_NAME,
    (SELECT STREET_ADDRESS FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID) AS STREET_ADDRESS,
    (SELECT CITY FROM LOCATIONS L WHERE L.LOCATION_ID = D.LOCATION_ID) AS CITY
FROM DEPARTMENTS D
ORDER BY DEPARTMENT_NAME;
--���� 8.
--LOCATIONS���̺� COUNTRIES���̺��� ��Į�� ������ ��ȸ�ϼ���.
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT *
FROM (
    SELECT 
        L.LOCATION_ID,
        STREET_ADDRESS,
        CITY,
        COUNTRY_ID, 
        (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS COUNTRY_NAME
    FROM LOCATIONS L
    ORDER BY COUNTRY_NAME
);

SELECT 
    LOCATION_ID,
    STREET_ADDRESS,
    CITY,
    COUNTRY_ID,
    (SELECT COUNTRY_NAME FROM COUNTRIES C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS COUNTRY_NAME
FROM LOCATIONS L
ORDER BY COUNTRY_NAME;
 
----------------------------------------------------------------------------------------------------
--���� 9.
--EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT 
    RN,
    FIRST_NAME
FROM (
    SELECT 
        ROWNUM AS RN,
        FIRST_NAME
    FROM (
        SELECT *
        FROM EMPLOYEES
        ORDER BY FIRST_NAME DESC
    )
)
WHERE RN BETWEEN 41 AND 50;
--���� 10.
--EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���.
SELECT
    RN,
    EMPLOYEE_ID,
    NAME,
    PHONE_NUMBER,
    HIRE_DATE
FROM (
    SELECT
        ROWNUM AS RN,
        CONCAT(FIRST_NAME, LAST_NAME) AS NAME,
        A.*
    FROM (
        SELECT *
        FROM EMPLOYEES
        ORDER BY HIRE_DATE ASC
    ) A
)
WHERE RN BETWEEN 31 AND 40;

--���� 11.
--COMMISSION�� ������ �޿��� ���ο� �÷����� ����� 10000���� ū ������� �̾� ������. (�ζ��κ並 ���� �˴ϴ�)

SELECT *
FROM (
    SELECT 
        A.*,
        SALARY * (1 + NVL(COMMISSION_PCT, 0)) AS UPDATE_SALARY
    FROM (
        SELECT * FROM EMPLOYEES
    ) A
)
WHERE UPDATE_SALARY > 10000;
--------------------------------------------------------------------------------
--����12
--EMPLOYEES���̺�, DEPARTMENTS ���̺��� left�����Ͽ�, �Ի��� �������� �������� 10-20��° �����͸� ����մϴ�.
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, �Ի���, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� �������� �ȵǿ�.
SELECT 
    RN,
    PHONE_NUMBER,
    EMPLOYEE_ID,
    CONCAT(FIRST_NAME, LAST_NAME) AS NAME,
    HIRE_DATE,
    DEPARTMENT_NAME
FROM (
    SELECT 
        A.*,
        ROWNUM AS RN
    FROM (
        SELECT *            
        FROM EMPLOYEES E
        LEFT JOIN DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        ORDER BY HIRE_DATE
    ) A
)
WHERE RN BETWEEN 10 AND 20;

SELECT *
FROM (
    SELECT ROWNUM AS RN,
           A.*,
           (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE A.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
    FROM (
        SELECT EMPLOYEE_ID,
               CONCAT(FIRST_NAME || ' ', LAST_NAME) AS NAME,
               HIRE_DATE,
               DEPARTMENT_ID
        FROM EMPLOYEES E
        ORDER BY HIRE_DATE
    ) A
)
WHERE RN BETWEEN 10 AND 20;

--����13
--SA_MAN ����� �޿� �������� �������� ROWNUM�� �ٿ��ּ���.
--����) SA_MAN ������� ROWNUM, �̸�, �޿�, �μ����̵�, �μ����� ����ϼ���.
SELECT 
    RN,
    NAME,
    SALARY,
    DEPARTMENT_ID,
    (SELECT 
        DEPARTMENT_NAME 
    FROM 
        DEPARTMENTS D 
    WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
    ) AS DEPARTMENT_NAME
FROM (
    SELECT 
        A.*,
        CONCAT(FIRST_NAME, LAST_NAME) AS NAME,
        ROWNUM AS RN
    FROM (
        SELECT * 
        FROM EMPLOYEES
        WHERE JOB_ID = 'SA_MAN'
        ORDER BY SALARY DESC
    ) A
) E;

SELECT
    ROWNUM AS RN,
    A.*,
    DEPARTMENT_NAME
FROM (
    SELECT 
        FIRST_NAME,
        SALARY,
        DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE JOB_ID = 'SA_MAN'
    ORDER BY SALARY DESC
) A
LEFT JOIN DEPARTMENTS D 
ON A.DEPARTMENT_ID = D.DEPARTMENT_ID;

--����14
--DEPARTMENTS���̺��� �� �μ��� �μ���, �Ŵ������̵�, �μ��� ���� �ο��� �� ����ϼ���.
--����) �ο��� ���� �������� �����ϼ���.
--����) ����� ���� �μ��� ������� �ʽ��ϴ�.
--��Ʈ) �μ��� �ο��� ���� ���Ѵ�. �� ���̺��� �����Ѵ�.

SELECT 
    DEPARTMENT_NAME,
    MANAGER_ID,
    DEPARTMENT_COUNT
FROM DEPARTMENTS D
LEFT JOIN 
    (SELECT 
        COUNT(*) AS DEPARTMENT_COUNT,
        DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    ) C
ON D.DEPARTMENT_ID = C.DEPARTMENT_ID
WHERE C.DEPARTMENT_COUNT IS NOT NULL
ORDER BY C.DEPARTMENT_COUNT DESC;


--����15
--�μ��� ��� �÷�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--����) �μ��� ����� ������ 0���� ����ϼ���

SELECT 
    D.*,
    L.STREET_ADDRESS,
    L.POSTAL_CODE,
    NVL((SELECT ROUND(AVG(SALARY), 2) 
        FROM EMPLOYEES E 
        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
        GROUP BY DEPARTMENT_ID), 0) AS SALARY_AVG
FROM DEPARTMENTS D
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;   


--����16
--���� 15����� ���� DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--����ϼ���
SELECT
    ROWNUM AS RN,
    A.*
FROM (
    SELECT 
        D.*,
        STREET_ADDRESS,
        POSTAL_CODE,
        NVL((SELECT ROUND(AVG(SALARY), 2)
            FROM EMPLOYEES E
            WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
            GROUP BY DEPARTMENT_ID), 0) AS SALARY_AVG
    FROM DEPARTMENTS D
    LEFT JOIN LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
    ORDER BY DEPARTMENT_ID DESC
) A
WHERE ROWNUM BETWEEN 1 AND 10;

