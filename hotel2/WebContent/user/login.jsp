<!-- 
작성일: 23.07.19.수
작성자: 김진아
아이디 저장기능 구현
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>로그인 | 호텔</title>
		<link rel="stylesheet" href="../style/login.css">
	</head>

	<%@include file="../include/head.jsp" %>
		<script>
		window.onload = function()
		{
			$("#useremail").focus();
			
			//로그인 버튼 눌렀을 때 기능
			$("#login_button").click(function()
			{
				if($("#useremail").val() == "")
				{
					alert("아이디를 입력해주세요.");
					$("#useremail").focus();		
					return false;
				}
				if($("#userpw").val() == "")
				{
					alert("비밀번호를 입력해주세요.");
					$("#userpw").focus();
					return false;
				}		
				return true;
			});
			
			//아이디 저장기능 구현
			$(document).ready(function()
			{
				// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
			    var key = getCookie("login");
			    $("#useremail").val(key); 
		     
			    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
			    if($("#useremail").val() != "")
			    { 
		        	$("#checidkbox").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    		}
		     
			    $("#checidkbox").change(function() // 체크박스에 변화가 있다면,
	    		{
			        if($("#checidkbox").is(":checked")) // ID 저장하기 체크했을 때,
			        {
			            setCookie("login", $("#useremail").val(), 7); // 7일 동안 쿠키 보관
			        }
			        else // ID 저장하기 체크 해제 시,
			        {
			            deleteCookie("login");
			        }
		    	});
		     
			    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
			    $("#useremail").keyup(function() // ID 입력 칸에 ID를 입력할 때,
	    		{
			        if($("#checidkbox").is(":checked")) // ID 저장하기를 체크한 상태라면,
			        {
		            	setCookie("login", $("#useremail").val(), 7); // 7일 동안 쿠키 보관
			        }
			    });
	
				// 쿠키 저장하기 
				// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
				function setCookie(cookieName, value, exdays) 
				{
					var exdate = new Date();
					exdate.setDate(exdate.getDate() + exdays);
					var cookieValue = escape(value)
							+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
					document.cookie = cookieName + "=" + cookieValue;
				}
	
				// 쿠키 삭제
				function deleteCookie(cookieName) 
				{
					var expireDate = new Date();
					expireDate.setDate(expireDate.getDate() - 1);
					document.cookie = cookieName + "= " + "; expires="
							+ expireDate.toGMTString();
				}
	     
				// 쿠키 가져오기
				function getCookie(cookieName) 
				{
					cookieName = cookieName + '=';
					var cookieData = document.cookie;
					var start = cookieData.indexOf(cookieName);
					var cookieValue = '';
					if (start != -1)  // 쿠키가 존재하면
					{
						start += cookieName.length;
						var end = cookieData.indexOf(';', start);
						if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
						{
							end = cookieData.length;
						}
			                console.log("end위치  : " + end);
							cookieValue = cookieData.substring(start, end);
					}
					return unescape(cookieValue);
				}
			});
		}
	</script>
	<!-- 컨텐츠 시작하는 부분 -->
	<section>
		<div class="main">
			<!-- 로그인 표지 시작 -->
			<div class="introduction">
				<div class="introhead"><h1> &nbsp;&nbsp; SIGN IN</h1></div>
				<div class="introtext"><p> &nbsp; 머무는 모든 순간이 특별해집니다.</p></div>
			</div>
			<!-- 로그인 표지 끝 -->
			<!-- 아이디 로그인 입력 창 시작 -->
			<form method="post" action="loginok.jsp" name="login" id="login">
			<!-- 아이디, 비밀번호 시작  -->
			<div class="logintotal">
				<hr class="line">
				<!-- 아이디 로그인, 아이디, 비밀번호, 아이디 저장, 회원가입, 비밀번호 찾기 시작 -->
				<ul class="tabType">
					<li class="on">
						<h3>아이디 로그인</h3>
						<input type="text" name="useremail" id="useremail" style="font-size:20px;" placeholder="아이디">
						<input type="password" name="userpw" id="userpw" style="font-size:20px;" placeholder="비밀번호">
							<span id="checkidboxfrm">
								<input type="checkbox" name="checkidbox" id="checidkbox">
								<label for="checkidbox">아이디 저장</label>
							</span>
						<input type="submit" name="login_button" id="login_button" value="로그인">
						<!-- 회원가입, 아이디/비밀번호 찾기 시작 -->
						<div id="loginlink">
							<a href="join.jsp" id="login_join">회원가입 ></a>
							<a href="pwfind.jsp" id="pw_find">비밀번호 찾기 ></a>
						</div>
						<!-- 회원가입, 비밀번호 찾기 끝 -->
					</li>
				</ul>
				<!-- 아이디 로그인, 아이디, 비밀번호, 아이디 저장, 회원가입, 아이디/비밀번호 찾기 끝 -->
			</div>
			<!-- 아이디, 비밀번호 끝  -->
			</form>
			<!-- 아이디 로그인 입력 창 끝 -->
			<!-- 로그인시 주의사항 시작-->
			<ul id="txtGuide">
				<li>
					* 이용자 비밀번호 5회 이상 오류시 계정이 잠기게 됩니다.
				</li>
				<li>
					* 유선 혹은 여행사를 통한 예약은 온라인 조회가 불가하오니 예약실로 문의 부탁드립니다.
				</li>
				<li>
					* 연락처 등의 정보가 변경되면 웹사이트에서 회원정보를 수정해주시기 바랍니다.
				</li>
			</ul>
			<!-- 로그인시 주의사항 끝 -->
		</div>	
		<!-- 아이디 로그인 창 끝 -->
	<!-- //.main -->
	</section>
	<!--  컨텐츠 끝나는 부분 -->
	<%@include file="../include/tail.jsp" %>