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
    number varchar(30) comment '전화번호',
    birth varchar(20) comment '생년월일',
    level varchar(2) default 'U' comment '등급',
    agreop varchar(2) comment '약관동의여부',
    pwfcnt varchar(1) default '0' comment '비밀번호틀린횟수',
    ismember varchar(2) default 'N' comment '가입여부',
    token varchar(200) comment '인증번호'
);

insert into user (email,pw,ename,kname,gender,korf,number,birth,level,agreop,token) 
values ('ezenteam@naver.com',md5('ezen'),'manager','관리자','F','K','010-1234-5678','19990909','A','Y','98765421');
insert into user (email,pw,ename,kname,gender,korf,number,birth,agreop,token) 
values ('teamb@naver.com',md5('ezen'),'donkey','동키','M','F','01012345678','19790909','Y','12349865');
insert into user(email,pw,ename,kname,gender,korf,number,birth,agreop,token)
values ('wkddudwo01@naver.com',md5('1234'),'JangYeongJae','장영재','M','K','01025666244','19921214','Y','12345678');
insert into user (email,pw,ename,kname,gender,korf,number,birth,agreop,token)
 values ('lsclsj2000@gmail.com',md5('lsj02071357'),'SeongJaeLee','이성재','M','K','01045724328','20000207','Y','777');

create table roompricectrl
(
  rtype varchar(20) primary key comment '객실타입',
  adprice varchar(20) comment '성인가격',
  chprice varchar(20) comment '어린이가격'
);

insert into roompricectrl(rtype,adprice,chprice)
values('S','100000','50000');
insert into roompricectrl(rtype,adprice,chprice)
values('D','300000','50000');
insert into roompricectrl(rtype,adprice,chprice)
values('F','600000','50000');
insert into roompricectrl(rtype,adprice,chprice)
values('ST','1000000','50000');

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

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (10000000,20230713,20230723,'베게 10개 부탁드립니다.',2,1,1,'ezen@naver.com','ST');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (8000000,20230913,20230923,'침구류 깨끗한거로 부탁드립니다.',2,2,0,'teamb@naver.com','ST');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (190000000,20240713,20240723,'패밀리 날짜 24년 9월',2,1,0,'wkddudwo01@naver.com','F');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (108000000,20230913,20230923,'패밀리 날짜 23년 9월.',2,0,0,'teamb@naver.com','F');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (100400000,20240713,20240723,'여기는 더블룸입니다.더블룸 날짜 24년 9월',2,0,0,'teamb@naver.com','D');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (103000000,20230913,20230923,'더블룸 날짜 23년 9월.',2,0,0,'ezen@naver.com','D');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (100700000,20240713,20240723,'스탠다드 정렬 확인 입력 1 / 날짜 24년 9월',1,0,0,'wkddudwo01@naver.com','S');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (10909000,20230913,20230923,'스탠다드 정렬 확인 입력2 / 날짜 23년 9월.',1,1,0,'wkddudwo01@naver.com','S');


create table board
(
  bno int auto_increment primary key comment '게시글 번호',
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
  lockop varchar(2) default 'N' comment '비밀글여부',
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
 awdate datetime default now() comment '작성일',
 afname varchar(200) comment '첨부파일_논리명',
 apname varchar(200) comment '첨부파일_물리명',
 ahit int default 0 comment '조회수',
 acategory varchar(2) comment '게시판구분',
 email varchar(100) comment '이메일',
 foreign key(email) references user(email)
);

