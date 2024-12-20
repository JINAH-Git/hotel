<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
작성일: 23.07.12.수, 23.07.13.목
작성자: 김진아
1. 값 잘 찍히는지 확인 2. VO객체로 받기
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%@include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

UserVO user = new UserVO();
user.setEname(request.getParameter("ename"));
user.setKname(request.getParameter("kname"));
user.setBirth(request.getParameter("birth"));
user.setEmail(request.getParameter("email"));
user.setPw(request.getParameter("pw"));
user.setGender(request.getParameter("gender"));
user.setKorf(request.getParameter("korf"));
user.setNumber(request.getParameter("number"));
user.setAgreop(request.getParameter("agreop"));
user.setToken(request.getParameter("token"));

//값이 들어오지 않을 때, 회원가입으로 보내기
if(user.getEname() == null || user.getKname() == null || user.getBirth() == null || user.getEmail() == null || user.getEmail().equals("") ||user.getPw() == null || user.getNumber() == null || user.getAgreop() == null)
{
	response.sendRedirect("/hotel2/user/join.jsp");
	return;
}

DBManager db = new DBManager();
db.DBOpen();
String sql ="";
sql = "select email from user where email = '" + user.getEmail() + "' ";
db.RunSelect(sql);

UserDTO dto = new UserDTO();
if(dto.isduplicate(request.getParameter("email")) == true)
{
	//중복된 이메일이 있음.
	%>
	<script>
		alert("중복된 아이디 [<%=user.getEmail()%>]가 존재합니다.");
		document.location = "join.jsp";
	</script>
	<%
}
else
{	
	//회원가입을 진행한다.
	dto.join(user);
	
	//회원가입 안내 메일 발송
	String authURL = "http://192.168.0.72:8080/hotel2/user/auth.jsp?token=" + request.getParameter("token");      //ip주소가 local 호스트 안됨!!! 서버 아이디로
	MailSender mail = new MailSender();
	mail.MailSend("ezenteam@naver.com", 
			request.getParameter("email"),
			"ezenteam","ezenezenezen1004",
			"회원가입 인증 메일","<a href='" + authURL + "'>인증하기</a>");
	
	%>
	<script>
		alert("아이디 [<%=user.getEmail()%>]로 회원가입이  완료되었습니다.");
		document.location = "login.jsp";
	</script>
	<%
}

%>

한글 성명       : <%=user.getEname() %><br>
영문 성명       : <%=user.getKname() %><br>
생년월일        : <%=user.getBirth() %><br>
아이디           : <%=user.getEmail() %><br>
비밀번호        : <%=user.getPw() %><br>
성별              : <%=user.getGender() %><br>
내국인/외국인: <%=user.getKorf() %><br>
전화번호        : <%=user.getNumber() %><br>
약관동의 여부 : <%=user.getAgreop() %><br>

	
