  /* PRACTICE SCENARIO SESSION 2
     JOB : SALES INFOMATION CHECK */
     
  /* SESSION 2-1
     현재 달을 기준으로 이전 3개월의 매월 매출액 조회
     
     CLIENT SIDE
        REQUEST  : 

     SERVER SIDE - DATA PROCESSING 
        
        
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
       -----------------------------------------------------------------
         새우깡            10       1000         15000        5000
         양파깡             9
         감자깡             7
           :
           :
       -----------------------------------------------------------------
      
  */