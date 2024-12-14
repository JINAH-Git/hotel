<!-- 
작성자: 장영재
작성일: 23.07.10 (월)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String checkin  = request.getParameter("checkin");
String checkout = request.getParameter("checkout");
String night    = request.getParameter("night");
String rtype    = request.getParameter("rtype");
String adcnt    = request.getParameter("adult");
String chcnt    = request.getParameter("child");
String kidcnt   = request.getParameter("kid");

if(adcnt == null || chcnt == null || kidcnt == null)
{
	%>
	<script>
		alert("입력한 데이터가 올바르지 않습니다.");
		location.href = "step1.jsp";
	</script>
	<%
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>예약 2단계</title>		
		<link rel="stylesheet" type="text/css" href="../../style/resv.css" />
	</head>

<%@ include file="../../include/head.jsp" %>
<%
if(login == null)
{	
	response.sendRedirect("../../user/login.jsp");
	return;
}

//이메일로 기존에 예약한 정보가 있는지 조회
ReserDTO dto = new ReserDTO();
ReserVO resvinfo = dto.reademail(login.getEmail());
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
}
%>
<section>
	<div class="main">
		<div class="stepWrap">
			<ul class="step">
				<li id="step1">1</li>&nbsp; &ndash; &nbsp;
				<li id="step2" style="background-color: brown; color: white;">2</li>&nbsp; &ndash; &nbsp;
				<li id="step3">3</li>
			</ul>
		</div>
		<!-- //.stepWrap -->
		<p>예약 정보</p>
		<div id="contents2" style="width: 1000px; margin: 0 auto;">
			<form action="step3.jsp" method="post">
				<input type="hidden" value=<%= checkin %> name="checkin">
				<input type="hidden" value=<%= checkout %> name="checkout">
				<input type="hidden" value=<%= night %> name="night">
				<input type="hidden" value=<%= rtype %> name="rtype">
				<input type="hidden" value=<%= adcnt %> name="adult">
				<input type="hidden" value=<%= chcnt %> name="child">
				<input type="hidden" value=<%= kidcnt %> name="kid">
				<table>
					<tr>
						<%
						String roomimg = "";
						if(rtype.equals("S"))  roomimg = "standard.jpg";
						if(rtype.equals("D"))  roomimg = "double.jpg";
						if(rtype.equals("F"))  roomimg = "family.jpg";
						if(rtype.equals("ST")) roomimg = "suite.jpg";
						%>
						<td rowspan="2"><img src="/hotel2/image/<%= roomimg %>" width="400px;" height="300px;"></td>
						<td>
							<div style="width: 600px; padding: 15px 20px;">
								- 객실 가격의 10%가 부가가치세로 부과됩니다.<br>
								- 체크인은 15:00, 체크아웃은 12:00시입니다.<br>
								- 노쇼(No-Show)시 숙박 요금은 환불이 불가합니다.<br>
								- 단체예약시 063 - 252 - 1234 연락처로 문의바랍니다.	<br>
								- 미성년자의 경우, 성인 보호자 동반에 한하여 체크인 및 투숙이 가능합니다.<br>
								- 기후변화 또는 천재지변 등의 불가항력적 상황으로 호텔의 정상적 영업이 불가한 경우, 
								호텔의 고지 (휴대전화 문자, 홈페이지 게재 등)에 의하여 예약이 취소되거나 호텔 업장 이용이 제한될 수 있습니다.<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="width: 600px; padding: 15px 20px;">
								<b>Requests</b> <br>
								<textarea placeholder="호텔 이용시 문의하실 사항이 있으시면 입력해 주세요." name="req" style="width: 600px; height: 70px; outline: none; resize: none; font-size: 16px;"></textarea>
							</div>
						</td>
					</tr>
				</table>
				<table style="margin-top: 70px;">
					<tr>
						<td>
							<div style="width: 1000px; padding: 15px 20px; text-align: center; font-size: 24px; font-weight: bold;">
								※ 유의사항, 취소 및 환불 규정을 모두 확인해주세요.
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="width: 1000px; padding: 15px 20px; text-align: center; font-size: 24px; font-weight: bold;">
								<input type="submit" value="확인" style="background: #DFDFE3; padding: 5px 10px; font-size: 24px; border-radius: 5%; border: 1px solid #DFDFE3; cursor: pointer;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- //#contents2 -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
