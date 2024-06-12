-- 문자열 함수
-- DUAL 가상테이블
-- 테이블 없이 SQL문을 간단하게 연습 하기 위한 가상 테이블
SELECT 'HELLO WORLD', LOWER('HELLO WORLD') FROM DUAL;

-- LOWER, UPPER, INITCAP
-- 문자열 대소문자 변경
SELECT LAST_NAME, LOWER(LAST_NAME), INITCAP(LAST_NAME), UPPER(LAST_NAME)
FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN%';

-- LENGTH
-- 문자열 길이 반환
SELECT FIRST_NAME, LENGTH(FIRST_NAME) FROM EMPLOYEES WHERE JOB_ID LIKE 'IT%';

-- INSTR
-- 문자열 찾기. 없으면 0 반환. 문자열 인덱스는 1부터 시작
SELECT FIRST_NAME, INSTR(FIRST_NAME, 'a') FROM EMPLOYEES;

-- SUBSTR
-- 문자열 자르기. 인덱스 문자부터 입력한 개수 만큼 자르기. 개수입력을 생략하면 문자열 끝까지 자른 값 반환.
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 2) FROM EMPLOYEES;

-- CONCAT
-- 문자열 합치기
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME, CONCAT(FIRST_NAME, LAST_NAME) FROM EMPLOYEES;

-- LPAD, RPAD
-- 범위를 지정하고 특정 문자로 채움
SELECT LPAD('ABC', 10, '*'), RPAD('DEF', 6, '-') FROM DUAL;
SELECT LPAD(FIRST_NAME, 10, '*'), RPAD(FIRST_NAME, 10, '-') FROM EMPLOYEES;

-- TRIM, LTRIM, RTRIM
-- 공백제거, 왼쪽 공백제거 -값을 넣으면 왼쪽에서부터 해당 값 지운다
SELECT TRIM('  HELLO WORLD    '), LTRIM('   HELLO WORLD      '), RTRIM('  HELLO WORLD    ') FROM DUAL;
SELECT LTRIM('HELLO WORLD  ', 'HE') FROM DUAL;

-- REPLACE
-- 해당 문자를 특정 문자로 바꾼다.
SELECT 'JAVASPECIALIST', REPLACE('JAVASPECIALIST', 'JAVA', 'DATABASE') FROM DUAL;
SELECT REPLACE('서울 대전 대구 부산 찍고', ' ', '->') FROM DUAL;
SELECT REPLACE('서울 대전 대구 부산 찍고', ' ', '') FROM DUAL;