SELECT * FROM MR;
SELECT * FROM AH;
SELECT * FROM CA;
SELECT * FROM TD;
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221112130000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221112130000', 'YYYYMMDDHH24MISS'), 
                 '줄넘기 100회', 'C', 'A', '다음엔 꼭…');
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221129160000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221029160000', 'YYYYMMDDHH24MISS'),
                 '댕댕이 산책', 'B', 'A', DEFAULT);
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221126140000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221126140000', 'YYYYMMDDHH24MISS'),
                 '세차하기', 'P', 'A', '빠른 시일내 일정 확정하기');
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221124000000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221130120000', 'YYYYMMDDHH24MISS'),
                 'JAVA Study', 'I', 'A', DEFAULT);
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221120130000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221120130000', 'YYYYMMDDHH24MISS'),
                 '줄넘기 100회', 'C', 'A', '아싸~ 드디어 성공');
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221120100000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221120100000', 'YYYYMMDDHH24MISS'),
                 '세차하기', 'P', 'I', '잊어버리지 않게 매일 스케줄 체크하자');
  INSERT INTO TD(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT, 
                 TD_STATE, TD_ACTIVATION, TD_FEEDBACK) 
          VALUES('HOON', TO_DATE('20221121000000', 'YYYYMMDDHH24MISS'), 
                 TO_DATE('20221130120000', 'YYYYMMDDHH24MISS'),
                 'English Study', 'I', 'I', '다음엔 진짜로 하기');
  COMMIT;
  
/* JDBC(JAVA DATA BASE CONNECTION)
   JAVA  ---------------------------------------- ORACLE
     ┖     JDBC ++++++++++++++++++++++++ OJDBC    ┚                
     
   CONNECT TO ORACLE 
   P1. ORACLE JDBC DRIVER LOAD     :  
                Class.forName(oracle.jdbc.driver.OracleDriver);
                
   P2. Connection Creation  :  Using DriverManager + with DB Info
                url >> jdbc:oracle:thin:@db_Addr:db_port:db_serviceName
                
                Connection DriverManager.getConnection(url, name, pwd);
                
   P3-1. Using Connection + with DML || Query
       Statement Def            : Speed↑  Injection Attack↑  Development↓
     + PreparedStatement Def    : Speed↓  Injection Attack↓  Development↑
       CallableStatement Def    : Speed↑↑  Injection Attack↓↑  Development↑↑
   + P3-2. Param Setting
   
   P4. DML Execution        : PreparedStatement.executeUpdate();
       Query Execution      : PreparedStatement.executeQuery();
       
   P5. Result Processing    :
     5-1.  DML      -> int
     5-2.  Query    -> ResultSet 
                        --> Loop record fetch  
                            --> extract column data >> Set Bean
                            --> Add to List 

   P6. Close
     5-1 >>                    PreparedStatement Close >> Connection Close
     5-2 >> ResultSet Close >> PreparedStatement Close >> Connection Close
     
*/
SELECT COUNT(*) AS ISMRID FROM MR WHERE MR_ID = 'HOON' AND MR_PWD = '4321';
SELECT * FROM MR;
SELECT * FROM AH;
DELETE FROM AH;
COMMIT;


SELECT  TO_CHAR(TD_DATE, 'YYYYMMDD') AS STARTDATE, 
        TO_CHAR(TD_EDATE, 'YYYYMMDD') AS ENDDATE
FROM TODO WHERE TD_MRID = 'HOON' AND TO_CHAR(TD_DATE, 'YYYYMM') = '202211';

SELECT *
FROM TODO WHERE TD_MRID = 'HOON' AND TO_CHAR(TD_DATE, 'YYYYMM') = '202211';

CREATE OR REPLACE VIEW TODOLIST
AS
 SELECT TD_MRID AS MRID,
        TO_CHAR(TD_DATE, 'YYYYMMDD') AS ACCESSCODE, 
        TO_CHAR(TD_DATE, 'YYYYMMDDHH24MISS') AS STARTDATE, 
        TO_CHAR(TD_EDATE, 'YYYYMMDDHH24MISS') AS ENDDATE, 
        TD_CONTENT AS CONTENTS, 
        TD_STATE AS STATUS, 
        TD_ACTIVATION AS ACTIVE, 
        TD_FEEDBACK AS COMMENTS 
 FROM TODO;
 GRANT SELECT ON DBA.TODOLIST TO HOON;
 
 SELECT * 
 FROM TODOLIST 
 WHERE MRID = 'HOON' 
   AND (SUBSTR(STARTDATE, 1, 8) >= '20221112' AND 
        SUBSTR(ENDDATE, 1, 8) <= '20221120');

 FROM TODOLIST 
 WHERE ACCESSCODE = 'HOON' AND SUBSTR(STARTDATE, 1, 6) = '202211' 
   AND ACTIVE = 'A';
/* TODO TABLE PK 수정*/
ALTER TABLE TODO
DROP CONSTRAINT TD_MRID_DATE_PK;
ALTER TABLE TODO
ADD CONSTRAINT TD_MRID_DATE_EDATE_CONTENT_PK 
    PRIMARY KEY(TD_MRID, TD_DATE, TD_EDATE, TD_CONTENT);

ALTER TABLE ACCESSHISTORY
DROP CONSTRAINT AH_MRID_DATE_PK;
ALTER TABLE ACCESSHISTORY
ADD CONSTRAINT AH_MRID_DATE_STATE_PK PRIMARY KEY(AH_MRID, AH_DATE, AH_STATE);

