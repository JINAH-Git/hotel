<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
String birth = request.getParameter("birthtext");
String email = request.getParameter("emailid");
if(birth == null || birth.equals("") || email == null || email.equals("") )
{
	out.print("ERROR");
	return;
}

UserDTO dto = new UserDTO();
//1.입력한 생일과 id(이메일)이 같은지 검사한다
if(dto.pwcheck(birth, email) == true)
{
	//정보 일치
	out.println("true");
}else
{	
	//정보 불일치
	out.println("false");
}

%>
