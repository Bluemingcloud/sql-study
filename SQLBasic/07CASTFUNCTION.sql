-- 변환 함수
-- 데이터베이스의 형변환
-- CHAR, NUM, DATE

-- 자동형변환을 제공해 줍니다. (문자, 숫자), (문자, 날짜)
SELECT * FROM EMPLOYEES WHERE SALARY >= '20000'; -- SALARY 값은 숫자지만 '20000' 은 문자. 문자를 숫자로 자동 형변환 하여 비교
SELECT * FROM EMPLOYEES WHERE HIRE_DATE >= '08/01/01'; -- HIRE_DATE 값은 날짜지만 '08/01/01' 은 문자. 문자를 날짜로 자동 형변환 하여 비교

-- 강제 형변환
-- TO_CHAR
-- 날짜를 문자로 변환
 SELECT SYSDATE,
        TO_CHAR(SYSDATE),
        TO_CHAR(SYSDATE, 'YY-MM-DD'),
        TO_CHAR(SYSDATE, 'YYYY_MM_DD HH12:MI:SS') AS TIME,
        TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS DAY
 FROM DUAL;
 
 -- 숫자를 문자로 변환
 -- 숫자도 포맷형식이 존재
 SELECT TO_CHAR(20000, '999999999') AS RESULT1, -- 9로 나타내고자 하는 자리수 표현
        TO_CHAR(20000, '099999999') AS RESULT2, -- 맨 앞 0은 남는자리 0으로 채우기
        TO_CHAR(20000, '999') AS RESULT3, -- 자리수가 부족하면 #으로 처리
        TO_CHAR(20000.123, '999999.9999') AS RESULT4, -- 정수부분 6자리, 실수부분 4자리
        TO_CHAR(20000, '$999999999') AS RESULT5, -- $는 맨 앞 $기호 표기
        TO_CHAR(20000, 'L999999999') AS RESULT6, -- 각 국 지역화폐기호 (로컬 시스템 기준)
        TO_CHAR(20000, 'L999,999,999') AS RESULT7 -- 자리수 마다 , 사용 가능
 FROM DUAL;
 
 -- 작성해보기
 -- 오늘 환율 1372.17원 일 때, EMPLOYEES 의 SALARY 값을 원화로 표현
 SELECT FIRST_NAME, SALARY, TO_CHAR(SALARY * 1372.17, 'L999,999,999') AS 원화 FROM EMPLOYEES;
 
 -- TO_DATE
 -- 문자를 날짜로 변환
 SELECT TO_DATE('2024-06-13', 'YYYY-MM-DD'), -- 날짜 모형에 맞춰 형식 작성
        ROUND(SYSDATE - TO_DATE('2024_06_13', 'YYYY_MM_DD'), 5) AS RESULT1, -- 날짜 연산 가능
        TO_DATE('2024년 06월 13일', 'YYYY"년" MM"월" DD"일"') AS RESULT2, -- 날짜 포맷 문자가 아니라면 ""
        TO_DATE('24-06-13 11시 30분 23초', 'YY-MM-DD HH"시" MI"분" SS"초"') AS RESULT3
 FROM DUAL;
 
 -- 240613 문자를 2024년06월13일 의 문자로 변환하기
 SELECT TO_CHAR(TO_DATE('240613', 'YYMMDD'), 'YYYY"년"MM"월"DD"일"') AS 날짜 FROM DUAL;
 
 -- TO_NUMBER
 -- 문자를 숫자로 변환
 SELECT '4000' - 1000 FROM DUAL; -- 문자를 숫자로 자동 형변환(문자에 숫자만 존재해야한다.)
 SELECT TO_NUMBER('4000') - 1000 FROM DUAL; -- 명시적 변환 후 연산
 
 SELECT '$5,500' - 1000 FROM DUAL; -- 자동 형변환 불가
 SELECT TO_NUMBER('$5,500', '$999,999') - 1000 AS RESULT1, -- 문자를 숫자로 형변환 후 연산
        TO_CHAR(TO_NUMBER('$5,500', '$999,999') * 1372.17, 'L999,999,999') AS RESULT2 -- 문자 '$5,500' 을 환율 계산하여 원화로 출력
 FROM DUAL;
 
 
 