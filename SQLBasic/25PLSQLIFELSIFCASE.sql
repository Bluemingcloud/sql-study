-- ���
/*
IF ������ THEN
ELSIF ������ THEN
ELSE ~~
END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1, 101)); -- 1 ~ 101 �̸� ������
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('����:' || POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A���� �Դϴ�.');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B���� �Դϴ�.');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C���� �Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F���� �Դϴ�.');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A���� �Դϴ�.');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B���� �Դϴ�.');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C���� �Դϴ�.');
         ELSE DBMS_OUTPUT.PUT_LINE('F���� �Դϴ�.');
    END CASE;    
END;