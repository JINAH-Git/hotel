<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.email.*" %>    
<%
String email = request.getParameter("emailid");
if(email == null || email.equals(""))
{
	out.println("�̸����� �Է��ϼ���.");
	return;
}

out.println("�Է��Ͻ� �̸��Ϸ� �ڵ带 �߼��Ͽ����ϴ�. �ڵ带 �Է����ּ���.");
MailSender m = new MailSender();
String token = m.maketoken();
session.setAttribute("token", token);
m.MailSend("ezenteam@naver.com", 
	email,
	"ezenteam@naver.com","ezenezenezen1004",
	"��й�ȣ ã�� ���������� �ڵ带 �������ּ���.",token);
return;

%>