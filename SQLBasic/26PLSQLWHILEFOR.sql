-- PLSQL
-- WHILE 문
SET SERVEROUTPUT ON;

DECLARE
    CNT NUMBER := 1;
BEGIN
    WHILE CNT <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE('3 X ' || CNT || ' = ' || CNT * 3);
        CNT := CNT + 1;
    END LOOP;
END;
--------------------------------------------------------------------------------
-- FOR 문
DECLARE
    
BEGIN
    FOR I IN 1..9 -- 1 ~ 9 까지
    LOOP 
        CONTINUE WHEN I = 5; -- I 가 5 면 다음으로
        DBMS_OUTPUT.PUT_LINE('3 X ' || I || ' = ' || I * 3);
--        EXIT WHEN I = 5; -- I 가 5 면 탈출
    END LOOP;
END;

--------------------------------------------------------------------------------
-- 1. 2 ~ 9 단까지 출력하는 익명블록
-- WHILE 문
DECLARE
    I NUMBER := 2;
BEGIN
    WHILE I <= 9
    LOOP
        DECLARE
            J NUMBER := 1;
        BEGIN
            WHILE J <= 9
            LOOP 
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I * J);
            J := J + 1;
            END LOOP;
        END;
        I := I + 1;
    END LOOP;
END;

DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
BEGIN
    WHILE I <= 9
    LOOP
        J := 1;
        WHILE J <= 9
        LOOP 
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I * J);
            J := J + 1;
        END LOOP;
        I := I + 1;
    END LOOP;
END;

-- FOR 문
DECLARE
BEGIN
    FOR I IN 2..9
    LOOP
        FOR J IN 1..9
        LOOP 
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I * J);
        END LOOP;
    END LOOP;
END;