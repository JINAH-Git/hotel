<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
//�Խñ��� ��ȣ�� �޾ƿ´�.
String ano = request.getParameter("ano");

//������� �̸��ϰ��� null�̸� ���ư���.
UserVO login = (UserVO)session.getAttribute("login");
if(login == null || ano == null)
{
	response.sendRedirect("../../user/login.jsp");
	return;
}

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� �����Ѵ�.
AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);
if(!login.getLevel().equals("A"))
{
	%>
	<script>
		alert("������ �Ǹ��� �����ϴ�.");
	</script>
	<%
	return;
}else
{
	dto.delete(ano);
	response.sendRedirect("index.jsp?acategory=F");	
}
%>