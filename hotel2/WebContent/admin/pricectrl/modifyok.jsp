<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
//session�� �ִ� ���� �޾ƿ���
//UserVO login = (UserVO)session.getAttribute("login");
/*
if(login_email == null || login_level != "A")
{
	%>
	<script>
		alert("���� ������ �����ϴ�. ������ �������� �α����Ͻñ� �ٶ��ϴ�");
		document.location = "../../index.jsp";
	</script>
	<%
	return;
}
*/

RoomctrVO vo = new RoomctrVO();
RoomctrDTO dto = new RoomctrDTO();

//���Ĵٵ�� ���� ������Ʈ
vo.setRtype("S");
vo.setAdprice(request.getParameter("stdadpri"));
vo.setChprice(request.getParameter("stdchpri"));
dto.pricemodify(vo);

//����� ���� ������Ʈ
vo.setRtype("D");
vo.setAdprice(request.getParameter("dbadpri"));
vo.setChprice(request.getParameter("dbchpri"));
dto.pricemodify(vo);

//�йи��� ���� ������Ʈ
vo.setRtype("F");
vo.setAdprice(request.getParameter("famadpri"));
vo.setChprice(request.getParameter("famchpri"));
dto.pricemodify(vo);

//����Ʈ�� ���� ������Ʈ
vo.setRtype("ST");
vo.setAdprice(request.getParameter("suitadpri"));
vo.setChprice(request.getParameter("suitchpri"));
dto.pricemodify(vo);

response.sendRedirect("index.jsp");
%>