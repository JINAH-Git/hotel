<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
request.setCharacterEncoding("euc-kr");
UserVO login = (UserVO)session.getAttribute("login");

String ename = request.getParameter("ename");
String kname = request.getParameter("kname");
String pw = request.getParameter("pw");
String number = request.getParameter("numbertext");

if(ename == null || ename.equals(""))
{
	ename = login.getEname();
}
if(kname == null || kname.equals(""))
{
	kname = login.getKname();
}
if(number == null || number.equals(""))
{
	number = login.getNumber();
}

UserDTO dto = new UserDTO();
UserVO vo = new UserVO();
vo.setEname(ename);
vo.setKname(kname);
vo.setNumber(number);

vo.setEmail(login.getEmail());
dto.modify(vo);

UserVO user = dto.read(login.getEmail());
session.setAttribute("login",user);
// ���� �����ð� 1�ð� 
session.setMaxInactiveInterval(60*60) ;
%>
<script>
	window.onload = function()
	{
		alert("ȸ������ ������ �Ϸ�Ǿ����ϴ�.");
		document.location = "/hotel2/user/userinfochange.jsp";
	}
</script>