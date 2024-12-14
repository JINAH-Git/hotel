<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
//select 박스의 옵션과 검색창에 입력된 값을 받아온다.
String option = request.getParameter("items");
String search = request.getParameter("search"); //검색값

//select 박스의 옵션에 따라 db에 들어가있는 내용으로 바꿔준다.
if(option.equals("E"))
{
	option = "email";
}else if(option.equals("N"))
{
	option = "ename";
}else if(option.equals("B"))
{
	option = "birth";
}else if(option.equals("P"))
{
	option = "number";
}

response.sendRedirect("index.jsp?option=" + option + "&search=" + search);
%>