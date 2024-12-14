<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%
//session에 있는 정보 받아오기
//UserVO login = (UserVO)session.getAttribute("login");
/*
if(login_email == null || login_level != "A")
{
	%>
	<script>
		alert("관리 권한이 없습니다. 관리자 계정으로 로그인하시기 바랍니다");
		document.location = "../../index.jsp";
	</script>
	<%
	return;
}
*/

RoomctrVO vo = new RoomctrVO();
RoomctrDTO dto = new RoomctrDTO();

//스탠다드룸 가격 업데이트
vo.setRtype("S");
vo.setAdprice(request.getParameter("stdadpri"));
vo.setChprice(request.getParameter("stdchpri"));
dto.pricemodify(vo);

//더블룸 가격 업데이트
vo.setRtype("D");
vo.setAdprice(request.getParameter("dbadpri"));
vo.setChprice(request.getParameter("dbchpri"));
dto.pricemodify(vo);

//패밀리룸 가격 업데이트
vo.setRtype("F");
vo.setAdprice(request.getParameter("famadpri"));
vo.setChprice(request.getParameter("famchpri"));
dto.pricemodify(vo);

//스위트룸 가격 업데이트
vo.setRtype("ST");
vo.setAdprice(request.getParameter("suitadpri"));
vo.setChprice(request.getParameter("suitchpri"));
dto.pricemodify(vo);

response.sendRedirect("index.jsp");
%>