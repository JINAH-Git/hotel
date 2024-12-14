<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>    
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
request.setCharacterEncoding("euc-kr");

String adcnt  = request.getParameter("adult");
String chcnt  = request.getParameter("child");
String kidcnt = request.getParameter("kid");
String checkin = request.getParameter("checkin");
String checkout = request.getParameter("checkout");
String night = request.getParameter("night");

if(adcnt == null) adcnt = "1";
if(chcnt == null) chcnt = "0";
if(kidcnt == null) kidcnt = "0";
if(checkin == null) checkin = "0";
if(checkout == null) checkout = "0";
if(night == null) night = "1박";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>		
		<link rel="stylesheet" type="text/css" href="style/main.css" />
		<link rel="stylesheet" type="text/css" href="style/resv.css" />
		<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
		<link type="text/css" rel="stylesheet" href="style/materialize.css"  media="screen,projection"/>
		<script src="./js/option.js"></script>
		<script src="./js/jquery-3.7.0.js"></script>
	</head>
	<style>
		#resvtb th
		{
			text-align: center;
		}
	
		/* 예약 클릭시 날짜 뜨는 위치 조정 */
		#date
		{
			width: 1000px;
			height: 485px;
			padding: 15px 0;
			position: absolute;
			top: -470px;
			left: 0;
			background-color: #fff;
			z-index: 10;
		}
		
		/* 예약 클릭시 옵션 뜨는 위치 조정 */
		#option
		{
			width: 880px;
			height: 130px;
			padding: 15px 0;
			position: absolute;
			top: -160px;
			left: 0;
			background-color: #fff;
			z-index: 10;
		}
	</style>
<%@ include file="include/head.jsp" %>
<script>
	<!-- 이미지 슬라이드 -->
	$(document).ready(function(){
		$('.slider').slider();
	});
	/* 이미지 자동 슬라이드  해당 기능은 jquery로 구현하는게 간편할듯*/
</script>
<section style="height:650px">
	<!-- 이미지 슬라이드 소스 코드 -->
	<div class="slider" style="height: 650px;">
		<ul class="slides">
			<li>
				<img src="image/mainimg1.jpg">
				<div class="caption center-align">
					<h3 class="htitle">Rewards Signature Edition</h3>
					<h5 class="light grey-text text-lighten-3">Alegria에서 기분 좋은 하루를 시작해보세요.</h5>
				</div>
			</li>
			<li>
				<img src="image/mainimg2.jpg">
				<div class="caption left-align">
					<h3 class="htitle">Suite Room</h3>
					<h5 class="light grey-text text-lighten-3">객실 곳곳 숨어 있는 장식 요소들로 즐거움을 전달합니다.</h5>
				</div>
			</li>
			<li>
				<img src="image/mainimg3.jpg">
				<div class="caption right-align">
					<h3 class="htitle">Dining</h3>
					<h5 class="light grey-text text-lighten-3">세계 각지의 수준 높은 요리를 더 특별하게 만나 볼 수 있습니다.</h5>
				</div>
			</li>
			<li>
				<img src="image/mainimg4.jpg">
				<div class="caption center-align">
					<h3 class="htitle">Private Lounge</h3>
					<h5 class="light grey-text text-lighten-3">아늑하고 모던한 라운지에서 비즈니스와 휴식을 동시에 취해보세요.</h5>
				</div>
			</li>
		</ul>
	 </div>
</section>
<section>
	<div class="main" >
		<!-- 예약 검색 바 -->
		<div id="resv">
			<form name="resvFrm" id="resvFrm" action="./resv/doresv/step1.jsp" method="get">
				<table id="resvtb">
					<tr>
						<th width="150px;">체크인</th>
						<th><img src="/hotel/image/moon.png" width="12px" height="12px"></th>
						<th width="150px;">체크아웃</th>
						<th width="100px;">객실</th>
						<th width="100px;">성인</th>
						<th width="100px;">어린이<img src="/hotel/image/bang.png" width="12px" height="12px" title="37개월 이상 ~ 만 12세 이하 (베트남 : 만 6세 이상 ∼ 만 11세까지)"></th>
						<th width="100px;">유아<img src="/hotel/image/bang.png" width="12px" height="12px" title="36개월 이하 (베트남 : 만 5세 이하)"></th>
						<th width="130px;" rowspan="2"><input type="submit" value="검색" id="searchBtn"></th>
					</tr>
					<tr>
						<td class="resvdate"><input type="text" value="<%= checkin %>" id="checkin" name="checkin" readonly></td>
						<td style="text-align: center;"><input type="text" value="<%= night %>" id="night" name="night" readonly></td>
						<td class="resvdate"><input type="text" value="<%= checkout %>" id="checkout" name="checkout" readonly></td>
						<td style="text-align: center;">1</td>
						<td class="people"><input type="text" value="<%= adcnt %>" class="adult" readonly></td>
						<td class="people"><input type="text" value="<%= chcnt %>" class="child" readonly></td>
						<td class="people"><input type="text" value="<%= kidcnt %>" class="kid" readonly></td>
					</tr>
				</table>
				<!-- //#resvtb -->
				<div id="date">
					<%@ include file="../../include/calendar.jsp" %>
				</div>
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
						<input type="text" value="<%= kidcnt %>" class="kid" name="kid" readonly>
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
				<!-- 이미지 소개 부분 -->
				<div id="serviceimg">
			<h1 style="text-align:center; font-family: Roxborough;" >Dining &amp; Service</h1>
			<h5 style="text-align:right;">&#43; &nbsp; <a href="/hotel2/info/service/">더보기</a></h5>
			<div id="todining">
				<a href="/hotel2/info/service/">
				<img src="/hotel2/image/todining.jpg" width="1000px" height="400px">
				</a>
			</div>
			<div id="torooms">
				<a href="/hotel2/info/roominfo/">
				<img src="/hotel2/image/torooms.jpg" width="490px" height="300px">
				</a>
			</div>
			<div id="tomap">
				<a href="/hotel2/info/map/">
				<img src="/hotel2/image/tomap.jpg" width="490px" height="300px">
				</a>
			</div>
		</div>
			</form>
		</div>
	</div>
	<!-- //.main -->
	<script type="text/javascript" src="js/materialize.js"></script>
</section>
<%@ include file="include/tail.jsp" %>