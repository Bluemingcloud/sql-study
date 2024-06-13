-- ��ȯ �Լ�
-- �����ͺ��̽��� ����ȯ
-- CHAR, NUM, DATE

-- �ڵ�����ȯ�� ������ �ݴϴ�. (����, ����), (����, ��¥)
SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; -- SALARY ���� �������� '20000' �� ����. ���ڸ� ���ڷ� �ڵ� ����ȯ �Ͽ� ��
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '08/01/01'; -- HIRE_DATE ���� ��¥���� '08/01/01' �� ����. ���ڸ� ��¥�� �ڵ� ����ȯ �Ͽ� ��

-- ���� ����ȯ
-- TO_CHAR
-- ��¥�� ���ڷ� ��ȯ
 SELECT SYSDATE,
        TO_CHAR(SYSDATE),
        TO_CHAR(SYSDATE, 'YY-MM-DD'),
        TO_CHAR(SYSDATE, 'YYYY_MM_DD HH12:MI:SS') AS TIME,
        TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') AS DAY
 FROM DUAL;
 
 -- ���ڸ� ���ڷ� ��ȯ
 -- ���ڵ� ���������� ����
 SELECT TO_CHAR(20000, '999999999') AS RESULT1, -- 9�� ��Ÿ������ �ϴ� �ڸ��� ǥ��
        TO_CHAR(20000, '099999999') AS RESULT2, -- �� �� 0�� �����ڸ� 0���� ä���
        TO_CHAR(20000, '999') AS RESULT3, -- �ڸ����� �����ϸ� #���� ó��
        TO_CHAR(20000.123, '999999.9999') AS RESULT4, -- �����κ� 6�ڸ�, �Ǽ��κ� 4�ڸ�
        TO_CHAR(20000, '$999999999') AS RESULT5, -- $�� �� �� $��ȣ ǥ��
        TO_CHAR(20000, 'L999999999') AS RESULT6, -- �� �� ����ȭ���ȣ (���� �ý��� ����)
        TO_CHAR(20000, 'L999,999,999') AS RESULT7 -- �ڸ��� ���� , ��� ����
 FROM DUAL;
 
 -- �ۼ��غ���
 -- ���� ȯ�� 1372.17�� �� ��, EMPLOYEES �� SALARY ���� ��ȭ�� ǥ��
 SELECT FIRST_NAME, SALARY, TO_CHAR(SALARY * 1372.17, 'L999,999,999') AS ��ȭ FROM EMPLOYEES;
 
 -- TO_DATE
 -- ���ڸ� ��¥�� ��ȯ
 SELECT TO_DATE('2024-06-13', 'YYYY-MM-DD'), -- ��¥ ������ ���� ���� �ۼ�
        ROUND(SYSDATE - TO_DATE('2024_06_13', 'YYYY_MM_DD'), 5) AS RESULT1, -- ��¥ ���� ����
        TO_DATE('2024�� 06�� 13��', 'YYYY"��" MM"��" DD"��"') AS RESULT2, -- ��¥ ���� ���ڰ� �ƴ϶�� ""
        TO_DATE('24-06-13 11�� 30�� 23��', 'YY-MM-DD HH"��" MI"��" SS"��"') AS RESULT3
 FROM DUAL;
 
 -- 240613 ���ڸ� 2024��06��13�� �� ���ڷ� ��ȯ�ϱ�
 SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"��"MM"��"DD"��"') AS ��¥ FROM DUAL;
 
 -- TO_NUMBER
 -- ���ڸ� ���ڷ� ��ȯ
 SELECT '4000' - 1000 FROM DUAL; -- ���ڸ� ���ڷ� �ڵ� ����ȯ(���ڿ� ���ڸ� �����ؾ��Ѵ�.)
 SELECT TO_NUMBER('4000') - 1000 FROM DUAL; -- ����� ��ȯ �� ����
 
 SELECT '$5,500' - 1000 FROM DUAL; -- �ڵ� ����ȯ �Ұ�
 SELECT TO_NUMBER('$5,500', '$999,999') - 1000 AS RESULT1, -- ���ڸ� ���ڷ� ����ȯ �� ����
        TO_CHAR(TO_NUMBER('$5,500', '$999,999') * 1372.17, 'L999,999,999') AS RESULT2 -- ���� '$5,500' �� ȯ�� ����Ͽ� ��ȭ�� ���
 FROM DUAL;
 
 
 