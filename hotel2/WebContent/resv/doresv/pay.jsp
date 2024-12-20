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
		alert("데이터가 없습니다.");
		location.href = "../../index.jsp";
	</script>
	<%
}else
{
	//이메일로 기존에 예약한 정보가 있는지 조회
	ReserVO resvinfo = dto.reademail(request.getParameter("email"));
	int resvno = resvinfo.getResvno();
	if(resvno != 0)
	{
		//기존에 예약한 정보가 있다면
		%>
		<script>
			alert("기존에 예약한 객실이 있습니다.");
			location.href = "../confirm.jsp?resvno=" + <%= resvno %>;
		</script>
		<%
	}else
	{
		//예약정보 등록
		dto.insert(vo);
		%>
		<script>
			alert("예약 완료되었습니다.");
			location.href = "../confirm.jsp?resvno=" + <%= vo.getResvno() %>;
		</script>
		<%	
	}
}
%>