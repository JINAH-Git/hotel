<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.*" %>  
<%@ include file="/include/head.jsp" %>  
<%
String token = request.getParameter("token");
if(token == null)
{
	out.println("���� ��ȣ�� �Էµ��� �ʾҽ��ϴ�.");		
	return;
}

DBManager db = new DBManager();
db.DBOpen();

String sql ="";
//�ش� ��ū�� ȸ������ �Ǿ��ִ��� �˻��Ѵ�.
//SQL : select id from user where id = 'test'
sql  = "select id,ismember from user ";
sql += "where token = '" + token + "' ";
db.RunSelect(sql);
if(db.Next() == true)
{
	//�ߺ��� ���̵� ������.
	String ismember = db.getValue("ismember");
	if(ismember.equals("Y"))
	{
		out.println("������ �Ϸ�� ��ū�Դϴ�.");
	}else
	{
		sql = "update user set ismember = 'Y' ";
		sql += "where token = '" + token + "' ";
		db.RunSQL(sql);
		out.println("ȸ�������� �Ϸ�Ǿ����ϴ�.");
	}
}else
{
	out.println("�߸� �Էµ� ���� ��ȣ�Դϴ�.");
}

db.DBClose(); 
%>