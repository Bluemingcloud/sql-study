--���� 1.
--�������ڸ� �������� EMPLOYEE���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 10�� �̻���
--����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
--���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�.

SELECT * FROM EMPLOYEES;
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME || LAST_NAME AS �����,
       HIRE_DATE AS �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES
WHERE TRUNC((SYSDATE - HIRE_DATE) / 365) >= 10
ORDER BY �ټӳ�� DESC;

SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME || LAST_NAME AS �����,
       HIRE_DATE AS �Ի�����,
       TRUNC((SYSDATE - HIRE_DATE) / 365) AS �ټӳ��
FROM EMPLOYEES
WHERE SYSDATE - HIRE_DATE >= 10 * 365
ORDER BY �ټӳ�� DESC;

--���� 2.
--EMPLOYEE ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
--100�̶�� �����塯 
--120�̶�� �����塯
--121�̶�� ���븮��
--122��� �����ӡ�
--�������� ������� ���� ����մϴ�.
--���� 1) �μ��� 50�� ������� ������θ� ��ȸ�մϴ�
--���� 2) DECODE�������� ǥ���غ�����.
--���� 3) CASE�������� ǥ���غ�����.
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;
SELECT FIRST_NAME, MANAGER_ID, 
       DECODE(MANAGER_ID, 100, '����'
                        , 120, '����'
                        , 121, '�븮'
                        , 122, '����'
                        , '���'
                        ) AS ����
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50;

SELECT FIRST_NAME, 
       MANAGER_ID,
       CASE MANAGER_ID WHEN 100 THEN '����'
                       WHEN 120 THEN '����'
                       WHEN 121 THEN '�븮'
                       WHEN 122 THEN '����'
                       ELSE '���'
       END AS ����
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50;

--���� 3. 
--EMPLOYEES ���̺��� �̸�, �Ի���, �޿�, ���޴�� �� ����մϴ�.
--����1) HIRE_DATE�� XXXX��XX��XX�� �������� ����ϼ���. 
--����2) �޿��� Ŀ�̼ǰ��� �ۼ�Ʈ�� ������ ���� ����ϰ�, 1300�� ���� ��ȭ�� �ٲ㼭 ����ϼ���.
--����3) ���޴���� 5�� ���� �̷�� ���ϴ�. �ټӳ���� 5�� ������ ���޴������ ����մϴ�.
--����4) �μ��� NULL�� �ƴ� �����͸� ������� ����մϴ�.
SELECT * FROM EMPLOYEES;
SELECT FIRST_NAME AS �̸�, 
       TO_CHAR(HIRE_DATE, 'YYYY"��"MM"��"DD"��"') AS �Ի���,
       TO_CHAR((SALARY + SALARY * NVL(COMMISSION_PCT, 0)) * 1300
                , 'L999,999,999,999'
                ) AS �޿�,
       CASE MOD(TRUNC((SYSDATE - HIRE_DATE) / 365), 5) WHEN 0 THEN '���޴��'
            ELSE NULL
       END AS ���޴��
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL;

SELECT FIRST_NAME AS �̸�,
       TO_CHAR(HIRE_DATE, 'YYYY"��"MM"��"DD"��"') AS �Ի���,
       TO_CHAR(SALARY * (1 + NVL(COMMISSION_PCT, 0)) * 1300, 'L999,999,999') AS �޿�,
       DECODE(MOD(TO_CHAR(SYSDATE, 'YY') - TO_CHAR(HIRE_DATE, 'YY'), 5), 0, '���޴��') AS ���޴��
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL;
       