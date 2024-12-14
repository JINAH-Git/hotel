<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
//번호값을 받아온다.
String ano = request.getParameter("ano");

UserVO login = (UserVO)session.getAttribute("login");

//사용자의 이메일값이 null이면 돌아간다.
if(login == null || ano == null)
{
	out.println("값이 없습니다.");
	return;
}

//해당 게시물 작성자가 아니면 종료한다.
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);


//게시물을 삭제한다.
dto.delete(ano);
%>