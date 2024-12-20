<!-- 
작성자: 장영재
작성일: 23.07.10 (월)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");

String checkin  = request.getParameter("checkin");
String checkout = request.getParameter("checkout");
String night    = request.getParameter("night");
String rtype    = request.getParameter("rtype");
String adcnt    = request.getParameter("adult");
String chcnt    = request.getParameter("child");
String kidcnt   = request.getParameter("kid");
String req      = request.getParameter("req");
if(checkin == null || checkout == null || night == null || adcnt == null || chcnt == null || kidcnt == null || req == null)
{
	response.sendRedirect("../../index.jsp");
	return;
}

req = req.replace("<","&lt;");
req = req.replace(">","&gt;");
req = req.replace("\n","\n<br>");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>예약 3단계</title>		
		<link rel="stylesheet" type="text/css" href="../../style/resv.css" />
	</head>
	<script src="../../js/jquery-3.7.0.js"></script>
<%@ include file="../../include/head.jsp" %>
<%
if(login == null)
{
	response.sendRedirect("../../user/login.jsp");
	return;
}
%>
<script>
	window.addEventListener('load',function()
	{
		$("#payBtn").click(function(){
			$("#payFrm").submit();
		})
	});
</script>
<section>
	<div class="main">
		<div class="stepWrap">
			<ul class="step">
				<li id="step1">1</li>&nbsp; &ndash; &nbsp;
				<li id="step2">2</li>&nbsp; &ndash; &nbsp;
				<li id="step3" style="background-color: brown; color: white;">3</li>
			</ul>
		</div>
		<!-- //.stepWrap -->
		<p>결제 정보</p>		
		<div id="contents3" style="width: 1200px; height: 800px; margin: 0 auto; position: relative;">
			<form name="payFrm" id="payFrm" method="post" action="pay.jsp">
				<input type="hidden" value="<%= checkin %>" name="checkin">
				<input type="hidden" value="<%= checkout %>" name="checkout">
				<input type="hidden" value="<%= night %>" name="night">
				<input type="hidden" value="<%= rtype %>" name="rtype">
				<input type="hidden" value="<%= adcnt %>" name="adult">
				<input type="hidden" value="<%= chcnt %>" name="child">
				<input type="hidden" value="<%= kidcnt %>" name="kid">
				<input type="hidden" value="<%= req %>" name="req">
				<input type="hidden" value=<%= login.getEmail() %> name="email">
				<table border="1" id="userinfo" class="userinfo">
					<tr>
						<td style="background-color:#F5F5F7"><b>예약자 정보</b></td>
					</tr>
					<tr>
						<td>
						<%
						if(login.getGender().equals("M"))
						{
							%>
							남자
							<%
						}else
						{
							%>
							여자
							<%
						}
						%>
						</td>
					</tr>
					<tr>
						<td><%= login.getKname() %></td>
					</tr>
					<tr>
						<td><%= login.getEname() %></td>
					</tr>
					<tr>
						<td><%= login.getEmail() %></td>
					</tr>
					<tr>
						<td>
						<%
						if(login.getKorf().equals("K"))
						{
							%>
							내국인
							<%
						}else
						{
							%>
							외국인
							<%
						}
						%>
						</td>
					</tr>
					<tr>
						<td><%= login.getNumber() %></td>
					</tr>
				</table>
				<table border="1" id="payinfo" class="payinfo">
					<%
					ReserDTO dto = new ReserDTO();
					ReserVO vo = new ReserVO();
					vo.setAdcnt(adcnt);
					vo.setChcnt(chcnt);
					String price = dto.gettotalprice(rtype,vo,night);
					RoomctrDTO dto2 = new RoomctrDTO();
					price = dto2.comma(price);
					%>
					<tr>
						<td style="font-weight: bold; background-color:#F5F5F7">객실 가격</td>
					</tr>
					<tr>
						<td><%= price %> KRW</td>
					</tr>
					<tr>
						<td style="font-weight: bold; background-color:#F5F5F7">투숙 인원</td>
					</tr>
					<tr>
						<td>성인 <%= adcnt %>명,어린이 <%= chcnt %>명,유아 <%= kidcnt %>명</td>
					</tr>
					<tr>
						<td style="font-weight: bold; background-color:#F5F5F7">체크인 날짜 - 체크아웃 날짜</td>
					</tr>
					<tr>
						<td><%= checkin %> - <%= checkout %>(<%= night %>)</td>
					</tr>
					<tr>
						<td style="font-weight: bold; background-color:#F5F5F7">총 예약 금액(세금 10% VAT 포함)</td>
					</tr>
					<tr>
						<td>
						<%
						//세금 10%붙은 총 결제 가격 계산
						double tprice = 1.1 * Double.parseDouble(dto._D(price));
						String totalprice = Integer.toString((int)tprice); 
						totalprice = dto2.comma(totalprice);
						%>
						<%= totalprice %> KRW
						</td>
					</tr>
					<tr>
						<td style="font-weight: bold; background-color:#F5F5F7">요청 사항</td>
					</tr>
					<tr>
						<td style="height: 50px;">
						<%
						if(!req.equals(""))
						{
							%>
							<%= req %>
							<%
						}
						%>
						</td>
					</tr>
				</table>
				<div style="width:1200px; text-align: center; position: absolute; bottom: 190px;">
					<input type="button" id="payBtn" name="payBtn" value="결제하기">
				</div>
				<input type="hidden" value=<%= totalprice %> name="totalprice">
			</form>
		</div>
		<!-- //#contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
