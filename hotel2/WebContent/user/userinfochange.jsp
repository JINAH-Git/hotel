<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
김진아/23.06.30.금, 23.07.03.월, 23.07.05.수, 23.07.12.수/회원가입 html 잡기, 2. 이어서 틀 잡기 3.include영역 정리
유수민/ 23.07.17.월 / 비밀번호 변경에서 넘어오기
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%
request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria | 회원정보 변경</title>
		<link rel="stylesheet" href="../style/userinfochange.css">
	</head>

	<body>
	<%@include file="../include/head.jsp" %>
	<script>
	window.addEventListener('load', function() 
	{
		//전화번호 하이폰 자동 입력
		$(document).on("keyup", ".numbertext", function() { 
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
		
		//한글 이름 한글만 받기
	    $(".kname").keyup(function (event)
		{
            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
            v = $(this).val();
            if (regexp.test(v)) 
            {
                //alert("한글만 입력가능 합니다.");
                //$(".infodovalue2").html("한글만 입력가능 합니다.");
                $(this).val(v.replace(regexp, ''));
            }
        });		
	});
	
	</script>
	<%
	if(login == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	%>
	<section>
	<!-- 컨텐츠 시작하는 부분 -->
		<div class="main">
		<!-- 필수정보 입력란 -->
		<div>
			<h2 class="necesse">회원정보 변경</h2>
		</div>
		<!-- 필수정보 입력 시작 -->
		<form method="post" name="joinintrofrm" action="/hotel2/user/userinfochangeok.jsp">
		<div class="infodostart">
			<!-- 영문 이름, 한글 이름 커멘트 -->
			<div class="infodovalue1">ENGLISH NAME</div>
			<div class="infodovalue2">KOREAN NAME</div>
			<br>
			<!-- 영문 이름, 한글 이름 입력 구간 시작 -->
			<div class="name">
				<input type="text" class="ename" name="ename" placeholder="영문 성명" value=<%=login.getEname() %> onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'');" />
				<input type="text" class="kname" name="kname" placeholder="한글 성명" value=<%=login.getKname() %>>
			</div>
			<!-- 영문 이름, 한글 이름 입력 구간 끝 -->
				<!-- 생년월일 입력 구간 시작 -->
				<div class="infodovalue3">BIRTH DATE</div>
				<br>
				<div class="birth">
					<input type="text" class="birthtext" placeholder="1900-01-03" value=<%=login.getBirth() %> readonly>
				</div>
				<!-- 생년월일 입력 구간 끝 -->
				<br>
				<!-- 이메일 입력 구간 시작 -->
				<div class="email">
					<div class="infodovalue4">ID</div>
					<br>
					<input type="text" class="emailid" placeholder="이메일" value=<%=login.getEmail() %> readonly>
				</div>
				<!-- 이메일 입력 구간 끝 -->
				<br>
				<!-- 성별  입력 7,8 입력 커멘트 시작 -->
				<div class="infodovalue7">GENDER</div>
				<div class="infodovalue8">KOREAN/FOREIGNER</div>
				<br>
				<!-- 성별  입력 7,8 입력 커멘트 끝 -->
				<br>
				<!-- 성별, 내국인/외국인 구간 시작  -->
				<div class="genderstart">
					<!-- 성별 시작  -->
					<div class="gender">
						<input type="radio" id="gender1" name="gender" value="M" <%=login.getGender().equals("M") ? "checked" : "disabled" %> >
							<label for="gender1">남</label>
						<input type="radio" id="gender2" name="gender" value="F" <%=login.getGender().equals("F") ? "checked" : "disabled" %>>
							<label for="gender2">여</label>
					</div>
					<!-- 성별 끝-->
					<!-- 내국인 외국인 시작 -->
					<div class="koreanforeigner">
						<input type="radio" id="korean" name="koreanforeigner1" value="K" <%=login.getKorf().equals("K") ? "checked" : "disabled" %>>
							<label for="korean">내국인</label>
						<input type="radio" id="foreigner" name="koreanforeigner1" value="F" <%=login.getKorf().equals("F") ? "checked" : "disabled" %>>
							<label for="foreigner">외국인</label>
					</div>
					<!-- 내국인 외국인 끝 -->
				</div>
				<!-- 영문 이름, 한글 이름 입력 구간 끝  -->
				<br>
				<!-- 핸드폰 번호 입력 구간 시작 -->
				<div class=numberstart>
					<!-- number 코멘트 -->
					<div class="infodovalue9">NUMBER *</div>
					<br>
					<!-- 번호 입력 input 시작 -->
					<div class="number">
						<input type="text" class="numbertext" name="numbertext" placeholder="전화번호" value=<%=login.getNumber() %>>
							<p style="text-decoration: underline;"></p>
					</div>
					<!-- 번호 입력 input 끝 -->
				</div>
				<br>
				<!-- 회원가입, 취소 버튼 구간 시작 -->
				<div class="joincancelstart">
					<input type=submit value="확인" class="joinbutton" id="joinbutton">
					<input type=button value="취소" class="cancelbutton" onclick="location.href='userinfoop.jsp'">
				</div>
				<!-- 회원가입, 취소 버튼 구간 끝 -->
		</div>
		</form>
		<!-- 필수정보 입력 끝 -->
				
			<!--  회원가입 약관, 필수정보 입력 전체 끝 -->
		</div>
		<!-- //.main -->
		</section>
		<%@include file="../include/tail.jsp" %>