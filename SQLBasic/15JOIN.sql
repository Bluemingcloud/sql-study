SELECT * FROM INFO;
SELECT * FROM AUTH;

-- INNER JOIN
-- 붙을수 없는 값은 나오지 않는다.
SELECT * FROM INFO INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.AUTH_ID;

SELECT 
    INFO.ID,
    INFO.TITLE,
    INFO.CONTENT,
    TO_CHAR(INFO.REGDATE, 'MM/DD/YYYY') AS REGDATE,
    INFO.AUTH_ID,   -- AUTH_ID 는 양쪽 테이블에 다있는 KEY
    AUTH.NAME       -- TABEL명.COLUMN명 으로 사용해야 출력 가능 
                    -- TABEL명.COLUMN명 을 사용하려면 모두 써주는게 좋다.
FROM INFO
INNER JOIN AUTH
ON INFO.AUTH_ID = AUTH.AUTH_ID;
        
-- TABLE명 에도 별칭(ALIAS) 사용가능
-- TABLE명 원하는별칭
SELECT 
    I.ID,
    I.TITLE,
    A.AUTH_ID,
    A.NAME,
    A.JOB
FROM INFO I -- TABLE ALIAS
INNER JOIN AUTH A
ON I.AUTH_ID = A.AUTH_ID;

-- 연결할 키가 같다면 USING 구문을 사용할 수 있음
SELECT * 
FROM INFO I
INNER JOIN AUTH A
USING(AUTH_ID);

----------------------------------------------------------------
-- OUTER JOIN
-- LEFT OUTER JOIN(OUTER 생략 가능)
-- FROM 테이블1 LEFT JOIN 테이블2
-- 왼쪽의 테이블1 기준으로 왼쪽테이블의 해당하는 행 만큼 값이 다 나온다.
SELECT * FROM INFO I LEFT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT OUTER JOIN
-- FROM 테이블1 RIGHT JOIN 테이블2
-- 오른쪽의 테이블2 기준으로 오른쪽테이블의 해당하는 행 만큼 값이 다 나온다.(중복적용)
SELECT * FROM INFO I RIGHT JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;

-- RIGHT JOIN 의 좌우 테이블 자리만 바꾸면 LEFT JOIN 과 같은 결과
SELECT * FROM AUTH A RIGHT JOIN INFO I ON A.AUTH_ID = I.AUTH_ID;

-- FULL OUTER JOIN
-- 양쪽 테이블 모두 누락없이 나온다.
SELECT * FROM INFO I FULL JOIN AUTH A ON I.AUTH_ID = A.AUTH_ID;


-- CROSS JOIN
-- 잘못된 JOIN 의 형태. 실제로 사용할 일은 없다.
SELECT * FROM INFO I CROSS JOIN AUTH A;
SELECT * FROM AUTH A CROSS JOIN INFO I;
--------------------------------------------------------------------

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

SELECT * 
FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- JOIN 은 여러번 할 수 있다.
SELECT 
    E.FIRST_NAME,
    D.DEPARTMENT_NAME,
    L.CITY,
    C.COUNTRY_NAME,
    R.REGION_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
LEFT JOIN REGIONS R ON C.REGION_ID = R.REGION_ID
WHERE C.COUNTRY_NAME LIKE 'U%';
------------------------------------------------------------------
-- FK가 있는 N테이블에 1개씩만 가지고있는 1테이블을 JOIN 하는것이 주로 사용되는 방법


--------------------------------------------------------------------
-- SELF JOIN
-- 하나의 테이블을 가지고 JOIN을 거는것
-- FK 로 사용 가능한 값이 있어야 가능하다.
SELECT * FROM EMPLOYEES;

SELECT 
    E1.EMPLOYEE_ID AS EMPLOYEE_ID,
    E1.FIRST_NAME || ' ' || E1.LAST_NAME AS NAME,
    E2.EMPLOYEE_ID AS MANAGER_ID,
    E2.FIRST_NAME || ' ' || E2.LAST_NAME AS MANAGER
FROM EMPLOYEES E1
LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID;
--------------------------------------------------------------------
-- ORACLE JOIN
-- ORACLE 에서만 사용가능
-- JOIN 할 TABLE명을 FROM 에, 조건은 WHERE 에 쓴다.
-- ORACLE INNER JOIN
SELECT * 
FROM INFO I, AUTH A 
WHERE I.AUTH_ID = A.AUTH_ID;

-- LEFT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID = A.AUTH_ID(+);

-- RIGHT JOIN
SELECT *
FROM INFO I, AUTH A
WHERE I.AUTH_ID(+) = A.AUTH_ID;

-- ORACLE FULL OUTER JOIN 은 없다.

-- CROSS JOIN 은 잘못된 조인 (조건을 안적으면 나타남)
SELECT *
FROM INFO I, AUTH A;