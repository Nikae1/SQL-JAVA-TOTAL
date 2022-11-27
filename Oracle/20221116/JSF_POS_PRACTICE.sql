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
  
  