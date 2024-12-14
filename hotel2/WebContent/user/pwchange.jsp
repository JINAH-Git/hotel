<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria | 회원정보 변경</title>
		<link rel="stylesheet" href="../style/userinfochange.css">
		<link rel="stylesheet" href="../style/uspwchange.css">
	</head>
<%@include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
String emailid = request.getParameter("emailid");
if(emailid == null || emailid.equals(""))
{
	%>
	<script>
	alert("잘못된 접근입니다.");
	window.location.href="pwfind.jsp";
	</script>
	<%
}else if(emailid != null || !emailid.equals(""))
{
	%>
	<script>
	alert("인증이 완료되었습니다. 비밀번호를 재설정해주세요.");
	</script>
	<%
}
%>
<script>
	var flag = "false";
	
	window.onload = function(){
		
		$(".pw").keyup(function(){
			samecheck();
		});
		
		$(".pwcheck").keyup(function(){
			samecheck();
		});
		
		$(".joinbutton").click(function(){
			
			if(flag == "false")
			{
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}
			
			if(flag == "true")
			{				
				pw = $(".pw").val();
				emailid = $("#id").val();
			
				$.ajax({
					type : "post",
					url: "pwchangeok.jsp?pw=" + pw + "&emailid=" + emailid,
					dataType: "html",
					success : function(data) 
					{	
						// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
						data = data.trim();
						
						alert(data);
						if(data == "비밀번호가 변경되었습니다. 로그인 페이지로 이동합니다.")
						{
							location.href = "login.jsp";	
						}
						return false;
					},
					error : function(xhr, status, error)
					{
						alert("비밀번호 변경 오류");
					}
				});
				
				
			}
		});		
	}
	
	function samecheck()
	{
		pw = $(".pw").val();
		if(pw == "")
		{
			$(".infodovalue4").html("새 비밀번호를 입력하세요.");
			return;
		}
		
		pwcheck = $(".pwcheck").val();		
		if(pwcheck == "")
		{
			$(".infodovalue4").html("새 비밀번호 확인을 입력하세요.");
			return;
		}
		
		$.ajax({
			type : "get",
			url: "pwchangeck.jsp?pw=" + pw + "&pwcheck=" + pwcheck,
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				console.log(data);
				flag = data;
				
				//true,false
				switch(data)
				{
				case "false" :
					$(".infodovalue4").html("비밀번호가 일치하지 않습니다.");
					break;
				case "true" :
					$(".infodovalue4").html("비밀번호가 일치합니다.");
					$(".infodovalue4").css("color", "green");
					break;
				}
			},
			error : function(xhr, status, error){}
		});
	}
</script>
<section>
	<div class="main">
	<!-- 필수정보 입력란 -->
		<div class="introduction">
			<div class="introhead">
				<h1> &nbsp;&nbsp; Password Change </h1>
				<p class="pwfindtotaltext"><em>비밀번호를 변경합니다.</em></p>
			</div>
		</div>
		<form method="post" name="pwchangeok" action="pwchangeok.jsp" style="height: 500px;"> 
			<div class="pwfindtotal">		
				<hr class="line">
				<div class="infodovalue9">PASSWORD *</div>
				<div class="infodovalue4" >CONFIRM PASSWORD *</div>
				<br>
				<span id="msg"></span>
				<div class="password" style="margin-top: 100px;">
					<input type="hidden" id="id" name="id" value="<%= emailid %>">
					<input type="password" class="pw" id="pw" name="pw" placeholder="새 비밀번호">
					<input type="password" class="pwcheck" id="pwcheck" name="pwcheck" placeholder="새 비밀번호 확인"><br>
					<input type="button" class="joinbutton" value="비밀번호 변경"><br>				
				</div>
				<!-- 비밀번호, 비밀번호 확인 입력 구간 끝 -->	
			</div>
		</form>
		<!-- 필수정보 입력 끝 -->
	</div>
	<!-- //.main -->
</section>
<%@include file="../include/tail.jsp" %>