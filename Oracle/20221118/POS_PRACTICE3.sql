-- SESSION 3 - 2
CREATE OR REPLACE VIEW SRSALES AS
SELECT
    OD.OD_OWCODE AS OWCODE,
    TO_CHAR(OD.OD_DATE, 'YYYYMM') AS SALESMONTH,
    SR.SR_NAME AS SRNAME,
    COUNT(*) AS ORDERS,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS TOTAL
FROM OD INNER JOIN SP ON OD.OD_OWCODE = SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP_PROCODE
        INNER JOIN SR ON OD.OD_OWCODE = SR_OWCODE AND
                         OD.OD_SRCODE = SR_CODE
GROUP BY OD.OD_OWCODE, SR.SR_NAME, TO_CHAR(OD.OD_DATE, 'YYYYMM');

SELECT
    SRSALES.SALESMONTH,
    SRSALES.SRNAME,
    SRSALES.ORDERS,
    SRSALES.TOTAL
FROM SRSALES
WHERE TO_CHAR(SRSALES.SALESMONTH) = TO_CHAR(SYSDATE, 'YYYYMM') AND
      SRSALES.OWCODE = '001';

-- SESSION 3 - 3
CREATE OR REPLACE VIEW SALESLIST AS
SELECT
    TO_CHAR(OD.OD_DATE, 'YYYYMM') AS SALESMONTH,
    SR.SR_NAME AS SRNAME,
    OD.OD_PRCOUNT * SP.SP_OUTPRICE AS TOTAL,
    COUNT(*) AS ODERS,
    OD.OD_OWCODE AS OWCODE,
    SR.SR_CODE AS SRCODE
FROM OD INNER JOIN SP ON OD.OD_OWCODE = SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP_PROCODE
        INNER JOIN SR ON OD.OD_OWCODE = SR_OWCODE AND
                         OD.OD_SRCODE = SR_CODE
GROUP BY OD.OD_OWCODE, SR.SR_CODE, SR.SR_NAME, TO_CHAR(OD.OD_DATE, 'YYYYMM'), 
         OD.OD_PRCOUNT, SP.SP_OUTPRICE;
        
SELECT
    SALESLIST.SALESMONTH,
    SALESLIST.SRNAME,
    SALESLIST.ODERS,
    SALESLIST.TOTAL
FROM SALESLIST
WHERE TO_CHAR(SALESLIST.SALESMONTH) = TO_CHAR(SYSDATE, 'YYYYMM') AND
      SALESLIST.OWCODE = '001' AND SALESLIST.SRCODE = '0241164171' AND
      SALESLIST.TOTAL < 100000;



-- SESSION 3 - 1
CREATE OR REPLACE VIEW SALESCUSTOMERS AS
SELECT
    TO_CHAR(OD.OD_DATE,'YYYYMM') AS OSDATE,
    MM.CM_MEMBERNAME AS CMNAME,
    PR.PR_NAME AS PRNAME,
    OD.OD_PRCOUNT AS PRCOUNT,
    SP.SP_OUTPRICE AS OUTPRICE,
    SP.SP_OUTPRICE * OD.OD_PRCOUNT AS TOTAL,
    MM.CM_MEMBERCODE AS CUSTOMERCODE,
    OD.OD_PRCODE AS PRCODE,
    OD.OD_SRCODE AS SRCODE,
    OD.OD_OWCODE AS OWCODE
FROM OD INNER JOIN MM ON OD.OD_MECODE = MM.CM_MEMBERCODE
        INNER JOIN SP ON OD.OD_OWCODE = SP.SP_OWOWNERCODE AND
                         OD.OD_PRCODE = SP.SP_PROCODE
        INNER JOIN PR ON OD.OD_PRCODE = PR.PR_CODE
GROUP BY MM.CM_MEMBERNAME, TO_CHAR(OD.OD_DATE,'YYYYMM'), PR.PR_NAME, OD.OD_PRCOUNT,
         SP.SP_OUTPRICE, MM.CM_MEMBERCODE, OD.OD_PRCODE, OD.OD_SRCODE,
         OD.OD_OWCODE;
         
SELECT
    SALESCUSTOMERS.CMNAME,
    SALESCUSTOMERS.OSDATE,
    SALESCUSTOMERS.PRNAME,
    SALESCUSTOMERS.PRCOUNT,
    SALESCUSTOMERS.OUTPRICE,
    SALESCUSTOMERS.TOTAL
FROM SALESCUSTOMERS
WHERE TO_CHAR(SALESCUSTOMERS.OSDATE) = TO_CHAR(ADD_MONTHS(SYSDATE, -1), 'YYYYMM') AND
      SALESCUSTOMERS.CUSTOMERCODE = '61';