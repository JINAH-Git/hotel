<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String pw = request.getParameter("pw");
String pwcheck = request.getParameter("pwcheck");

if(pw == null || pw.equals("") )
{
	out.print("1.�Էµ��� �ʾҽ��ϴ�.");
	return;
}
if(pwcheck == null || pwcheck.equals(""))
{
	out.print("2.�Էµ��� �ʾҽ��ϴ�.");
	return;
}

//�Է��� ��й�ȣ�� ������ �˻��Ѵ�...?
if(pw.equals(pwcheck))
{
	//��й�ȣ ��ġ
	out.println("true");
}else
{	
	//��й�ȣ ����ġ
	out.println("false");
}

%>