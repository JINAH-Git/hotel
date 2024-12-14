<!-- 
23-07-10 성재 | jsp 작성함.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("euc-kr");

AdminVO vo = new AdminVO();
vo.setAtitle(request.getParameter("atitle"));
vo.setAcategory(request.getParameter("acategory"));
vo.setAnote(request.getParameter("anote"));
vo.setAno(Integer.parseInt(request.getParameter("ano")));

AdminDTO dto = new AdminDTO();
dto.modifyq(vo);

response.sendRedirect("index.jsp");
%>