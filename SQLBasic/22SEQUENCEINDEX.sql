-- SEQUENCE
-- 순차적으로 증가하는 값
-- 주로 PK에 적용될 수 있습니다.
-- 시퀀스가 없는 데이터베이스도 있습니다.

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE 생성
CREATE SEQUENCE DEPTS_SEQ
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 10
    NOCYCLE  -- 최대값에 도달했을 때 재사용 하지 않음
    NOCACHE; -- 캐시에 시퀀스를 두지 않음
    
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

-- SEQUENCE 사용
-- CURRVAL, NEXTVAL
SELECT DEPTS_SEQ.CURRVAL FROM DUAL; -- 현재 시퀀스 (NEXTVAL 가 선행 되어야 한다.)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; -- 현재 시퀀스 증가값 만큼 증가

-- TABLE 에 SEQUENCE 값을 넣기
INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL,  'EXAMPLE');
-- 10 까지 증가한 이후 오류 발생
-- sequence DEPTS_SEQ.NEXTVAL exceeds MAXVALUE and cannot be instantiated
SELECT * FROM DEPTS;

-- SEQUENCE 수정
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

INSERT INTO DEPTS VALUES(DEPTS_SEQ.NEXTVAL, 'EXAMPLE2');
SELECT * FROM DEPTS;

-- SEQUENCE 삭제
DROP SEQUENCE DEPTS_SEQ;

-- 시퀀스가 이미 사용되고 있다면, DROP 하면 안됩니다.
-- 만약 시퀀스를 초기화 해야한다면?
-- 시퀀스 증가값을 음수로 만들어서 초기화 인것처럼 쓸 수는 있습니다.
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;

-- 1.시퀀스의 증가를 -(현재값 - 1) 로 바꿈
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -39;
-- 2.현재시퀀스를 전진
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
-- 3.다시 증가값을 1로 변경
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
--------------------------------------------------------------------------------
-- SEQUENCE 응용
-- 테이블을 설계할 때, 데이터가 엄청 많다면 시퀀스의 사용 고려
-- 문자열 PK (년도값-일련번호), 년도가 바뀌면 시퀀스 초기화
DROP TABLE DEPTS2;
CREATE TABLE DEPTS2(
    DEPT_NO VARCHAR2(20) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);

INSERT INTO DEPTS2 VALUES(TO_CHAR(SYSDATE, 'YYYY-MM-') || LPAD(DEPTS_SEQ.NEXTVAL, 6, 0), 'EXAMPLE');

SELECT *  FROM DEPTS2;

--------------------------------------------------------------------------------
-- INDEX
-- INDEX는 PK, UNIQUE에 자동으로 생성되고, 조회를 빠르게 하는 HINT 역할을 합니다.
-- INDEX 종류는 고유인덱스, 비고유인덱스 가 있습니다.
-- UNIQUE한 컬럼에는 UNIQUE인덱스(고유인덱스) 가 쓰입니다.
-- 일반 컬럼에는 비고유인덱스를 지정할 수 있습니다.
-- INDEX는 조회를 빠르게 하지만, DML 구문이 많이 사용되는 컬럼은 오히려 성능저하를 부를 수도 있습니다.

CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES);
-- INDEX 생성

-- INDEX 가 없을 때 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- 비고유 인덱스 생성
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME);
-- INDEX 생성 후 조회
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Nancy';

-- INDEX 의 삭제
-- INDEX는 삭제 하더라도 테이블에 영향을 미치지 않습니다.
DROP INDEX EMPS_IT_IX;

-- 결합 인덱스
-- 여러개의 컬럼을 동시에 인덱스로 지정.
CREATE INDEX EMPS_IT_IX ON EMPS_IT (FIRST_NAME, LAST_NAME);

SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
SELECT * FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy' AND LAST_NAME = 'Greenberg';
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Greenberg';

-- 고유 인덱스
-- PK, UK 에서 자동 생성
-- CREATE UNIQUE INDEX 인덱스명 ~~~~~~