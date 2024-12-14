<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String pw = request.getParameter("pw");
String pwcheck = request.getParameter("pwcheck");

if(pw == null || pw.equals("") )
{
	out.print("1.입력되지 않았습니다.");
	return;
}
if(pwcheck == null || pwcheck.equals(""))
{
	out.print("2.입력되지 않았습니다.");
	return;
}

//입력한 비밀번호가 같은지 검사한다...?
if(pw.equals(pwcheck))
{
	//비밀번호 일치
	out.println("true");
}else
{	
	//비밀번호 불일치
	out.println("false");
}

%>