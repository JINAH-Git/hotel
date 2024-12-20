<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.vo.*" %>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="/hotel2/style/head.css" />
		<script src="/hotel2/js/jquery-3.7.0.js"></script>
	</head>
	<style>
		/*fonts.css*/
		@font-face 
		{
			font-family: "Roxborough"; /*font 이름*/
		    /* 브라우저&디바이스 환경에 따른 font 파일 위치 정의 */
		    src: url("/hotel2/fonts/Roxborough CF.ttf"); 
		}
	</style>
	<script>
	window.onload = function()
	{
		//로그인한 사용자의 이름을 클릭할때 이벤트
		$("#loginName").click(function(){
			if($(".subMenu").css('display') == 'none')
			{
				$(".subMenu").css('display','block');
			}else
			{
				$(".subMenu").css('display','none');
			}
		});		
	}
	</script>
	<body>
		<header>
			<div class="head">
				<div class="loginArea" style="background-color: #fff; padding: 0 10px;">
					<%
					if(login == null)
					{
						%>
						<a href="/hotel2/user/login.jsp">로그인</a> |
						<a href="/hotel2/user/join.jsp">회원가입</a> |
						<a href="/hotel2/resv/findresv.jsp">예약 확인</a>
						<%
					}else
					{
						%>
						<ul class="loginMenu">
							<li>
								<b id="loginName"><%= login.getKname() %></b>님 환영합니다.	|
								<ul class="subMenu">
									<li>
										<a href="/hotel2/user/userinfoop.jsp">마이페이지</a>
									</li>
									<% 
									if(login.getLevel().equals("A")){%>
									<li>
										<a href="/hotel2/admin/userctrl/index.jsp">관리자 페이지</a>
									</li>
									<% }%>	
								</ul>
							</li>
							<li>
								<a href="/hotel2/user/loginout.jsp">로그아웃</a> |
							</li>
							
							<li>
								<a href="/hotel2/resv/confirm.jsp">예약 확인</a>
							</li>				
						</ul>
						<%
					}%>
				</div>
				<!-- //.loginArea -->
				<div class="header">
					<div class="hubMenu">
						<ul>
							<li>
								<a href="/hotel2/resv/doresv/step1.jsp">예약&nbsp;<img src="/hotel2/image/calender.png" width="20px;" height="20px;"></a>
							</li>
							<li>
								<a href="/hotel2/info/map">호텔 소개</a>
							</li>
							<li>
								<a href="/hotel2/index.jsp" style="color: #black;">Alegria &nbsp;Hotel </a>
							</li>
							<li>
								<a href="/hotel2/faq/question">고객 문의</a>
							</li>
							<li>
								<a href="/hotel2/promotion/event">프로모션</a>
							</li>
						</ul>
					</div>
					<!-- //.hubMenu -->
				</div>
				<!-- //.header -->
			</div>
			<!-- //.head -->
		</header>