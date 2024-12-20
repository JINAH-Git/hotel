<!-- 
작성자: 유수민  / 작성일: 23.06.30.금 
작성자: 유수민 / 작성일: 23.07.06.목 
작성자: 유수민 / 작성일: 23.07.10.월 - jsp변환
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>   
<%@ include file="../../include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/admuser.css" />
<%@ page import="java.util.*" %>
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
//검색 조건(option), 검색어(search)
String option = request.getParameter("option");
String search = request.getParameter("search");

//게시물 목록 받아오기
int curPage = 1;
try
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

//회원 정보 목록 받아오기
UserDTO dto = new UserDTO();
ArrayList<UserVO> list = dto.list(curPage);
int dataTotal = dto.gettotal();

//검색을 안했을때, 했을때로 나눠서 list받아오기
if(option == null || search == null)
{
	list = dto.list(curPage);
	dataTotal = dto.gettotal();
}else
{
	list = dto.list(curPage, option,search);
	dataTotal = dto.gettotal(option,search);
}
%>
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>관리자 페이지</h2>
			<hr>
			<ul class="menu">
				<li><a href="../userctrl/" style="background-color: white; padding: 0 30px;">회원 정보 관리</a></li>
				<li><a href="../pricectrl/">객실 가격 관리</a></li>
				<li><a href="../resvctrl/">객실 예약 조회</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>회원 정보 관리</h3>
			<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; 관리자 페이지 &gt; 회원 정보 관리</p>
			<br>
			<hr>
		<table border="0">
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td>
				<table id="usertable" border="1">
					<tr style="background-color:#e4e4e4; font-weight:bold;">
						<td width="200px">이메일</td>
						<td width="120px">영문 이름</td>
						<td width="80px">한글 이름</td>
						<td width="90px">생년월일</td>
						<td width="40px">성별</td>
						<td width="70px">내국인<br>º<br>외국인</td>
						<td width="120px">핸드폰 번호</td>
						<td width="100px">가입일</td>
					</tr>
					<%
					if(dataTotal == 0)
					{
						%>
						<tr>
							<td style="text-align:center;height:100px;" colspan="10">조회된 회원 정보가 없습니다.</td>
						</tr>
						<%
					}
					for(UserVO vo : list)
					{
						%>
						<tr style="height:45px;">
							<td><%= vo.getEmail() %></td>
							<td><%= vo.getEname() %></td>
							<td><%= vo.getKname() %></td>
							<td><%= vo.getBirth() %></td>
							<td><%= vo.getGender() %></td>
							<td><%= vo.getKorf() %></td>
							<td><%= vo.getNumber() %></td>
							<td><%= vo.getJoindate() %></td>
						</tr>
						<%
					}
					%>
				</table>
				</td>
			</tr>
			<tr>
				<td><br></td>
			</tr>
			<tr>
				<td>
					<%
						int totalPage = (dataTotal / 10);
						if(dataTotal % 10 != 0) totalPage++;
						int startBlock = curPage - (curPage % 5) + 1;
						if(curPage % 5 == 0) {	startBlock = (curPage - 1) - ((curPage - 1) % 5) + 1;	}
						int endBlock = startBlock + 5; 
						if(endBlock >= totalPage) endBlock = totalPage + 1;
						
						//일반 페이징,검색시 페이징 구현 로직 2개로 나눔
						if(option == null || search == null)
						{	if(startBlock > 1)	{ %> <a href="index.jsp?page=<%= startBlock - 1 %>">◀</a>	<% }
							for(int i = startBlock; i < endBlock; i++)
							{	if( i == curPage)
								{ %> <span style="background-color:darkgray">
								<a href="index.jsp??page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span><%
								}else
								{ %> <a href="index.jsp?page=<%= i %>"><%= i %></a> <% }
							}
							if(endBlock < totalPage)
							{ %>	<a href="index.jsp?page=<%= endBlock %>">▶</a> <% }
						}else
						{	if(startBlock > 1)
							{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= startBlock - 1 %>">이전</a> <% }
							for(int i = startBlock; i < endBlock; i++)
							{	if( i == curPage)
								{ %> <span style="background-color:darkgray">
								<a href="index.jsp??option=<%= option %>&search=<%= search %>&page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span> <%
								}else
								{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= i %>"><%= i %></a> <% }
							}
							if(endBlock < totalPage)
							{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= endBlock %>">다음</a> <% }
						}
					%>
				</td>
			</tr>
			<tr>
				<td><br></td>
			</tr>	
			<tr>
				<td>
				<form id="searchFrm" name="searhFrm" method="get" action="searchok.jsp">
					<select id="items" name="items">
						<option id="E" class="E" value="E">이메일</option>
						<option id="N" class="N" value="N">영문 이름</option>
						<option id="B" class="B" value="B">생년월일</option>
						<option id="P" class="P" value="P">핸드폰 번호</option>
					</select>
					<input type="text" id="search" name="search" placeholder="검색어를 입력하세요">
					&nbsp;&nbsp;
					<input type="submit" id="searchBtn" name="searchBtn" value="검색">
				</form>
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