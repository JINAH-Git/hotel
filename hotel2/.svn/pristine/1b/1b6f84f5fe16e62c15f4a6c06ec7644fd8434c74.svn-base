<!-- 
작성자: 장영재
작성일: 23.07.10 (월)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>예약확인</title>		
		<link rel="stylesheet" type="text/css" href="../style/resv.css" />
	</head>
<%@ include file="../include/head.jsp" %>
<%
ReserDTO dto = new ReserDTO();
ReserVO vo = null;
String roomimg = "standard.jpg"; //스탠다드룸으로 초기화
//로그인 상태에서 예약확인 하는 경우
if(login != null)
{	
	vo = dto.reademail(login.getEmail());
	if(vo.getResvno() == 0)
	{
		%>
		<script>
			alert("예약정보가 없습니다.");
			location.href = "./../index.jsp";
		</script>
		<%
		return;
	}
	if(vo.getRtype().equals("D"))  roomimg  = "double.jpg";
	if(vo.getRtype().equals("F"))  roomimg  = "family.jpg";
	if(vo.getRtype().equals("ST")) roomimg = "suite.jpg";
}
else //비로그인 상태에서 예약 확인하는 경우
{	
	String resvno = request.getParameter("resvno");
	if(resvno == null)
	{
		response.sendRedirect("findresv.jsp");
		return;
	}
	vo = dto.readresvno(Integer.parseInt(resvno));
	if(vo.getResvno() == 0)
	{
		%>
		<script>
			alert("조회하신 예약번호의 예약정보가 없습니다.");
			location.href = "findresv.jsp";
		</script>
		<%
		return;
	}
	if(vo.getRtype().equals("D"))  roomimg  = "double.jpg";
	if(vo.getRtype().equals("F"))  roomimg  = "family.jpg";
	if(vo.getRtype().equals("ST")) roomimg = "suite.jpg";
}
%>
<script>
	window.addEventListener('load',function()
	{
		//돌아가기 버튼 클릭하면 메인으로 이동한다.
		$("#return").click(function(){
			location.href = "../index.jsp";
		})
		
	});
	
	function cancel(resvno)
	{
		if(!confirm("예약을 취소하시겠습니까?") == false)
		{
			location.href = "delete.jsp?resvno=" + resvno;			
		}
	}
</script>
<section>
	<div class="main">
		<p>예약 확인</p>
		<table style="position: relative;">
			<tr>
				<td rowspan="2"><img src="/hotel2/image/<%= roomimg %>" width="500px;" height="320px;"></td>
				<td>
					<div style="width: 600px; padding: 15px 20px;">
						<table border="1" style="width: 400px; height: 500px; text-align: center; position: absolute; border-collapse:collapse;
						border-colo:#66575A;border-left:none;border-right:none;border-width:2px 0px 2px 0px; top: 0; right: 0">
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">예약 번호</td>
							</tr>
							<tr>
								<td><%= vo.getResvno() %></td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">투숙 인원</td>
							</tr>
							<tr>
								<td>성인 <%= vo.getAdcnt() %>명,어린이 <%= vo.getChcnt() %>명,유아 <%= vo.getKidcnt() %>명</td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">체크인 날짜 - 체크아웃 날짜</td>
							</tr>
							<tr>
								<td><%= vo.getCheckindate() %> - <%= vo.getCheckoutdate() %></td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">총 예약 금액(세금 10% VAT 포함)</td>
							</tr>
							<tr>
								<td><%= vo.getTotalprice() %> KRW</td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">요청 사항</td>
							</tr>
							<tr>
								<td style="height: 50px;"><%= vo.getRequest() %></td>
							</tr>
						</table>	
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div style="position: absolute; top: 330px; left: 0">
						- 객실 가격의 10%가 부가가치세로 부과됩니다.<br>
						- 체크인은 15:00, 체크아웃은 12:00시입니다.<br>
						- 노쇼(No-Show)시 숙박 요금은 환불이 불가합니다.<br>
						- 미성년자의 경우, 성인 보호자 동반에 한하여 체크인 및 투숙이 가능합니다.<br>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div style="position: absolute; top: 460px; left: 0;">
						<%
						if(login != null)
						{
							%>
							<input type="button" class="cnclbtn" value="예약취소" onclick="cancel(<%= vo.getResvno() %>)" >
							<%
						}
						%>
						<input type="button" class="rtnbtn" value="돌아가기" id="return">
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- //.main -->
</section>
<%@ include file="../include/tail.jsp" %>
