-- DDL 문장
-- CREATE, ALTER, DROP
-- DDL 문은 TRANSACTION이 없다

DROP TABLE DEPTS; -- 테이블 삭제

CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2), -- 숫자 2자리
    DEPT_NAME VARCHAR2(30), -- 30바이트 (한글은 15글자, 영어 30글자)
    DEPT_YN CHAR(1), -- 고정문자 1BYTE
    DEPT_DATE DATE, 
    DEPT_BONUS NUMBER(10, 2), -- 정수 10자리, 소숫점 2자리수 까지 저장
    DEPT_CONTENT LONG -- 2기가 까지 저장가능한 가변 문자열 (VARCHAR2 보다 더큰). DB마다 이름이 조금씩 다름
);

DESC DEPTS;

INSERT INTO DEPTS VALUES(99, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~~~');
INSERT INTO DEPTS VALUES(100, 'HELLO', 'Y', SYSDATE, 3.14, 'LONG TEXT~'); -- DEPT_NO 초과
INSERT INTO DEPTS VALUES(1, 'HELLO', '가', SYSDATE, 3.14, 'LONG TEXT~'); -- DEPT_YN 초과 (한글은 2BYTE)
INSERT INTO DEPTS VALUES(1, 'HELLO', 'Y', SYSDATE, 123.123, 'LONG TEXT~'); -- DEPT_BONUS에 123.12 까지만 저장됨
SELECT * FROM DEPTS;

-- ALTER
-- 테이블 구조 변경
-- ADD, MODIFY, RENAME, COLUMN, DROP COLUMN

DESC DEPTS;
SELECT * FROM DEPTS;

ALTER TABLE DEPTS ADD DEPT_COUNT NUMBER(3); -- 마지막에 컬럼 추가

ALTER TABLE DEPTS RENAME COLUMN DEPT_COUNT TO EMP_COUNT; -- 컬럼명 변경

ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(5); -- 컬럼의 크기 수정
ALTER TABLE DEPTS MODIFY EMP_COUNT NUMBER(1);
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR(1); -- 기존 데이터가 변경할 크기보다 큰 경우 변경불가

ALTER TABLE DEPTS DROP COLUMN EMP_COUNT; -- 컬럼 삭제

--------------------------------------------------------------------------------
-- DROP
-- 테이블 삭제
DROP TABLE DEPTS; -- 테이블을 삭제. 자동 커밋. 트랜잭션이 영구적으로 변함(되돌릴 수 없다)
DROP TABLE DEPTS CASCADE /*제약조건명*/; -- 테이블이 가지는 FK 제약조건을 삭제하고 테이블을 삭제한다. (위험)

DROP TABLE DEPARTMENTS; -- FK 제약조건이 있어 삭제 불가(EMPLOYEES 테이블과 참조관계)

--------------------------------------------------------------------------------
