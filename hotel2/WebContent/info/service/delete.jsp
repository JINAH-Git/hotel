<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
//게시글의 번호를 받아온다.
String ano = request.getParameter("ano");

//사용자의 이메일값이 null이면 돌아간다.
UserVO login = (UserVO)session.getAttribute("login");
if(login == null || ano == null)
{
	response.sendRedirect("../../user/login.jsp");
	return;
}

//해당 게시물 작성자가 아니면 종료한다.
AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);
if(!login.getLevel().equals("A"))
{
	%>
	<script>
		alert("삭제할 권리가 없습니다.");
	</script>
	<%
	return;
}else
{
	dto.delete(ano);
	response.sendRedirect("index.jsp?acategory=F");	
}
%>