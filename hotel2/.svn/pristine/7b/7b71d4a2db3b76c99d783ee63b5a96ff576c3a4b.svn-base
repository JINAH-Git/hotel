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
	out.println("이메일을 입력하세요.");
	return;
}

out.println("입력하신 이메일로 코드를 발송하였습니다. 코드를 입력해주세요.");
MailSender m = new MailSender();
String token = m.maketoken();
session.setAttribute("token", token);
m.MailSend("ezenteam@naver.com", 
	email,
	"ezenteam@naver.com","ezenezenezen1004",
	"비밀번호 찾기 페이지에서 코드를 인증해주세요.",token);
return;

%>