<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.email.*" %>
<%
String email = request.getParameter("email");
if(email == null || email.equals(""))
{
	out.println("�̸����� �Է��ϼ���.");
	return;
}
UserDTO dto = new UserDTO();
if(dto.isduplicate(email) == true)
{
	out.println("�̹� ������ �̸����� �ֽ��ϴ�.");
	return;
}else
{
	out.println("�Է��Ͻ� �̸��Ϸ� �ڵ带 �߼��Ͽ����ϴ�. �ڵ带 �Է����ּ���.");
	MailSender m = new MailSender();
	String token = m.maketoken();
	session.setAttribute("token", token);	
	//������ȣ ��ȿ�ð� 
	session.setMaxInactiveInterval(60*5);
	m.MailSend("ezenteam@naver.com", 
			email,
			"ezenteam@naver.com","ezenezenezen1004",
			"ȸ������ ���������� �ڵ带 �������ּ���.","�����ڵ�� " +  token + " �Դϴ�.");
	return;
}
%>