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
	alert("�ڵ尡 �Էµ��� �ʾҽ��ϴ�.");
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
	alert("�Է��� �ڵ尡 �ùٸ��� �ʽ��ϴ�. �ٽ� �Է��ϼ���.");
	window.location.href="pwfind.jsp";
	</script>
	<%
	return;
}
%>