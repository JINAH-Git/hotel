<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

//��ȣ���� �޾ƿ´�.
String bno = request.getParameter("bno");

//������� �̸��ϰ��� null�̸� ���ư���.
if(login == null || bno == null)
{
	out.println("���� �����ϴ�.");
	return;
}

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� �����Ѵ�.
BoardDTO dto = new BoardDTO();
BoardVO   vo = dto.read(bno,false);

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
