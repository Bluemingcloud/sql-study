-- ��¥ �Լ�

-- SYSDATE ���� ��¥ ��ȯ
SELECT SYSDATE FROM DUAL;

-- SYSTIMESTAMP ���� ��¥�� �ð� ��ȯ
SELECT SYSTIMESTAMP FROM DUAL;

-- ��¥ ����
-- �׻� ��(DAY) �������� ���ϰų� ������.
 SELECT SYSDATE AS ����,
        SYSDATE + 1 AS ����,
        SYSDATE - 1 AS ����
 FROM DUAL;

-- ���� �Լ� ��� ����
 SELECT FIRST_NAME,
        HIRE_DATE,
        SYSDATE AS TODAY,
        CEIL((SYSDATE - HIRE_DATE) / 7) AS WEEKS,
        CEIL((SYSDATE - HIRE_DATE) / 365) AS YEARS
 FROM EMPLOYEES;
 
 -- ��¥�� �ݿø�, ����
 SELECT ROUND(SYSDATE), TRUNC(SYSDATE) FROM DUAL; -- DAY �������� �ݿø�, ����
 SELECT ROUND(SYSDATE, 'MONTH'), TRUNC(SYSDATE, 'MONTH') FROM DUAL; -- MONTH �������� �ݿø�, ����
 SELECT ROUND(SYSDATE, 'YEAR'), TRUNC(SYSDATE, 'YEAR') FROM DUAL; -- YEAR �������� �ݿø�, ����
 
 SELECT HIRE_DATE, 
        ROUND(HIRE_DATE, 'YEAR') AS ROUND, 
        TRUNC(HIRE_DATE, 'YEAR') AS TRUNC 
 FROM EMPLOYEES;
 
    