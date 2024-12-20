<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
작성자: 김진아
작성일: 23.06.30.금, 23.07.03.월, 23.07.05.수, 23.07.13.목, 23.07.19.수, 23.07.20.목
1. 회원가입 html 잡기, 2. 이어서 틀 잡기 3.이메일 값 받아서 넣기 4.비밀번호 설정 5.인증 완료 구현
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%
UserDTO dto = new UserDTO();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원가입 - 약관동의 및 회원정보</title>
		<link rel="stylesheet" href="../style/join.css">
	</head>
	<body>
	<%@include file="../include/head.jsp" %>
		<script>
		//전역 변수 선언
		var enameflag   = false;
		var knameflag   = false;
		var birthflag   = false;
		var emailflag   = false; //아이디 체크
		var codeflag    = false;
		var pwflag      = false;
		var pwcheckflag = false;
		var numberflag  = false;
		
		//var emailval = "";
		////window창 시작
		window.onload = function()
		{
			
			//체크박스 전체 선택
			$(".checkbox_group").on("click","#check_all",function()
			{
				  var checked = $(this).is(":checked");
				  if(checked)
				  {
				  	$(this).parents(".checkbox_group").find('input').prop("checked", true);
				  } else 
				  {
				  	$(this).parents(".checkbox_group").find('input').prop("checked", false);
				  }
			});
			
			//체크박스 개별 선택
			$(".checkbox_group").on("click", ".normal", function() 
			{
			    var is_checked = true;
			    
			    $(".checkbox_group .normal").each(function()
	    		{
			        is_checked = is_checked && $(this).is(":checked");
			    });
			    
			    $("#check_all").prop("checked", is_checked);
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
			
			//생년월일 하이폰 자동입력
			$(document).on("keyup", ".birthtext", function() 
			{
		    	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/([0-9]{4})+([0-9]{2})+([0-9]{2})$/,"$1-$2-$3").replace("--", "-"));
		    });
		
			
			//전화번호 하이폰 자동 입력
			$(document).on("keyup", ".numbertext", function() 
			{ 
				$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
			});
			
			
			//회원가입 취소 버튼 눌렀을 때
			$(".cancelbutton").click(function()
			{
				if(confirm("회원가입을 취소하겠습니까?") == false)
				{
					return;
				}
				document.location = "/hotel2/index.jsp";
			});
					
			
			//회원가입 버튼 눌렀을 때
			$(".joinbutton").click(function()   //익명 함수
			{  	
				var agreop = $("#check_1").is(":checked");
				if(agreop != true)
				{
					alert("약관동의에 동의하셔야 회원가입을 진행할 수 있습니다.");
					$("#check_1").focus();
					return false;
				}
				//영문이름
				var ename = $(".ename").val();
				if(ename == "")
				{
					$(".infodovalue1").html("영문이름을 입력하세요.");
					$(".ename").focus();
					enameflag = false;
					return false;
				}
				//한글이름
				var kname = $(".kname").val();
				if(kname == "")
				{
					$(".infodovalue2").html("한글이름을 입력하세요.");
					$(".kname").focus();
					enameflag = false;
					return false;
				}
				//생년월일
				var birth = $(".birthtext").val();
				if(birth == "")
				{
					$(".infodovalue3").html("생년월일을 입력하세요.");
					$(".birthtext").focus();
					birthflag = false;
					return false;
				}
				//아이디(이메일)
				var emailid = $(".emailid").val();
				if(emailid == "")
				{
					$(".infodovalue4").html("이메일을 입력하세요.");
					$(".infodovalue4").css("color", "red");
					$(".emailid").focus();
					emailflag = false;
					return false;
				}else if(!emailflag)
				{
					alert("이메일 인증 후, 코드를 입력해주세요.");
					$(".emailcode").focus();
					emailflag = false;
					return false;
				}
				
				//코드번호
				var emailcode = $(".emailcode").val();
				if(emailcode == "")
				{
					$(".emailcheck").html("인증번호를 입력하세요.");
					$(".emailcheck").css("color", "red");
					$(".emailcode").focus();
					codeflag = false;
					return false;
				}
				
			
				//비밀번호
				var pw = $("#pw").val();
				if(pw == "")
				{
					$(".infodovalue5").html("비밀번호를 입력해주세요.");
					$(".infodovalue5").css("color", "red");
					$("#pw").focus();
					return false;
				}
				//비밀번호 확인
				var pwcheck = $("#pwcheck").val();
				if(pwcheck == "")
				{
					$(".infodovalue6").html("비밀번호 확인을 입력하세요.");
					$(".infodovalue6").css("color", "red");
					$("#pwcheck").focus();
					return false;
				}
				
				//비밀번호 일치 여부
				if(pwcheck != pw)
				{
					alert("비밀번호 일치를 확인해주세요.");
					$("#pwcheck").focus();
					return false;
					
				}
				//전화번호
				var number = $(".numbertext").val(); 
				if(number == "")
				{
					$(".infodovalue9").html("연락처를 입력하세요.");
					$(".number").focus();
					return false;
				}
				
				$("#joinfrm").submit();
			});	
			
			//이메일 입력 확인 
			$(".emailid").keyup(function()
			{
				$(".infodovalue4").html("ID *");
			});
			
			
			//비밀번호 확인
			$("#pwcheck").keyup(function()
			{
				var pass1 = $("#pw").val();
				var pass2 = $("#pwcheck").val();
				
				if(pass1 != "" || pass2 != "")
				{
					if(pass1 == pass2)
					{
						$(".infodovalue6").html("비밀번호가 일치합니다.");
						$(".infodovalue6").css("color", "green");
					}else
					{
						$(".infodovalue6").html("비밀번호가 불일치합니다.");
						$(".infodovalue6").css("color", "red");
					}
				}
			});
			
			//이메일 인증 버튼
			$(".emailbtn").click(function()
			{
				alert("코드를 전송중입니다.");
				var email = $(".emailid").val();
				
				$.ajax(
				{					
					type : "get",     // 방식 2가지 (get방식 or post방식)
					url: "emailcheck.jsp?email=" + email , //호출 할 페이지 접속해서 데이터를 받아옴.
					dataType: "html",  //넘어오는 데이터 형태를 지정. html, xml, json이 있음.
					success : function(data) 
					{	
						// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
						data = data.trim();
						alert(data);
						if(data == "입력하신 이메일로 코드를 발송하였습니다. 코드를 입력해주세요.")
						{
							 $(".emailcode").focus();
						}
					},
					complete : function(data) 
					{	
						// 통신이 성공하거나 실패했어도 이 함수를 타게된다.
					},
					error : function(xhr, status, error) 
					{
						// 통신 오류 발생시
						alert("이메일 인증 오류입니다.");
					}
				});
			});
			
			//코드 인증
			$(".codebtn").click(function()
			{
				var ecode = $(".emailcode").val();
				$.ajax(
				{					
					type : "post",     // 방식 2가지 (get방식 or post방식)
					url: "codecheck.jsp?ecode=" + ecode , //호출 할 페이지 접속해서 데이터를 받아옴.
					dataType: "html",  
					success : function(data) 
					{	
						// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
						data = data.trim();
						alert(data);
						if(data == "코드가 입력되지 않았습니다.")
						{
							$(".emailcode").focus();
						}else if(data == "인증 완료되었습니다.")
						{
							emailflag = true;
						}
					},
					complete : function(data) 
					{	
						// 통신이 성공하거나 실패했어도 이 함수를 타게된다.
					},
					error : function(xhr, status, error) 
					{
						// 통신 오류 발생시
						alert("오류입니다.");
					}
				});
			});
			
		}
	
		</script>
	<section>
		<!-- 컨텐츠 시작하는 부분 -->
		<div class="main">
			<!-- 회원가입 표지 시작 -->
			<div class="introduction">
				<h1 class="introhead"> &nbsp; &nbsp; JOIN</h1>
				<div class="introtext"><p> &nbsp; Alegria 오신 것을 환영합니다.</p></div>	
			</div>	
			<!-- 회원가입 표지 끝 -->
			<!-- 1 본인 인증, 2 약관동의 및 회원정보 단계 표시 시작-->
			<div class="stepwrap">
				<div class="firstimge">1</div>
				<div class="second"></div>
				<div class="third"> &nbsp;&nbsp;&nbsp; 약관동의 및 회원정보 입력</div>	 
			</div>
			<!-- 1 본인 인증, 2 약관동의 및 회원정보 단계 표시 끝-->
			<!--  회원가입 약관, 필수정보 입력 전체 시작-->
			<form method="post" id="joinfrm" name="joinintrofrm" action="joinok.jsp">
			<div class="jointotal">
				<!-- 회원가입 약관 시작 -->
				<div class="joindostart">
					<div class="joindostarthead"><h2>회원가입 약관</h2></div>
					<div class="joindostarttext">
						Alegert는 체계적인 회원 정보 관리를 위하여 아래와 같이 개인정보를 수집·이용 및 제공하고자 합니다.<br>
						내용을 자세히 읽으신 후 동의 여부를 결정하여 주시기 바랍니다.
					</div>
					<hr class="jointotalline">
					<!-- 구분 체크 박스 바로 위 -->
					<!-- 회원가입 약관 시작 -->
					<!-- 체크박스 시작 -->
					
					<div class="checkbox_group">
					
					<input type="checkbox" id="check_all">
						<label for="check_all">전체동의</label>
						<p class="joindochecktext1">
						아래 동의 항목을 개별 확인 후 각 항목마다 개별적으로 동의하실 수 있습니다.<br>
						전체 동의 시 체크되는 동의 항목에는 선택동의 항목이 포함되어 있습니다.
						</p>
						<hr class="jointotalline2">
						<input type="checkbox" id="check_1" class="normal" name="agreop" value="Y">
						<!-- 개인 정보 수집 및 이용에 대한 동의 시작-->
						<label for="check_1">[필수] 개인정보 수집 및 이용에 대한 동의</label>
							<!-- 개인정보 수집 및 이용에 대한 동의 안에 내용 시작 -->
							<div class="joindochecktexthead1">
								<p class="joindochecktext2">
								Alegert는 아래와 같은 개인정보를 수집 및 이용하고 있습니다.<br>
								개인정보 처리에 대한 상세한 사항은 Alegert 홈페이지의 '개인정보처리방침'을 참조하십시오.
								<br>
								<br>
								본 개인정보 수집 및 이용 동의서의 내용과 상충되는 부분은 본 동의서의 내용이 우선합니다.
								</p>
								<!-- 개인 정보 수집 및 이용에 대한 동의 끝 -->
								<!-- table 시작 -->
								<table border="1" class="table1">
									<tr>
										<th>수집 항목</th>
										<th>수집 목적</th>
										<th>보유 기간</th>
									</tr>
									<tr>
										<td>회원 ID, 비밀번호, 이름, 생년월일, 국적, 성별, 휴대폰 번호</td>
										<td>서비스 이용자 식별 및 본인, 14세 이상 여부 확인</td>
										<td rowspan="3" style="text-decoration: underline;"><b>회원 탈퇴 또는 5년간 이용 실적 없을 시</b></td>
									</tr>
									<tr>
										<td>휴대폰 번호, 이메일 주소</td>
										<td>계약 이행을 위한 연락 및 민원업무 처리 등의 의사소통</td>
									</tr>
									<tr>
										<td>주소</td>
										<td>멤버십 카드발송</td>
									</tr>
								</table>
								<!-- table 끝 -->
								<p class="joindochecktext3"> * 위의 개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으나 동의를 거부하실 경우 회원가입, 멤버십 서비스 이용이 불가합니다.</p>
								<hr>
							</div>
							<!-- 개인정보 수집 및 이용에 대한 동의 안에 내용 끝 -->
							<!-- 마케팅 활용 및 광고성 정보 수신을 위한 개인 정보 이용 동의 -->
							<input type="checkbox" id="check_2" class="normal">
							<label for="check_2">[선택] 마케팅 활용 및 광고성 정보 수신을 위한 개인 정보 이용 동의</label>
							<!-- 마케팅 활용 및 광고성 정보 수신을 위한 개인 정보 이용 동의 안에 내용 시작 -->
							<div class="joindochecktexthead2">
								<p class="joindochecktext2"> Alegert의 회원서비스 관련 정보, 할인상품 및 신상품 안내, 이벤트 및 맞춤 서비스 정보 수신을 위해 개인정보를 수집 및 이용하는 것에 동의 합니다.</p>
								<!-- 체크박스 시작 -->
								<div class="joindocheckbox">
									<input type="checkbox" value="agree1" id="check_3" class="normal">
										<label for="check_3">SMS 수신동의</label>
									<input type="checkbox" value="agree2" id="check_4" class="normal">
										<label for="check_4">E-MAIL 수신동의 </label>
									<input type="checkbox" value="agree3" id="check_5" class="normal">
										<label for="check_5">전화 수신동의 </label>
								</div>
								<!-- 체크박스 끝 -->
								<!-- 두 번째 테이블 시작 -->
								<table border="1" class="table2">
									<tr>
										<th>수집 항목</th>
										<th>수집 목적</th>
										<th>보유 기간</th>
									</tr>
									<tr>
										<td>이메일, 휴대폰번호, 주소</td>
										<td>행사 및 상품정보 안내 / 마케팅 활동</td>
										<td style="text-decoration: underline;"><b>회원탈퇴 또는 5년간 이용실적 없을 시</b></td>
									</tr>
								</table>
								<p class="joindochecktext3">* 위 개인정보 수집·이용에 대한 동의를 거부할 수 있으나 동의 거부 시 할인 및 이벤트 정보 안내 등의 서비스가 제한됩니다.</p>
								<hr>
							</div>
							<!-- 마케팅 활용 및 광고성 정보 수신을 위한 개인 정보 이용 동의 안에 내용 끝 -->
					</div>
					<!-- 체크박스 끝 -->
				</div>
				<!-- 회원가입 약관 끝 -->
					<br>
					<br>
					<!-- 필수정보 입력란 -->
					<div>
						<h2 class="necesse">필수정보 입력</h2>
					</div>
					<!-- 필수정보 입력 시작 -->
					<div class="infodostart">
						<!-- 영문 이름, 한글 이름 커멘트 -->
						<div class="infodovalue1">ENGLISH NAME *</div>
						<div class="infodovalue2">KOREAN NAME *</div>
						<br>
						<!-- 영문 이름, 한글 이름 입력 구간 시작 -->
						<div class="name">
							<input type="text" name="ename" class="ename" placeholder="영문 성명" onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'');" />
							<input type="text" name="kname" class="kname" placeholder="한글 성명" >
						</div>
						<!-- 영문 이름, 한글 이름 입력 구간 끝 -->
							<!-- 생년월일 입력 구간 시작 -->
							<div class="infodovalue3">BIRTH DATE *</div>
							<br>
							<div class="birth">
								<input type="text" name="birth" class="birthtext" placeholder="ex) 1900-01-03">
							</div>
							<!-- 생년월일 입력 구간 끝 -->
							<br>
							<!-- 이메일 입력 구간 시작 -->
							<div class="email">
								<div class="infodovalue4">ID *</div>
								<br>
									<input type="text" name="email" class="emailid" placeholder="ex) ezen@naver.com">
								<!-- 인증 버튼 -->
								<input type="button" class="emailbtn" value="인 증">
							</div>
							<!-- 이메일 입력 구간 끝 -->
							<br>
							<!-- 이메일 !인증! 구간 시작 -->
							<div class="emailcheck">EMAIL CODE *</div>
							<div>
								<input type="email" name="token" class="emailcode" placeholder="이메일 코드를 입력해주세요.">
								<input type="button" class="codebtn" value="확인">
							</div>	
							<!-- 이메일 !인증! 구간 끝 -->
							<br>
							<!-- 비밀번호, 비밀번호 확인 5,6 입력 커멘트 시작 -->
							<div class="infodovalue5">PASSWORD *</div>
							<div class="infodovalue6">CONFIRM PASSWORD *</div>
							<!-- 비밀번호, 비밀번호 확인 입력 커멘트 끝 -->
							<br>
							<!-- 비밀번호, 비밀번호 확인 입력 구간 시작 -->
							<div class="password">
								<input type="password" name="pw" id="pw" placeholder="비밀번호">
								<input type="password" name="pwcheck" id="pwcheck" placeholder="비밀번호 확인">
							</div>
							<!-- 비밀번호, 비밀번호 확인 입력 구간 끝 -->
							<br>
							<!-- 성별  입력 7,8 입력 커멘트 시작 -->
							<div class="infodovalue7">GENDER *</div>
							<div class="infodovalue8">KOREAN/FOREIGNER *</div>
							<br>
							<!-- 성별  입력 7,8 입력 커멘트 끝 -->
							<br>
							<!-- 성별, 내국인/외국인 구간 시작  -->
							<div class="genderstart">
								<!-- 성별 시작  -->
								<div class="gender">
									<input type="radio" id="gender1" name="gender" value="M" checked>
										<label for="gender1">남</label>
									<input type="radio" id="gender2" name="gender" value="F">
										<label for="gender2">여</label>
								</div>
								<!-- 성별 끝-->
								<!-- 내국인 외국인 시작 -->
								<div class="koreanforeigner">
									<input type="radio" id="korean" name="korf" value="K" checked>
										<label for="korean">내국인</label>
									<input type="radio" id="foreigner" name="korf" value="F">
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
									<input type="text" name="number" class="numbertext" placeholder="ex) 010-1234-5678">
										<p style="text-decoration: underline;"></p>
								</div>
								<!-- 번호 입력 input 끝 -->
							</div>
							<br>
							<!-- 회원가입, 취소 버튼 구간 시작 -->
							<div class="joincancelstart">
								<input type=button value="회원가입" class="joinbutton">
								<input type=button value="취소" class="cancelbutton">
							</div>
							<!-- 회원가입, 취소 버튼 구간 끝 -->
					</div>
					<!-- 필수정보 입력 끝 -->
				
				
			</div>
			<!--  회원가입 약관, 필수정보 입력 전체 끝 -->
			</form>
		</div>
		<!-- //.main -->
		</section>
		<%@include file="../include/tail.jsp" %>

		