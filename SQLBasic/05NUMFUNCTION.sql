-- ���� �Լ�

-- ROUND �ݿø�
SELECT ROUND(45.923), ROUND(45.923, 0), ROUND(45.923, 2), ROUND(45.923, -1) FROM DUAL;

-- TRUNC ����
SELECT TRUNC(45.923), TRUNC(45.923, 0), TRUNC(45.923, 2), TRUNC(45.923, -1) FROM DUAL;

-- CEIL �ø� ������ ��ȯ
SELECT CEIL(45.923) FROM DUAL; -- CEIL(45.923, 2) �� ���� �߻�

-- FLOOR ���� ������ ��ȯ
SELECT FLOOR(45.923) FROM DUAL; -- FLOOR(45.923, 2) �� ���� �߻�

-- ABS ���밪 ��ȯ
SELECT ABS(-23) FROM DUAL;

-- MOD ������ �� ��ȯ. ���� / �� �������� ���
SELECT 5 / 3, FLOOR(5 / 3), MOD(5, 3) FROM DUAL;