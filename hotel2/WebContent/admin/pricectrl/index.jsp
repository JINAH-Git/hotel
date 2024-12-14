<!-- 
작성자: 유수민
작성일: 23.06.30.금 
작성일: 23.07.06.목
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>   
<%@ include file="../../include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/adprice.css" />
<script src="./js/jquery-3.7.0.js"></script>
<%
if(login.getLevel() == null || login.getLevel().equals("U"))
{
	%>
	<script>
	alert("접근 권한이 없습니다.");
	window.location.href="../../index.jsp";
	</script>
	<%
}
//관리자가 아닐 경우에는 메인 페이지로 이동 
//login변수는 사실 session에 저장된대로 바꿔줘야함
//진아가 변수 정의,사용할때까지는 기다려야함

RoomctrDTO dto = new RoomctrDTO();
RoomctrVO vo = new RoomctrVO();

//스탠다드룸 가격
vo = dto.priceread("S"); 
String stdadpri = vo.getAdprice();
String stdchpri = vo.getChprice();

//더블룸 가격
vo = dto.priceread("D"); 
String dbadpri = vo.getAdprice();
String dbchpri = vo.getChprice();

//패밀리룸 가격
vo = dto.priceread("F"); 
String famadpri = vo.getAdprice();
String famchpri = vo.getChprice();

//스위트룸 가격
vo = dto.priceread("ST"); 
String suitadpri = vo.getAdprice();
String suitchpri = vo.getChprice();
%>
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>관리자 페이지</h2>
			<hr>
			<ul class="menu">
				<li><a href="../userctrl/">회원 정보 관리</a></li>
				<li><a href="../pricectrl/" style="background-color: white; padding: 0 30px;">객실 가격 관리</a></li>
				<li><a href="../resvctrl/">객실 예약 조회</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>객실 가격 관리</h3>
			<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; 관리자 페이지 &gt; 객실 가격 관리</p>
			<br>
			<hr>
		<table border="0">
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td>
				<table border="1" id="pricetable">
					<tr class="T">
						<td style="width:100px">객실</td>
						<td style="width:350px">객실 성인 가격</td>
						<td style="width:350px">객실 어린이 가격</td>
					</tr>
					<tr>
						<td	class="S">스탠다드</td>
						<td><%= stdadpri  %>&nbsp;KRW</td>
						<td><%= stdchpri  %>&nbsp;KRW</td>
					</tr>
					<tr>
						<td class="D">더블</td>
						<td><%= dbadpri %>&nbsp;KRW</td>
						<td><%= dbchpri %>&nbsp;KRW</td>
					</tr>
					<tr>
						<td class="F">패밀리</td>
						<td><%= famadpri %>&nbsp;KRW</td>
						<td><%= famchpri %>&nbsp;KRW</td>
					</tr>
					<tr>
						<td class="ST">스위트</td>
						<td><%= suitadpri  %>&nbsp;KRW</td>
						<td><%= suitchpri  %>&nbsp;KRW</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td>
				<a href="modify.jsp"><input type="button" value="수정"></a>
				</td>
			</tr>
		</table>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>