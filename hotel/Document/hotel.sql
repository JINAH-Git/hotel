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
    phone varchar(30) comment '��ȭ��ȣ',
    birth varchar(20) comment '�������',
    level varchar(2) default 'U' comment '���',
    agreop varchar(2) comment '������ǿ���',
    pwfcnt varchar(1) comment '��й�ȣƲ��Ƚ��'
);

create table roompricectrl
(
  rtype varchar(20) primary key comment '����Ÿ��',
  adprice varchar(20) comment '���ΰ���',
  chprice varchar(20) comment '��̰���'
);


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

create table board
(
  bno integer primary key comment '�Խñ� ��ȣ',
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
  lookop varchar(2) default 'N' comment '��бۿ���',
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
 afname varchar(200) comment '÷������_������',
 apname varchar(200) comment '÷������_������',
 ahit int default 0 comment '��ȸ��',
 acategory varchar(2) comment '�Խ��Ǳ���'
);
