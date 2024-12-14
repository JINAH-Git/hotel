<%@ page language="java" contentType="text/xml; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
//데이터로 비밀번호(pw)가 들어오면 받음
String pw = request.getParameter("pw");
String pwcheck = request.getParameter("pwcheck");

//userID에 따른 
if(pwcheck == null || pwcheck.equals(""))
{
	%>
	<response>
		<code>01</code>
		<<msg>비밀번호확인을 입력하세요.</msg>
	</response>
	<%
	return;
}
if(!pwcheck.equals(pw))
{
	%>
	<response>
		<code>02</code>
		<msg>비밀번호가 일치하지 않습니다.</msg>
	</response>
	<%
}
else
{
	%>
	<response
		<code>03</code>
		<msg>비밀번호가 일치합니다.</msg>
	</response>
	<%
}

%>