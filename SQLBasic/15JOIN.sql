SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN
-- ������ ���� ���� ������ �ʴ´�.
SELECT * FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT 
    INFO.ID,
    INFO.TITLE,
    INFO.CONTENT,
    TO_CHAR(INFO.REGDATE, 'MM/DD/YYYY') AS REGDATE,
    INFO.AUTH_ID,   -- AUTH_ID �� ���� ���̺� ���ִ� KEY
    AUTH.NAME       -- TABEL��.COLUMN�� ���� ����ؾ� ��� ���� 
                    -- TABEL��.COLUMN�� �� ����Ϸ��� ��� ���ִ°� ����.
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;
        
-- TABLE�� ���� ��Ī(ALIAS) ��밡��
-- TABLE�� ���ϴº�Ī
SELECT 
    I.ID,
    I.TITLE,
    A.AUTH_ID,
    A.NAME,
    A.JOB
FROM INFO I -- TABLE ALIAS
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- ������ Ű�� ���ٸ� USING ������ ����� �� ����
SELECT * 
FROM INFO I
INNER JOIN AUTH A
USING(AUTH_ID);

----------------------------------------------------------------
-- OUTER JOIN
-- LEFT OUTER JOIN(OUTER ���� ����)
-- FROM ���̺�1 LEFT JOIN ���̺�2
-- ������ ���̺�1 �������� �������̺��� �ش��ϴ� �� ��ŭ ���� �� ���´�.
SELECT * FROM INFO I LEFT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT OUTER JOIN
-- FROM ���̺�1 RIGHT JOIN ���̺�2
-- �������� ���̺�2 �������� ���������̺��� �ش��ϴ� �� ��ŭ ���� �� ���´�.(�ߺ�����)
SELECT * FROM INFO I RIGHT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT JOIN �� �¿� ���̺� �ڸ��� �ٲٸ� LEFT JOIN �� ���� ���
SELECT * FROM AUTH A RIGHT JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

-- FULL OUTER JOIN
-- ���� ���̺� ��� �������� ���´�.
SELECT * FROM INFO I FULL JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;


-- CROSS JOIN
-- �߸��� JOIN �� ����. ������ ����� ���� ����.
SELECT * FROM INFO I CROSS JOIN AUTH A;
SELECT * FROM AUTH A CROSS JOIN INFO I;
--------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * 
FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- JOIN �� ������ �� �� �ִ�.
SELECT 
    E.FIRST_NAME,
    D.DEPARTMENT_NAME,
    L.CITY,
    C.COUNTRY_NAME,
    R.REGION_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
LEFT JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
WHERE C.COUNTRY_NAME LIKE 'U%';
------------------------------------------------------------------
-- FK�� �ִ� N���̺� 1������ �������ִ� 1���̺��� JOIN �ϴ°��� �ַ� ���Ǵ� ���


--------------------------------------------------------------------
-- SELF JOIN
-- �ϳ��� ���̺��� ������ JOIN�� �Ŵ°�
-- FK �� ��� ������ ���� �־�� �����ϴ�.
SELECT * FROM EMPLOYEES;

SELECT 
    E1.EMPLOYEE_ID AS EMPLOYEE_ID,
    E1.FIRST_NAME || ' ' || E1.LAST_NAME AS NAME,
    E2.EMPLOYEE_ID AS MANAGER_ID,
    E2.FIRST_NAME || ' ' || E2.LAST_NAME AS MANAGER
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;
--------------------------------------------------------------------
-- ORACLE JOIN
-- ORACLE ������ ��밡��
-- JOIN �� TABLE���� FROM ��, ������ WHERE �� ����.
-- ORACLE INNER JOIN
SELECT * 
FROM INFO I, AUTH A 
WHERE I.AUTH_ID = A.AUTH_ID;

-- LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID(+);

-- RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID(+) = A.AUTH_ID;

-- ORACLE FULL OUTER JOIN �� ����.

-- CROSS JOIN �� �߸��� ���� (������ �������� ��Ÿ��)
SELECT *
FROM INFO I, AUTH A;