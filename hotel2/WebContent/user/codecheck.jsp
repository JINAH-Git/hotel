<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.email.*" %>
<%
String token = (String)session.getAttribute("token");

String ecode = request.getParameter("ecode");
if(ecode == null || ecode.equals(""))
{
	out.println("코드가 입력되지 않았습니다.");
	return;
}else if(ecode.equals(token))
{
	out.println("인증 완료되었습니다.");
	return;
}else
{
	out.println("입력한 코드가 올바르지 않습니다. 다시 입력하세요.");
	return;
}
%>