<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String token = (String)session.getAttribute("token");
String email = request.getParameter("emailid");

String ecode = request.getParameter("ecode");
if(ecode == null || ecode.equals(""))
{
	%>
	<script>
	alert("코드가 입력되지 않았습니다.");
	window.location.href="pwfind.jsp";
	</script><%
	return;
}else if(ecode.equals(token))
{
	response.sendRedirect("pwchange.jsp?emailid=" + email);
	return;
}else
{
	%>
	<script>
	alert("입력한 코드가 올바르지 않습니다. 다시 입력하세요.");
	window.location.href="pwfind.jsp";
	</script>
	<%
	return;
}
%>