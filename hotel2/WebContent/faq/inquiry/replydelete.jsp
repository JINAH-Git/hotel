<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
//댓글의 번호값을 받아온다.
String rno = request.getParameter("rno");
if(rno == null)
{
	out.println("댓글 삭제 오류입니다.");
}

//사용자의 계정값을 받아온다
UserVO login = (UserVO)session.getAttribute("login");

if(login == null)
{
	out.println("로그인 값이 없습니다.");
	return;
}

ReplyDTO dto = new ReplyDTO();
ReplyVO   vo = dto.read(rno);

if(!login.getLevel().equals("A"))
{
	out.println("권한이 없습니다.");
	return;
}

dto.delete(rno);
%>