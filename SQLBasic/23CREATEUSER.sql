-- ���� ���
SELECT * FROM ALL_USERS;

-- ���� ���� Ȯ��
SELECT * FROM user_sys_privs;

-- ���� ����
CREATE USER USER01 IDENTIFIED BY USER01; -- ID : USER01, PW : USER01 ���� ����

-- ���� �ο�
-- ���ӱ���, ���̺�, ��, ������, ���ν��� �������� ��
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW, CREATE PROCEDURE TO USER01;

-- TABLESPACE 
-- �����͸� �����ϴ� �������� ����
-- TABLESPACE �� �����Ǿ�� �����͸� ���� ����
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

-- ���� ȸ��
GRANT CREATE TABLESPACE TO USER01;
REVOKE CREATE TABLESPACE FROM USER01;
REVOKE CREATE SESSION FROM USER01;
GRANT CREATE SESSION TO USER01;

-- ���� ����
DROP USER USER01;
--------------------------------------------------------------------------------
-- ROLE
-- ������ �׷��� ���� ���Ѻο�
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT CONNECT, RESOURCE TO USER01; -- CONNECT : ���� ��, RESOURCE : ���� ��, DBA : ������ ��

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;



