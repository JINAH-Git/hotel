<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
//번호와 카테고리값을 받아온다.
String      bno = request.getParameter("bno");
System.out.println(bno);
String category = "I";

//게시글 값이 null이면 돌아간다.
if(bno == null)
{
	out.println("FAIL");
	return;
}

BoardDTO dto = new BoardDTO();
BoardVO   vo = dto.read(bno,false);

//해당 게시물 작성자가 아니면 종료한다.
if(login == null)
{
	out.println("FAIL");
	return;
}

if(login.getLevel().equals("A") || login.getEmail().equals(vo.getEmail()))
{
	//게시물을 삭제한다.
	dto.delete(bno);
	out.println("OK");
}else
{
	out.println("FAIL");
}


%>