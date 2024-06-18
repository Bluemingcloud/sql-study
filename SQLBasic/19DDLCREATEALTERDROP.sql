-- DDL ����
-- CREATE, ALTER, DROP
-- DDL ���� TRANSACTION�� ����

DROP TABLE DEPTS; -- ���̺� ����

CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2), -- ���� 2�ڸ�
    DEPT_NAME VARCHAR2(30), -- 30����Ʈ (�ѱ��� 15����, ���� 30����)
    DEPT_YN CHAR(1), -- �������� 1BYTE
    DEPT_DATE DATE, 
    DEPT_BONUS NUMBER(10, 2), -- ���� 10�ڸ�, �Ҽ��� 2�ڸ��� ���� ����
    DEPT_CONTENT LONG -- 2�Ⱑ ���� ���尡���� ���� ���ڿ� (VARCHAR2 ���� ��ū). DB���� �̸��� ���ݾ� �ٸ�
);

DESC DEPTS;

INSERT INTO DEPTS VALUES(99, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~~~');
INSERT INTO DEPTS VALUES(100, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~'); -- DEPT_NO �ʰ�
INSERT INTO DEPTS VALUES(1, 'HELLO', '��', SYSDATE, 3.14, 'LONG TEXT~'); -- DEPT_YN �ʰ� (�ѱ��� 2BYTE)
INSERT INTO DEPTS VALUES(1, 'HELLO', 'Y', SYSDATE, 123.123, 'LONG TEXT~'); -- DEPT_BONUS�� 123.12 ������ �����
SELECT * FROM DEPTS;

-- ALTER
-- ���̺� ���� ����
-- ADD, MODIFY, RENAME, COLUMN, DROP COLUMN

DESC DEPTS;
SELECT * FROM DEPTS;

ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); -- �������� �÷� �߰�

ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; -- �÷��� ����

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5); -- �÷��� ũ�� ����
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1);
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR(1); -- ���� �����Ͱ� ������ ũ�⺸�� ū ��� ����Ұ�

ALTER TABLE DEPTS DROP COLUMN EMP_COUNT; -- �÷� ����

--------------------------------------------------------------------------------
-- DROP
-- ���̺� ����
DROP TABLE DEPTS; -- ���̺��� ����. �ڵ� Ŀ��. Ʈ������� ���������� ����(�ǵ��� �� ����)
DROP TABLE DEPTS CASCADE /*�������Ǹ�*/; -- ���̺��� ������ FK ���������� �����ϰ� ���̺��� �����Ѵ�. (����)

DROP TABLE DEPARTMENTS; -- FK ���������� �־� ���� �Ұ�(EMPLOYEES ���̺�� ��������)

--------------------------------------------------------------------------------
