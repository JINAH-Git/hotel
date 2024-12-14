<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
String resvno = request.getParameter("resvno");
if(resvno == null)
{
	response.sendRedirect("./../user/login.jsp");
}else
{
	ReserDTO dto = new ReserDTO();
	dto.cancel(Integer.parseInt(resvno));
	%>
	<script>
		alert("예약이 취소되었습니다.");
		location.href = "./../index.jsp";
	</script>
	<%
}
%>
