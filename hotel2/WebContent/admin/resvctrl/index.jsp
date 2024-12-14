<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="../../include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/admresv.css" />
<script src="/hotel2/js/jquery-3.7.0.js"></script>
<%
if(login == null || login.getLevel() == null || login.getLevel().equals("U"))
{
	%>
	<script>
	alert("접근 권한이 없습니다.");
	window.location.href="../../index.jsp";
	</script>
	<%
}

ReserDTO dto = new ReserDTO();
//Date now = new Date();//오늘 날짜 가져오기?

//객실 타입에 따라서 예약정보 가져오기 		
ArrayList<ReserVO> list1 = dto.list("S");
ArrayList<ReserVO> list2 = dto.list("D");
ArrayList<ReserVO> list3 = dto.list("F");
ArrayList<ReserVO> list4 = dto.list("ST");

//날짜 비교 하기 위함
LocalDate now = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
int today = Integer.parseInt(now.format(formatter));
%>
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<!-- 컨텐츠 시작하는 부분 -->
	<script>
	//객실 타입 탭
	$(function(){
		$('.cont_area > div').hide();
		$('.list2 a').click(function () {
			$('.cont_area > div').hide().filter(this.hash).fadeIn();
			$('.list2 a').removeClass('active');
			$(this).addClass('active');
			return false;
		}).filter(':eq(0)').click();
	});
	</script>
	<div class="main">
		<div class="menubar">
			<h2>관리자 페이지</h2>
			<hr>
			<ul class="menu">
				<li><a href="../userctrl/">회원 정보 관리</a></li>
				<li><a href="../pricectrl/">객실 가격 관리</a></li>
				<li><a href="../resvctrl/" style="background-color: white;  padding: 0 30px;">객실 예약 조회</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>객실 예약 조회</h3>
			<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; 관리자 페이지 &gt; 객실 예약 조회</p>
			<br>
			<hr>
			<div class="tab_menu">
				<ul class="list2">
					<li><a href="#tab1"> 스탠다드 </a></li>
					<li><a href="#tab2"> 더블 </a></li>
					<li><a href="#tab3"> 패밀리 </a></li>
					<li><a href="#tab4"> 스위트 </a></li>
				</ul>
			<!-- 정보 -->
				<div class="cont_area" style="overflow-x:hidden;">
					<div id="tab1">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">객실<br>타입</td>
								<td width="50px">예약<br>번호</td>
								<td width="100px">예약자 성명</td>
								<td width="90px">체크인<br>날짜</td>
								<td width="90px">체크아웃<br>날짜</td>
								<td width="100px">투숙 인원</td>
								<td width="90px">예약 일자</td>
								<td width="80px">총 <br> 예약 금액</td>
								<td width="130px">요청사항</td>
							</tr>
							<%
							if(list1.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">스탠다드 룸에 조회된 예약 내역이 없습니다.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list1)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">스탠다드 룸</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>성인 <%= vo.getAdcnt() %>명 <br> 어린이 <%= vo.getChcnt() %>명<br> 어린이 <%= vo.getKidcnt() %>명</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "요청사항 없음" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}
							%>
					</table>
					</div>
					<div id="tab2">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">객실<br>타입</td>
								<td width="50px">예약<br>번호</td>
								<td width="100px">예약자 성명</td>
								<td width="90px">체크인<br>날짜</td>
								<td width="90px">체크아웃<br>날짜</td>
								<td width="100px">투숙 인원</td>
								<td width="90px">예약 일자</td>
								<td width="80px">총 <br> 예약 금액</td>
								<td width="130px">요청사항</td>
							</tr>
							<%
							if(list2.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">더블 룸에 조회된 예약 내역이 없습니다.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list2)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">더블 룸</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>성인 <%= vo.getAdcnt() %>명 <br> 어린이 <%= vo.getChcnt() %>명<br> 어린이 <%= vo.getKidcnt() %>명</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "요청사항 없음" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}

							%>
						</table>
					</div>
					<div id="tab3">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">객실<br>타입</td>
								<td width="50px">예약<br>번호</td>
								<td width="100px">예약자 성명</td>
								<td width="90px">체크인<br>날짜</td>
								<td width="90px">체크아웃<br>날짜</td>
								<td width="100px">투숙 인원</td>
								<td width="90px">예약 일자</td>
								<td width="80px">총 <br> 예약 금액</td>
								<td width="130px">요청사항</td>
							</tr>
							<%
							if(list3.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">패밀리 룸에 조회된 예약 내역이 없습니다.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list3)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">패밀리 룸</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>성인 <%= vo.getAdcnt() %>명 <br> 어린이 <%= vo.getChcnt() %>명<br> 어린이 <%= vo.getKidcnt() %>명</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "요청사항 없음" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}

							%>
						</table>
					</div>
					<div id="tab4">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">객실<br>타입</td>
								<td width="50px">예약<br>번호</td>
								<td width="100px">예약자 성명</td>
								<td width="90px">체크인<br>날짜</td>
								<td width="90px">체크아웃<br>날짜</td>
								<td width="100px">투숙 인원</td>
								<td width="90px">예약 일자</td>
								<td width="80px">총 <br> 예약 금액</td>
								<td width="130px">요청사항</td>
							</tr>
							<%
							if(list4.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">스위트 룸에 조회된 예약 내역이 없습니다.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list4)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">스위트 룸</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>성인 <%= vo.getAdcnt() %>명 <br> 어린이 <%= vo.getChcnt() %>명<br> 어린이 <%= vo.getKidcnt() %>명</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "요청사항 없음" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>