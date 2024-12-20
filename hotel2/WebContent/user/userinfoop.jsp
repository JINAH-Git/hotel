<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원정보 수정</title>		
		<script src="/hotel2/js/includeHTML.js"></script>
	</head>
<%@include file="../include/head.jsp" %>
	<style>		
		.joinbutton
		{
			position:absolute;
			top:450px;
			left: 300px;
		    min-width: 190px;
		    height: 60px;
		    padding: 0 25px;
		    line-height: 58px;
		    font-size: 18px;
		    letter-spacing: -.01em;
	        background: #000 !important;
   			color: #fff !important;
   			margin-left:366px;
		}
		.cancelbutton
		{
			position:absolute;
			top:450px;
			left: 600px;
			min-width: 190px;
		    height: 60px;
		    padding: 0 25px;
		    line-height: 58px;
		    font-size: 18px;
		    letter-spacing: -.01em;
	        background: #000 !important;
   			color: #fff !important;
   			margin-left:366px;
		}
		.necesse
		{
			position:absolute;
			top:250px;
			left: 830px;
		}
	</style>
	<script>
		function pwchange(){
			if(confirm('비밀번호를 재설정하기 위해서는 본인인증이 필요합니다.') == true)
			{
				location.href="pwfind.jsp";
			}else
			{
				location.href="userinfoop.jsp";
			}
		}
	</script>
	<section>
		<div class="main">
			<h1 class="necesse">마이페이지</h1>	
			<div>
				<input type=submit value="회원정보 변경" class="joinbutton" onclick="location.href='userinfochange.jsp'">
				<input type=button value="비밀번호 변경" class="cancelbutton" onclick="pwchange()">
			</div>
			<!-- //#contents -->
		</div>
		<!-- //.main -->
	</section>
<%@include file="../include/tail.jsp" %>