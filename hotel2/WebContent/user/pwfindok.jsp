<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
String birth = request.getParameter("birthtext");
String email = request.getParameter("emailid");
if(birth == null || birth.equals("") || email == null || email.equals("") )
{
	out.print("ERROR");
	return;
}

UserDTO dto = new UserDTO();
//1.�Է��� ���ϰ� id(�̸���)�� ������ �˻��Ѵ�
if(dto.pwcheck(birth, email) == true)
{
	//���� ��ġ
	out.println("true");
}else
{	
	//���� ����ġ
	out.println("false");
}

%>
