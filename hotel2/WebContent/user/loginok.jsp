<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
String useremail = request.getParameter("useremail");
String userpw = request.getParameter("userpw");

if(useremail == null || userpw == null)
{
	response.sendRedirect("login.jsp");
	return;
}

UserDTO dto = new UserDTO();
if(dto.login(useremail,userpw) == "false")
{
	//로그인 실패
	%>
	<script>
		alert("아이디 또는 비빌번호가 일치하지않습니다.");
		document.location = "login.jsp";
	</script>
	<% 
}else if(dto.login(useremail,userpw) == "true")
{
	//로그인 성공
	//로그인 사용자 정보를 읽는다.
	UserVO user = dto.read(useremail);
	
	session.setAttribute("login",user);
	// 세션 유지시간 1시간 
	session.setMaxInactiveInterval(60*60) ;
	
	response.sendRedirect("../index.jsp"); 
}else if(dto.login(useremail,userpw) == "fail")
{
	//로그인 실패
	%>
	<script>
		alert("비밀번호 5회 이상 불일치로 비밀번호 찾기를 진행하여야합니다.");
		document.location = "pwfind.jsp";
	</script>
	<% 
}
%>
