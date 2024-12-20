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
	out.println("이메일을 입력하세요.");
	return;
}
UserDTO dto = new UserDTO();
if(dto.isduplicate(email) == true)
{
	out.println("이미 가입한 이메일이 있습니다.");
	return;
}else
{
	out.println("입력하신 이메일로 코드를 발송하였습니다. 코드를 입력해주세요.");
	MailSender m = new MailSender();
	String token = m.maketoken();
	session.setAttribute("token", token);	
	//인증번호 유효시간 
	session.setMaxInactiveInterval(60*5);
	m.MailSend("ezenteam@naver.com", 
			email,
			"ezenteam@naver.com","ezenezenezen1004",
			"회원가입 페이지에서 코드를 인증해주세요.","인증코드는 " +  token + " 입니다.");
	return;
}
%>