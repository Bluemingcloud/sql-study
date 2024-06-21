-- PLSQL
-- CURSOR
-- ���ǰ���� ������ �� ���� CURSOR�� ����ؼ� ó���� �����մϴ�.
-- �迭, ���ͷ����� �� ����� ����
SET SERVEROUTPUT ON;

-- SELECT �� ����� �������� ��
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'; -- SELECT ����� �������̶� ERR�� ���ϴ�.
    
    DBMS_OUTPUT.PUT_LINE(NAME);
END;

-- CURSOR ���
DECLARE
    -- �Ϲݺ���
    NM VARCHAR2(30);
    SALARY NUMBER;
    -- Ŀ��
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
BEGIN
    
    OPEN X; -- Ŀ���� ����
        DBMS_OUTPUT.PUT_LINE('---------Ŀ�� ����---------');
    LOOP
        FETCH X INTO NM, SALARY; -- NM������ SALARY �� ����
        -- CURSOR Ż���� ������ BUFFER OVERFLOW ���� �߻�
        EXIT WHEN X%NOTFOUND; -- X Ŀ���� ���̻� ���� ���� ������ TRUE
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
        
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------Ŀ�� ����---------');
    DBMS_OUTPUT.PUT_LINE('������ ��:' || X%ROWCOUNT); -- Ŀ������ ���� ������ ��
    
    CLOSE X; -- Ŀ�� ����
END;
