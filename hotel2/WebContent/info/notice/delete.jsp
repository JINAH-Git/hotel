<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
//��ȣ���� �޾ƿ´�.
String ano = request.getParameter("ano");



//������� �̸��ϰ��� null�̸� ���ư���.
UserVO login = (UserVO)session.getAttribute("login");
if(login == null || ano == null)
{
	out.println("���� �����ϴ�.");
	return;
}

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� �����Ѵ�.
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);

if( !login.getLevel().equals("A") )
{
	out.println("�ش� �Խù��� �ۼ��ڰ� �ƴմϴ�!");
	return;
}

//�Խù��� �����Ѵ�.
dto.delete(ano);
out.println("OK");
%>
