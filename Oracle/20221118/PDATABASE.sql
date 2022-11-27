SELECT * FROM SR;
UPDATE SR SET SR_NUMBER = '032' || SUBSTR(SR_OWCODE, 1, 3) || '1234';
COMMIT;

/* 현재 달을 기준으로 이전 3개월의 매월 매출액 조회 - 박초롱, 정영준, 김준석 */
SELECT 
    SR.SR_NAME AS SRNAME,
    OW.OW_OWNAME AS OWNAME,
    SR.SR_NUMBER AS SRNUMBER,
    SR.SR_POSITION AS SRLOCATION ,
    SR.SR_OWCODE AS OWCODE,
    SR.SR_CODE AS SRCODE
FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_OWCODE 
WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171';

SELECT * FROM OD;

SELECT
    TO_CHAR(OD.OD_DATE, 'YYYYMM') AS SALESMONTH,
    COUNT(*) AS ORDERS,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS TOTAL,
    FLOOR(SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE)/COUNT(*)) AS AVG
FROM OD INNER JOIN SP ON OD.OD_OWCODE = SP.SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP.SP_PROCODE
WHERE TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM') OR
      TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYYYMM') OR
      TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'YYYYMM') AND
      OD_OWCODE = '001' AND OD_SRCODE = '0241164171'
GROUP BY TO_CHAR(OD.OD_DATE, 'YYYYMM');

-- 현금 건수, 카드 건수 - 박초롱
SELECT
    CASH.SALESMONTH,
    CASH.CASHCOUNT,
    CARD.CARDCOUNT
FROM (SELECT
    TO_CHAR(SD_SLDATE, 'YYYYMM') AS SALESMONTH,
    COUNT(*) AS CASHCOUNT
FROM SD
WHERE TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMMDD') OR
      TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYMMDD') OR
      TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'YYMMDD') AND
        SD_INSTALLMENT = 0
GROUP BY TO_CHAR(SD_SLDATE, 'YYYYMM')) CASH
INNER JOIN (SELECT
    TO_CHAR(SD_SLDATE, 'YYYYMM') AS SALESMONTH,
    COUNT(*) AS CARDCOUNT
FROM SD
WHERE TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYMMDD') OR
      TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYMMDD') OR
      TO_CHAR(SD_SLDATE, 'YYMMDD') = TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'YYMMDD') AND
        SD_INSTALLMENT > 0
GROUP BY TO_CHAR(SD_SLDATE, 'YYYYMM')) CARD ON CASH.SALESMONTH = CARD.SALESMONTH;

SELECT * FROM SP;

-- 총 결제 통계 - 박초롱, 정영준, 김준석
SELECT
    '매출 통계',
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS TOTAL,
    FLOOR(SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE)/COUNT(*)) AS AVG
FROM OD INNER JOIN SP ON OD.OD_OWCODE = SP.SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP.SP_PROCODE
WHERE TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM') OR
      TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -2), 'YYYYMM') OR
      TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -3), 'YYYYMM') AND
      OD_OWCODE = '001' AND OD_SRCODE = '0241164171'
GROUP BY '매출 통계';

/* 지난 달의 상품별 매출액 조회 - 박초롱 */
SELECT 
    SR.SR_NAME AS SRNAME,
    OW.OW_OWNAME AS OWNAME,
    SR.SR_NUMBER AS SRNUMBER,
    SR.SR_POSITION AS SRLOCATION ,
    SR.SR_OWCODE AS OWCODE,
    SR.SR_CODE AS SRCODE
FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_OWCODE 
WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171';

SELECT
    TO_CHAR(OD.OD_DATE, 'YYYYMM') AS SALESMONTH,
    PR.PR_NAME AS PRNAME,
    COUNT(*) AS ORDERS,
    SP.SP_INPRICE AS INPRICE,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS TOTAL,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) - SUM(SP_OUTPRICE - SP_INPRICE) AS PROFIT
FROM OD INNER JOIN SP ON OD.OD_OWCODE = SP.SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP.SP_PROCODE
              JOIN PR ON OD.OD_PRCODE = PR.PR_CODE
WHERE TO_CHAR(OD.OD_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM') AND
      OD.OD_OWCODE = '001' AND OD.OD_SRCODE = '0241164171'
GROUP BY TO_CHAR(OD.OD_DATE, 'YYYYMM'), PR.PR_NAME, SP.SP_INPRICE, OD.OD_PRCOUNT * SP.SP_OUTPRICE;