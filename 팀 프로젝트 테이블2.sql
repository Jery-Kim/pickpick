--���� ���̺�--
CREATE TABLE PP_reservation
(
    res_num NUMBER(20) PRIMARY KEY --�����ȣ--
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --�ɹ� ���̵�--
    ,suk_num NUMBER(20) references PP_sukso(suk_num) --���ҹ�ȣ--
    ,res_inputdate DATE DEFAULT sysdate --������ �ð�--
    ,res_resdate DATE NOT NULL --���� �ð�--
    ,res_outdate DATE NOT NULL--������ �ð�--
    ,res_pop NUMBER(5) NOT NULL --�ο���--
    ,res_parking  NUMBER(1) DEFAULT 0 CHECK (res_parking IN (0, 1)) --������ ��뿩��--
    ,res_pet  NUMBER(1) DEFAULT 0 CHECK (res_pet IN (0, 1)) --�ֿϵ��� ����--
    ,res_message VARCHAR2(100) --�޼���--
    ,res_price VARCHAR2(100) NOT NULL --���--
    ,user_milelage(FK)
    ,res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) --�� ����, state 0�� ����, 1�� ���ຯ�� �Ұ���(��ҵ� �Ұ���),  2�� ������, 3�� ���ڿϷ�--
);
--���� ���̺�--
CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY --���ҹ�ȣ
    ,suk_name VARCHAR2(20) NOT NULL -- ���� �̸�
    ,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --�ɹ� ���̵�
    ,suk_address VARCHAR2(100) NOT NULL --�ּ�
    ,suk_location VARCHAR2(40) CHECK (suk_location IN ('����Ư����','��⵵',
    '������','��û����','��û�ϵ�','���󳲵�','����ϵ�', '��󳲵�','���ϵ�','����Ư����ġ��')) --�������� ��ġ
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('�ٴ�','��','��õ','��','����')) --�ֺ� ȯ�� ������
    ,suk_files_orz VARCHAR2(50)
     ,suk_files_saved VARCHAR2(50)
);
select * from PP_sukso;

drop table PP_sukso;
create SEQUENCE PP_sukso_seq;
drop SEQUENCE PP_sukso_seq;
--���� ����--
CREATE TABLE PP_suk_spec
(

     suk_spec  VARCHAR2(20) REFERENCES PP_sukso(suk_spec) UNIQUE --������--
     , suk_visitcount NUMBER(5) DEFAULT 0--�湮��
     , suk_bed NUMBER(5) DEFAULT 0 --ħ���
     , suk_restroom NUMBER(5) DEFAULT 0 
     , suk_parking NUMBER(1) DEFAULT 0 CHECK (suk_parking IN (0, 1))
     , suk_kitchin NUMBER(1) DEFAULT 0 CHECK (suk_kitchin IN (0, 1))
     , suk_bbq NUMBER(1) DEFAULT 0 CHECK (suk_bbq IN (0, 1))
     , suk_maxmember NUMBER(5)--�ִ� �̿밡�� �ο���--
     , suk_cctv NUMBER(1) DEFAULT 0 CHECK (suk_cctv IN (0, 1))
     , suk_pet NUMBER(1) DEFAULT 0 CHECK (suk_pet IN (0, 1))
     , suk_floor NUMBER(5)
     , suk_elev NUMBER(1) DEFAULT 0 CHECK (suk_elev IN (0, 1))
     , suk_wifi NUMBER(1) DEFAULT 0 CHECK (suk_wifi IN (0, 1))
     , suk_laundary NUMBER(1) DEFAULT 0 CHECK (suk_laundary IN (0, 1)) --��Ź���� ����
     , suk_notice VARCHAR2(3000) --��Ʈ
    -- �⺻ : 0�� ����, 1�� ����. (�Է� �޾ƾ���)--
    -- �Է� �޾ƾ��ϴ� ������ �ʿ��� �÷����� ��� (5)�� �����Ѵ�.--
);


--�Ű�
CREATE TABLE PP_report
(
rep_num NUMBER(20) PRIMARY KEY
,suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)
,rep_title VARCHAR2(20) NOT NULL
,rep_contents VARCHAR2(300) NOT NULL
,rep_files_orz VARCHAR2
,rep_files_saved VARCHAR2
,rep_date date default sysdate
,res_num NUMBER(20) REFERENCES PP_reservation(res_num)
);
--����
CREATE TABLE PP_pay
(
    pay_num NUMBER(20) PRIMARY KEY
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)
    , pay_date date DEFAULT sysdate
    , res_price VARCHAR2(100) REFERENCES PP_reservation(res_price)
);

--���� ��û
CREATE TABLE PP_deny
(
deny_num NUMBER(20) PRIMARY KEY
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,res_num NUMBER(20) 
,deny_title VARCHAR2(20) NOT NULL
,deny_contents VARCHAR2(300) NOT NULL
,deny_files_orz VARCHAR2(300)
,deny_files_saved VARCHAR2(100)
,deny_date date DEFAULT sysdate
);

create SEQUENCE PP_deny_seq;
drop table pp_deny;
select*table pp_deny;
drop sequence pp_deny_seq;

--���� ��û �ݹ�
CREATE TABLE PP_deny_comment 
(
deny_comment_num NUMBER(20) PRIMARY KEY
,deny_num NUMBER(20) REFERENCES PP_deny(deny_num)
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,deny_comment_contents VARCHAR2(300) NOT NULL
,deny_comment_date date DEFAULT sysdate
);

create SEQUENCE PP_deny_comment_seq;
drop table pp_deny_comment;
drop sequence pp_deny_comment_seq;

select*from PP_deny_comment ;

--����
CREATE TABLE PP_review
(
rev_num NUMBER(20) PRIMARY KEY
,suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)
--,res_num NUMBER(20) REFERENCES PP_reservation(res_num)
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,rev_star_clean NUMBER(1) DEFAULT 0 CHECK (rev_star_clean IN (0, 1, 2, 3, 4, 5))
--,rev_star_access NUMBER(1) DEFAULT 0 CHECK (rev_star_access IN (0, 1, 2, 3, 4, 5))
--,rev_star_faci NUMBER(1) DEFAULT 0 CHECK (rev_star_faci IN (0, 1, 2, 3, 4, 5))
--,rev_star_service NUMBER(1) DEFAULT 0 CHECK (rev_star_service IN (0, 1, 2, 3, 4, 5))
,rev_contents VARCHAR2(300) NOT NULL
,rev_files_orz VARCHAR2(300)
,rev_files_saved VARCHAR2(100)
,rev_date date DEFAULT sysdate
);
drop table PP_review;
create SEQUENCE PP_review_seq;
drop sequence PP_review_seq;
select * from pp_review where suk_num=12

--����
CREATE TABLE PP_bung
(
bung_num NUMBER(20) PRIMARY KEY
,bung_title VARCHAR2(20) NOT NULL
,bung_contents VARCHAR2(300) NOT NULL
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,res_num REFERENCES PP_reservation(res_num)
,suk_address VARCHAR2(100) PP_sukso(suk_address)
,bung_inputdate DATE NOT NULL,
,bung_meetdate DATE NOT NULL,
,mem_nickname VARCHAR2(30) REFERENCES PP_member(mem_nickname)
,bung_cate VARCHAR2(100) --����-- 
);
--���� ���
CREATE TABLE PP_bung_comment
(
bung_comm_num NUMBER(20) PRIMARY KEY
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,bung_comment_contents VARCHAR2(300) NOT NULL
,bung_num NUMBER(20) REFERENCES PP_bung(bung_num)
,bung_comm_date DEFAULT sysdate
);

-- ��� ���̺�
CREATE TABLE PP_member
(
    mem_id VARCHAR2(20) PRIMARY KEY                             -- ��� ���̵�(3�� �̻� 10�� ����)
    , mem_password VARCHAR2(200) NOT NULL                       -- ��� ��й�ȣ(6�� �̻� 10�� ����)
    , mem_nickname VARCHAR2(20) NOT NULL                        -- ��� �г���(2�� �̻� 8�� ����)
    , mem_email VARCHAR2(20) NOT NULL                           -- ��� �̸���
    , mem_phone VARCHAR2(20) NOT NULL                           -- ��� �ڵ�����ȣ
    , mem_gender VARCHAR2(20) CHECK(mem_gender IN('MALE', 'FEMALE', 'NONE'))     -- ��� ����
    , mem_address VARCHAR2(30) NOT NULL                         -- ��� �� �ּ�
    , mem_role VARCHAR2(20) CHECK(mem_role IN('ROLE_USER', 'ROLE_HOST', 'ROLE_ADMIN')) NOT NULL       -- ��� ��
    , mem_joindate DATE DEFAULT SYSDATE                         -- ��� ������
    , mem_state NUMBER(1) DEFAULT 1           -- ��� ����
    -- 0�� ����, 1�� ��밡��, 2�� �޸�, 3�� ��������
);

insert into PP_member(mem_id, mem_password, mem_nickname, mem_email, mem_phone, mem_gender, mem_address, mem_role) 
values( 'aaa', 'aaaaaa', 'aaa', 'aaa', '1234', 'NONE', '�ּ�', 'ROLE_USER');
select*from PP_member;
drop table PP_member;
commit;

-- ȣ��Ʈ ���̺�
CREATE TABLE PP_member_host
(
    mem_role VARCHAR2(20) REFERENCES PP_member(mem_id) NOT NULL     -- �����(ȣ��Ʈ)
    , host_count NUMBER(20) DEFAULT 0 NOT NULL                      -- ���� �ü� �̿��� �� �̿밴 ��
    , host_reported NUMBER(5) DEFAULT 0                             -- ���� �ü��� �Ű���� Ƚ��
    , host_grade NUMBER DEFAULT 0 CHECK(host_grade IN(0, 1, 2, 3, 4))       -- ȣ��Ʈ ���
    -- 0 : �Ϲ�, 1 : �����, 2 : �ǹ�, 3 : ���, 4 : �÷�Ƽ��
);

-- ���ڰ� ���̺�
CREATE TABLE PP_member_user
(
    mem_role VARCHAR2(20) REFERENCES PP_member(mem_id) NOT NULL     -- �����(����)
    , user_reported NUMBER(5) DEFAULT 0                             -- �Ű� ���� Ƚ��(����)
    , user_totalspend NUMBER(30) DEFAULT 0 NOT NULL                 -- �� ���ݾ�
    , user_tripcount NUMBER(20) DEFAULT 0 NOT NULL                  -- ���� Ƚ��
    , user_milelage NUMBER(20) DEFAULT 0                            -- ���ϸ���
    -- '���� ���� ���ϸ���' 10�� ����Ʈ ��Ʈ�ѷ����� �ֱ�.
    , user_grade NUMBER(1) DEFAULT 0 CHECK(user_grade IN(0, 1, 2, 3, 4))        -- ���� ���
    -- 0 : �Ϲ� ����, 1 : �����, 2 : �ǹ�, 3 : ���, 4 : VIP
);



CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY --���ҹ�ȣ
    ,suk_name VARCHAR2(20) NOT NULL -- ���� �̸�
    ,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --�ɹ� ���̵�
    ,suk_address VARCHAR2(100) NOT NULL --�ּ�
  --  ,suk_spec VARCHAR2(20) --������--
    ,suk_location VARCHAR2(20) CHECK (suk_location IN ('����Ư����','��⵵',
    '������','��û����','��û�ϵ�','���󳲵�','����ϵ�', '��󳲵�','���ϵ�','����Ư����ġ��')) --�������� ��ġ
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('�ٴ�','��','��õ','��','����')) --�ֺ� ȯ�� ������
);

drop table PP_sukso;
create SEQUENCE PP_sukso_seq;


insert into PP_sukso(suk_num,suk_name,mem_ID,suk_address,suk_location,suk_nearby)
values(PP_sukso_seq.NEXTVAL, 'aaa','3333','�ּ�','����Ư����','�ٴ�');
commit;

-- �Ű� �Խ��� ���̺�
CREATE TABLE PP_report
(
    rep_num NUMBER(20) PRIMARY KEY                          -- �Ű� (�Խ���) ��ȣ
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- ������ �ɹ� ���̵�
--    , suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)       -- ���� ��ȣ
    , rep_title VARCHAR2(20) NOT NULL                       -- �Ű� �Խ��� ����
    , rep_contents VARCHAR2(3000) NOT NULL                  -- �Ű� ����
    , rep_files_orz VARCHAR2(300)                           -- �Ű� �Խ��� ���� ����
    , rep_files_saved VARCHAR2(100)                         -- �Ű� �Խ��� ����� ����
    , rep_date DATE DEFAULT SYSDATE                         -- �Ű� �ۼ� �Ͻ�
    , res_num NUMBER(20)  -- ���� ��ȣ
);
create SEQUENCE PP_report_seq;
select*from PP_report;

drop table PP_report;
drop SEQUENCE PP_report_seq;

commit;
-- �Ű� ���
CREATE TABLE PP_rep_comment
(
    rep_comment_num NUMBER(20) PRIMARY KEY              -- �Ű� �Խ��� ���
    ,rep_num NUMBER(20)REFERENCES PP_report(rep_num)    -- �Ű� �Խ��� ��ȣ
    , rep_comment_contents VARCHAR2(3000) NOT NULL      -- ��� ����
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- ��� �ۼ���
    , rep_comment_date date DEFAULT SYSDATE
);
drop table PP_rep_comment;
create SEQUENCE PP_rep_comment_seq;
drop SEQUENCE PP_rep_comment_seq;
select *from PP_rep_comment;

-- ���� ���̺�
CREATE TABLE PP_reservation
(
    res_num NUMBER(20) PRIMARY KEY                           -- �����ȣ
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)       -- ������ �ɹ� ���̵�
    , suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)        -- ���� ��ȣ
    , res_inputdate DATE DEFAULT SYSDATE                     -- ������ �ð�
    , res_resdate DATE NOT NULL                              -- �Խ� �ð�
    , res_outdate DATE NOT NULL                              -- ��� �ð�
    , res_pop NUMBER(5) NOT NULL                             -- ���� �ο���
    , res_parking  NUMBER(1) DEFAULT 0 CHECK (res_parking IN (0, 1))     -- ������ ��뿩��
    , res_pet  NUMBER(1) DEFAULT 0 CHECK (res_pet IN (0, 1)) -- �ֿϵ����� ������ ���°�
    , res_message VARCHAR2(300)                              -- �������ο��� ���� �޼���
    , suk_price NUMBER(20) REFERENCES PP_sukso(suk_price)    -- ���� ���
    , res_price NUMBER(20) NOT NULL                          -- �� ���(���� �� �ݾ�)
    , user_milelage REFERENCES PP_member_user(user_milelage) -- ���ϸ���(��� �� ���ϸ����� ����, �����ݾ׿� ����.)
    , res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) -- ������ ���� ����
    -- state 0�� ����, 1�� ���ຯ�� �Ұ���(��ҵ� �Ұ���),  2�� ������, 3�� ���ڿϷ�
);


CREATE TABLE PP_suk_files
(
    suk_files_num NUMBER(20) PRIMARY KEY                             -- ���� ���� ��ȣ
    , suk1_files_orz VARCHAR2(300)                                    -- ���� ���� �̸�
    , suk1_files_saved VARCHAR2(100)                                  -- ���� ����� �̸�
    , suk_num NUMBER(20) REFERENCES PP_Sukso(suk_num) ON DELETE CASCADE           -- ���� ��ȣ
);
drop table pp_suk_files

create sequence pp_suk_files_seq;





select 
r.res_num
,r.mem_id
,r.suk_num
,s.suk_name
,m.mem_nickname
,s.suk_address
,r.res_resdate
,r.res_outdate
,r.res_price
,r.res_message
,r.res_pop

 from PP_reservation r, PP_sukso s, PP_member m where r.suk_num=s.suk_num and 
 s.mem_id=m.mem_id and r.mem_id=222 and r.res_state=0

select * from PP_reservation;
delete pp_reservation where res_num=23;

select 
r.res_num
,r.mem_id
,r.suk_num
,r.res_resdate
,r.res_outdate
,r.res_pop
,r.res_message
,r.res_price
,s.suk_name
,s.suk_address
,m.mem_nickname

 from PP_reservation r, PP_sukso s, PP_member m where r.suk_num=s.suk_num and 
 s.mem_id=m.mem_id and r.mem_id=222 and r.res_state=0
 
 
select * from pp_suk_spec;