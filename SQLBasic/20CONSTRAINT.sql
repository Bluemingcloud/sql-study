-- 제약조건
-- 컬럼에 대한 데이터 수정, 삭제, 삽입 등 에서 발생하는 이상을 방지하기 위한 조건
-- PRIMARY KEY
-- 테이블 고유 키. 중복 X, NULL X, PK는 테이블에서 1개만 지정 가능

-- NOT NULL
-- NULL 을 허용하지 않음.

-- UNIQUE KEY
-- 중복 X, NULL O. 이메일, 전화번호 등

-- FOREIGN KEY
-- 참조하는 테이블에 PK를 넣어놓은 키. 중복 O, NULL O

-- CHECK
-- 컬럼에 대한 데이터 제한

-- 전체 제약조건 확인
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE DEPTS;

-- 첫번째
-- COLUMN LEVEL 제약조건 정의
CREATE TABLE DEPTS(
        DEPT_NO    NUMBER(2) CONSTRAINT     DEPTS_DEPT_NO_PK PRIMARY KEY, -- 제약조건 명을 생략하면 자동으로 적어서 저장된다.
      DEPT_NAME VARCHAR2(30) CONSTRAINT   DEPTS_DEPT_NAME_NN    NOT NULL,
      DEPT_DATE         DATE    DEFAULT              SYSDATE, -- 컬럼의 기본 값을 지정(제약조건은 아님). , 로 연결해서 작성 가능
     DEPT_PHONE VARCHAR2(30) CONSTRAINT  DEPTS_DEPT_PHONE_UK      UNIQUE,
    DEPT_GENDER      CHAR(1) CONSTRAINT DEPTS_DEPT_GENDER_CK       CHECK(DEPT_GENDER IN('F', 'M')),
        LOCA_ID    NUMBER(4) CONSTRAINT     DEPTS_LOCA_ID_FK  REFERENCES LOCATIONS(LOCATION_ID)
);

SELECT * FROM DEPTS;

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, NULL, '010-1234-1234', 'F', 1700); -- DEPT_NAME 은 NOT NULL 제약이라 NULL 값이 들어가지 못한다.

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, '홍길동', '010-1234-1234', 'X', 1700); -- CHECK 제약 위배 (F, M 일때 만 저장 가능)

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, '홍길동', '010-1234-1234', 'F', 100); -- 참조 제약 위배 (PK 값이 아닌 값은 FK 로 저장 불가)

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, '홍길동', '010-1234-1234', 'F', 1700); -- PK 1 데이터 저장 성공

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(1, '홍길동', '010-1234-1234', 'F', 1700); -- PK 1인 값에 저장 불가

INSERT INTO DEPTS(DEPT_NO, DEPT_NAME, DEPT_PHONE, DEPT_GENDER, LOCA_ID)
VALUES(2, '홍길동', '010-1234-1234', 'F', 1700); -- UK 제약 위배 (DEPT_PHONE 은 같은값 중복 불가 UNIQUE)

SELECT * FROM DEPTS;

--------------------------------------------------------------------------------
-- 두번째
-- TABLE LEVEL 제약조건 정의
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR(30) NOT NULL, -- NOT NULL 제약은 COLUMN LEVEL 로 정의
    DEPT_DATE DATE DEFAULT SYSDATE, -- DEFAULT 값은 COLUMN 옆에 적어준다.
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4),
    CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY (DEPT_NO, DEPT_NAME), -- 슈퍼키 생성 가능
    CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE (DEPT_PHONE),
    CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M')),
    CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID)    
);

DESC DEPTS;
--------------------------------------------------------------------------------
-- ALTER 로 제약조건 추가
DROP TABLE DEPTS;
CREATE TABLE DEPTS (
    DEPT_NO NUMBER(2),
    DEPT_NAME VARCHAR(30),
    DEPT_DATE DATE DEFAULT SYSDATE,
    DEPT_PHONE VARCHAR2(30),
    DEPT_GENDER CHAR(1),
    LOCA_ID NUMBER(4)
);

-- PK 추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_NO_PK PRIMARY KEY (DEPT_NO);
-- NOT NULL 은 열 변경(MODIFY) 로 추가합니다.
ALTER TABLE DEPTS MODIFY DEPT_NAME VARCHAR2(30) NOT NULL;
-- UK 추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_PHONE_UK UNIQUE (DEPT_PHONE);
-- CHECK 추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_DEPT_GENDER_CK CHECK(DEPT_GENDER IN ('F', 'M'));
-- FK 추가
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_LOCA_ID_FK FOREIGN KEY (LOCA_ID) REFERENCES LOCATIONS(LOCATION_ID);

-- 제약 조건 삭제
ALTER TABLE DEPTS DROP CONSTRAINT DEPTS_DEPT_GENDER_CK; 
