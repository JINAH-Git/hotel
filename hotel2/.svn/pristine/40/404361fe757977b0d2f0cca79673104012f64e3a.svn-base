<!-- 
작성자: 장영재
작성일: 23.07.10 (월)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String acategory = "T";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>예약 1단계</title>		
		<link rel="stylesheet" type="text/css" href="../../style/resv.css" />
		<script src="../../js/option.js"></script>
	</head>	
<%@ include file="../../include/head.jsp" %>
<script>
	window.addEventListener('load',function(){
	  viewroom();
	});
</script>	
<section>
	<div class="main">
		<div class="stepWrap">
			<ul class="step">
				<li id="step1" style="background-color: brown; color: white;">1</li>&nbsp; &ndash; &nbsp;
				<li id="step2">2</li>&nbsp; &ndash; &nbsp;
				<li id="step3">3</li>
			</ul>
		</div>
		<!-- //.stepWrap -->
		<p>날짜, 인원 선택</p>
		<hr id="hr1">
		<form name="resvFrm" id="resvFrm" method="post" action="step2.jsp">
			<table id="resvtb">
				<tr>
					<th width="150px;">체크인</th>
					<th><img src="/hotel2/image/moon.png" width="12px" height="12px"></th>
					<th width="150px;">체크아웃</th>
					<th width="100px;">객실</th>
					<th width="100px;">성인</th>
					<th width="100px;">어린이<img src="/hotel2/image/bang.png" width="12px" height="12px" title="37개월 이상 ~ 만 12세 이하 (베트남 : 만 6세 이상 ∼ 만 11세까지)"></th>
					<th width="100px;">유아<img src="/hotel2/image/bang.png" width="12px" height="12px" title="36개월 이하 (베트남 : 만 5세 이하)"></th>
					<th width="130px;" rowspan="2"><input type="button" value="검색" id="searchBtn"></th>
				</tr>
				<%		
					String adcnt    = request.getParameter("adult");
					String chcnt    = request.getParameter("child");
					String kidcnt   = request.getParameter("kid");
					String checkin  = request.getParameter("checkin");
					String checkout = request.getParameter("checkout");
					String night = request.getParameter("night");
					
					if(adcnt == null) adcnt = "1";
					if(chcnt == null) chcnt = "0";
					if(kidcnt == null) kidcnt = "0";
					if(night == null) night = "1박";
				%>
				<tr>
					<td class="resvdate"><input type="text" value="<%= checkin %>" id="checkin" name="checkin" readonly></td>
					<td><input type="text" value="<%= night %>" id="night" name="night" readonly></td>
					<td class="resvdate"><input type="text" value="<%= checkout %>" id="checkout" name="checkout" readonly></td>
					<td>1</td>
					<td class="people"><input type="text" value="<%= adcnt %>" class="adult" readonly></td>
					<td class="people"><input type="text" value="<%= chcnt %>" class="child" readonly></td>
					<td class="people"><input type="text" value="<%= kidcnt %>" class="kid" readonly></td>
				</tr>
			</table>
			<!-- //#resvtb -->		
			<hr id="hr2">
			<div id="date">
				<%@ include file="../../include/calendar.jsp" %>
			</div>
			<!-- //#date -->
			<div id="option">
				<span class="room">객실</span>
				<span id="adult">
					성인 &nbsp; &nbsp; 
					<input type="button" value="-" onclick="count('aminus')">
					<input type="text" value="<%= adcnt %>" class="adult" name="adult" readonly"> 
					<input type="button" value="+" onclick="count('aplus')">
				</span>
				<!-- //.adult -->
				<span id="child">
					어린이 &nbsp; &nbsp; 
					<input type="button" value="-" onclick="count('cminus')"> 
					<input type="text" value="<%= chcnt %>" class="child" name="child" readonly">
					<input type="button" value="+" onclick="count('cplus')">
				</span>
				<!-- //.child -->
				<span id="kid">
					유아 &nbsp; &nbsp; 
					<input type="button" value="-" onclick="count('kminus')">
					<input type="text" value="<%= kidcnt %>" class="kid" name="kid" readonly">
					<input type="button" value="+" onclick="count('kplus')">
				</span>
				<!-- //.kid -->
				<hr>
				<p class="guide">
					※어린이 : 37개월 이상 ~ 만 12세 이하 (베트남 : 만 6세 이상 ∼ 만 11세까지)<br>
					※유아 : 36개월 이하 (베트남 : 만 5세 이하)
				</p>
			</div>
			<!-- //#option -->
			<script>
				btnclick();
			</script>
			<%
			RoomctrDTO dto = new RoomctrDTO();
		 	ArrayList<RoomctrVO> list = dto.list();
			for(int i = 0; i < list.size(); i++)
			{	
				String roomname = "";
		 		if(list.get(i).getRtype().equals("S"))  roomname = "Standard Room";
		 		if(list.get(i).getRtype().equals("D"))  roomname = "Double Room";
		 		if(list.get(i).getRtype().equals("F"))  roomname = "Family Room";
		 		if(list.get(i).getRtype().equals("ST")) roomname = "Suite Room";
		 		
		 		String roomimg = "";
		 		if(roomname == "Standard Room") roomimg = "standard.jpg";
		 		if(roomname == "Double Room")   roomimg = "double.jpg";
		 		if(roomname == "Family Room")   roomimg = "family.jpg";
		 		if(roomname == "Suite Room")    roomimg = "suite.jpg";		 		
				%>
				<div class="contents">
					<table>
						<tr>
							<td rowspan="3" width="400px;" class="roomImg" style="background-image: url('/hotel2/image/<%= roomimg %>'); background-repeat : no-repeat; background-size : cover;"></td>
							<td width="200px;"><%= roomname %></td>
							<td rowspan="3" width="200px;"><input type="button" value="예약하기" onclick="resv('<%= list.get(i).getRtype() %>')"></td>
						</tr>
						<tr>
							<td><%= i + 1 %>인용 객실</td>
						</tr>
						<tr>
							<td>성인 1인  : <%= list.get(i).getAdprice() %><br>어린이 1인 : <%= list.get(i).getChprice() %><br>유아 1인 : 0원</td>
						</tr>
					</table>
				</div>
				<!-- //.contents -->
				<%
			}
			%>
		</form>	
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
