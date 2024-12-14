<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
//번호값을 받아온다.
String ano = request.getParameter("ano");



//사용자의 이메일값이 null이면 돌아간다.
UserVO login = (UserVO)session.getAttribute("login");
if(login == null || ano == null)
{
	out.println("값이 없습니다.");
	return;
}

//해당 게시물 작성자가 아니면 종료한다.
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);

if( !login.getLevel().equals("A") )
{
	out.println("해당 게시물의 작성자가 아닙니다!");
	return;
}

//게시물을 삭제한다.
dto.delete(ano);
out.println("OK");
%>
