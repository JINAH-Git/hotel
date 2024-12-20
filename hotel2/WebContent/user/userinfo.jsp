<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Ezen Hotels & Resorts</title>
		<link rel="stylesheet" type="text/css" href="/hotel/style/head.css" />
		<link rel="stylesheet" type="text/css" href="/hotel/style/tail.css" />
	</head>
	<body>
		<div class="head">
			<div class="header">
				<h1 class="logo">
					<a href="/hotel/index.jsp">Ezen <br> Hotels & Resorts</a>
				</h1>
				<span class="loginArea">
					<a href="/hotel/user/login.jsp">로그인</a>&nbsp;|
					<a href="/hotel/user/join.jsp">회원가입</a>&nbsp;|
					<a href="/hotel/resv/confirm.jsp">예약 확인</a>
				</span>
				<!-- //.loginArea -->
				<div class="hubMenu">
					<ul>
						<li>
							<a href="/hotel/resv/doresv.jsp">예약</a>
							<img src="/hotel/image/calender.png" width="20px;" height="20px;">
						</li>
						<li>
							<a href="/hotel/info/map">호텔 소개</a>
						</li>
						<li>
							<a href="/hotel/faq/question">고객 문의</a>
						</li>
						<li>
							<a href="/hotel/promotion/event">프로모션</a>
						</li>
					</ul>
				</div>
				<!-- //.hubMenu -->
			</div>
			<!-- //.header -->
		</div>
		<!-- //.head -->
		<!-- 컨텐츠 시작하는 부분 -->
		<div class="main">
			
		</div>
		<!-- //.main -->
		<!--  컨텐츠 끝나는 부분 -->
		<div class="tail">
			<div class="localBox">
				<img src="image/hotel.jpg" width="170px" height="170px">
				<div class="brandInfo">
					<dl class="brand">
						<dt><a href="#">HOTEL1</a></dt>
						<dt><a href="#">HOTEL2</a></dt>
						<dt><a href="#">HOTEL3</a></dt>
					</dl>
				</div>
				<!-- //.brand -->
				<div class="info">
					<dl class="introduction">
						<dd>호텔이젠 소개</dd>
						<dd>호텔 개발</dd>
						<dd>고객문의</dd>
						<dd>사이트맵</dd>
					</dl>
					<!-- //.introduction -->
					<dl class="hotelInfo">
						<dd>전주이젠호텔 tel : 010 - 1111- 1111</dd>
						<dd>전주이젠호텔 tel2 : 010 - 2222- 2222</dd>
					</dl>
					<!-- //.hotelInfo -->
				</div>
				<!-- //.info -->
			</div>
			<!-- //.localBox -->
			<div class="footer">
			</div>
			<!-- //.footer -->
		</div>
		<!-- //.tail -->
	</body>
</html>