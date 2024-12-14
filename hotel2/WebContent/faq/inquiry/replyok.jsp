<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");

//게시글의 번호와 댓글 값들을 받아온다
String bno     = request.getParameter("bno");
String rnote   = request.getParameter("rnote");
String rwriter = request.getParameter("rwriter");

UserVO login = (UserVO)session.getAttribute("login");

ReplyVO vo = new ReplyVO();
vo.setBno(Integer.parseInt(bno));
vo.setRwriter(login.getKname());
vo.setRnote(rnote);

ReplyDTO dto = new ReplyDTO();
dto.insert(vo);

response.sendRedirect("view.jsp?bno=" + vo.getBno() + "&rno=" + vo.getBno());
%>