<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
//��ȣ�� ī�װ����� �޾ƿ´�.
String      bno = request.getParameter("bno");
System.out.println(bno);
String category = "I";

//�Խñ� ���� null�̸� ���ư���.
if(bno == null)
{
	out.println("FAIL");
	return;
}

BoardDTO dto = new BoardDTO();
BoardVO   vo = dto.read(bno,false);

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� �����Ѵ�.
if(login == null)
{
	out.println("FAIL");
	return;
}

if(login.getLevel().equals("A") || login.getEmail().equals(vo.getEmail()))
{
	//�Խù��� �����Ѵ�.
	dto.delete(bno);
	out.println("OK");
}else
{
	out.println("FAIL");
}


%>