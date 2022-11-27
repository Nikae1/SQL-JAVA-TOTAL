/**************************************************************************
 DB PROJECT :: DML + QUERY PRACTICE
                       DATABASE BASED ON POS
                                             SMART-WEB USING JS FRAMEWORK
**************************************************************************/

  /* PRACTICE SCENARIO SESSION 1 
     JOB : SYSTEM ACCESS

     CLIENT SIDE
        REQUEST  : (UI)OWCODE, (UI)SRCODE, (UI)SECRETCODE (UE)BUTTON

     SERVER SIDE - DATA PROCESSING 
        (B)STOREINFO >> (S)STOREINFO
        [SEL]OWCODE? >> [SEL]SRCODE? >> [SEL]PASSWORD CHECK 
                     >> [INS]AL      
                     >> [SEL]STOREINFO
                     >> [SEL]PREVIOUS DAY SALESINFO

     SERVER SIDE - RESPONSE
     ********************************************************************
       매장명(매장코드)     대표자명(오너코드)    매장전번    매장위치
     ********************************************************************
       ----------------------------------------------------------------
          매출일자       판매건수        총 판매액           평균 판매액
       ----------------------------------------------------------------
        2022.11.15         5건           100,000              20,000
       ----------------------------------------------------------------
           (CARD)           3건           70,000              
           (CASH)           2건           30,000
       ----------------------------------------------------------------
  */
-- OWCODE : W01   SRCODE : 1234567890  SECRET : 4321
-- P1 [SEL] ?OWCODE  << GROUPING FUNCTION : COUNT(*) MAX(COL) MIN(COL) SUM(COL) AVG(COL)
SELECT COUNT(*)
FROM OW
WHERE OW_CODE = 'W01';
-- P2 [SEL] ?SRCODE  << GROUPING FUNCTION : COUNT(*) MAX(COL) MIN(COL) SUM(COL) AVG(COL)
SELECT COUNT(*) AS CNT
FROM SR
WHERE SR_OWCODE = 'W01' AND SR_CODE = '1234567890';
-- P3 [SEL]PASSWORD CHECK << GROUPING FUNCTION : COUNT(*)
SELECT COUNT(*) AS CNT
FROM SR
WHERE SR_OWCODE = 'W01' AND SR_CODE = '1234567890' AND SR_SECRETCODE = '4321';

-- P4 [INS]AL ACCESSTYPE = 1
INSERT INTO AL(AL_SROWCODE, AL_SRCODE, AL_DATE, AL_TYPE) 
     VALUES('W01', '1234567890', DEFAULT, 1);
COMMIT;

-- P5 [SEL]STOREINFO
 /*********************************************************************
       매장명(매장코드)     대표자명(오너코드)    매장전번    매장위치
         SR    SR             OW      SR         SR          SR
  ********************************************************************/
  SELECT SR.SR_NAME AS SRNAME,
         OW.OW_NAME AS OWNAME,
         SR.SR_PHONE AS SRPHONE,
         SR.SR_LOCATION AS SRLOCATION,
         SR.SR_OWCODE AS OWCODE,
         SR.SR_CODE AS SRCODE
  FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_CODE
  WHERE SR_OWCODE = 'W01' AND SR_CODE = '1234567890';

 -- P6 >> [SEL]PREVIOUS DAY SALESINFO
 /*----------------------------------------------------------------
       매출일자       판매건수        총 판매액           평균 판매액
          OD            OS            OD-SP                 OD-SP
                       
   ----------------------------------------------------------------
     2022.11.15         5건           100,000              20,000
   ----------------------------------------------------------------*/
-- 전날 매출 건수
 SELECT TO_CHAR(OS_DATE, 'YYMMDD') AS SALESDATE, 
        COUNT(*) AS DAILYCNT
 FROM OS 
 WHERE TO_CHAR(OS_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
 GROUP BY TO_CHAR(OS_DATE, 'YYMMDD'); 

-- 전날 매출액 
/*
SELECT [COL],[COL USING GROUPING FUNC] 
FROM [TAB]  
WHERE [CONDITION]  GROUP BY [COL] HAVING [GROUPING-CONDITION]

CEIL(NUMBER) FLOOR(NUMBER) ROUND(NUMBER) TRUNC(NUMBER)
  -- SELECT CEIL(125.521), FLOOR(125.521), ROUND(125.521, 0), 
     ROUND(125.521, 1), ROUND(125.521, -1) FROM DUAL;
*/

SELECT  TO_CHAR(OD.OD_OSDATE, 'YYMMDD') AS SALESDATE,
        SUM(SP.SP_PRICE * OD.OD_QUANTITY) AS SALESAMOUNT,
        FLOOR(AVG(SP.SP_PRICE * OD.OD_QUANTITY)) AS SALESAVG
FROM OD INNER JOIN SP ON OD.OD_OSOWCODE = SP.SP_OWCODE AND OD.OD_SPPRCODE = SP.SP_PRCODE
WHERE TO_CHAR(OD_OSDATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OD.OD_OSDATE, 'YYMMDD');


 -- FINAL :: INNER JOIN USING IN-LINE VIEW
 SELECT T2.SALESDATE AS SALESDATE,
        T1.DAILYCNT AS DAILYCNT,
        T2.SALESAMOUNT AS SALESAMOUNT,
        T2.SALESAVG AS SALESAVG
 FROM (SELECT TO_CHAR(OS_DATE, 'YYMMDD') AS SALESDATE, COUNT(*) AS DAILYCNT
        FROM OS 
        WHERE TO_CHAR(OS_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
        GROUP BY TO_CHAR(OS_DATE, 'YYMMDD')) T1 
       INNER JOIN 
       (SELECT  TO_CHAR(OD.OD_OSDATE, 'YYMMDD') AS SALESDATE,
                SUM(SP.SP_PRICE * OD.OD_QUANTITY) AS SALESAMOUNT,
                FLOOR(AVG(SP.SP_PRICE * OD.OD_QUANTITY)) AS SALESAVG
         FROM OD INNER JOIN SP ON OD.OD_OSOWCODE = SP.SP_OWCODE AND OD.OD_SPPRCODE = SP.SP_PRCODE
         WHERE TO_CHAR(OD_OSDATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
         GROUP BY TO_CHAR(OD.OD_OSDATE, 'YYMMDD')) T2
       ON T1.SALESDATE = T2.SALESDATE;
       
-- FINAL :: INNER JOIN USING VIEW
CREATE OR REPLACE VIEW T1
AS
SELECT TO_CHAR(OS_DATE, 'YYMMDD') AS SALESDATE, 
        COUNT(*) AS DAILYCNT
 FROM OS 
 WHERE TO_CHAR(OS_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
 GROUP BY TO_CHAR(OS_DATE, 'YYMMDD'); 


CREATE OR REPLACE VIEW T2
AS
SELECT  TO_CHAR(OD.OD_OSDATE, 'YYMMDD') AS SALESDATE,
        SUM(SP.SP_PRICE * OD.OD_QUANTITY) AS SALESAMOUNT,
        FLOOR(AVG(SP.SP_PRICE * OD.OD_QUANTITY)) AS SALESAVG
FROM OD INNER JOIN SP ON OD.OD_OSOWCODE = SP.SP_OWCODE AND OD.OD_SPPRCODE = SP.SP_PRCODE
WHERE TO_CHAR(OD_OSDATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OD.OD_OSDATE, 'YYMMDD');

/* 재활용 가능한 형태의 VIEW */
CREATE OR REPLACE VIEW T1
AS
SELECT TO_CHAR(OS_DATE, 'YYMMDD') AS SALESDATE, 
        COUNT(*) AS DAILYCNT
 FROM OS 
 GROUP BY TO_CHAR(OS_DATE, 'YYMMDD'); 

CREATE OR REPLACE VIEW T2
AS
SELECT  TO_CHAR(OD.OD_OSDATE, 'YYMMDD') AS SALESDATE,
        SUM(SP.SP_PRICE * OD.OD_QUANTITY) AS SALESAMOUNT,
        FLOOR(AVG(SP.SP_PRICE * OD.OD_QUANTITY)) AS SALESAVG
FROM OD INNER JOIN SP ON OD.OD_OSOWCODE = SP.SP_OWCODE AND OD.OD_SPPRCODE = SP.SP_PRCODE
GROUP BY TO_CHAR(OD.OD_OSDATE, 'YYMMDD');
  
  -- GRANT VIEW 
     GRANT SELECT ON POSDBA.T1 TO POSDEV;
     GRANT SELECT ON POSDBA.T2 TO POSDEV;
  -- PUBLIC SYNONYM
     CREATE PUBLIC SYNONYM T1 FOR POSDBA.T1;
     CREATE PUBLIC SYNONYM T2 FOR POSDBA.T2;
     
-->> INNER JOIN
SELECT T2.SALESDATE AS SALESDATE,
        T1.DAILYCNT AS DAILYCNT,
        T2.SALESAMOUNT AS SALESAMOUNT,
        T2.SALESAVG AS SALESAVG
FROM T1 INNER JOIN T2 ON T1.SALESDATE = T2.SALESDATE
WHERE T2.SALESDATE = TO_CHAR(SYSDATE-2, 'YYMMDD');

-- P7 결재 통계 
/*  ----------------------------------------------------------------
           (CARD)           3건           70,000              
           (CASH)           2건           30,000
    ---------------------------------------------------------------- */
    -- CARD
        SELECT  '(CARD)' AS PAYMENT, COUNT(*) AS ORDERS, 
                SUM(SD_APPROVALAMOUNT) AS AMOUNT
        FROM SD
        WHERE TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
              AND SD_INSTALLMENT > 0
        INTERSECT
    -- CASH
        SELECT  '(CASH)' AS PAYMENT, COUNT(*) AS ORDERS, 
                SUM(SD_APPROVALAMOUNT) AS AMOUNT
        FROM SD
        WHERE TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
              AND SD_INSTALLMENT = 0;

         
  /* PRACTICE SCENARIO SESSION 2
     JOB : SALES INFOMATION CHECK */
  /* SESSION 2-1
     현재 달을 기준으로 이전 3개월의 매월 매출액 조회
     
     CLIENT SIDE
        REQUEST  : OWCODE, SRCODE, (UI)MONTH, (UE)BUTTON

     SERVER SIDE - DATA PROCESSING 
            (S)STOREINFO  (B)ORDERSINFO
            [SEL](?)ACCESS
              >> (S)STOREINFO
              >> [SEL]SALESINFO FOR LAST THREE MONTHS
                
     SERVER SIDE - RESPONSE
     ********************************************************************
       매장명(매장코드)     대표자명(오너코드)    매장전번    매장위치
     ********************************************************************
       ----------------------------------------------------------------
         매출월       판매건수    총 판매액(전월대비)  평균 판매액(전월대비)
       -----------------------------------------------------------------
        2022.10          5건       100,000   (▼)       20,000   (▼)
        2022.09         10건       300,000   (▲)       30,000   (↔)
        2022.08          7건       210,000   (↔)       30,000   (↔)     
       -----------------------------------------------------------------
       -----------------------------------------------------------------
                      2022.10           2022.09          2022.08
       -----------------------------------------------------------------
           CARD         ???                ???              ???
           CASH         ???                ???              ???
       -----------------------------------------------------------------   
        총 누적 매출액                  510,000
        총 평균 매출액                  170,000
       -----------------------------------------------------------------
  */
-- P1. ACCESS CHECK
SELECT SUM(AL_TYPE) AS ACCESSCHECK
FROM AL WHERE AL_SROWCODE = 'W01' AND AL_SRCODE = '1234567890';

  -- P2. STOREINFO 
  SELECT SR.SR_NAME AS SRNAME,
         OW.OW_NAME AS OWNAME,
         SR.SR_PHONE AS SRPHONE,
         SR.SR_LOCATION AS SRLOCATION,
         SR.SR_OWCODE AS OWCODE,
         SR.SR_CODE AS SRCODE
  FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_CODE
  WHERE SR_OWCODE = 'W01' AND SR_CODE = '1234567890';

  -- P3 SALESINFO FOR LAST THREE MONTHS
  /* ----------------------------------------------------------------
         매출월       판매건수    총 판매액(전월대비)  평균 판매액(전월대비)
       -----------------------------------------------------------------
        2022.10          5건       100,000   (▼)       20,000   (▼)
        2022.09         10건       300,000   (▲)       30,000   (↔)
        2022.08          7건       210,000   (↔)       30,000   (↔)     
       ----------------------------------------------------------------- */
  /* USING VIEW */     
  -- PART 1 MONTHLY ORDERS << USING T1
   SELECT SUBSTR(SALESDATE, 1, 4) AS MONTH, 
          SUM(DAILYCNT) AS MONTHLYCNT
   FROM T1
   WHERE SUBSTR(SALESDATE, 1, 4) >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
         SUBSTR(SALESDATE, 1, 4) < TO_CHAR(SYSDATE, 'YYMM')
   GROUP BY SUBSTR(SALESDATE, 1, 4);
   
  -- PART 2 MONTHLY AMOUNT + MONTHLY AVERAGE << USING T2
   SELECT SUBSTR(SALESDATE, 1, 4) AS MONTH,
          SUM(SALESAMOUNT) AS MONTHLYAMOUNT,
          FLOOR(AVG(SALESAVG)) AS MONTHLYAVG
   FROM T2
   WHERE SUBSTR(SALESDATE, 1, 4) >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
         SUBSTR(SALESDATE, 1, 4) < TO_CHAR(SYSDATE, 'YYMM')
   GROUP BY SUBSTR(SALESDATE, 1, 4);
   
  -- PART 3 INNER JOIN
   SELECT SUBSTR(T1.SALESDATE, 1, 4) AS MONTH,
          SUM(T1.DAILYCNT) AS MONTHLYCNT,
          SUM(T2.SALESAMOUNT) AS MONTHLYAMOUNT,
          FLOOR(AVG(T2.SALESAVG)) AS MONTHLYAVG
   FROM T1 INNER JOIN T2 ON T1.SALESDATE = T2.SALESDATE
   WHERE SUBSTR(T1.SALESDATE, 1, 4) >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
         SUBSTR(T1.SALESDATE, 1, 4) < TO_CHAR(SYSDATE, 'YYMM')
   GROUP BY SUBSTR(T1.SALESDATE, 1, 4);
   
  /* USING TABLE */
   -- PART 1 MONTHLY ORDERS
   SELECT TO_CHAR(OS_DATE, 'YYMM') AS MONTH, 
          COUNT(*) AS MONTHLYCNT
   FROM OS
   WHERE TO_CHAR(OS_DATE, 'YYMM') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
         TO_CHAR(OS_DATE, 'YYMM') < TO_CHAR(SYSDATE, 'YYMM')
   GROUP BY TO_CHAR(OS_DATE,'YYMM');
   
   -- PART 2 MONTHLY AMOUNT + MONTHLY AVERAGE << USING T2
   SELECT TO_CHAR(OD.OD_OSDATE, 'YYMM') AS MONTH,
          SUM(OD.OD_QUANTITY * SP.SP_PRICE) AS MONTHLYAMOUNT,
          FLOOR(AVG(OD.OD_QUANTITY * SP.SP_PRICE)) AS MONTHLYAVG
   FROM OD INNER JOIN SP ON OD.OD_SPPRCODE = SP.SP_PRCODE AND
                            OD.OD_OSOWCODE = SP.SP_OWCODE
   WHERE TO_CHAR(OD.OD_OSDATE, 'YYMM') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
         TO_CHAR(OD.OD_OSDATE, 'YYMM') < TO_CHAR(SYSDATE, 'YYMM')
   GROUP BY TO_CHAR(OD.OD_OSDATE,'YYMM');
   
   -- PART 3 INNER JOIN
   SELECT T1.MONTH, T1.MONTHLYCNT, T2.MONTHLYAMOUNT, T2.MONTHLYAVG
   FROM (SELECT TO_CHAR(OS_DATE, 'YYMM') AS MONTH, 
          COUNT(*) AS MONTHLYCNT
         FROM OS
         WHERE TO_CHAR(OS_DATE, 'YYMM') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
               TO_CHAR(OS_DATE, 'YYMM') < TO_CHAR(SYSDATE, 'YYMM')
         GROUP BY TO_CHAR(OS_DATE,'YYMM')) T1 
   INNER JOIN 
        (SELECT TO_CHAR(OD.OD_OSDATE, 'YYMM') AS MONTH,
                SUM(OD.OD_QUANTITY * SP.SP_PRICE) AS MONTHLYAMOUNT,
                FLOOR(AVG(OD.OD_QUANTITY * SP.SP_PRICE)) AS MONTHLYAVG
         FROM OD INNER JOIN SP ON OD.OD_SPPRCODE = SP.SP_PRCODE AND
                                  OD.OD_OSOWCODE = SP.SP_OWCODE
         WHERE TO_CHAR(OD.OD_OSDATE, 'YYMM') >= TO_CHAR(ADD_MONTHS(SYSDATE, -4), 'YYMM') AND 
               TO_CHAR(OD.OD_OSDATE, 'YYMM') < TO_CHAR(SYSDATE, 'YYMM')
         GROUP BY TO_CHAR(OD.OD_OSDATE,'YYMM')) T2
    ON T1.MONTH = T2.MONTH;
    
    
    
    /* SESSION 2-2
     지난 달의 상품별 매출액 조회
     
     CLIENT SIDE
        REQUEST  : 

     SERVER SIDE - DATA PROCESSING 
        
        
     SERVER SIDE - RESPONSE
     ********************************************************************
       매장명(매장코드)     대표자명(오너코드)    매장전번    매장위치
     ********************************************************************
       ----------------------------------------------------------------
         2022.10       판매건수    매입가      매출총액      영업이익
            OD           OD        SP        SP * OD    SP*OD - SP*OD
            PR
       -----------------------------------------------------------------
         새우깡            10       1000         15000        5000
         양파깡             9
         감자깡             7
           :
           :
       -----------------------------------------------------------------
  */
  -- MASTER VIEW
  CREATE OR REPLACE VIEW PRODUCTINFO
  AS
    SELECT  SP.SP_PRCODE AS PRCODE, SP_OWCODE AS OWCODE,
            SP.SP_GROUP AS GRCODE, SP.SP_STATE AS STATUS,
            PR.PR_NAME AS PRNAME,
            SP.SP_COST AS COST, SP.SP_PRICE AS PRICE,
            SP.SP_STOCK AS STOCK, CG.CG_NAME
    FROM SP INNER JOIN PR ON SP.SP_PRCODE = PR.PR_CODE
            INNER JOIN CG ON SP.SP_GROUP = CG.CG_CODE;
  
  SELECT * FROM PRODUCTINFO WHERE OWCODE = 'W01';
  
  CREATE OR REPLACE VIEW DAILYSALES1
  AS
    SELECT  OD_OSOWCODE AS OWCODE,
            OD_OSSRCODE AS SRCODE,
            TO_DATE(TO_CHAR(OD_OSDATE, 'YYYYMMDD'), 'YYYYMMDD') AS ODDATE,
            OD_OSMECMCODE AS CMCODE, 
            OD_SPPRCODE AS PRCODE,
            COUNT(OD_SPPRCODE) AS PRODUCTS,
            SUM(OD_QUANTITY) AS QUANTITY
    FROM OD 
    GROUP BY OD_OSOWCODE, OD_OSSRCODE, 
             TO_DATE(TO_CHAR(OD_OSDATE, 'YYYYMMDD'), 'YYYYMMDD'), 
             OD_OSMECMCODE, OD_SPPRCODE;
  
  SELECT * FROM DAILYSALES1;
  
  -- 판매정보와 상품정보의 결합 
  SELECT * FROM DAILYSALES1;
  SELECT COALESCE(GR.ODDATE, TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMM')) AS ODDATE, 
         COALESCE(GR.PRCODE, PI.PRCODE) AS PRCODE, 
         COALESCE(GR.OWCODE, PI.OWCODE) AS GRCODE, PI.PRNAME AS PRNAME, 
         COALESCE(GR.ORDERS, 0) AS ORDERS,
         PI.COST AS COST, COALESCE(GR.QUANTITY, 0) * PI.PRICE AS AMOUNT,
         ((COALESCE(GR.QUANTITY, 0) * PI.PRICE) 
            - 
          (COALESCE(GR.QUANTITY, 0) * PI.COST)
          ) AS PRODUCTMARGIN 
  FROM (SELECT  TO_CHAR(COALESCE(ODDATE, ADD_MONTHS(SYSDATE, -1)), 'YYMM') AS ODDATE, 
                PRCODE, OWCODE, SUM(PRODUCTS) AS ORDERS, SUM(QUANTITY) AS QUANTITY
        FROM DAILYSALES1   
        WHERE OWCODE = 'W01' AND SRCODE = '1234567890' AND 
              TO_CHAR(ODDATE, 'YYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMM')
        GROUP BY TO_CHAR(COALESCE(ODDATE, ADD_MONTHS(SYSDATE, -1)), 'YYMM'), 
                 PRCODE, OWCODE) GR 
  RIGHT OUTER JOIN 
        (SELECT * FROM PRODUCTINFO WHERE OWCODE = 'W01')  PI 
    ON GR.PRCODE = PI.PRCODE AND GR.OWCODE = PI.OWCODE;
  
  
  
  -- CHAR
  CREATE OR REPLACE VIEW DAILYSALES2
  AS
  SELECT TO_CHAR(OD.OD_OSDATE, 'YYMMDD') AS ODDATE, 
         PR.PR_NAME AS PRNAME,
         COUNT(*) AS ORDERS, SUM(OD_QUANTITY) AS QUANTITY,
         SP.SP_COST AS COST, SP.SP_PRICE AS PRICE,
         OD.OD_OSOWCODE AS OWCODE, OD.OD_OSSRCODE AS SRCODE, 
         OD.OD_SPPRCODE AS PRCODE, OD.OD_OSMECMCODE AS CMCODE
  FROM OD INNER JOIN SP ON OD.OD_SPPRCODE = SP.SP_PRCODE AND
                           OD.OD_OSOWCODE = SP.SP_OWCODE
          INNER JOIN PR ON SP.SP_PRCODE = PR.PR_CODE
  GROUP BY OD.OD_OSOWCODE, OD.OD_OSSRCODE, 
           OD.OD_OSMECMCODE, TO_CHAR(OD.OD_OSDATE, 'YYMMDD'), OD.OD_SPPRCODE, 
           PR.PR_NAME, 
           SP.SP_COST, SP.SP_PRICE;
  
  -- DAILY SALES INFOMATION BY PRODUCT
  SELECT * FROM DAILYSALES1;
  SELECT * FROM DAILYSALES2;
  
  SELECT TO_CHAR(ODDATE, 'YYMM') AS ODDATE,
         PRNAME, SUM(ORDERS), COST, 
         SUM(PRICE * QUANTITY) AS SALESAMOUNT,
         SUM((PRICE - COST) * QUANTITY) AS SALESMARGIN
  FROM DAILYSALES1
  WHERE OWCODE = 'W01' AND SRCODE = '1234567890' AND
        TO_CHAR(ODDATE, 'YYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMM') 
  GROUP BY TO_CHAR(ODDATE, 'YYMM'), PRNAME, COST;
  
  SELECT SUBSTR(ODDATE, 1, 4) AS ODDATE,
         PRNAME, SUM(ORDERS), COST, 
         SUM(PRICE * QUANTITY) AS SALESAMOUNT,
         SUM((PRICE - COST) * QUANTITY) AS SALESMARGIN
  FROM DAILYSALES2
  WHERE OWCODE = 'W01' AND SRCODE = '1234567890' AND
        SUBSTR(ODDATE, 1, 4) = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMM')
  GROUP BY SUBSTR(ODDATE, 1, 4), PRNAME, COST;
  
/* WHERE --> SUB-QUERY */
 
DELETE FROM OD
WHERE OD_SPPRCODE IN (
         SELECT PR_CODE FROM PR WHERE PR_NAME = '다시다' OR PR_NAME = '테라');
DELETE FROM OD
WHERE OD_SPPRCODE IN ('30004', '70001');         
         
ROLLBACK;
COMMIT;

/* OUTER JOIN 
   : INNER JOIN에 해당하는 레코드 + 지정한 테이블의 레코드는 모두 출력
*/
SELECT TO_CHAR(ODDATE, 'YYMM') AS ODDATE,
         PRNAME, SUM(ORDERS), COST, 
         SUM(PRICE * QUANTITY) AS SALESAMOUNT,
         SUM((PRICE - COST) * QUANTITY) AS SALESMARGIN
  FROM DAILYSALES1
  WHERE OWCODE = 'W01' AND
        (TO_CHAR(ODDATE, 'YYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMM') OR
         ODDATE IS NULL)
  GROUP BY TO_CHAR(ODDATE, 'YYMM'), PRNAME, COST;
  
/* JOB : 주문      
     CLIENT SIDE
                 : 0 : PRCODE --> SPINFO
        REQUEST  : 1 : OWCODE, SRCODE, CMCODE[DF], DATE[DF], STATE[DF]
                       PRCODE, QUANTITY
                 : 2 : SLTYPE, SL_CARDNO, SLAMOUNT, SLINSTALLMENT  

     SERVER SIDE - DATA PROCESSING
        [SEL] SP  : SPCODE, OWCODE, SPNAME, SPPRICE
        [INS] OS  --> PRIMARY KEY
        [SEL] OS  : (SPCODE), (OWCODE), (CMCODE), OSDATE
        [INS] OD  --> (SPCODE), (OWCODE), (CMCODE), OSDATE
                       SPCODE, QUANTITY
        [SEL] OD  --> (SPCODE), (OWCODE), (CMCODE), (OSDATE), AMOUNT
        [TRANSACTION CLOSE]
        [INS] SL  : SPCODE, OWCODE, CMCODE, OSDATE, SLTYPE
                >> PAYMENT GATEWAY >> APPROVALNO, APPROVALDATE, APPROVALAMOUNT
        [INS] SD  : CARDNO, AMOUNT, INSTALLMENT    
        [TRANSACTION CLOSE]
        [UPD] OS  : 
                
     SERVER SIDE - RESPONSE 
        [SEL] SD  : CMCODE, APPROVALNO, APPROVALDATE, APPROVALAMOUNT,
                    INSTALLMENT, CARDNO, CARDNAME
*/
       