<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
String newpw = request.getParameter("pw");
String emailid = request.getParameter("emailid");

UserDTO dto = new UserDTO();

UserVO vo = new UserVO();
vo.setEmail(emailid);
vo.setPw(newpw);
dto.pwchange(vo);
dto.pwfreset(emailid);

session.setAttribute("login", null);

out.println("비밀번호가 변경되었습니다. 로그인 페이지로 이동합니다.");

%>