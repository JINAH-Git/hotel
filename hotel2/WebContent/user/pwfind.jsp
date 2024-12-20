<!-- 
김진아 / 23.07.05.수, 23.07.06.목 /디자인 수정 완료
유수민/ 23.07.17.월 / 디자인, 기능 구현
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>비밀번호 찾기</title>
		<link rel="stylesheet" type="text/css" href="../style/uspwfnd.css" />
	</head>
	<%@ include file="../include/head.jsp"%>
		<script>
		window.addEventListener('load', function()
		{
			$(".birthtext").keyup(function(){
				samecheck();
			});
			
			$(".emailid").keyup(function(){
				samecheck();
			});
			
			//생년월일 입력
			$(document).on("keyup", ".birthtext", function() {
		     $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/([0-9]{4})+([0-9]{2})+([0-9]{2})$/,"$1-$2-$3").replace("--", "-"));
		    });
			
			$(".emailbutton").click(function(){
				if(checkCode == "false")
				{
					alert("정보가 일치하지 않습니다. 비밀번호 찾기를 진행할 수 없습니다.");
					return false;
				}
				if(checkCode == "ERROR")
				{
					alert("정보를 입력해주세요.");
					return false;
				}
				if(checkCode == "true")
				{
					alert("본인 확인 되었습니다. 이메일 발송까지 잠시만 기다려주세요")
					emailid = $(".emailid").val();
					$.ajax({
						type : "get",
						url: "pwfindck.jsp?emailid=" + emailid,
						dataType: "html",	//html,xml,json
						success : function(data) 
						{	
							//이메일 보내기
							data = data.trim();
							alert(data);
							if(data == "입력하신 이메일로 코드를 발송하였습니다. 코드를 입력해주세요.")
							{
								 $(".ecode").focus();
							}
						},
						error : function(xhr, status, error){alert("인증 코드 발송 오류");}
					});
				}
			});
		});
		
		//상태를 저장하기 위한 변수
		var checkCode = "ERROR"
		
		function samecheck()
		{
			checkCode = "ERROR"
			
			birthtext = $(".birthtext").val();
			if(birthtext == "")
			{
				$("#msg").html("생년월일을 입력하세요");
				return;
			}
			
			emailid = $(".emailid").val();		
			if(emailid == "")
			{
				$("#msg").html("아이디를 입력하세요");
				return;
			}
			
			$.ajax({
				type : "get",
				url: "pwfindok.jsp?birthtext=" + birthtext + "&emailid=" + emailid,
				dataType: "html",	//html,xml,json
				success : function(data) 
				{	
					// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
					data = data.trim();
					console.log(data);
					
					checkCode = data;
					
					//true,false
					switch(data)
					{
					case "false" :
						$("#msg").html("입력하신 정보가 일치하지 않습니다.");
						break;
					case "true" :
						$("#msg").html("입력하신 정보가 일치합니다.");
						break;
					case "ERROR" :
						$("#msg").html("정보를 입력해주세요.");
						break;
					}
				},
				error : function(xhr, status, error){}
			});
		}
		</script>
		<!-- 컨텐츠 시작하는 부분 -->
		<div class="main">
			<!-- 로그인 표지 시작 -->
			<div class="introduction">
				<div class="introhead">
					<h1> &nbsp;&nbsp; Identification</h1>
					<p class="pwfindtotaltext"><em>회원가입한 이메일 주소와 입력한 이메일 주소가 같아야, 인증번호를 받을 수 있습니다.</em></p>
				</div>
			</div>
			<!-- 비밀번호 찾기 폼 시작 -->
			<form method="post" action="pwfindfin.jsp" name="pwfindfin" id="pwfindfin">
				<!-- 비밀번호 찾기  -->
				<div class="pwfindtotal">
					<hr class="line">
					<!-- 생년월일 코멘트 -->
					<div class="infodovalue9">BIRTH DATE*</div>
					<br>
					<div class="birth">
						<input type="text" class="birthtext" name="birthtext" placeholder="1900-01-03">
					</div>
					<!-- 이메일 입력 구간 시작 -->
					<br>
					<div class="email">
						<div class="infodovalue4">ID *</div>
						<br>
						<input type="text" class="emailid" name="emailid" placeholder="이메일">
						<input type="button" value="인증번호 받기" class="emailbutton" name="emailbutton">
					</div>
					<br>
					<!-- 인증번호 확인 시작 -->
					<div class="codestart">
						<div class="codecomment">Verification Code *</div> <span id="msg"></span>
						<br>
						<input type="text" class="ecode" name="ecode" placeholder="인증번호를 입력해주세요.">					
						<input type="submit" value="확인" class="codestartcheck">
					</div>
				</div>
			</form>
			<!-- 비밀번호 찾기 폼 끝  -->
			<div id="txtGuide"></div>
		</div>
		<!-- //.main -->
	<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp" %>