<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

String ano = request.getParameter("ano");
System.out.println(ano);
String category = "E";

//게시글 값이 null이면 돌아간다.
if(ano == null)
{
	out.println("FAIL");
	return;
}
AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);

//해당 게시물 작성자가 아니면 종료한다.
if(login == null)
{
	out.println("FAIL");
	return;
}

if(login.getLevel().equals("A") || login.getEmail().equals(vo.getEmail()))
{
	//게시물을 삭제한다.
	dto.delete(ano);
	out.println("OK");
}else
{
	out.println("FAIL");
}


%>