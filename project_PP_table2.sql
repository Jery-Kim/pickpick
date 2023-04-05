
-- ��� ���̺�
CREATE TABLE PP_member
(
    mem_id VARCHAR2(20) PRIMARY KEY                             -- ��� ���̵�(3�� �̻� 10�� ����)
    , mem_password VARCHAR2(200) NOT NULL                       -- ��� ��й�ȣ(6�� �̻� 10�� ����)
    , mem_nickname VARCHAR2(20) UNIQUE NOT NULL                 -- ��� �г���(2�� �̻� 8�� ����)  (�ߺ� �Ұ���)
    , mem_email VARCHAR2(20) NOT NULL                           -- ��� �̸���
    , mem_phone VARCHAR2(20) NOT NULL                           -- ��� �ڵ�����ȣ
    , mem_gender VARCHAR2(5) CHECK(mem_gender IN('MALE', 'FEMALE', 'NONE'))     -- ��� ����
    , mem_address VARCHAR2(30) NOT NULL                         -- ��� �� �ּ�
    , mem_role VARCHAR2(20) CHECK(mem_role IN('ROLE_USER', 'ROLE_HOST', 'ROLE_ADMIN')) NOT NULL       -- ��� ��
    , mem_joindate DATE DEFAULT SYSDATE                         -- ��� ������
    , mem_state NUMBER(1) DEFAULT 1                             -- ��� ����
    -- ���¸� ������ �� �ִ� �÷��� ���߿� ���� ���� �ִ�.(��Ʈ�ѷ����� ����ϱ�� ������, �ٸ� ������� �� ���� ����)
);
ALTER TABLE PP_member DROP COLUMN mem_address;
ALTER TABLE PP_member ADD mem_address VARCHAR(300);

DROP TABLE PP_member; 
select*from  PP_member; 
-- ȣ��Ʈ ���̺�
CREATE TABLE PP_member_host
(
    mem_id VARCHAR2(20) REFERENCES PP_member(mem_id) PRIMARY KEY    -- ��� ���̵�
    , mem_role VARCHAR2(20) NOT NULL                                -- �����(ȣ��Ʈ)
    , host_count NUMBER(20) DEFAULT 0 NOT NULL                      -- ���� �ü� �̿��� �� �̿밴 ��
    , host_reported NUMBER(5) DEFAULT 0                             -- ���� �ü��� �Ű���� Ƚ��
    , host_grade NUMBER DEFAULT 0 CHECK(host_grade IN(0, 1, 2, 3, 4))       -- ȣ��Ʈ ���
    -- 0 : �Ϲ�, 1 : �����, 2 : �ǹ�, 3 : ���, 4 : �÷�Ƽ��
);

DROP TABLE PP_member_host;

-- ���ڰ� ���̺�
CREATE TABLE PP_member_user
(
    mem_id VARCHAR2(20) REFERENCES PP_member(mem_id) PRIMARY KEY    -- ��� ���̵�
    , mem_role VARCHAR2(20) NOT NULL                                -- �����(����)
    , user_reported NUMBER(5) DEFAULT 0                             -- �Ű� ���� Ƚ��(����)
    , user_totalspend NUMBER(30) DEFAULT 0 NOT NULL                 -- �� ���ݾ�
    , user_tripcount NUMBER(20) DEFAULT 0 NOT NULL                  -- ���� Ƚ��
    , user_milelage NUMBER(20) DEFAULT 0                            -- ���ϸ���
    -- '���� ���� ���ϸ���' 10�� ����Ʈ ��Ʈ�ѷ����� �ֱ�.
    , user_grade NUMBER(1) DEFAULT 0 CHECK(user_grade IN(0, 1, 2, 3, 4))        -- ���� ���
    -- 0 : �Ϲ� ����, 1 : �����, 2 : �ǹ�, 3 : ���, 4 : VIP
);

DROP TABLE PP_member_user;

-- ���� ���̺�
CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY                                                                 -- ���ҹ�ȣ
    , suk_name VARCHAR2(20) NOT NULL                                                               -- ���� �̸�
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)                                             -- �ɹ� ���̵�
    , suk_address VARCHAR2(100) NOT NULL                                                           -- ������ �ּ�
 
    , suk_location VARCHAR2(20) CHECK (suk_location IN ('����Ư����','��⵵',
    '������','��û����','��û�ϵ�','���󳲵�','����ϵ�', '��󳲵�','���ϵ�','����Ư����ġ��')) -- ��������
    , suk_visit NUMBER(20) DEFAULT 0                                                               -- ���� �̿��
    , suk_price1 NUMBER(20) NOT NULL                                                               -- ���� ����(�Ϲ�)
--  , suk_price2 NUMBER(20) NOT NULL                                                               -- ���� ����(������/�ָ�)
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('�ٴ�','��','��õ','��','����'))
    , suk_files_orz VARCHAR2(300)                     -- ���� ���� �̸�
    , suk_files_saved VARCHAR2(100)                   -- ���� ����� �̸�
);
select *from  PP_sukso;
create SEQUENCE PP_sukso_seq;
drop table  PP_sukso;
drop SEQUENCE PP_sukso_seq;

-- �±� ���̺�(���� �Խ���, ���� �Խ��ǿ�)
CREATE TABLE PP_tag
(
    tag_index NUMBER(20) PRIMARY KEY                                    -- �±׿� �� �ε���
    , tag_name VARCHAR2(20) UNIQUE NOT NULL                             -- �±� �ܾ�
);

-- ���� ����
CREATE TABLE PP_suk_spec
(
     suk_num PRIMARY KEY REFERENCES PP_sukso(suk_num)                   -- ���� ���̵� (PK, FK ����)
     , suk_visitcount NUMBER(5) DEFAULT 0                               -- �湮��
     , suk_bed NUMBER(5) DEFAULT 0                                      -- ħ�� ����
     , suk_restroom NUMBER(5) DEFAULT 0                                 -- ȭ��� ����
     , suk_parking NUMBER(1) DEFAULT 0 CHECK (suk_parking IN (0, 1))    -- ������ ����
     , suk_kitchin NUMBER(1) DEFAULT 0 CHECK (suk_kitchin IN (0, 1))    -- �ֹ� ��뿩��
     , suk_bbq NUMBER(1) DEFAULT 0 CHECK (suk_bbq IN (0, 1))            -- �ٺ�ť �ü� ����
     , suk_maxmember NUMBER(5)                                          -- �ִ� �̿밡�� �ο���
     , suk_cctv NUMBER(1) DEFAULT 0 CHECK (suk_cctv IN (0, 1))          -- cctv ����
     , suk_pet NUMBER(1) DEFAULT 0 CHECK (suk_pet IN (0, 1))            -- �ֿϵ����� ���� ����
     , suk_floor NUMBER(5)                                              -- ������ ����
     , suk_elev NUMBER(1) DEFAULT 0 CHECK (suk_elev IN (0, 1))          -- ����������
     , suk_wifi NUMBER(1) DEFAULT 0 CHECK (suk_wifi IN (0, 1))          -- ��������
     , suk_laundary NUMBER(1) DEFAULT 0 CHECK (suk_laundary IN (0, 1))  -- ��Ź ���� ����
     , suk_notice VARCHAR2(3000) DEFAULT ' '                            -- ���� ���� ����
    -- �⺻ : 0�� ����, 1�� ����. (�Է� �޾ƾ���)
    -- �Է� �޾ƾ��ϴ� ������ �ʿ��� �÷����� ��� (5)�� ����.
);


select * from PP_suk_spec WHERE suk_num = '12';

drop table  PP_suk_spec;
-- ���� �±� �Խ���
-- (�±� ���̺��̶� �����ؼ� ����Ű�� ����)
CREATE TABLE PP_sukso_tag
(
    suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)                                                -- ���ҹ�ȣ
    , tag_name VARCHAR2(20) REFERENCES PP_tag(tag_name)                                            -- �±�
    , CONSTRAINT suk_tag_pk PRIMARY KEY(suk_num, tag_name)                                         -- ����Ű ����
);

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
    , res_message VARCHAR2(3000)                             -- �������ο��� ���� �޼���
    , res_price NUMBER(20) NOT NULL                          -- �� ���(���� �� �ݾ�)
        -- ���ϸ���(��� �� ���ϸ����� �� ���ұݾ� ����, �����ݾ׿� ����.)
    , res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) -- ������ ���� ����
    -- state 0�� ����, 1�� ���ຯ�� �Ұ���(��ҵ� �Ұ���),  2�� ������, 3�� ���ڿϷ�
);
create sequence PP_reservation_seq;
select * from PP_reservation;
-- �Ű� �Խ��� ���̺�
CREATE TABLE PP_report
(
    rep_num NUMBER(20) PRIMARY KEY                          -- �Ű� (�Խ���) ��ȣ
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- ������ �ɹ� ���̵�
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num) -- ���� ��ȣ
    , rep_title VARCHAR2(20) NOT NULL                       -- �Ű� �Խ��� ����
    , rep_contents VARCHAR2(3000) NOT NULL                  -- �Ű� ����
    , rep_files_orz VARCHAR2(300)                           -- �Ű� �Խ��� ���� ����
    , rep_files_saved VARCHAR2(100)                         -- �Ű� �Խ��� ����� ����
    , rep_date DATE DEFAULT SYSDATE                         -- �Ű� �ۼ� �Ͻ�
);

-- �Ű� ���
CREATE TABLE PP_rep_comment
(
    rep_comment_num NUMBER(20) PRIMARY KEY              -- �Ű� �Խ��� ���
    , rep_num NUMBER(20)REFERENCES PP_report(rep_num)   -- �Ű� �Խ��� ��ȣ
    , rep_comment_contents VARCHAR2(3000) NOT NULL      -- ��� ����
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- ��� �ۼ���
    , rep_comment_date DATE DEFAULT SYSDATE             -- ��� �ۼ� �ð�
);

-- ���� ��û
CREATE TABLE PP_deny
(
    deny_num NUMBER(20) PRIMARY KEY                    -- ���ǽ�û �Խ��� ��ȣ
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) -- �̿��ڿ�
    , rev_num NUMBER(20) REFERENCES PP_reservation(rev_num) -- ���� ���� ��������
    , deny_title VARCHAR2(20) NOT NULL                 -- ���ǽ�û �Խ��� ����
    , deny_contents VARCHAR2(3000) NOT NULL            -- �Խ��� ����
    , deny_files_orz VARCHAR2(300)                     -- ���� ���� �̸�
    , deny_files_saved VARCHAR2(100)                   -- ���� �����ϴ� �̸�
    , deny_date DATE DEFAULT SYSDATE                   -- ���ǽ�û �Խ��� ��¥
);

-- ���� ��û ���
CREATE TABLE PP_deny_comment
(
    deny_comment_num NUMBER(20) PRIMARY KEY                 -- ���ǽ�û �Խ��� ��� ��ȣ
    , deny_num NUMBER(20) REFERENCES PP_deny(deny_num)      -- ���ǽ�û �Խñ� ��ȣ
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- ��� ���̵�
    , deny_comment_contents VARCHAR2(300) NOT NULL          -- ���ǽ�û ��� ����
    , deny_comment_date DATE DEFAULT SYSDATE                -- ��� �ۼ� �ð�
);

-- ����(�Խ���)
CREATE TABLE PP_review
(
    rev_num NUMBER(20) PRIMARY KEY              
    ,suk_num NUMBER(20)-- ���� ��ȣ
--    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)     -- ���� ��ȣ
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)          -- ��� ���̵�
    , rev_star_clean NUMBER(1) CHECK (rev_star_clean IN (0, 1, 2, 3, 4, 5))       -- û�� ����
    , rev_star_access NUMBER(1) CHECK (rev_star_access IN (0, 1, 2, 3, 4, 5))     -- ���ټ� ����
    , rev_star_faci NUMBER(1) CHECK (rev_star_faci IN (0, 1, 2, 3, 4, 5))         -- �ü� ����
    , rev_star_service NUMBER(1) CHECK (rev_star_service IN (0, 1, 2, 3, 4, 5))   -- ���� ����
    , rev_title VARCHAR2(30)                                     -- ���� ����
    , rev_contents VARCHAR2(3000)                                -- ���� ����
    , rev_files_orz VARCHAR2(300)                                -- ���� ���� �̸�
    , rev_files_saved VARCHAR2(100)                              -- ���� ���� �̸�
    , rev_date DATE DEFAULT SYSDATE                              -- ���� �ۼ� �Ͻ�     
);
drop table pp_review;
create SEQUENCE PP_review_seq;

-- ���� �Խ��� ���
CREATE TABLE PP_rev_comment
(
    rev_comment_num NUMBER(20) PRIMARY KEY                       -- ���� ��� ��ȣ
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)      -- ���� �Խñ� ��ȣ
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)           -- ��� ���̵�
    , rev_comment_contents VARCHAR2(3000) NOT NULL               -- ���� ��� ����
    , rev_comment_date DATE DEFAULT SYSDATE                      -- ���� ��� ��¥
);

-- ���� �±�
CREATE TABLE PP_review_tag
(
    rev_num NUMBER(20) REFERENCES PP_review(rev_num)                                               -- ���� ��ȣ
    , tag_name VARCHAR2(20) REFERENCES PP_tag(tag_name)                                            -- �±�
    , CONSTRAINT suk_tag_pk PRIMARY KEY(rev_num, tag_name)                                         -- ����Ű ����
);

-- ���� �Խ���
CREATE TABLE PP_bung
(
    bung_num NUMBER(20) PRIMARY KEY                         -- ���� �Խ��� ��ȣ
    , bung_title VARCHAR2(20) NOT NULL                      -- ���� �Խ��� ����
    , bung_contents VARCHAR2(300) NOT NULL                  -- ���� �Խ��� ����
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- �ۼ���
    , res_num REFERENCES PP_reservation(res_num)            -- ���� ��ȣ
    , suk_address VARCHAR2(100) REFERENCES PP_sukso(suk_address)       -- ���� �ּ�
    , bung_inputdate DATE DEFAULT SYSDATE                   -- �Է� �ð�
    , bung_meetdate DATE DEFAULT SYSDATE                    -- ������ �ð�
    , mem_nickname VARCHAR2(30) REFERENCES PP_member(mem_nickname)     -- �г���
    , bung_cate VARCHAR2(30) CHECK(bung_cate IN ('food', 'vehicle', 'activity', 'tour')) -- �Խñ� ī�װ�
);

-- ���� ���
CREATE TABLE PP_bung_comment
(
    bung_comm_num NUMBER(20) PRIMARY KEY                -- ���� ��� ��ȣ 
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- ��� �ۼ��� 
    , bung_comment_contents VARCHAR2(3000) NOT NULL     -- ���� ��� ����
    , bung_num NUMBER(20) REFERENCES PP_bung(bung_num)  -- ���� �Խñ� ��ȣ
    , bung_comm_date DATE DEFAULT SYSDATE               -- ��� �ۼ� �Ͻ�
);

-- ���� ���̺�
CREATE TABLE PP_pay
(
    pay_num NUMBER(20) PRIMARY KEY                          -- ���� ��ȣ
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num) -- ���� ��ȣ
    , pay_date DATE DEFAULT SYSDATE                         -- ���� �Ͻ�
    , res_price VARCHAR2(100) REFERENCES PP_reservation(res_price)  -- ������ �����Ǵ� �ݾ�
);


-- ä�ù� ���̺�
CREATE TABLE PP_chat_room
(
    chat_room_num NUMBER(20) PRIMARY KEY                          -- ä�ù� ��ȣ
    , chat_room_name VARCHAR2(30) NOT NULL                        -- ä�ù� �̸�
    , chat_room_created DATE DEFAULT SYSDATE                      -- ä�ù� ���� �Ͻ�
);

-- ä�ù� �������� ���̺�
CREATE TABLE PP_chat_user
(
    chat_user_mem VARCHAR2(20) NOT NULL                                 -- ä�ù濡 ���� ���̵�
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_id)                  -- ��� ���̵�(���� �������� ����)
    , chat_room_num NUMBER(20) REFERENCES PP_chat_room(PP_room_num)     -- ä�ù� ��ȣ
);

-- ä�ù� �޽������� ���̺�
CREATE TABLE PP_chat_message
(
    chat_msg_num NUMBER(20) PRIMARY KEY                          -- ä�� ��ȣ
    , chat_msg_content VARCHAR2(1000) NOT NULL                   -- ä�� ����
    , chat_user_mem VARCHAR2(20) REFERENCES PP_chat_user(chat_user_mem) NOT NULL            -- ä�ù� ���� �ο�
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_id)           -- ������ ���
    , chat_room_num REFERENCES PP_chat_room(PP_room_num)         -- ���� ä�ù�
    , chat_msg_date DATE DEFAULT SYSDATE                         -- �޽��� ���� �Ͻ�
);

select * from PP_member;






---------------------------------

-- �غ���

CREATE TABLE ADDRESS_COORDS (
    ADDRESS VARCHAR2(255),
    LATITUDE NUMBER(10, 8),
    LONGITUDE NUMBER(11, 8)
);
