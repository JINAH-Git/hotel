<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.*" %>  
<%@ include file="/include/head.jsp" %>  
<%
String token = request.getParameter("token");
if(token == null)
{
	out.println("인증 번호가 입력되지 않았습니다.");		
	return;
}

DBManager db = new DBManager();
db.DBOpen();

String sql ="";
//해당 토큰에 회원가입 되어있는지 검사한다.
//SQL : select id from user where id = 'test'
sql  = "select id,ismember from user ";
sql += "where token = '" + token + "' ";
db.RunSelect(sql);
if(db.Next() == true)
{
	//중복된 아이디가 존재함.
	String ismember = db.getValue("ismember");
	if(ismember.equals("Y"))
	{
		out.println("가입이 완료된 토큰입니다.");
	}else
	{
		sql = "update user set ismember = 'Y' ";
		sql += "where token = '" + token + "' ";
		db.RunSQL(sql);
		out.println("회원가입이 완료되었습니다.");
	}
}else
{
	out.println("잘못 입력된 인증 번호입니다.");
}

db.DBClose(); 
%>