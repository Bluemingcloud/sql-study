-- SEQUENCE
-- ���������� �����ϴ� ��
-- �ַ� PK�� ����� �� �ֽ��ϴ�.
-- �������� ���� �����ͺ��̽��� �ֽ��ϴ�.

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE ����
CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCYCLE  -- �ִ밪�� �������� �� ���� ���� ����
    NOCACHE; -- ĳ�ÿ� �������� ���� ����
    
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

-- SEQUENCE ���
-- CURRVAL, NEXTVAL
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- ���� ������ (NEXTVAL �� ���� �Ǿ�� �Ѵ�.)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- ���� ������ ������ ��ŭ ����

-- TABLE �� SEQUENCE ���� �ֱ�
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL,  'EXAMPLE');
-- 10 ���� ������ ���� ���� �߻�
-- sequence DEPTS_SEQ.NEXTVAL exceeds MAXVALUE and cannot be instantiated
SELECT * FROM DEPTS;

-- SEQUENCE ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'EXAMPLE2');
SELECT * FROM DEPTS;

-- SEQUENCE ����
DROP SEQUENCE DEPTS_SEQ;

-- �������� �̹� ���ǰ� �ִٸ�, DROP �ϸ� �ȵ˴ϴ�.
-- ���� �������� �ʱ�ȭ �ؾ��Ѵٸ�?
-- ������ �������� ������ ���� �ʱ�ȭ �ΰ�ó�� �� ���� �ֽ��ϴ�.
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

-- 1.�������� ������ -(���簪 - 1) �� �ٲ�
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39;
-- 2.����������� ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
-- 3.�ٽ� �������� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--------------------------------------------------------------------------------
-- SEQUENCE ����
-- ���̺��� ������ ��, �����Ͱ� ��û ���ٸ� �������� ��� ���
-- ���ڿ� PK (�⵵��-�Ϸù�ȣ), �⵵�� �ٲ�� ������ �ʱ�ȭ
DROP TABLE DEPTS2;
CREATE TABLE DEPTS2(
    DEPT_NO VARCHAR2(20) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES(TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 6, 0), 'EXAMPLE');

SELECT *  FROM DEPTS2;

--------------------------------------------------------------------------------
-- INDEX
-- INDEX�� PK, UNIQUE�� �ڵ����� �����ǰ�, ��ȸ�� ������ �ϴ� HINT ������ �մϴ�.
-- INDEX ������ �����ε���, ������ε��� �� �ֽ��ϴ�.
-- UNIQUE�� �÷����� UNIQUE�ε���(�����ε���) �� ���Դϴ�.
-- �Ϲ� �÷����� ������ε����� ������ �� �ֽ��ϴ�.
-- INDEX�� ��ȸ�� ������ ������, DML ������ ���� ���Ǵ� �÷��� ������ �������ϸ� �θ� ���� �ֽ��ϴ�.

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);
-- INDEX ����

-- INDEX �� ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- ����� �ε��� ����
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);
-- INDEX ���� �� ��ȸ
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- INDEX �� ����
-- INDEX�� ���� �ϴ��� ���̺� ������ ��ġ�� �ʽ��ϴ�.
DROP INDEX EMPS_IT_IX;

-- ���� �ε���
-- �������� �÷��� ���ÿ� �ε����� ����.
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg';

-- ���� �ε���
-- PK, UK ���� �ڵ� ����
-- CREATE UNIQUE INDEX �ε����� ~~~~~~