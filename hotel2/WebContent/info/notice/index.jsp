<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/notice.css" />	
	</head>
<%@ include file="../../include/head.jsp" %>
<%
//공지사항 페이지의 카테고리 값을 받음
String acategory = request.getParameter("acategory");
if (acategory == null) acategory = "N";

//페이징처리용 변수
int curPage = 1;
try //페이지 데이터를 받는다.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};
//게시물 목록을 얻는다.
AdminDTO dto = new AdminDTO();
System.out.println(acategory);

ArrayList<AdminVO> list = dto.list(acategory, curPage);

//전체 게시물을 조회한다.
int dataTotal = dto.gettotal(acategory);
%>
<section>
	<div class="main">
		<div class="menubar">
			<h2>호텔 소개</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">오는 길 소개</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">객실 소개</a></li>
				<li><a href="../service/index.jsp?acategory=F">부대 시설</a></li>
				<li><a href="../notice/index.jsp?acategory=N" style="background-color: white; padding: 0 30px;">공지사항</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>공지사항</h3>
			<p class="list"><img src="/hotel2/image/home.png"> &gt; 호텔 소개 &gt; 공지사항</p>
			<hr>
			<div class="adminBtn">
				<%
				if(login != null && login.getLevel().equals("A"))
				{
					%>
					<a href="write.jsp" style="text-decoration:none; color:black; position:absolute; right:30px;">글쓰기</a>
					<%
				}
				%> 
			</div>
			<!-- //.adminBtn -->
			<table id="noticetb" style="width:708px;">
				<tr>
					<th>게시글 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<%
				int SeqNo = dataTotal - ((curPage - 1) * 10);
				for( AdminVO vo : list )
				{
					%>
					<tr>
						<td><%= SeqNo-- %></td>
						<td style="height:32px; width:300px; text-overflow:ellipsis; overflow:hidden; white-space:nowrap; display:block; font-size:17px;">
							<a href="view.jsp?acategory=<%= acategory %>&ano=<%= vo.getAno() %>&page=<%= page %>"><%= vo.getAtitle() %></a>
						</td>
						<td>관리자</td>
						<td><%= vo.getAwdate() %></td>
						<td><%= vo.getAhit() %></td>
					</tr>
					<%
				}
				%>
			</table>
			<div class="paging">
			<%
			int totalPage = (dataTotal / 10);
			if(dataTotal % 10 != 0) totalPage++;
			int startBlock = curPage - (curPage % 5) + 1;
			if(curPage % 5 == 0) { startBlock = (curPage - 1) - ((curPage - 1) % 5) + 1; }
			int endBlock = startBlock + 5; 
			if(endBlock >= totalPage) endBlock = totalPage + 1;
			
			//페이징 부분
			if(startBlock > 1)	{ %> <a href="index.jsp?page=<%= startBlock - 1 %>">◀</a>	<% }
			for(int i = startBlock; i < endBlock; i++)
			{	if( i == curPage)
				{ %> <span style="background-color:darkgray">
				<a href="index.jsp?page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span><%
				}else
				{ %> <a href="index.jsp?page=<%= i %>"><%= i %></a> <% }
			}
			if(endBlock < totalPage)
			{ %>	<a href="index.jsp?page=<%= endBlock %>">▶</a> <% }
			%>
			</div>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>