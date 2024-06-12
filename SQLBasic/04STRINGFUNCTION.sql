-- ���ڿ� �Լ�
-- DUAL �������̺�
-- ���̺� ���� SQL���� �����ϰ� ���� �ϱ� ���� ���� ���̺�
SELECT 'HELLO WORLD', LOWER('HELLO WORLD') FROM DUAL;

-- LOWER, UPPER, INITCAP
-- ���ڿ� ��ҹ��� ����
SELECT LAST_NAME, LOWER(LAST_NAME), INITCAP(LAST_NAME), UPPER(LAST_NAME)
FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN%';

-- LENGTH
-- ���ڿ� ���� ��ȯ
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES WHERE JOB_ID LIKE 'IT%';

-- INSTR
-- ���ڿ� ã��. ������ 0 ��ȯ. ���ڿ� �ε����� 1���� ����
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a') FROM EMPLOYEES;

-- SUBSTR
-- ���ڿ� �ڸ���. �ε��� ���ں��� �Է��� ���� ��ŭ �ڸ���. �����Է��� �����ϸ� ���ڿ� ������ �ڸ� �� ��ȯ.
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES;

-- CONCAT
-- ���ڿ� ��ġ��
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD
-- ������ �����ϰ� Ư�� ���ڷ� ä��
SELECT LPAD('ABC', 10, '*'), RPAD('DEF', 6, '-') FROM DUAL;
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES;

-- TRIM, LTRIM, RTRIM
-- ��������, ���� �������� -���� ������ ���ʿ������� �ش� �� �����
SELECT TRIM('  HELLO WORLD    '), LTRIM('   HELLO WORLD      '), RTRIM('  HELLO WORLD    ') FROM DUAL;
SELECT LTRIM('HELLO WORLD  ', 'HE') FROM DUAL;

-- REPLACE
-- �ش� ���ڸ� Ư�� ���ڷ� �ٲ۴�.
SELECT 'JAVASPECIALIST', REPLACE('JAVASPECIALIST', 'JAVA', 'DATABASE') FROM DUAL;
SELECT REPLACE('���� ���� �뱸 �λ� ���', ' ', '->') FROM DUAL;
SELECT REPLACE('���� ���� �뱸 �λ� ���', ' ', '') FROM DUAL;