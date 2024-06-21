-- ������ ���ν���
-- �Ϸ��� SQL ó�� ������ ����ó�� ��� ����ϴ� ����

-- ����� ȣ���� �ֽ��ϴ�.
-- ����
SET SERVEROUTPUT ON;
DROP PROCEDURE NEW_JOB_POC;
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- PROCEDURE ��
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD!');
END; -- ������ �Ǿ����ϴ�.

-- ȣ��
EXEC NEW_JOB_POC;

--------------------------------------------------------------------------------
-- PROCEDURE�� �Ű����� IN
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- �̸��� ������ �ڵ����� ������.
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN JOBS.MIN_SALARY%TYPE := 0,
     P_MAX_SALARY IN JOBS.MAX_SALARY%TYPE := 10000
    )
IS
BEGIN
    
    INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    COMMIT;
END;

EXEC NEW_JOB_PROC('EXAMPLE', 'EXAMPLE', 1000, 10000);
EXEC NEW_JOB_PROC('EXAMPLE'); -- �Ű������� ��ġ���� ������ X
EXEC NEW_JOB_PROC('EXAMPLE2', 'EXAMPLE2'); -- �Ű������� DEFAULT ���� �����Ǿ� ������ �ش� ������ ���� �ʾƵ� ����
DESC JOBS_IT;
SELECT * FROM JOBS_IT;

--------------------------------------------------------------------------------
-- PLSQL ��� ���� ���, Ż�⹮, Ŀ�������� PROCEDURE�� �� �� �ֽ��ϴ�.
-- JOB_ID �� �����ϸ� UPDATE, ������ INSERT
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN NUMBER,
     P_MAX_SALARY IN NUMBER
    )
IS
    CNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT -- ������ CNT �� ����
    FROM JOBS_IT
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        -- JOB_ID �� ���ٸ�
        INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    
    ELSE
        -- JOB_ID �� �ִٸ�
        UPDATE JOBS_IT
        SET JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SALARY,
            MAX_SALARY = P_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;   
    END IF;
    
    COMMIT;
END;
--
EXEC NEW_JOB_PROC('AD', 'ADMIN', 1000, 10000);

EXEC NEW_JOB_PROC('AD_VP', 'ADMIN2', 1000, 20000);

SELECT * FROM JOBS_IT;
--------------------------------------------------------------------------------
-- OUT �Ű�����
-- PROCEDURE �ܺη� ���� �����ֱ� ���� ����ϴ� �Ű�����

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN NUMBER,
     P_MAX_SALARY IN NUMBER,
     P_CNT OUT NUMBER -- �ܺη� ������ �Ű�����
     )
IS
    CNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT -- ������ CNT �� ����
    FROM JOBS_IT
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        -- JOB_ID �� ���ٸ�
        INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    
    ELSE
        -- JOB_ID �� �ִٸ�
        UPDATE JOBS_IT
        SET JOB_TITLE = P_JOB_TITLE,
            MIN_SALARY = P_MIN_SALARY,
            MAX_SALARY = P_MAX_SALARY
        WHERE JOB_ID = P_JOB_ID;   
    END IF;
    
    P_CNT := CNT;
    
    COMMIT;
END;
-- 
DECLARE
    CNT NUMBER;
BEGIN
    new_job_proc('AD_VP', 'ADMIN', 1000, 10000, CNT); -- �͸��� �ȿ����� EXEC ����
    
    DBMS_OUTPUT.PUT_LINE('���ν��� ���ο��� �Ҵ���� ��:' || CNT);
    
END;
--------------------------------------------------------------------------------
-- RETURN
-- ���ν����� ������
-- EXCEPTION WHEN OTHERS THEN ����ó��

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC2
    (P_JOB_ID IN JOBS.JOB_ID%TYPE
    )
IS
    CNT NUMBER;
    SALARY NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT
    FROM JOBS
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('���� �����ϴ�.');
        RETURN; -- ���ν��� ����
    ELSE
        
        SELECT MAX_SALARY
        INTO SALARY
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
        
        DBMS_OUTPUT.PUT_LINE('�ִ�޿�:' || SALARY);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ν��� ���� ����!');
    
    -- ����ó�� ����(���ܸ� ������ ���ܹ����� �����)
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��߽��ϴ�.');
END;

EXEC NEW_JOB_PROC2('AD'); -- ���� �����Ƿ� RETURN�� ���� ���ν��� ����
EXEC NEW_JOB_PROC2('AD_VP');

