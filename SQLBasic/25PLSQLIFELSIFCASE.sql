-- 제어문
/*
IF 조건절 THEN
ELSIF 조건절 THEN
ELSE ~~
END IF;
*/
SET SERVEROUTPUT ON;

DECLARE
    POINT NUMBER := TRUNC(DBMS_RANDOM.VALUE(1, 101)); -- 1 ~ 101 미만 랜덤수
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('점수:' || POINT);
    /*
    IF POINT >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A학점 입니다.');
    ELSIF POINT >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B학점 입니다.');
    ELSIF POINT >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C학점 입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('F학점 입니다.');
    END IF;
    */
    
    CASE WHEN POINT >= 90 THEN DBMS_OUTPUT.PUT_LINE('A학점 입니다.');
         WHEN POINT >= 80 THEN DBMS_OUTPUT.PUT_LINE('B학점 입니다.');
         WHEN POINT >= 70 THEN DBMS_OUTPUT.PUT_LINE('C학점 입니다.');
         ELSE DBMS_OUTPUT.PUT_LINE('F학점 입니다.');
    END CASE;    
END;