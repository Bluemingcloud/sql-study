-- ���� ����
-- SELECT �� �ȿ� SELECT
-- ������ ��������
-- ���������� ����� 1���� ��������

-- Nancy ���� �޿��� ���� ���
-- 1. Nancy�� �޿��� ã�´�.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
-- 2. ã�� �޿��� WHERE���� �ִ´�.
SELECT * FROM EMPLOYEES WHERE SALARY > 12008;

-- ������������ �ۼ�
SELECT * FROM EMPLOYEES WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

-- 103���� ������ ���� ���
-- 1. 103���� ������ ã�´�.
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
-- 2. ã�� �����̸��� WHERE���� �ִ´�.
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

-- ������������ �ۼ�
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

-- ���������� ���� ���� �� ��
-- ���� �÷��� ��Ȯ�� �Ѱ����� �մϴ�.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103); -- ���������� ���� ���� ���Ƽ� ����

-- ������������ ���� �������� ������ �����̶��, ������ �������� �����ڸ� ������մϴ�.
SELECT * 
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'); -- �̸��� Steven �� �����Ͱ� 2�� �����ؼ� ����

--------------------------------------------------------------------------------
-- ������ ��������
-- ���������� ����� ������ ���ϵǴ� ��� IN, ANY, ALL �� ��
-- ANY, ALL
-- ������ �������� ��
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; -- 4800, 6800, 9500

-- David �� '�ּ�' �޿����� ���� �޴� ���
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David �� '�ִ�' �޿����� ���� �޴� ���
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David �� '�ִ�' �޿����� ���� �޴� ���
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David �� '�ּ�' �޿����� ���� �޴� ���
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN
-- ������ �������� ��ġ�ϴ� ������
SELECT DEPARTMENT_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                       FROM EMPLOYEES 
                       WHERE FIRST_NAME = 'David');
--------------------------------------------------------------------------------
-- ��Į��(Scala) ��������
-- SELECT ���� ����ϴ� ��������
-- Ư�� ���̺� 1���� �÷��� �����ö� �����ϴ�.
-- JOIN ������ ��ü�Ͽ� ��밡��.

-- JOIN �� ����� ��
SELECT 
    E.DEPARTMENT_ID AS DEPARTMENT_ID,
    E.FIRST_NAME AS FIRST_NAME,
    D.DEPARTMENT_NAME AS DEPARTMENT_NAME    
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IN (SELECT E.DEPARTMENT_ID 
                          FROM EMPLOYEES E WHERE E.FIRST_NAME = 'David');

-- ��Į�� ������ �ۼ�
SELECT
    E.DEPARTMENT_ID AS DEPARTMENT_ID,
    E.FIRST_NAME AS FIRST_NAME,
    (SELECT DEPARTMENT_NAME 
     FROM DEPARTMENTS D 
     WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David');
    
-- ��Į�� ������ �ٸ� ���̺��� �÷� 1���� ������ �� ��, JOIN���� ������ ����մϴ�.
SELECT * FROM JOBS;
-- COLUMN �� �� JOIN
SELECT 
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

-- COLUMN ������ JOIN
SELECT
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE, MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
    -- ��Į�� ���� ���� ��� ���� �ϳ��� ����!
FROM EMPLOYEES E;

SELECT 
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
    (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS MIN_SALARY
FROM EMPLOYEES E;
-- �������� COLUMN �� JOIN �� ���� JOIN ������ �������� �� ���� �� �ִ�.
SELECT
    FIRST_NAME,
    E.JOB_ID AS JOB_ID,
    JOB_TITLE,
    MIN_SALARY
FROM EMPLOYEES E
LEFT JOIN JOBS J 
ON E.JOB_ID = J.JOB_ID;

-- ����
-- FIRST_NAME, DEPARTMENT_NAME, JOB_TITLE �� ���ÿ� SELECT
-- ��Į�� ���� ����
SELECT 
    FIRST_NAME,
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

-- JOIN ����
SELECT 
    E.FIRST_NAME,
    D.DEPARTMENT_NAME,
    J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;
--------------------------------------------------------------------------------
-- �ζ��� ��
-- FROM �� ������ ������������ ���ϴ�.
-- �ζ��� �信�� (�����÷�) �� �����, �� �÷��� ���ؼ� ��ȸ�� ������ ����մϴ�.
SELECT *
FROM (SELECT * 
      FROM EMPLOYEES);
      
-- ROWNUM �� ��ȸ�� ������ ���� ��ȣ�� �ٽ��ϴ�.
-- PK ���� �ش� �ε��� ����
SELECT 
    ROWNUM,
    FIRST_NAME,
    SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- ORDER �� ���� ��Ų ����� ���� ����ȸ
SELECT
    ROWNUM,
    FIRST_NAME,
    SALARY
FROM (SELECT
          FIRST_NAME,
          SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      )
WHERE ROWNUM BETWEEN 11 AND 20; -- ROWNUM �� �ݵ�� 1���� �����ؾ��Ѵ�.

-- 11���� 20�� ����? 1���� ��ȸ�� ROWNUM �� ���󿭷� ���� �� ����ȸ
SELECT *
FROM (
    SELECT 
        ROWNUM AS RN, -- ����(���������� ������ ��)
        FIRST_NAME,
        SALARY
    FROM (
        SELECT 
            FIRST_NAME,
            SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    )
)
WHERE RN BETWEEN 11 AND 20; -- �ȿ��� ���󿭷� ������� �����͸� �ۿ��� ����� �� ����

-- ����
-- �ټӳ���� 5�� ����� ����鸸 ���
SELECT 
    FIRST_NAME,
    TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES
WHERE MOD(�ټӳ��, 5) = 0 -- WHERE ���� ALIAS ��� �Ұ�
ORDER BY �ټӳ�� DESC;

-- �ζ��� �� ���
SELECT *
FROM (
    SELECT
        FIRST_NAME,
        HIRE_DATE,
        TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
    FROM EMPLOYEES
    ORDER BY �ټӳ�� DESC
)
WHERE MOD(�ټӳ��, 5) = 0;

-- �ζ��� �信�� ���̺� ALIAS �� ��ȸ
SELECT 
    ROWNUM AS RN,
    A.*
FROM (
    SELECT
        E.*,
        TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
    FROM EMPLOYEES E
    ORDER BY �ټӳ�� DESC 
) A
WHERE MOD(A.�ټӳ��, 5) = 0;

SELECT *
FROM (
    SELECT 
        ROWNUM AS RN,
        A.*
    FROM (
        SELECT
            E.*,
            TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
        FROM EMPLOYEES E
        ORDER BY �ټӳ�� DESC 
    ) A
    WHERE MOD(A.�ټӳ��, 5) = 0
)
WHERE RN BETWEEN 5 AND 10;