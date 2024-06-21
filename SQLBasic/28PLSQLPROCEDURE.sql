-- 스토어드 프로시저
-- 일련의 SQL 처리 과정을 집합처럼 묶어서 사용하는 구조

-- 선언과 호출이 있습니다.
-- 선언
SET SERVEROUTPUT ON;
DROP PROCEDURE NEW_JOB_POC;
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- PROCEDURE 명
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WORLD!');
END; -- 컴파일 되었습니다.

-- 호출
EXEC NEW_JOB_POC;

--------------------------------------------------------------------------------
-- PROCEDURE의 매개변수 IN
CREATE OR REPLACE PROCEDURE NEW_JOB_PROC -- 이름이 같으면 자동으로 수정됨.
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
EXEC NEW_JOB_PROC('EXAMPLE'); -- 매개변수가 일치하지 않으면 X
EXEC NEW_JOB_PROC('EXAMPLE2', 'EXAMPLE2'); -- 매개변수에 DEFAULT 값이 설정되어 있으면 해당 변수를 적지 않아도 동작
DESC JOBS_IT;
SELECT * FROM JOBS_IT;

--------------------------------------------------------------------------------
-- PLSQL 모든 구문 제어문, 탈출문, 커서구문을 PROCEDURE에 쓸 수 있습니다.
-- JOB_ID 가 존재하면 UPDATE, 없으면 INSERT
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
    INTO CNT -- 개수를 CNT 에 저장
    FROM JOBS_IT
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        -- JOB_ID 가 없다면
        INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    
    ELSE
        -- JOB_ID 가 있다면
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
-- OUT 매개변수
-- PROCEDURE 외부로 값을 돌려주기 위해 사용하는 매개변수

CREATE OR REPLACE PROCEDURE NEW_JOB_PROC
    (P_JOB_ID IN VARCHAR2,
     P_JOB_TITLE IN VARCHAR2,
     P_MIN_SALARY IN NUMBER,
     P_MAX_SALARY IN NUMBER,
     P_CNT OUT NUMBER -- 외부로 전달할 매개변수
     )
IS
    CNT NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO CNT -- 개수를 CNT 에 저장
    FROM JOBS_IT
    WHERE JOB_ID = P_JOB_ID;
    
    IF CNT = 0 THEN
        -- JOB_ID 가 없다면
        INSERT INTO JOBS_IT VALUES(P_JOB_ID, P_JOB_TITLE, P_MIN_SALARY, P_MAX_SALARY);
    
    ELSE
        -- JOB_ID 가 있다면
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
    new_job_proc('AD_VP', 'ADMIN', 1000, 10000, CNT); -- 익명블록 안에서는 EXEC 제외
    
    DBMS_OUTPUT.PUT_LINE('프로시저 내부에서 할당받은 값:' || CNT);
    
END;
--------------------------------------------------------------------------------
-- RETURN
-- 프로시저를 종료함
-- EXCEPTION WHEN OTHERS THEN 예외처리

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
        DBMS_OUTPUT.PUT_LINE('값이 없습니다.');
        RETURN; -- 프로시저 종료
    ELSE
        
        SELECT MAX_SALARY
        INTO SALARY
        FROM JOBS
        WHERE JOB_ID = P_JOB_ID;
        
        DBMS_OUTPUT.PUT_LINE('최대급여:' || SALARY);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('프로시저 정상 종료!');
    
    -- 예외처리 구문(예외를 만나면 예외문장이 실행됨)
    EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외가 발생했습니다.');
END;

EXEC NEW_JOB_PROC2('AD'); -- 값이 없으므로 RETURN을 만나 프로시저 종료
EXEC NEW_JOB_PROC2('AD_VP');

