<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
�ۼ���: 23.07.12.��, 23.07.13.��
�ۼ���: ������
1. �� �� �������� Ȯ�� 2. VO��ü�� �ޱ�
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%@include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");

UserVO user = new UserVO();
user.setEname(request.getParameter("ename"));
user.setKname(request.getParameter("kname"));
user.setBirth(request.getParameter("birth"));
user.setEmail(request.getParameter("email"));
user.setPw(request.getParameter("pw"));
user.setGender(request.getParameter("gender"));
user.setKorf(request.getParameter("korf"));
user.setNumber(request.getParameter("number"));
user.setAgreop(request.getParameter("agreop"));
user.setToken(request.getParameter("token"));

//���� ������ ���� ��, ȸ���������� ������
if(user.getEname() == null || user.getKname() == null || user.getBirth() == null || user.getEmail() == null || user.getEmail().equals("") ||user.getPw() == null || user.getNumber() == null || user.getAgreop() == null)
{
	response.sendRedirect("/hotel2/user/join.jsp");
	return;
}

DBManager db = new DBManager();
db.DBOpen();
String sql ="";
sql = "select email from user where email = '" + user.getEmail() + "' ";
db.RunSelect(sql);

UserDTO dto = new UserDTO();
if(dto.isduplicate(request.getParameter("email")) == true)
{
	//�ߺ��� �̸����� ����.
	%>
	<script>
		alert("�ߺ��� ���̵� [<%=user.getEmail()%>]�� �����մϴ�.");
		document.location = "join.jsp";
	</script>
	<%
}
else
{	
	//ȸ�������� �����Ѵ�.
	dto.join(user);
	
	//ȸ������ �ȳ� ���� �߼�
	String authURL = "http://192.168.0.72:8080/hotel2/user/auth.jsp?token=" + request.getParameter("token");      //ip�ּҰ� local ȣ��Ʈ �ȵ�!!! ���� ���̵��
	MailSender mail = new MailSender();
	mail.MailSend("ezenteam@naver.com", 
			request.getParameter("email"),
			"ezenteam","ezenezenezen1004",
			"ȸ������ ���� ����","<a href='" + authURL + "'>�����ϱ�</a>");
	
	%>
	<script>
		alert("���̵� [<%=user.getEmail()%>]�� ȸ��������  �Ϸ�Ǿ����ϴ�.");
		document.location = "login.jsp";
	</script>
	<%
}

%>

�ѱ� ����       : <%=user.getEname() %><br>
���� ����       : <%=user.getKname() %><br>
�������        : <%=user.getBirth() %><br>
���̵�           : <%=user.getEmail() %><br>
��й�ȣ        : <%=user.getPw() %><br>
����              : <%=user.getGender() %><br>
������/�ܱ���: <%=user.getKorf() %><br>
��ȭ��ȣ        : <%=user.getNumber() %><br>
������� ���� : <%=user.getAgreop() %><br>

	