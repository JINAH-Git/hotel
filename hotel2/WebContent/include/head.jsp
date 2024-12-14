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
			font-family: "Roxborough"; /*font �̸�*/
		    /* ������&����̽� ȯ�濡 ���� font ���� ��ġ ���� */
		    src: url("/hotel2/fonts/Roxborough CF.ttf"); 
		}
	</style>
	<script>
	window.onload = function()
	{
		//�α����� ������� �̸��� Ŭ���Ҷ� �̺�Ʈ
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
						<a href="/hotel2/user/login.jsp">�α���</a> |
						<a href="/hotel2/user/join.jsp">ȸ������</a> |
						<a href="/hotel2/resv/findresv.jsp">���� Ȯ��</a>
						<%
					}else
					{
						%>
						<ul class="loginMenu">
							<li>
								<b id="loginName"><%= login.getKname() %></b>�� ȯ���մϴ�.	|
								<ul class="subMenu">
									<li>
										<a href="/hotel2/user/userinfoop.jsp">����������</a>
									</li>
									<% 
									if(login.getLevel().equals("A")){%>
									<li>
										<a href="/hotel2/admin/userctrl/index.jsp">������ ������</a>
									</li>
									<% }%>	
								</ul>
							</li>
							<li>
								<a href="/hotel2/user/loginout.jsp">�α׾ƿ�</a> |
							</li>
							
							<li>
								<a href="/hotel2/resv/confirm.jsp">���� Ȯ��</a>
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
								<a href="/hotel2/resv/doresv/step1.jsp">����&nbsp;<img src="/hotel2/image/calender.png" width="20px;" height="20px;"></a>
							</li>
							<li>
								<a href="/hotel2/info/map">ȣ�� �Ұ�</a>
							</li>
							<li>
								<a href="/hotel2/index.jsp" style="color: #black;">Alegria &nbsp;Hotel </a>
							</li>
							<li>
								<a href="/hotel2/faq/question">���� ����</a>
							</li>
							<li>
								<a href="/hotel2/promotion/event">���θ��</a>
							</li>
						</ul>
					</div>
					<!-- //.hubMenu -->
				</div>
				<!-- //.header -->
			</div>
			<!-- //.head -->
		</header>