create database hoteldb;
use hoteldb;

create table user
(
    email varchar(100) primary key comment '�̸���',
    pw varchar(60) comment '��й�ȣ',
    ename varchar(60) comment '�����̸�',
    kname varchar(20) comment '�ѱ��̸�',
    gender varchar(2) comment '����',
    joindate datetime default now() comment '��������',
    korf varchar(2) comment '������/�ܱ���',
    number varchar(30) comment '��ȭ��ȣ',
    birth varchar(20) comment '�������',
    level varchar(2) default 'U' comment '���',
    agreop varchar(2) comment '������ǿ���',
    pwfcnt varchar(1) default '0' comment '��й�ȣƲ��Ƚ��',
    ismember varchar(2) default 'N' comment '���Կ���',
    token varchar(200) comment '������ȣ'
);

insert into user (email,pw,ename,kname,gender,korf,number,birth,level,agreop,token) 
values ('ezenteam@naver.com',md5('ezen'),'manager','������','F','K','010-1234-5678','19990909','A','Y','98765421');
insert into user (email,pw,ename,kname,gender,korf,number,birth,agreop,token) 
values ('teamb@naver.com',md5('ezen'),'donkey','��Ű','M','F','01012345678','19790909','Y','12349865');
insert into user(email,pw,ename,kname,gender,korf,number,birth,agreop,token)
values ('wkddudwo01@naver.com',md5('1234'),'JangYeongJae','�念��','M','K','01025666244','19921214','Y','12345678');
insert into user (email,pw,ename,kname,gender,korf,number,birth,agreop,token)
 values ('lsclsj2000@gmail.com',md5('lsj02071357'),'SeongJaeLee','�̼���','M','K','01045724328','20000207','Y','777');

create table roompricectrl
(
  rtype varchar(20) primary key comment '����Ÿ��',
  adprice varchar(20) comment '���ΰ���',
  chprice varchar(20) comment '��̰���'
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
   resvno int auto_increment primary key comment '�����ȣ',
   totalprice varchar(20) comment '�Ѱ�������',
   checkindate varchar(20) comment 'üũ�γ�¥',
   checkoutdate varchar(20) comment 'üũ�ƿ���¥',
   request text comment '��û����',
   resvdate datetime default now() comment '��������',
   adcnt varchar(2) comment '���μ�',
   chcnt varchar(2) comment '��̼�',
   kidcnt varchar(2) comment '���Ƽ�',
   email varchar(100) comment '�̸���',
   rtype varchar(20) comment '����Ÿ��',
   foreign key(email) references user(email),
   foreign key(rtype) references roompricectrl(rtype)
);

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (10000000,20230713,20230723,'���� 10�� ��Ź�帳�ϴ�.',2,1,1,'ezen@naver.com','ST');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (8000000,20230913,20230923,'ħ���� �����Ѱŷ� ��Ź�帳�ϴ�.',2,2,0,'teamb@naver.com','ST');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (190000000,20240713,20240723,'�йи� ��¥ 24�� 9��',2,1,0,'wkddudwo01@naver.com','F');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (108000000,20230913,20230923,'�йи� ��¥ 23�� 9��.',2,0,0,'teamb@naver.com','F');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (100400000,20240713,20240723,'����� �������Դϴ�.������ ��¥ 24�� 9��',2,0,0,'teamb@naver.com','D');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (103000000,20230913,20230923,'������ ��¥ 23�� 9��.',2,0,0,'ezen@naver.com','D');

insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (100700000,20240713,20240723,'���Ĵٵ� ���� Ȯ�� �Է� 1 / ��¥ 24�� 9��',1,0,0,'wkddudwo01@naver.com','S');
insert into reservation (totalprice,checkindate,checkoutdate,request,adcnt,chcnt,kidcnt,email,rtype) 
values (10909000,20230913,20230923,'���Ĵٵ� ���� Ȯ�� �Է�2 / ��¥ 23�� 9��.',1,1,0,'wkddudwo01@naver.com','S');


create table board
(
  bno int auto_increment primary key comment '�Խñ� ��ȣ',
  email varchar(100) comment '�̸���',
  btitle varchar(100) comment '����',
  bwriter varchar(60) comment '�ۼ���',
  bnote text comment '����',
  bfname varchar(200) comment '÷������_������',
  bpname varchar(200) comment '÷������_������',
  bwdate datetime default now() comment '�ۼ���',
  bhit integer default 0 comment '��ȸ��',
  category varchar(2) comment '�Խ��Ǳ���',
  noticeop varchar(2) default 'N' comment '��������',
  lockop varchar(2) default 'N' comment '��бۿ���',
  foreign key(email) references user(email)
);

create table reply
(
  rno int auto_increment primary key comment '��۹�ȣ',
  bno int comment '�Խñ۹�ȣ',
  rwriter varchar(60) comment '�ۼ���',
  rnote text comment '����',
  rwdate datetime default now() comment '����ۼ���',
  foreign key(bno) references board(bno)
);


create table admin
(
 ano int auto_increment primary key comment '�����ڰԽñ۹�ȣ',
 atitle varchar(100) comment '����',
 anote text comment '����',
 awdate datetime default now() comment '�ۼ���',
 afname varchar(200) comment '÷������_������',
 apname varchar(200) comment '÷������_������',
 ahit int default 0 comment '��ȸ��',
 acategory varchar(2) comment '�Խ��Ǳ���',
 email varchar(100) comment '�̸���',
 foreign key(email) references user(email)
);
