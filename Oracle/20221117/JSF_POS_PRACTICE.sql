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