-- ORDER BY ����
SELECT * FROM EMPLOYEES ORDER BY SALARY;    -- �ƹ��͵� �������� ASC
SELECT * FROM EMPLOYEES ORDER BY SALARY ASC;    -- �������� null ���� ���� �������̴�.
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC;    -- ��������.

SELECT FIRST_NAME, SALARY * 12 AS ���� FROM EMPLOYEES ORDER BY ����;    -- ���� ��Ī ���� ��������

-- ������ 2�� �̻� COLUMN ���� ��ų �� �ִ�. ,(�޸�) �� ���� ����.
-- �μ���ȣ�� ���� ����� �߿���, �޿��� ���� ����� ���� ����
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID DESC, SALARY DESC;

SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SA_MAN') ORDER BY FIRST_NAME ASC;

