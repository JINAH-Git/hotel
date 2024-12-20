create database hoteldb;
use hoteldb;

create table user
(
    email varchar(100) primary key comment '이메일',
    pw varchar(60) comment '비밀번호',
    ename varchar(60) comment '영문이름',
    kname varchar(20) comment '한글이름',
    gender varchar(2) comment '성별',
    joindate datetime default now() comment '가입일자',
    korf varchar(2) comment '내국인/외국인',
    phone varchar(30) comment '전화번호',
    birth varchar(20) comment '생년월일',
    level varchar(2) default 'U' comment '등급',
    agreop varchar(2) comment '약관동의여부',
    pwfcnt varchar(1) comment '비밀번호틀린횟수'
);

create table roompricectrl
(
  rtype varchar(20) primary key comment '객실타입',
  adprice varchar(20) comment '성인가격',
  chprice varchar(20) comment '어린이가격'
);


create table reservation
(
   resvno int auto_increment primary key comment '예약번호',
   totalprice varchar(20) comment '총결제가격',
   checkindate varchar(20) comment '체크인날짜',
   checkoutdate varchar(20) comment '체크아웃날짜',
   request text comment '요청사항',
   resvdate datetime default now() comment '예약일자',
   adcnt varchar(2) comment '성인수',
   chcnt varchar(2) comment '어린이수',
   kidcnt varchar(2) comment '유아수',
   email varchar(100) comment '이메일',
   rtype varchar(20) comment '객실타입',
   foreign key(email) references user(email),
   foreign key(rtype) references roompricectrl(rtype)
);

create table board
(
  bno integer primary key comment '게시글 번호',
  email varchar(100) comment '이메일',
  btitle varchar(100) comment '제목',
  bwriter varchar(60) comment '작성자',
  bnote text comment '내용',
  bfname varchar(200) comment '첨부파일_논리명',
  bpname varchar(200) comment '첨부파일_물리명',
  bwdate datetime default now() comment '작성일',
  bhit integer default 0 comment '조회수',
  category varchar(2) comment '게시판구분',
  noticeop varchar(2) default 'N' comment '공지여부',
  lookop varchar(2) default 'N' comment '비밀글여부',
  foreign key(email) references user(email)
);

create table reply
(
  rno int auto_increment primary key comment '댓글번호',
  bno int comment '게시글번호',
  rwriter varchar(60) comment '작성자',
  rnote text comment '내용',
  rwdate datetime default now() comment '댓글작성일',
  foreign key(bno) references board(bno)
);


create table admin
(
 ano int auto_increment primary key comment '관리자게시글번호',
 atitle varchar(100) comment '제목',
 anote text comment '내용',
 afname varchar(200) comment '첨부파일_논리명',
 apname varchar(200) comment '첨부파일_물리명',
 ahit int default 0 comment '조회수',
 acategory varchar(2) comment '게시판구분'
);

