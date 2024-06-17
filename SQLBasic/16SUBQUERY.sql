-- 서브 쿼리
-- SELECT 문 안에 SELECT
-- 단일행 서브쿼리
-- 서브쿼리의 결과가 1행인 서브쿼리

-- Nancy 보다 급여가 높은 사람
-- 1. Nancy의 급여를 찾는다.
SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';
-- 2. 찾은 급여를 WHERE절에 넣는다.
SELECT * FROM EMPLOYEES WHERE SALARY > 12008;

-- 서브쿼리절로 작성
SELECT * FROM EMPLOYEES WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

-- 103번과 직업이 같은 사람
-- 1. 103번의 직업을 찾는다.
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
-- 2. 찾은 직업이름을 WHERE절에 넣는다.
SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

-- 서브쿼리절로 작성
SELECT * FROM EMPLOYEES WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

-- 서브쿼리절 사용시 주의 할 점
-- 비교할 컬럼은 정확히 한개여야 합니다.
SELECT *
FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103); -- 서브쿼리절 안의 행이 많아서 오류

-- 서브쿼리절의 값이 여러행이 나오는 구문이라면, 다중행 서브쿼리 연산자를 써줘야합니다.
SELECT * 
FROM EMPLOYEES
WHERE SALARY >= (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Steven'); -- 이름이 Steven 인 데이터가 2개 존재해서 오류

--------------------------------------------------------------------------------
-- 다중행 서브쿼리
-- 서브쿼리의 결과가 여러행 리턴되는 경우 IN, ANY, ALL 로 비교
-- ANY, ALL
-- 다중행 데이터의 비교
SELECT SALARY
FROM EMPLOYEES
WHERE FIRST_NAME = 'David'; -- 4800, 6800, 9500

-- David 의 '최소' 급여보다 많이 받는 사람
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David 의 '최대' 급여보다 많이 받는 사람
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES 
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David 의 '최대' 급여보다 적게 받는 사람
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- David 의 '최소' 급여보다 적게 받는 사람
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'David');

-- IN
-- 다중행 데이터중 일치하는 데이터
SELECT DEPARTMENT_ID, FIRST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID 
                       FROM EMPLOYEES 
                       WHERE FIRST_NAME = 'David');
--------------------------------------------------------------------------------
-- 스칼라(Scala) 서브쿼리
-- SELECT 절에 사용하는 서브쿼리
-- 특정 테이블에 1개의 컬럼만 가져올때 유용하다.
-- JOIN 구문을 대체하여 사용가능.

-- JOIN 을 사용할 때
SELECT 
    E.DEPARTMENT_ID AS DEPARTMENT_ID,
    E.FIRST_NAME AS FIRST_NAME,
    D.DEPARTMENT_NAME AS DEPARTMENT_NAME    
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IN (SELECT E.DEPARTMENT_ID 
                          FROM EMPLOYEES E WHERE E.FIRST_NAME = 'David');

-- 스칼라 쿼리로 작성
SELECT
    E.DEPARTMENT_ID AS DEPARTMENT_ID,
    E.FIRST_NAME AS FIRST_NAME,
    (SELECT DEPARTMENT_NAME 
     FROM DEPARTMENTS D 
     WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPARTMENT_NAME
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE FIRST_NAME = 'David');
    
-- 스칼라 쿼리는 다른 테이블의 컬럼 1개를 가지고 올 때, JOIN보다 구문이 깔끔합니다.
SELECT * FROM JOBS;
-- COLUMN 한 개 JOIN
SELECT 
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

-- COLUMN 여러개 JOIN
SELECT
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE, MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
    -- 스칼라 쿼리 안의 결과 값은 하나만 가능!
FROM EMPLOYEES E;

SELECT 
    FIRST_NAME,
    JOB_ID,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE,
    (SELECT MIN_SALARY FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS MIN_SALARY
FROM EMPLOYEES E;
-- 여러개의 COLUMN 을 JOIN 할 때는 JOIN 구문이 가독성이 더 좋을 수 있다.
SELECT
    FIRST_NAME,
    E.JOB_ID AS JOB_ID,
    JOB_TITLE,
    MIN_SALARY
FROM EMPLOYEES E
LEFT JOIN JOBS J 
ON E.JOB_ID = J.JOB_ID;

-- 예제
-- FIRST_NAME, DEPARTMENT_NAME, JOB_TITLE 을 동시에 SELECT
-- 스칼라 쿼리 구문
SELECT 
    FIRST_NAME,
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID) AS DEPARTMENT_NAME,
    (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID) AS JOB_TITLE
FROM EMPLOYEES E;

-- JOIN 구문
SELECT 
    E.FIRST_NAME,
    D.DEPARTMENT_NAME,
    J.JOB_TITLE
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID;
--------------------------------------------------------------------------------
-- 인라인 뷰
-- FROM 절 하위에 서브쿼리절이 들어갑니다.
-- 인라인 뷰에서 (가상컬럼) 을 만들고, 그 컬럼에 대해서 조회해 나갈때 사용합니다.
SELECT *
FROM (SELECT * 
      FROM EMPLOYEES);
      
-- ROWNUM 은 조회된 순서에 대해 번호가 붙습니다.
-- PK 기준 해당 인덱스 순서
SELECT 
    ROWNUM,
    FIRST_NAME,
    SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- ORDER 를 먼저 시킨 결과에 대해 재조회
SELECT
    ROWNUM,
    FIRST_NAME,
    SALARY
FROM (SELECT
          FIRST_NAME,
          SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      )
WHERE ROWNUM BETWEEN 11 AND 20; -- ROWNUM 은 반드시 1부터 시작해야한다.

-- 11부터 20의 값은? 1부터 조회된 ROWNUM 을 가상열로 만든 후 재조회
SELECT *
FROM (
    SELECT 
        ROWNUM AS RN, -- 가상열(인위적으로 생성된 열)
        FIRST_NAME,
        SALARY
    FROM (
        SELECT 
            FIRST_NAME,
            SALARY
        FROM EMPLOYEES
        ORDER BY SALARY DESC
    )
)
WHERE RN BETWEEN 11 AND 20; -- 안에서 가상열로 만들어진 데이터를 밖에서 사용할 수 있음

-- 예시
-- 근속년수가 5의 배수인 사람들만 출력
SELECT 
    FIRST_NAME,
    TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수
FROM EMPLOYEES
WHERE MOD(근속년수, 5) = 0 -- WHERE 절에 ALIAS 사용 불가
ORDER BY 근속년수 DESC;

-- 인라인 뷰 사용
SELECT *
FROM (
    SELECT
        FIRST_NAME,
        HIRE_DATE,
        TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수
    FROM EMPLOYEES
    ORDER BY 근속년수 DESC
)
WHERE MOD(근속년수, 5) = 0;

-- 인라인 뷰에서 테이블 ALIAS 로 조회
SELECT 
    ROWNUM AS RN,
    A.*
FROM (
    SELECT
        E.*,
        TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수
    FROM EMPLOYEES E
    ORDER BY 근속년수 DESC 
) A
WHERE MOD(A.근속년수, 5) = 0;

SELECT *
FROM (
    SELECT 
        ROWNUM AS RN,
        A.*
    FROM (
        SELECT
            E.*,
            TRUNC((SYSDATE - HIRE_DATE) / 365) AS 근속년수
        FROM EMPLOYEES E
        ORDER BY 근속년수 DESC 
    ) A
    WHERE MOD(A.근속년수, 5) = 0
)
WHERE RN BETWEEN 5 AND 10;