----DEV ���� 
CREATE USER "POSJYJ" IDENTIFIED BY "3135"
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION, RESOURCE TO POSJYJ;

CREATE USER "POSKJS" IDENTIFIED BY "9712"
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION, RESOURCE TO POSKJS;

CREATE USER "POSPCR" IDENTIFIED BY "4171"
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION, RESOURCE TO POSPCR;

CREATE USER "POSKJW" IDENTIFIED BY "1452"
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION, RESOURCE TO POSKJW;
--�������� �� ���ӱ��� �ο�

--TABLE CREATE (CATEGORIES) ����
CREATE TABLE POSDBA.CATEGORIES(
CG_CODE NVARCHAR2(2), -- �з��ڵ� 
CG_NAME NVARCHAR2(2) -- �з��� 
)TABLESPACE USERS;

-- CATEGORIES ���Ǿ� 
CREATE PUBLIC SYNONYM CG FOR POSDBA.CATEGORIES;

-- CATEGORIES �������� 
ALTER TABLE POSDBA.CATEGORIES
ADD CONSTRAINT CG_CODE_PK PRIMARY KEY(CG_CODE)
MODIFY CG_NAME NOT NULL;

-- CATEGORIES ���Ѻο�
GRANT ALTER ANY TABLE TO POSPCR;
GRANT SELECT,INSERT ON POSDBA.CATEGORIES TO POSPCR;

GRANT ALTER ANY TABLE TO POSKJW;
GRANT SELECT, INSERT ON POSDBA.CATEGORIES TO POSKJW;

--CATEGORIES INSERT
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('20', '�Ż�');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('21', 'ǰ��');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('22', '���');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('23', '����');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('01', '����');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('02', '����');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('03', '����');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('04', 'ä��');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('05', '����');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('Y1','�ֹ� ��');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('Y2','�ֹ� ��');
INSERT INTO CG(CG_CODE, CG_NAME)
VALUES('Y3','�ֹ� �Ϸ�');
COMMIT;

SELECT*FROM CG;

-- CREATE PRODUCTS
-- PRODUCTS ���� 
CREATE TABLE POSDBA.PRODUCTS(
PR_CODE NVARCHAR2(5),
PR_NAME NVARCHAR2(2))
TABLESPACE USERS;

-- PRODUCTS ���Ǿ� 
CREATE PUBLIC SYNONYM PR FOR POSDBA.PRODUCTS;

-- PRODUCTS �������� 
ALTER TABLE POSDBA.PRODUCTS
ADD CONSTRAINT PR_PROCODE_PK PRIMARY KEY(PR_PROCODE)
MODIFY PR_NAME NOT NULL;

-- PRODUCTS ���̺� ���Ѻο�
GRANT ALTER ANY TABLE TO POSPCR;
GRANT SELECT,INSERT ON POSDBA.PRODUCTS TO POSPCR;

-- INSERT PRODUCTS
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10131', '��������');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10132', '�Ұ���');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10133', '�߰���');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10134', '�����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10135', '��������');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10136', '�����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10137', '��ġ');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10138', '��ġ');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10139', '��ġ');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10140', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10141', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10142', '���');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10143', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10144', '�ٳ���');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10145', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10146', '�丶��');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10147', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10148', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10149', '��');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10150', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10151', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10152', '����');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10153', '��å');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10154', '���찳');
INSERT INTO PR(PR_CODE, PR_NAME)
VALUES('10155', '����');
COMMIT;

-- CUSTOMERS ����
CREATE TABLE POSDBA.CUSTOMERS(
CM_MEMBERCODE NVARCHAR2(4),  -- �����ڵ�
CM_MEMBERNAME NVARCHAR2(5),  -- ������
CM_MEMBERPHONE NVARCHAR2(11) -- ������ȭ��ȣ
) TABLESPACE USERS;

-- CUSTOMERS ���Ǿ� 
CREATE PUBLIC SYNONYM MM FOR POSDBA.CUSTOMERS;

-- CUSTOMER ��������
ALTER TABLE POSDBA.CUSTOMERS
ADD CONSTRAINT CM_MEMBERCODE_PK PRIMARY KEY(CM_MEMBERCODE)
MODIFY CM_MEMBERNAME NOT NULL
MODIFY CM_MEMBERPHONE DEFAULT NULL NOT NULL;

-- CUSTOMER ���Ѻο�
GRANT ALTER ANY TABLE TO POSJYJ;
GRANT SELECT,INSERT ON POSDBA.CUSTOMERS TO POSJYJ;

---INSERT CUSTOMERS
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('60', '���ʷ�', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('61', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('62', '���ؼ�', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('63', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('64', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('65', 'Ȳ����', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('66', '�ּ���', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('67', '�̻���', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('68', 'ȫ����', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('69', '���ϴ�', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('70', '�̿���', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('71', 'Ȳ��ȣ', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('72', '�ڰ�ȣ', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('73', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('74', '��â��', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('75', '��α�', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('76', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('77', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('78', '��ȣ��', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('79', '������', '01011111111');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('96', '��ȸ��', '01000000000');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('97', '��ȸ��', '01000000000');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('98', '��ȸ��', '01000000000');
INSERT INTO MM(CM_MEMBERCODE, CM_MEMBERNAME, CM_MEMBERPHONE)
VALUES('99', '��ȸ��', '01000000000');
COMMIT;

---CREATE OWNERS
CREATE TABLE POSDBA.OWNERS(
OW_OWCODE NVARCHAR2(4), -- �����ڵ�
OW_OWNAME NVARCHAR2(5)  -- �����̸�.
)TABLESPACE USERS;

-- OWNERS ���Ǿ�
CREATE PUBLIC SYNONYM OW FOR POSDBA.OWNERS;

-- OWNERS ���Ѻο�
GRANT ALTER ANY TABLE TO POSJYJ;
GRANT SELECT, INSERT ON POSDBA.OWNERS TO POSJYJ;
GRANT ALTER ANY TABLE TO POSKJW;
GRANT SELECT, INSERT ON POSDBA.OWNERS TO POSKJW;

-- OWNERS �������� 
ALTER TABLE POSDBA.OWNERS
ADD CONSTRAINT OW_OWCODE_PK PRIMARY KEY(OW_OWCODE)
MODIFY OW_OWNAME NOT NULL;

---INSERT
INSERT INTO OW(OW_OWCODE, OW_OWNAME)
VALUES('001', '���ʷ�'); 
INSERT INTO OW(OW_OWCODE, OW_OWNAME)
VALUES('002', '������'); 
INSERT INTO OW(OW_OWCODE, OW_OWNAME)
VALUES('003', '���ؼ�'); 
INSERT INTO OW(OW_OWCODE, OW_OWNAME)
VALUES('004', '�念��'); 
COMMIT;

---CREATE STORES
CREATE TABLE POSDBA.STORES(
SR_OWCODE NVARCHAR2(3),     -- �����ڵ� FOR OWNERS
SR_CODE NVARCHAR2(10),      -- �����ڵ�
SR_NAME NVARCHAR2(10),      -- �����
SR_POSITION NVARCHAR2(50),  -- ������ġ
SR_NUMBER NVARCHAR2(11),     -- ������ȭ��ȣ
SR_SECRETCODE NVARCHAR2(20) --- �����й�ȣ
)TABLESPACE USERS;

-- STORES ���Ǿ�
CREATE PUBLIC SYNONYM SR FOR POSDBA.STORES;

-- STORES ��������
ALTER TABLE POSDBA.STORES
ADD CONSTRAINT SR_OWCODE_CODE_PK PRIMARY KEY(SR_OWCODE, SR_CODE)

ADD CONSTRAINT SR_OWCODE_FK FOREIGN KEY(SR_OWCODE)
REFERENCES POSDBA.OWNERS(OW_OWCODE)

MODIFY SR_NAME NOT NULL
MODIFY SR_NUMBER NOT NULL
MODIFY SR_POSITION NOT NULL;

-- STORES ���� �ο�
GRANT ALTER ANY TABLE TO POSPCR;
GRANT SELECT, INSERT ON POSDBA.STORES TO POSPCR;

-- INSERT
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('60','001');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('61','002');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('62','003');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('63','004');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('99','001');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
 VALUES('99','002');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('99','003');
INSERT INTO ME(ME_CMMEMBERCODE, ME_OWCODE)
VALUES('99','004');
COMMIT;

---CREATE MEMBERS
CREATE TABLE POSDBA.MEMBERS(
ME_CMMEMBERCODE NVARCHAR2(4),     -- �����ڵ�
ME_OWCODE NVARCHAR2(3)      -- �����ڵ�
)TABLESPACE USERS;

-- MEMBERS ���Ǿ�
CREATE PUBLIC SYNONYM ME FOR POSDBA.MEMBERS;

-- MEMBERS ��������
ALTER TABLE POSDBA.MEMBERS
ADD CONSTRAINT ME_CMMEMBERCODE_OWCODE_PK PRIMARY KEY(ME_CMMEMBERCODE,ME_OWCODE)
ADD CONSTRAINT ME_CMMEMBERCODE_FK FOREIGN KEY(ME_CMMEMBERCODE)
REFERENCES POSDBA.CUSTOMERS(CM_MEMBERCODE)
ADD CONSTRAINT ME_OWCODE_FK FOREIGN KEY(ME_OWCODE)
REFERENCES POSDBA.OWNERS(OW_OWCODE);

--- MEMBERS ���� �ο�
GRANT ALTER ANY TABLE TO POSJYJ;
GRANT SELECT, INSERT ON POSDBA.MEMBERS TO POSJYJ;

---CREATE STOREPRODUCTS
CREATE TABLE POSDBA.STOREPRODUCTS(
SP_PROCODE NVARCHAR2(5),
SP_OWOWNERCODE NVARCHAR2(3),
SP_INPRICE NUMBER(5,0),
SP_OUTPRICE NUMBER(5,0),
SP_PRCGCODE NVARCHAR2(2),
SP_PRCGNAME NVARCHAR2(2),
SP_COUNT NUMBER(3,0))
TABLESPACE USERS;

---���Ǿ� �ο�
CREATE PUBLIC SYNONYM SP FOR POSDBA.STOREPRODUCTS;


---��������
ALTER TABLE POSDBA.STOREPRODUCTS
ADD CONSTRAINT SP_PROCODE_OWOWNERCODE_PK PRIMARY KEY(SP_PROCODE, SP_OWOWNERCODE)
ADD CONSTRAINT SP_PROCODE_FK FOREIGN KEY(SP_PROCODE) REFERENCES POSDBA.PRODUCTS(PR_CODE)
ADD CONSTRAINT SP_OWOWNERCODE_FK FOREIGN KEY(SP_OWOWNERCODE) REFERENCES POSDBA.OWNERS(OW_OWCODE)
ADD CONSTRAINT SP_PRCGCODE_FK FOREIGN KEY(SP_PRCGCODE) REFERENCES POSDBA.CATEGORIES(CG_CODE)
ADD CONSTRAINT SP_PRCGNAME_FK FOREIGN KEY(SP_PRCGNAME) REFERENCES POSDBA.CATEGORIES(CG_CODE)
MODIFY SP_INPRICE DEFAULT 0 NOT NULL
MODIFY SP_OUTPRICE DEFAULT 0 NOT NULL
MODIFY SP_COUNT DEFAULT 0 NOT NULL
MODIFY SP_PRCGCODE NOT NULL
MODIFY SP_PRCGNAME NOT NULL;

---���Ѻο�
GRANT ALTER ANY TABLE TO POSPCR;
GRANT SELECT, INSERT ON POSDBA.STOREPRODUCTS TO POSPCR;

---INSERT
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10131', '001', DEFAULT, DEFAULT, '20', '01', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10132', '001', DEFAULT, DEFAULT, '20', '01', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10133', '001', DEFAULT, DEFAULT, '20', '01', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10134', '001', DEFAULT, DEFAULT, '20', '01', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10135', '001', DEFAULT, DEFAULT, '20', '01', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10136', '002', DEFAULT, DEFAULT, '21', '02', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10137', '002', DEFAULT, DEFAULT, '21', '02', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10138', '002', DEFAULT, DEFAULT, '23', '02', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10139', '002', DEFAULT, DEFAULT, '22', '02', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10140', '002', DEFAULT, DEFAULT, '21', '02', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10141', '002', DEFAULT, DEFAULT, '21', '03', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10142', '002', DEFAULT, DEFAULT, '21', '03', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10143', '002', DEFAULT, DEFAULT, '21', '03', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10144', '002', DEFAULT, DEFAULT, '21', '03', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10145', '002', DEFAULT, DEFAULT, '21', '03', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10146', '003', DEFAULT, DEFAULT, '21', '04', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10147', '003', DEFAULT, DEFAULT, '21', '04', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10148', '003', DEFAULT, DEFAULT, '21', '04', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10149', '003', DEFAULT, DEFAULT, '21', '04', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10150', '003', DEFAULT, DEFAULT, '21', '04', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10151', '004', DEFAULT, DEFAULT, '21', '05', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10152', '004', DEFAULT, DEFAULT, '21', '05', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10153', '004', DEFAULT, DEFAULT, '21', '05', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10154', '004', DEFAULT, DEFAULT, '21', '05', DEFAULT);
INSERT INTO SP(SP_PROCODE, SP_OWOWNERCODE, SP_INPRICE, SP_OUTPRICE,
SP_PRCGCODE, SP_PRCGNAME, SP_COUNT)
VALUES('10155', '004', DEFAULT, DEFAULT, '21', '05', DEFAULT);
COMMIT;

---CREATE ORDERS
CREATE TABLE POSDBA.ORDERS(
OR_OWCODE NVARCHAR2(3),  -- �����ڵ� 
OR_SRCODE NVARCHAR2(10), -- �����ڵ� 
OR_MECODE NVARCHAR2(4),  -- �����ڵ� 
OR_DATE   DATE,          -- �ֹ��Ͻ�
OR_STATE  NCHAR(2)       -- �ֹ������ڵ�
)TABLESPACE USERS;

---���Ǿ� �ο�
CREATE PUBLIC SYNONYM OS FOR POSDBA.ORDERS;

---���� �ο�
GRANT CREATE ANY TABLE TO POSKJW;
GRANT ALTER ANY TABLE TO POSKJW;
GRANT SELECT, INSERT ON POSDBA.ORDERS TO POSKJW;
GRANT DELETE, UPDATE ON POSDBA.ORDERS TO POSKJW;

---��������
ALTER TABLE POSDBA.ORDERS  -- �� FOREIGN KEY�� REFERENCES�� �÷������� ��ġ�ؾ� ���� ��
ADD CONSTRAINT OR_OWCODE_SRCODE_MECODE_DATE PRIMARY KEY(OR_OWCODE,OR_SRCODE,OR_MECODE,OR_DATE)
ADD CONSTRAINT OR_OWCODE_SRCODE_FK FOREIGN KEY(OR_OWCODE, OR_SRCODE) REFERENCES POSDBA.STORES(SR_OWCODE, SR_CODE)
ADD CONSTRAINT OR_MECODE_FK FOREIGN KEY(OR_OWCODE, OR_MECODE) REFERENCES POSDBA.MEMBERS(ME_OWCODE, ME_CMMEMBERCODE )
MODIFY OR_DATE DEFAULT NULL NOT NULL
MODIFY OR_STATE DEFAULT NULL NOT NULL;

---INSERT
INSERT INTO OS(OR_OWCODE, OR_SRCODE, OR_MECODE, OR_DATE, OR_STATE)
VALUES('001', '0241164171', '60', TO_DATE('20221110120000', 'YYYYMMDDHH24MISS'), 'Y1');
INSERT INTO OS(OR_OWCODE, OR_SRCODE, OR_MECODE, OR_DATE, OR_STATE)
VALUES('002', '0241164172', '61', TO_DATE('20221110120000', 'YYYYMMDDHH24MISS'), 'Y3');
INSERT INTO OS(OR_OWCODE, OR_SRCODE, OR_MECODE, OR_DATE, OR_STATE)
VALUES('003', '0241164173', '62', TO_DATE('20221110120000', 'YYYYMMDDHH24MISS'), 'Y3');
INSERT INTO OS(OR_OWCODE, OR_SRCODE, OR_MECODE, OR_DATE, OR_STATE)
VALUES('004', '0241164174', '63', TO_DATE('20221110120000', 'YYYYMMDDHH24MISS'), 'Y1');
COMMIT;

---CREATE ORDERDETAILS
CREATE TABLE POSDBA.ORDERDETAILS(
OD_OWCODE NVARCHAR2(3),  -- �����ڵ� 
OD_SRCODE NVARCHAR2(10), -- �����ڵ� 
OD_MECODE NVARCHAR2(4),  -- �����ڵ�
OD_DATE   DATE,          -- �ֹ��Ͻ�
OD_PRCODE NVARCHAR2(5),  
OD_PRCOUNT NUMBER(3,0)
)TABLESPACE USERS;

---���Ǿ� �ο�
CREATE PUBLIC SYNONYM OD FOR POSDBA.ORDERDETAILS;

--���� �ο�
GRANT SELECT, INSERT ON POSDBA.ORDERDETAILS TO POSKJW;

---��������
ALTER TABLE POSDBA.ORDERDETAILS
ADD CONSTRAINT OD_ORDERDETAILS_PK PRIMARY KEY(OD_OWCODE, OD_SRCODE, OD_MECODE, OD_DATE, OD_PRCODE)
ADD CONSTRAINT OD_ORDER_FK FOREIGN KEY(OD_OWCODE, OD_SRCODE, OD_MECODE, OD_DATE) REFERENCES POSDBA.ORDERS(OR_OWCODE, OR_SRCODE, OR_MECODE, OR_DATE)
ADD CONSTRAINT OD_OWCODE_PRCODE_FK FOREIGN KEY(OD_OWCODE, OD_PRCODE) REFERENCES POSDBA.STOREPRODUCTS(SP_OWOWNERCODE, SP_PROCODE)
MODIFY OD_PRCOUNT DEFAULT 0 NOT NULL;


----INSERT
--INSERT INTO POSDBA.ORDERDETAILS(OD_OWCODE,OD_SRCODE,OD_MECODE,OD_DATE,OD_PRCODE,OD_PRCOUNT)
--VALUES('004','0241164171','60',
--TO_DATE('20221111120000', 'YYYYMMDDHH24MISS'),'10155',DEFAULT);