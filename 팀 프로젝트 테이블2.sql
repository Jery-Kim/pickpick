--예약 테이블--
CREATE TABLE PP_reservation
(
    res_num NUMBER(20) PRIMARY KEY --예약번호--
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --맴버 아이디--
    ,suk_num NUMBER(20) references PP_sukso(suk_num) --숙소번호--
    ,res_inputdate DATE DEFAULT sysdate --예약한 시간--
    ,res_resdate DATE NOT NULL --들어가는 시간--
    ,res_outdate DATE NOT NULL--나가는 시간--
    ,res_pop NUMBER(5) NOT NULL --인원수--
    ,res_parking  NUMBER(1) DEFAULT 0 CHECK (res_parking IN (0, 1)) --주차장 사용여부--
    ,res_pet  NUMBER(1) DEFAULT 0 CHECK (res_pet IN (0, 1)) --애완동물 유무--
    ,res_message VARCHAR2(100) --메세지--
    ,res_price VARCHAR2(100) NOT NULL --비용--
    ,user_milelage(FK)
    ,res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) --현 상태, state 0은 예약, 1은 예약변경 불가능(취소도 불가능),  2는 숙박중, 3은 숙박완료--
);
--숙소 테이블--
CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY --숙소번호
    ,suk_name VARCHAR2(20) NOT NULL -- 숙소 이름
    ,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --맴버 아이디
    ,suk_address VARCHAR2(100) NOT NULL --주소
    ,suk_location VARCHAR2(40) CHECK (suk_location IN ('서울특별시','경기도',
    '강원도','충청남도','충청북도','전라남도','전라북도', '경상남도','경상북도','제주특별자치시')) --행정구역 위치
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('바다','강','하천','산','도심')) --주변 환경 보류중
    ,suk_files_orz VARCHAR2(50)
     ,suk_files_saved VARCHAR2(50)
);
select * from PP_sukso;

drop table PP_sukso;
create SEQUENCE PP_sukso_seq;
drop SEQUENCE PP_sukso_seq;
--숙소 스펙--
CREATE TABLE PP_suk_spec
(

     suk_spec  VARCHAR2(20) REFERENCES PP_sukso(suk_spec) UNIQUE --보류중--
     , suk_visitcount NUMBER(5) DEFAULT 0--방문수
     , suk_bed NUMBER(5) DEFAULT 0 --침대수
     , suk_restroom NUMBER(5) DEFAULT 0 
     , suk_parking NUMBER(1) DEFAULT 0 CHECK (suk_parking IN (0, 1))
     , suk_kitchin NUMBER(1) DEFAULT 0 CHECK (suk_kitchin IN (0, 1))
     , suk_bbq NUMBER(1) DEFAULT 0 CHECK (suk_bbq IN (0, 1))
     , suk_maxmember NUMBER(5)--최대 이용가능 인원수--
     , suk_cctv NUMBER(1) DEFAULT 0 CHECK (suk_cctv IN (0, 1))
     , suk_pet NUMBER(1) DEFAULT 0 CHECK (suk_pet IN (0, 1))
     , suk_floor NUMBER(5)
     , suk_elev NUMBER(1) DEFAULT 0 CHECK (suk_elev IN (0, 1))
     , suk_wifi NUMBER(1) DEFAULT 0 CHECK (suk_wifi IN (0, 1))
     , suk_laundary NUMBER(1) DEFAULT 0 CHECK (suk_laundary IN (0, 1)) --세탁가능 여부
     , suk_notice VARCHAR2(3000) --노트
    -- 기본 : 0은 없음, 1은 있음. (입력 받아야함)--
    -- 입력 받아야하는 개수가 필요한 컬럼들은 모두 (5)로 통일한다.--
);


--신고
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
--결제
CREATE TABLE PP_pay
(
    pay_num NUMBER(20) PRIMARY KEY
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)
    , pay_date date DEFAULT sysdate
    , res_price VARCHAR2(100) REFERENCES PP_reservation(res_price)
);

--이의 신청
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

--이의 신청 반박
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

--리뷰
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

--번개
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
,bung_cate VARCHAR2(100) --보류-- 
);
--번개 댓글
CREATE TABLE PP_bung_comment
(
bung_comm_num NUMBER(20) PRIMARY KEY
,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)
,bung_comment_contents VARCHAR2(300) NOT NULL
,bung_num NUMBER(20) REFERENCES PP_bung(bung_num)
,bung_comm_date DEFAULT sysdate
);

-- 멤버 테이블
CREATE TABLE PP_member
(
    mem_id VARCHAR2(20) PRIMARY KEY                             -- 멤버 아이디(3자 이상 10장 이하)
    , mem_password VARCHAR2(200) NOT NULL                       -- 멤버 비밀번호(6자 이상 10자 이하)
    , mem_nickname VARCHAR2(20) NOT NULL                        -- 멤버 닉네임(2자 이상 8자 이하)
    , mem_email VARCHAR2(20) NOT NULL                           -- 멤버 이메일
    , mem_phone VARCHAR2(20) NOT NULL                           -- 멤버 핸드폰번호
    , mem_gender VARCHAR2(20) CHECK(mem_gender IN('MALE', 'FEMALE', 'NONE'))     -- 멤버 성별
    , mem_address VARCHAR2(30) NOT NULL                         -- 사는 곳 주소
    , mem_role VARCHAR2(20) CHECK(mem_role IN('ROLE_USER', 'ROLE_HOST', 'ROLE_ADMIN')) NOT NULL       -- 멤버 롤
    , mem_joindate DATE DEFAULT SYSDATE                         -- 멤버 가입일
    , mem_state NUMBER(1) DEFAULT 1           -- 멤버 상태
    -- 0은 정지, 1은 사용가능, 2는 휴면, 3은 영구정지
);

insert into PP_member(mem_id, mem_password, mem_nickname, mem_email, mem_phone, mem_gender, mem_address, mem_role) 
values( 'aaa', 'aaaaaa', 'aaa', 'aaa', '1234', 'NONE', '주소', 'ROLE_USER');
select*from PP_member;
drop table PP_member;
commit;

-- 호스트 테이블
CREATE TABLE PP_member_host
(
    mem_role VARCHAR2(20) REFERENCES PP_member(mem_id) NOT NULL     -- 멤버롤(호스트)
    , host_count NUMBER(20) DEFAULT 0 NOT NULL                      -- 숙박 시설 이용한 총 이용객 수
    , host_reported NUMBER(5) DEFAULT 0                             -- 숙박 시설이 신고당한 횟수
    , host_grade NUMBER DEFAULT 0 CHECK(host_grade IN(0, 1, 2, 3, 4))       -- 호스트 등급
    -- 0 : 일반, 1 : 브론즈, 2 : 실버, 3 : 골드, 4 : 플레티넘
);

-- 숙박객 테이블
CREATE TABLE PP_member_user
(
    mem_role VARCHAR2(20) REFERENCES PP_member(mem_id) NOT NULL     -- 멤버롤(유저)
    , user_reported NUMBER(5) DEFAULT 0                             -- 신고 당한 횟수(유저)
    , user_totalspend NUMBER(30) DEFAULT 0 NOT NULL                 -- 총 사용금액
    , user_tripcount NUMBER(20) DEFAULT 0 NOT NULL                  -- 여행 횟수
    , user_milelage NUMBER(20) DEFAULT 0                            -- 마일리지
    -- '가입 감사 마일리지' 10만 포인트 콘트롤러에서 주기.
    , user_grade NUMBER(1) DEFAULT 0 CHECK(user_grade IN(0, 1, 2, 3, 4))        -- 유저 등급
    -- 0 : 일반 유저, 1 : 브론즈, 2 : 실버, 3 : 골드, 4 : VIP
);



CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY --숙소번호
    ,suk_name VARCHAR2(20) NOT NULL -- 숙소 이름
    ,mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) --맴버 아이디
    ,suk_address VARCHAR2(100) NOT NULL --주소
  --  ,suk_spec VARCHAR2(20) --보류중--
    ,suk_location VARCHAR2(20) CHECK (suk_location IN ('서울특별시','경기도',
    '강원도','충청남도','충청북도','전라남도','전라북도', '경상남도','경상북도','제주특별자치시')) --행정구역 위치
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('바다','강','하천','산','도심')) --주변 환경 보류중
);

drop table PP_sukso;
create SEQUENCE PP_sukso_seq;


insert into PP_sukso(suk_num,suk_name,mem_ID,suk_address,suk_location,suk_nearby)
values(PP_sukso_seq.NEXTVAL, 'aaa','3333','주소','서울특별시','바다');
commit;

-- 신고 게시판 테이블
CREATE TABLE PP_report
(
    rep_num NUMBER(20) PRIMARY KEY                          -- 신고 (게시판) 번호
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- 예약한 맴버 아이디
--    , suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)       -- 숙소 번호
    , rep_title VARCHAR2(20) NOT NULL                       -- 신고 게시판 제목
    , rep_contents VARCHAR2(3000) NOT NULL                  -- 신고 내용
    , rep_files_orz VARCHAR2(300)                           -- 신고 게시판 현재 파일
    , rep_files_saved VARCHAR2(100)                         -- 신고 게시판 저장된 파일
    , rep_date DATE DEFAULT SYSDATE                         -- 신고 작성 일시
    , res_num NUMBER(20)  -- 예약 번호
);
create SEQUENCE PP_report_seq;
select*from PP_report;

drop table PP_report;
drop SEQUENCE PP_report_seq;

commit;
-- 신고 댓글
CREATE TABLE PP_rep_comment
(
    rep_comment_num NUMBER(20) PRIMARY KEY              -- 신고 게시판 댓글
    ,rep_num NUMBER(20)REFERENCES PP_report(rep_num)    -- 신고 게시판 번호
    , rep_comment_contents VARCHAR2(3000) NOT NULL      -- 댓글 내용
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- 댓글 작성자
    , rep_comment_date date DEFAULT SYSDATE
);
drop table PP_rep_comment;
create SEQUENCE PP_rep_comment_seq;
drop SEQUENCE PP_rep_comment_seq;
select *from PP_rep_comment;

-- 예약 테이블
CREATE TABLE PP_reservation
(
    res_num NUMBER(20) PRIMARY KEY                           -- 예약번호
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)       -- 예약한 맴버 아이디
    , suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)        -- 숙소 번호
    , res_inputdate DATE DEFAULT SYSDATE                     -- 예약한 시간
    , res_resdate DATE NOT NULL                              -- 입실 시간
    , res_outdate DATE NOT NULL                              -- 퇴실 시간
    , res_pop NUMBER(5) NOT NULL                             -- 묵는 인원수
    , res_parking  NUMBER(1) DEFAULT 0 CHECK (res_parking IN (0, 1))     -- 주차장 사용여부
    , res_pet  NUMBER(1) DEFAULT 0 CHECK (res_pet IN (0, 1)) -- 애완동물을 데리고 오는가
    , res_message VARCHAR2(300)                              -- 숙소주인에게 보낼 메세지
    , suk_price NUMBER(20) REFERENCES PP_sukso(suk_price)    -- 숙박 비용
    , res_price NUMBER(20) NOT NULL                          -- 총 비용(할인 후 금액)
    , user_milelage REFERENCES PP_member_user(user_milelage) -- 마일리지(사용 시 마일리지는 차감, 결제금액에 사용됨.)
    , res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) -- 숙소의 예약 상태
    -- state 0은 예약, 1은 예약변경 불가능(취소도 불가능),  2는 숙박중, 3은 숙박완료
);


CREATE TABLE PP_suk_files
(
    suk_files_num NUMBER(20) PRIMARY KEY                             -- 숙소 파일 번호
    , suk1_files_orz VARCHAR2(300)                                    -- 사진 원래 이름
    , suk1_files_saved VARCHAR2(100)                                  -- 사진 저장된 이름
    , suk_num NUMBER(20) REFERENCES PP_Sukso(suk_num) ON DELETE CASCADE           -- 숙소 번호
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