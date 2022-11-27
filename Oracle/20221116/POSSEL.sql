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
       �����(�����ڵ�)     ��ǥ�ڸ�(�����ڵ�)    ��������    ������ġ
     ********************************************************************
       ----------------------------------------------------------------
          ��������       �ǸŰǼ�        �� �Ǹž�           ��� �Ǹž�
       ----------------------------------------------------------------
        2022.11.15         5��           100,000              20,000
       ----------------------------------------------------------------
           (CARD)           3��           70,000              
           (CASH)           2��           30,000
*/

/* 001, 0241164171, 1109 */

-- �Է¹��� OWCODE�� DB�� �����ϴ��� Ȯ���Ѵ�.
/*
    ORACLE���� BOOLEAN Ÿ���� �������� �ʱ� ������, GROUPING �Լ� COUNT�� ����Ͽ�
    ���ڵ��� �� ���� Ȯ���ϰ� �����Ѵ�.
*/
SELECT COUNT(*)
FROM OW
WHERE OW_OWCODE = '001';

-- �Է��� ����� ������ SECRETCODE�� ��ġ�ϴ��� Ȯ���Ѵ�.
SELECT COUNT(*)
FROM SR
WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171' AND SR_SECRETCODE = '1109';

-- �α��ο� �����Ͽ��ٸ�, ACCESS ����� �����.
INSERT INTO AL(AL_SROWCODE, AL_SRCODE, AL_DATE, AL_TYPE)
VALUES('001','0241164171', DEFAULT, 1);

SELECT * FROM AL;
SELECT * FROM SR;
SELECT * FROM OW;

-- ���� ���� ����� ���� Į���� �����Ѵ�. �����, ��ǥ�ڸ�, ��������, ������ġ

SELECT 
SR.SR_NAME AS SRNAME,
OW.OW_OWNAME AS OWNAME,
SR.SR_NUMBER AS SRNUMBER,
SR.SR_POSITION AS SRLOCATION ,
SR.SR_OWCODE AS OWCODE,
SR.SR_CODE AS SRCODE

FROM SR INNER JOIN OW ON SR.SR_OWCODE = OW.OW_OWCODE 

WHERE SR_OWCODE = '001' AND SR_CODE = '0241164171';

-- ������ �Ǹ� ���� ����� ���� Į���� �����Ѵ�.
/*
   ----------------------------------------------------------------
       ��������       �ǸŰǼ�        �� �Ǹž�           ��� �Ǹž�
   ----------------------------------------------------------------
     2022.11.15        5��          100,000             20,000
   ----------------------------------------------------------------
*/
SELECT * FROM OD;

-- ���� �Ǹ� �Ǽ�
SELECT  TO_CHAR(OR_DATE, 'YYMMDD') AS SALESDATE,
        COUNT(*) AS DAYCOUNT
FROM OS
WHERE TO_CHAR(OR_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OR_DATE, 'YYMMDD');

-- ���� �����
SELECT * FROM SP;
SELECT
    TO_CHAR(OD_DATE, 'YYMMDD') AS SALESDATE,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE) AS SALESAMOUNT,
    SUM(OD.OD_PRCOUNT * SP.SP_OUTPRICE)/COUNT(*) AS SALESAVG
FROM OD INNER JOIN SP ON OD.OD_PRCODE = SP.SP_PROCODE
                      AND OD.OD_OWCODE = SP.SP_OWOWNERCODE
WHERE TO_CHAR(OD_DATE, 'YYMMDD') = TO_CHAR(SYSDATE-1, 'YYMMDD')
GROUP BY TO_CHAR(OD.OD_DATE, 'YYMMDD');