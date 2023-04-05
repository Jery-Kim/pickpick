
-- 멤버 테이블
CREATE TABLE PP_member
(
    mem_id VARCHAR2(20) PRIMARY KEY                             -- 멤버 아이디(3자 이상 10장 이하)
    , mem_password VARCHAR2(200) NOT NULL                       -- 멤버 비밀번호(6자 이상 10자 이하)
    , mem_nickname VARCHAR2(20) UNIQUE NOT NULL                 -- 멤버 닉네임(2자 이상 8자 이하)  (중복 불가능)
    , mem_email VARCHAR2(20) NOT NULL                           -- 멤버 이메일
    , mem_phone VARCHAR2(20) NOT NULL                           -- 멤버 핸드폰번호
    , mem_gender VARCHAR2(5) CHECK(mem_gender IN('MALE', 'FEMALE', 'NONE'))     -- 멤버 성별
    , mem_address VARCHAR2(30) NOT NULL                         -- 사는 곳 주소
    , mem_role VARCHAR2(20) CHECK(mem_role IN('ROLE_USER', 'ROLE_HOST', 'ROLE_ADMIN')) NOT NULL       -- 멤버 롤
    , mem_joindate DATE DEFAULT SYSDATE                         -- 멤버 가입일
    , mem_state NUMBER(1) DEFAULT 1                             -- 멤버 상태
    -- 상태를 저장할 수 있는 컬럼을 나중에 만들 수도 있다.(콘트롤러에서 사용하기로 했으나, 다른 기능으로 들어갈 수도 있음)
);
ALTER TABLE PP_member DROP COLUMN mem_address;
ALTER TABLE PP_member ADD mem_address VARCHAR(300);

DROP TABLE PP_member; 
select*from  PP_member; 
-- 호스트 테이블
CREATE TABLE PP_member_host
(
    mem_id VARCHAR2(20) REFERENCES PP_member(mem_id) PRIMARY KEY    -- 멤버 아이디
    , mem_role VARCHAR2(20) NOT NULL                                -- 멤버롤(호스트)
    , host_count NUMBER(20) DEFAULT 0 NOT NULL                      -- 숙박 시설 이용한 총 이용객 수
    , host_reported NUMBER(5) DEFAULT 0                             -- 숙박 시설이 신고당한 횟수
    , host_grade NUMBER DEFAULT 0 CHECK(host_grade IN(0, 1, 2, 3, 4))       -- 호스트 등급
    -- 0 : 일반, 1 : 브론즈, 2 : 실버, 3 : 골드, 4 : 플레티넘
);

DROP TABLE PP_member_host;

-- 숙박객 테이블
CREATE TABLE PP_member_user
(
    mem_id VARCHAR2(20) REFERENCES PP_member(mem_id) PRIMARY KEY    -- 멤버 아이디
    , mem_role VARCHAR2(20) NOT NULL                                -- 멤버롤(유저)
    , user_reported NUMBER(5) DEFAULT 0                             -- 신고 당한 횟수(유저)
    , user_totalspend NUMBER(30) DEFAULT 0 NOT NULL                 -- 총 사용금액
    , user_tripcount NUMBER(20) DEFAULT 0 NOT NULL                  -- 여행 횟수
    , user_milelage NUMBER(20) DEFAULT 0                            -- 마일리지
    -- '가입 감사 마일리지' 10만 포인트 콘트롤러에서 주기.
    , user_grade NUMBER(1) DEFAULT 0 CHECK(user_grade IN(0, 1, 2, 3, 4))        -- 유저 등급
    -- 0 : 일반 유저, 1 : 브론즈, 2 : 실버, 3 : 골드, 4 : VIP
);

DROP TABLE PP_member_user;

-- 숙소 테이블
CREATE TABLE PP_sukso
(
    suk_num NUMBER(20) PRIMARY KEY                                                                 -- 숙소번호
    , suk_name VARCHAR2(20) NOT NULL                                                               -- 숙소 이름
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)                                             -- 맴버 아이디
    , suk_address VARCHAR2(100) NOT NULL                                                           -- 숙소의 주소
 
    , suk_location VARCHAR2(20) CHECK (suk_location IN ('서울특별시','경기도',
    '강원도','충청남도','충청북도','전라남도','전라북도', '경상남도','경상북도','제주특별자치시')) -- 행정구역
    , suk_visit NUMBER(20) DEFAULT 0                                                               -- 숙박 이용수
    , suk_price1 NUMBER(20) NOT NULL                                                               -- 숙박 가격(일반)
--  , suk_price2 NUMBER(20) NOT NULL                                                               -- 숙박 가격(성수기/주말)
    ,suk_nearby VARCHAR2(20) CHECK (suk_nearby IN ('바다','강','하천','산','도심'))
    , suk_files_orz VARCHAR2(300)                     -- 사진 원래 이름
    , suk_files_saved VARCHAR2(100)                   -- 사진 저장된 이름
);
select *from  PP_sukso;
create SEQUENCE PP_sukso_seq;
drop table  PP_sukso;
drop SEQUENCE PP_sukso_seq;

-- 태그 테이블(숙소 게시판, 리뷰 게시판용)
CREATE TABLE PP_tag
(
    tag_index NUMBER(20) PRIMARY KEY                                    -- 태그에 들어갈 인덱스
    , tag_name VARCHAR2(20) UNIQUE NOT NULL                             -- 태그 단어
);

-- 숙소 스펙
CREATE TABLE PP_suk_spec
(
     suk_num PRIMARY KEY REFERENCES PP_sukso(suk_num)                   -- 숙소 아이디 (PK, FK 동시)
     , suk_visitcount NUMBER(5) DEFAULT 0                               -- 방문수
     , suk_bed NUMBER(5) DEFAULT 0                                      -- 침대 개수
     , suk_restroom NUMBER(5) DEFAULT 0                                 -- 화장실 개수
     , suk_parking NUMBER(1) DEFAULT 0 CHECK (suk_parking IN (0, 1))    -- 주차장 유무
     , suk_kitchin NUMBER(1) DEFAULT 0 CHECK (suk_kitchin IN (0, 1))    -- 주방 사용여부
     , suk_bbq NUMBER(1) DEFAULT 0 CHECK (suk_bbq IN (0, 1))            -- 바베큐 시설 유무
     , suk_maxmember NUMBER(5)                                          -- 최대 이용가능 인원수
     , suk_cctv NUMBER(1) DEFAULT 0 CHECK (suk_cctv IN (0, 1))          -- cctv 여부
     , suk_pet NUMBER(1) DEFAULT 0 CHECK (suk_pet IN (0, 1))            -- 애완동물의 가능 여부
     , suk_floor NUMBER(5)                                              -- 숙소의 층수
     , suk_elev NUMBER(1) DEFAULT 0 CHECK (suk_elev IN (0, 1))          -- 엘레베이터
     , suk_wifi NUMBER(1) DEFAULT 0 CHECK (suk_wifi IN (0, 1))          -- 와이파이
     , suk_laundary NUMBER(1) DEFAULT 0 CHECK (suk_laundary IN (0, 1))  -- 세탁 가능 여부
     , suk_notice VARCHAR2(3000) DEFAULT ' '                            -- 숙소 공지 사항
    -- 기본 : 0은 없음, 1은 있음. (입력 받아야함)
    -- 입력 받아야하는 개수가 필요한 컬럼들은 모두 (5)로 통일.
);


select * from PP_suk_spec WHERE suk_num = '12';

drop table  PP_suk_spec;
-- 숙소 태그 게시판
-- (태그 테이블이랑 연결해서 복합키로 설정)
CREATE TABLE PP_sukso_tag
(
    suk_num NUMBER(20) REFERENCES PP_sukso(suk_num)                                                -- 숙소번호
    , tag_name VARCHAR2(20) REFERENCES PP_tag(tag_name)                                            -- 태그
    , CONSTRAINT suk_tag_pk PRIMARY KEY(suk_num, tag_name)                                         -- 복합키 설정
);

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
    , res_message VARCHAR2(3000)                             -- 숙소주인에게 보낼 메세지
    , res_price NUMBER(20) NOT NULL                          -- 총 비용(할인 후 금액)
        -- 마일리지(사용 시 마일리지는 총 숙소금액 차감, 결제금액에 사용됨.)
    , res_state NUMBER(1) DEFAULT 0 CHECK (res_state IN (0, 1, 2, 3)) -- 숙소의 예약 상태
    -- state 0은 예약, 1은 예약변경 불가능(취소도 불가능),  2는 숙박중, 3은 숙박완료
);
create sequence PP_reservation_seq;
select * from PP_reservation;
-- 신고 게시판 테이블
CREATE TABLE PP_report
(
    rep_num NUMBER(20) PRIMARY KEY                          -- 신고 (게시판) 번호
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- 예약한 맴버 아이디
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num) -- 예약 번호
    , rep_title VARCHAR2(20) NOT NULL                       -- 신고 게시판 제목
    , rep_contents VARCHAR2(3000) NOT NULL                  -- 신고 내용
    , rep_files_orz VARCHAR2(300)                           -- 신고 게시판 현재 파일
    , rep_files_saved VARCHAR2(100)                         -- 신고 게시판 저장된 파일
    , rep_date DATE DEFAULT SYSDATE                         -- 신고 작성 일시
);

-- 신고 댓글
CREATE TABLE PP_rep_comment
(
    rep_comment_num NUMBER(20) PRIMARY KEY              -- 신고 게시판 댓글
    , rep_num NUMBER(20)REFERENCES PP_report(rep_num)   -- 신고 게시판 번호
    , rep_comment_contents VARCHAR2(3000) NOT NULL      -- 댓글 내용
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- 댓글 작성자
    , rep_comment_date DATE DEFAULT SYSDATE             -- 댓글 작성 시간
);

-- 이의 신청
CREATE TABLE PP_deny
(
    deny_num NUMBER(20) PRIMARY KEY                    -- 이의신청 게시판 번호
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID) -- 이용자용
    , rev_num NUMBER(20) REFERENCES PP_reservation(rev_num) -- 숙박 정보 가져오기
    , deny_title VARCHAR2(20) NOT NULL                 -- 이의신청 게시판 제목
    , deny_contents VARCHAR2(3000) NOT NULL            -- 게시판 내용
    , deny_files_orz VARCHAR2(300)                     -- 파일 원래 이름
    , deny_files_saved VARCHAR2(100)                   -- 파일 저장하는 이름
    , deny_date DATE DEFAULT SYSDATE                   -- 이의신청 게시한 날짜
);

-- 이의 신청 댓글
CREATE TABLE PP_deny_comment
(
    deny_comment_num NUMBER(20) PRIMARY KEY                 -- 이의신청 게시판 댓글 번호
    , deny_num NUMBER(20) REFERENCES PP_deny(deny_num)      -- 이의신청 게시글 번호
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- 멤버 아이디
    , deny_comment_contents VARCHAR2(300) NOT NULL          -- 이의신청 댓글 내용
    , deny_comment_date DATE DEFAULT SYSDATE                -- 댓글 작성 시간
);

-- 리뷰(게시판)
CREATE TABLE PP_review
(
    rev_num NUMBER(20) PRIMARY KEY              
    ,suk_num NUMBER(20)-- 리뷰 번호
--    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)     -- 예약 번호
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)          -- 멤버 아이디
    , rev_star_clean NUMBER(1) CHECK (rev_star_clean IN (0, 1, 2, 3, 4, 5))       -- 청결 별점
    , rev_star_access NUMBER(1) CHECK (rev_star_access IN (0, 1, 2, 3, 4, 5))     -- 접근성 별점
    , rev_star_faci NUMBER(1) CHECK (rev_star_faci IN (0, 1, 2, 3, 4, 5))         -- 시설 별점
    , rev_star_service NUMBER(1) CHECK (rev_star_service IN (0, 1, 2, 3, 4, 5))   -- 서비스 별점
    , rev_title VARCHAR2(30)                                     -- 리뷰 제목
    , rev_contents VARCHAR2(3000)                                -- 리뷰 내용
    , rev_files_orz VARCHAR2(300)                                -- 파일 원래 이름
    , rev_files_saved VARCHAR2(100)                              -- 파일 저장 이름
    , rev_date DATE DEFAULT SYSDATE                              -- 리뷰 작성 일시     
);
drop table pp_review;
create SEQUENCE PP_review_seq;

-- 리뷰 게시판 댓글
CREATE TABLE PP_rev_comment
(
    rev_comment_num NUMBER(20) PRIMARY KEY                       -- 리뷰 댓글 번호
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num)      -- 리뷰 게시글 번호
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)           -- 멤버 아이디
    , rev_comment_contents VARCHAR2(3000) NOT NULL               -- 리뷰 댓글 내용
    , rev_comment_date DATE DEFAULT SYSDATE                      -- 리뷰 댓글 날짜
);

-- 리뷰 태그
CREATE TABLE PP_review_tag
(
    rev_num NUMBER(20) REFERENCES PP_review(rev_num)                                               -- 리뷰 번호
    , tag_name VARCHAR2(20) REFERENCES PP_tag(tag_name)                                            -- 태그
    , CONSTRAINT suk_tag_pk PRIMARY KEY(rev_num, tag_name)                                         -- 복합키 설정
);

-- 번개 게시판
CREATE TABLE PP_bung
(
    bung_num NUMBER(20) PRIMARY KEY                         -- 번개 게시판 번호
    , bung_title VARCHAR2(20) NOT NULL                      -- 번개 게시판 제목
    , bung_contents VARCHAR2(300) NOT NULL                  -- 번개 게시판 내용
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)      -- 작성자
    , res_num REFERENCES PP_reservation(res_num)            -- 예약 번호
    , suk_address VARCHAR2(100) REFERENCES PP_sukso(suk_address)       -- 숙소 주소
    , bung_inputdate DATE DEFAULT SYSDATE                   -- 입력 시간
    , bung_meetdate DATE DEFAULT SYSDATE                    -- 만나는 시간
    , mem_nickname VARCHAR2(30) REFERENCES PP_member(mem_nickname)     -- 닉네임
    , bung_cate VARCHAR2(30) CHECK(bung_cate IN ('food', 'vehicle', 'activity', 'tour')) -- 게시글 카테고리
);

-- 번개 댓글
CREATE TABLE PP_bung_comment
(
    bung_comm_num NUMBER(20) PRIMARY KEY                -- 번개 댓글 번호 
    , mem_ID VARCHAR2(20) REFERENCES PP_member(mem_ID)  -- 댓글 작성자 
    , bung_comment_contents VARCHAR2(3000) NOT NULL     -- 번개 댓글 내용
    , bung_num NUMBER(20) REFERENCES PP_bung(bung_num)  -- 번개 게시글 번호
    , bung_comm_date DATE DEFAULT SYSDATE               -- 댓글 작성 일시
);

-- 결제 테이블
CREATE TABLE PP_pay
(
    pay_num NUMBER(20) PRIMARY KEY                          -- 결제 번호
    , res_num NUMBER(20) REFERENCES PP_reservation(res_num) -- 예약 번호
    , pay_date DATE DEFAULT SYSDATE                         -- 결제 일시
    , res_price VARCHAR2(100) REFERENCES PP_reservation(res_price)  -- 실제로 결제되는 금액
);


-- 채팅방 테이블
CREATE TABLE PP_chat_room
(
    chat_room_num NUMBER(20) PRIMARY KEY                          -- 채팅방 번호
    , chat_room_name VARCHAR2(30) NOT NULL                        -- 채팅방 이름
    , chat_room_created DATE DEFAULT SYSDATE                      -- 채팅방 생성 일시
);

-- 채팅방 유저정보 테이블
CREATE TABLE PP_chat_user
(
    chat_user_mem VARCHAR2(20) NOT NULL                                 -- 채팅방에 들어온 아이디
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_id)                  -- 멤버 아이디(정보 가져오기 위함)
    , chat_room_num NUMBER(20) REFERENCES PP_chat_room(PP_room_num)     -- 채팅방 번호
);

-- 채팅방 메시지정보 테이블
CREATE TABLE PP_chat_message
(
    chat_msg_num NUMBER(20) PRIMARY KEY                          -- 채팅 번호
    , chat_msg_content VARCHAR2(1000) NOT NULL                   -- 채팅 내용
    , chat_user_mem VARCHAR2(20) REFERENCES PP_chat_user(chat_user_mem) NOT NULL            -- 채팅방 참여 인원
    , mem_id VARCHAR2(20) REFERENCES PP_member(mem_id)           -- 보내는 사람
    , chat_room_num REFERENCES PP_chat_room(PP_room_num)         -- 속한 채팅방
    , chat_msg_date DATE DEFAULT SYSDATE                         -- 메시지 전송 일시
);

select * from PP_member;






---------------------------------

-- 해보기

CREATE TABLE ADDRESS_COORDS (
    ADDRESS VARCHAR2(255),
    LATITUDE NUMBER(10, 8),
    LONGITUDE NUMBER(11, 8)
);
