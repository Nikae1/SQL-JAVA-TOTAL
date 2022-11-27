UPDATE POSDBA.STORES SET SR_SECRETCODE = '1109'
WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171';
COMMIT;

/* JOB : SYSTEM ACCESS

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

/* 001, 0241164171, 1109 */

-- 입력받은 OWCODE가 DB에 존재하는지 확인한다.
/*
    ORACLE에는 BOOLEAN 타입이 존재하지 않기 때문에, GROUPING 함수 COUNT를 사용하여
    레코드의 총 수를 확인하고 리턴한다.
*/
SELECT COUNT(*)
FROM OW
WHERE OW_OWCODE = '001';

-- 입력한 스토어 정보와 SECRETCODE가 일치하는지 확인한다.
SELECT COUNT(*)
FROM SR
WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171' AND SR_SECRETCODE = '1109';

-- 로그인에 성공하였다면, ACCESS 기록을 남긴다.
INSERT INTO AL(AL_SROWCODE, AL_SRCODE, AL_DATE, AL_TYPE)
VALUES('001','0241164171', DEFAULT, 1);

SELECT * FROM AL;
SELECT * FROM SR;
SELECT * FROM OW;

-- 매장 정보 출력을 위한 칼럼을 취합한다. 매장명, 대표자명, 매장전번, 매장위치

SELECT 
SR.SR_NAME AS SRNAME,
OW.OW_OWNAME AS OWNAME,
SR.SR_NUMBER AS SRNUMBER,
SR.SR_POSITION AS SRLOCATION ,
SR.SR_OWCODE AS OWCODE,
SR.SR_CODE AS SRCODE

FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_OWCODE 

WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171';

-- 어제의 판매 정보 출력을 위한 칼럼을 취합한다.
/*
   ----------------------------------------------------------------
       매출일자       판매건수        총 판매액           평균 판매액
   ----------------------------------------------------------------
     2022.11.15        5건          100,000             20,000
   ----------------------------------------------------------------
*/
SELECT * FROM OD;

-- 전날 판매 건수
SELECT  TO_CHAR(OR_DATE, 'YYMMDD') AS SALESDATE,
        COUNT(*) AS DAYCOUNT
FROM OS
WHERE TO_CHAR(OR_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OR_DATE, 'YYMMDD');

-- 전날 매출액
SELECT * FROM SP;
SELECT
    TO_CHAR(OD_DATE, 'YYMMDD') AS SALESDATE,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS SALESAMOUNT,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE)/COUNT(*) AS SALESAVG
FROM OD INNER JOIN SP ON OD.OD_PRCODE = SP.SP_PROCODE
                      AND OD.OD_OWCODE = SP.SP_OWOWNERCODE
WHERE TO_CHAR(OD_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OD.OD_DATE, 'YYMMDD');