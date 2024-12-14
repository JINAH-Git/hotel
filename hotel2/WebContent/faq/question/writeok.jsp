<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");



//AdminVO에 제목, 카테고리, 내용 값을 넣어준다
AdminVO vo = new AdminVO();
vo.setAtitle(request.getParameter("atitle"));
vo.setAcategory(request.getParameter("acategory"));
vo.setAnote(request.getParameter("anote"));
System.out.println("anote");
UserVO login = (UserVO)session.getAttribute("login");

//작성자 ID를 설정한다.
vo.setName(login.getKname());
vo.setEmail(login.getEmail());


AdminDTO dto = new AdminDTO();
dto.insert(vo);


response.sendRedirect("index.jsp");
%>