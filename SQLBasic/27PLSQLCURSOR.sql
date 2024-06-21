-- PLSQL
-- CURSOR
-- 질의결과가 여러행 일 때는 CURSOR를 사용해서 처리가 가능합니다.
-- 배열, 이터레이터 와 비슷한 느낌
SET SERVEROUTPUT ON;

-- SELECT 의 결과가 여러행일 때
DECLARE
    NAME VARCHAR2(30);
BEGIN
    SELECT FIRST_NAME 
    INTO NAME
    FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG'; -- SELECT 결과가 여러행이라서 ERR가 납니다.
    
    DBMS_OUTPUT.PUT_LINE(NAME);
END;

-- CURSOR 사용
DECLARE
    -- 일반변수
    NM VARCHAR2(30);
    SALARY NUMBER;
    -- 커서
    CURSOR X IS SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';
    
BEGIN
    
    OPEN X; -- 커서의 선언
        DBMS_OUTPUT.PUT_LINE('---------커서 시작---------');
    LOOP
        FETCH X INTO NM, SALARY; -- NM변수와 SALARY 에 저장
        -- CURSOR 탈출이 없으면 BUFFER OVERFLOW 에러 발생
        EXIT WHEN X%NOTFOUND; -- X 커서가 더이상 읽을 값이 없으면 TRUE
        DBMS_OUTPUT.PUT_LINE(NM);
        DBMS_OUTPUT.PUT_LINE(SALARY);
        
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('---------커서 종료---------');
    DBMS_OUTPUT.PUT_LINE('데이터 수:' || X%ROWCOUNT); -- 커서에서 읽은 데이터 수
    
    CLOSE X; -- 커서 닫음
END;
