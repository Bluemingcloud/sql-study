-- PLSQL 문제
--4. 부서벌 급여합을 출력하는 커서구문을 작성해봅시다.
DESC EMP_SAL;
SELECT * FROM EMP_SAL;


DECLARE
    DEPARTMENT_NAME VARCHAR2(30);
    SUM_SALARY NUMBER;
    
    CURSOR X IS SELECT (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID), 
                SUM(E.SALARY) FROM EMPLOYEES E GROUP BY DEPARTMENT_ID;
BEGIN
    OPEN X;
    LOOP
        FETCH X INTO DEPARTMENT_NAME, SUM_SALARY;
        EXIT WHEN X%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('부서:' || DEPARTMENT_NAME || ', 급여합:' || SUM_SALARY);
        
    END LOOP;
    CLOSE X;
END;


--5. 사원테이블의 연도별 급여합을 구하여 EMP_SAL에 순차적으로 INSERT하는 커서구문을 작성해봅시다.
DROP TABLE EMP_SAL;
-- EMP_SAL 테이블 생성
CREATE TABLE EMP_SAL(
    YEARS VARCHAR2(50),
    SALARY_AVG NUMBER(10)
);
-- EMP_SAL 테이블의 초기값 (2007 년도의 값 넣기)
DECLARE
    YEARS VARCHAR2(50) := 2007;
    SALARY_AVG NUMBER(10);
BEGIN
    SELECT AVG(SALARY)
    INTO SALARY_AVG
    FROM EMPLOYEES 
    WHERE TO_CHAR(HIRE_DATE, 'YYYY') = YEARS;
    
    INSERT INTO EMP_SAL VALUES (YEARS, SALARY_AVG);
    COMMIT;
END;

SELECT * FROM EMP_SAL;
-- SALARY_SUM 열 생성
ALTER TABLE EMP_SAL ADD SALARY_SUM NUMBER;

DECLARE
    CURSOR X IS SELECT YEARS,
                       SUM(SALARY) AS SALARY_SUM
                FROM (SELECT TO_CHAR(HIRE_DATE, 'YYYY') AS YEARS,
                             SALARY
                      FROM EMPLOYEES
                      ) 
                GROUP BY YEARS;
BEGIN
    -- FOR IN X 로 사용 가능. OPEN 과 CLOSE 생략.
    FOR I IN X
    LOOP
        -- FETCH 도 필요없음(IN X 가 FETCH 역할)
        -- 기존에 2007년의 값이 있으므로 MERGE 사용
        MERGE INTO EMP_SAL A
        USING (SELECT I.YEARS, I.SALARY_SUM FROM DUAL)
        ON (A.YEARS = I.YEARS)
        WHEN MATCHED THEN 
            UPDATE SET A.SALARY_SUM = I.SALARY_SUM
        WHEN NOT MATCHED THEN
            INSERT (YEARS, SALARY_SUM)
            VALUES (I.YEARS, I.SALARY_SUM);
    END LOOP;
    COMMIT;
END;

DELETE FROM EMP_SAL;

SELECT * FROM EMP_SAL;