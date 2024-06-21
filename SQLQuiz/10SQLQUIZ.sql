DROP TABLE DEPTS;
CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);
SELECT * FROM DEPTS;
--3. ���ν����� DEPTS_PROC
--- �μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
--DEPTS���̺� ���� flag�� i�� INSERT, u�� UPDATE, d�� DELETE �ϴ� ���ν����� �����մϴ�.
--- �׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
--- ����ó���� �ۼ����ּ���.

CREATE OR REPLACE PROCEDURE DEPTS_PROC
    (P_DEPTS_ID IN DEPARTMENTS.DEPARTMENT_ID%TYPE,
     P_DEPTS_NAME IN DEPARTMENTS.DEPARTMENT_NAME%TYPE,
     FLAG IN VARCHAR2
     )
IS
BEGIN
    IF UPPER(FLAG) = 'I' THEN
        INSERT INTO DEPTS(DEPARTMENT_ID, DEPARTMENT_NAME)
        VALUES (P_DEPTS_ID, P_DEPTS_NAME);
    ELSIF UPPER(FLAG) = 'U' THEN
        UPDATE DEPTS SET DEPARTMENT_NAME = P_DEPTS_NAME
        WHERE DEPARTMENT_ID = P_DEPTS_ID;
    ELSIF UPPER(FLAG) = 'D' THEN
        DELETE FROM DEPTS WHERE DEPARTMENT_ID = P_DEPTS_ID;
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('�����Է��Դϴ�.');
END;

EXEC DEPTS_PROC(280, 'ADMIN', 'I');
EXEC DEPTS_PROC(280, 'ADMINISTRATOR', 'U');
SELECT * FROM DEPTS;

--6. ���ν����� - SALES_PROC
--- sales���̺��� ������ �Ǹų����̴�.
--- day_of_sales���̺��� �Ǹų��� ������ ���� ������ �Ѹ����� ����ϴ� ���̺��̴�.
--- ������ sales�� ���ó�¥ �Ǹų����� �����Ͽ� day_of_sales�� �����ϴ� ���ν����� �����غ�����.
--����) day_of_sales�� ���������� �̹� �����ϸ� ������Ʈ ó��
DROP TABLE SALES;
CREATE TABLE SALES(
    SNO NUMBER(5) CONSTRAINT SALES_PK PRIMARY KEY, -- ��ȣ
    NAME VARCHAR2(30), -- ��ǰ��
    TOTAL NUMBER(10), --����
    PRICE NUMBER(10), --����
    REGDATE DATE DEFAULT SYSDATE --��¥
);

DROP TABLE DAY_OF_SALES;
CREATE TABLE DAY_OF_SALES(
    REGDATE DATE,
    FINAL_TOTAL NUMBER(10)
);

DESC SALES;

INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (1, '�Ƹ޸�ī��', 3, 1000);
INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (2, '�ݵ���', 2, 2000);
INSERT INTO SALES(SNO, NAME, TOTAL, PRICE) VALUES (3, '��ü��', 1, 3000);

SELECT * FROM SALES;    

CREATE OR REPLACE PROCEDURE SALES_PROC
    (
     P_REGDATE DATE := SYSDATE
     )
IS 
    CNT NUMBER := 0;     -- ��¥ Ȯ�� ����
    P_TOTAL NUMBER := 0; -- ��Ż�� ���� ����
BEGIN
    SELECT COUNT(*)
    INTO CNT -- ������ CNT �� ����
    FROM DAY_OF_SALES
    WHERE TO_CHAR(REGDATE,'YYYYMMDD') = TO_CHAR(P_REGDATE, 'YYYYMMDD');
    
    SELECT FINAL_TOTAL
    INTO P_TOTAL
    FROM (SELECT SUM(TOTAL * PRICE) AS FINAL_TOTAL 
          FROM SALES 
          GROUP BY TO_CHAR(REGDATE, 'YY/MM/DD')
          );
        
    IF CNT > 0 THEN 
        UPDATE DAY_OF_SALES
        SET FINAL_TOTAL = P_TOTAL 
        WHERE TO_CHAR(REGDATE, 'YYYYMMDD') = TO_CHAR(P_REGDATE, 'YYYYMMDD');
    ELSE
        INSERT INTO DAY_OF_SALES VALUES(P_REGDATE, P_TOTAL);
    END IF;
    
    COMMIT;
    
    EXCEPTION WHEN OTHERS THEN
        ROLLBACK;
END;

EXEC SALES_PROC(SYSDATE);
SELECT * FROM DAY_OF_SALES;