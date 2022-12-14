ALTER TABLE POSDBA.CATEGORIES
MODIFY CG_NAME NOT NULL;

-- 상품 상태 코드
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('20', '상');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('21', '중');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('22', '하');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('23', '폐기');
COMMIT;

-- 상품 분류 코드
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('01', '고기');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('02', '생선');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('03', '과일');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('04', '채소');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('05', '문구');
COMMIT;

-- 상품 코드 (고기)
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('31', '10131'); -- 돼지고기
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('32', '10132'); -- 소고기
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('33', '10133'); -- 닭고기
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('34', '10134'); -- 양고기
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('35', '10135'); -- 오리고기
COMMIT;

-- 상품 코드 (생선)
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('36', '10136'); -- 고등어
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('37', '10137'); -- 갈치
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('38', '10138'); -- 꽁치
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('39', '10139'); -- 참치
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('40', '10140'); -- 연어
COMMIT;

-- 상품 코드 (과일)
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('41', '10141'); -- 수박
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('42', '10142'); -- 사과
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('43', '10143'); -- 포도
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('44', '10144'); -- 바나나
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('45', '10145'); -- 딸기
COMMIT;



-- 상품 코드 (채소)
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('46', '10146'); -- 토마토
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('47', '10147'); -- 가지
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('48', '10148'); -- 양파
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('49', '10149'); -- 파
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('50', '10150'); -- 감자
COMMIT;



-- 상품 코드 (문구)
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('51', '10151'); -- 연필
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('52', '10152'); -- 샤프
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('53', '10153'); -- 공책
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('54', '10154'); -- 지우개
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('55', '10155'); -- 볼펜
COMMIT;



-- 고객 코드
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('60', '0160'); -- 박초롱
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('61', '0161'); -- 김지웅
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('62', '0162'); -- 김준석
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('63', '0163'); -- 정영준
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('64', '0164'); -- 윤지수
INSERT INTO CG(CG_CODE, CG_NAME)

VALUES('65', '0165'); -- 황영현
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('66', '0166'); -- 주성현
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('67', '0167'); -- 이상훈
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('68', '0168'); -- 홍준택
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('69', '0169'); -- 김하늘
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('70', '0170'); -- 이예림
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('71', '0171'); -- 황영호
INSERT INTO CG(CG_CODE, CG_NAME)



VALUES('72', '0172'); -- 박건호
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('73', '0173'); -- 염은진
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('74', '0174'); -- 임창용
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('75', '0175'); -- 김민규
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('76', '0176'); -- 송은혜
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('77', '0177'); -- 이정한
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('78', '0178'); -- 김호원
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('79', '0179'); -- 정현우
INSERT INTO CG(CG_CODE, CG_NAME)



VALUES('80', '0180'); -- 비회원
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('81', '0181'); -- 비회원
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('82', '0182'); -- 비회원
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('83', '0183'); -- 비회원
COMMIT;

-- 오너 코드
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('10', '001'); -- 박초롱
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('11', '002'); -- 김지웅
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('12', '003'); -- 김준석
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('13', '004'); -- 장영준
COMMIT;

-- 매장 코드
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('90', '0241164171'); -- 매장1
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('91', '0241164172'); -- 매장2
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('92', '0241164173'); -- 매장3
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('93', '0241164174'); -- 매장4
COMMIT;

SELECT * FROM CG;



OR_STATE (주문상태코드) 'Y' , 'N'
