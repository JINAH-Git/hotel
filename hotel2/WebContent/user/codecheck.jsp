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
	out.println("�ڵ尡 �Էµ��� �ʾҽ��ϴ�.");
	return;
}else if(ecode.equals(token))
{
	out.println("���� �Ϸ�Ǿ����ϴ�.");
	return;
}else
{
	out.println("�Է��� �ڵ尡 �ùٸ��� �ʽ��ϴ�. �ٽ� �Է��ϼ���.");
	return;
}
%>