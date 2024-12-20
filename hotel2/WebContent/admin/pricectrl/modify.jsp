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
//기존 가격 가져오기
RoomctrDTO dto = new RoomctrDTO();
RoomctrVO vo = new RoomctrVO();

//스탠다드룸 가격
vo = dto.priceread("S"); 
int stdadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int stdchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//더블룸 가격
vo = dto.priceread("D"); 
int dbadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int dbchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//패밀리룸 가격
vo = dto.priceread("F"); 
int famadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int famchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//스위트룸 가격
vo = dto.priceread("ST"); 
int suitadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int suitchpri = Integer.parseInt(vo.getChprice().replace(",", ""));
%>
<!-- 컨텐츠 시작하는 부분 -->
<script>
	function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
	}
	
	window.onload = function()
	{
		$("#stdadpri").focus();
			
		$("#btnSubmit").click(function(){
			//모든 가격이 정해졌는지 확인한다.
			if($("#stdadpri").val() == "")	{	alert("스탠다드 룸의 성인 가격을 설정해 주세요.");		$("#stdadpri").focus();		return;	}
			if($("#stdchpri").val() == "")	{	alert("스탠다드 룸의 어린이 가격을 설정해 주세요");		$("#stdchpri").focus();		return;	}
			if($("#dbadpri").val() == "")	{	alert("더블 룸의 성인 가격을 설정해 주세요");			$("#dbadpri").focus();		return;	}
			if($("#dbchpri").val() == "")	{	alert("더블 룸의 어린이 가격을 설정해 주세요");		$("#dbchpri").focus();		return;	}
			if($("#famadpri").val() == "")	{	alert("패밀리 룸의 성인 가격을 설정해 주세요");		$("#famadpri").focus();		return;	}
			if($("#famchpri").val() == "")	{	alert("패밀리 룸의 어린이 가격을 설정해 주세요");		$("#famchpri").focus();		return;	}
			if($("#suitadpri").val() == "")	{	alert("스위트 룸의 성인 가격을 설정해 주세요");		$("#suitadpri").focus();	return;	}
			if($("#suitchpri").val() == "")	{	alert("스위트 룸의 어린이 가격을 설정해 주세요");		$("#suitchpri").focus();	return;	}
			
			if(confirm("수정된 가격을 적용하시겠습니까?") == false)	return;	
			
			$("#priceFrm").submit();
		});
		
		$("#btnCancel").click(function(){
			if(confirm("가격 수정을 취소하시겠습니까?") == false) return;
			document.location = "index.jsp";
		});
	}
</script>
<section>
<div class="main">
	<div class="menubar">
		<h2>관리자 페이지</h2>
		<hr>
		<ul class="menu">
			<li><a href="../userctrl/">회원 정보 관리</a></li>
			<li><a href="../pricectrl/" style="background-color: whitew; padding: 0 30px;">객실 가격 관리</a></li>
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
	<form id="priceFrm" name="priceFrm" method="post" action="modifyok.jsp">		
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
						<td><input type="text" id="stdadpri" name="stdadpri" maxlength="9" value="<%= stdadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="stdchpri" name="stdchpri" maxlength="9" value="<%= stdchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="D">더블</td>
						<td><input type="text" id="dbadpri" name="dbadpri" maxlength="9" value="<%= dbadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="dbchpri" name="dbchpri" maxlength="9" value="<%= dbchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="F">패밀리</td>
						<td><input type="text" id="famadpri" name="famadpri" maxlength="9" value="<%= famadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="famchpri" name="famchpri" maxlength="9" value="<%= famchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="ST">스위트</td>
						<td><input type="text" id="suitadpri" name="suitadpri" maxlength="9" value="<%= suitadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="suitchpri" name="suitchpri" maxlength="9" value="<%= suitchpri  %>" onKeyup="onlyNumber(this)"></td>	
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="text-align:center;">
				<br>
				※성수기 : 1월, 2월, 7월, 8월, 9월, 12월
				<br> 
				※비성수기 : 3월, 4월, 5월, 6월, 10월, 11월
				<br>
				※가격은 10억원 미만까지 설정 가능합니다.
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td>
			<input type="button" id="btnSubmit" value="저장">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btnCancel" value="취소">
			</td>
		</tr>
	</table>
	</form>
	</div>
	<!-- //.contents -->
</div>
<!-- //.main -->
</section>
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>