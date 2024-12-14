<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %>
<%
request.setCharacterEncoding("euc-kr");

ReserDTO dto = new ReserDTO();
ReserVO vo = new ReserVO();
vo.setTotalprice(request.getParameter("totalprice"));
vo.setCheckindate(request.getParameter("checkin"));
vo.setCheckoutdate(request.getParameter("checkout"));
vo.setRequest((request.getParameter("req")));
if((request.getParameter("req")) == null)
{
	vo.setRequest("");
}
vo.setAdcnt(request.getParameter("adult"));
vo.setChcnt(request.getParameter("child"));
vo.setKidcnt(request.getParameter("kid"));
vo.setEmail(request.getParameter("email"));
vo.setRtype(request.getParameter("rtype"));

if(request.getParameter("totalprice") == null || request.getParameter("checkin") == null || request.getParameter("adult") == null || request.getParameter("rtype") == null)
{
	%>
	<script>
		alert("�����Ͱ� �����ϴ�.");
		location.href = "../../index.jsp";
	</script>
	<%
}else
{
	//�̸��Ϸ� ������ ������ ������ �ִ��� ��ȸ
	ReserVO resvinfo = dto.reademail(request.getParameter("email"));
	int resvno = resvinfo.getResvno();
	if(resvno != 0)
	{
		//������ ������ ������ �ִٸ�
		%>
		<script>
			alert("������ ������ ������ �ֽ��ϴ�.");
			location.href = "../confirm.jsp?resvno=" + <%= resvno %>;
		</script>
		<%
	}else
	{
		//�������� ���
		dto.insert(vo);
		%>
		<script>
			alert("���� �Ϸ�Ǿ����ϴ�.");
			location.href = "../confirm.jsp?resvno=" + <%= vo.getResvno() %>;
		</script>
		<%	
	}
}
%>