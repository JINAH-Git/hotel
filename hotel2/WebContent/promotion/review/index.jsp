<!-- 
23-07-10 성재 | jsp 작성함.
23-07-11 성재 | jsp 추가 작성함.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/notice.css" />
<%@include file="../../include/head.jsp" %>
<%
//리뷰 페이지의 카테고리 값을 받음
String category = request.getParameter("category");
if (category == null) category = "R";

//페이징처리용 변수
int curPage = 1;
try //페이지 데이터를 받는다.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};
//게시물 목록을 얻는다.
BoardDTO dto = new BoardDTO();

ArrayList<BoardVO> list = dto.list(category, curPage);

//전체 게시물을 조회한다.
int dataTotal = dto.gettotal(category);
BoardVO notice = dto.noticeread(category);
%>
<style>
	tr
	{
		text-align:center;
	}
	.review_write
	{
		position:absolute;
		right:0;
		top:50px;
		width:650px;
		height:100px;
		margin:85px;
	}
	.paging
	{
		text-align:center;
		margin-top:20px;
	}
</style>
<!-- //.head -->
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>프로모션</h2>
			<hr>
			<ul class="menu">
				<li><a href="../event/index.jsp?acategory=E">이벤트</a></li>
				<li><a href="../review/index.jsp?category=R" style="background-color: white; padding: 0 30px;">리뷰</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>리뷰</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 프로모션 &gt; 리뷰</p>
			<hr>
			<div class="adminBtn">
				<%
				//테스트 시작할 때 주석 삭제하기
				if( login != null )
				{
					%>
					<a href="write.jsp" style="float:right;">글쓰기</a>
					<%
				}
				%>
			</div>
			<!-- //.event_write -->
			<table id="noticetb">
				<tr>
					<th>게시글 번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
				<% 
				if( notice == null || notice.equals(""))
				{
					%>
					<tr>
						<td style="font-weight:bolder;">공지</td>
						<td>등록된 공지사항이 없습니다.</td>
						<td>관리자</td>
						<td>0000-00-00</td>
						<td>0</td>
					</tr>
					<%
				}else
				{
					%>
					<tr>
						<td style="font-weight:bolder;">공지</td>
						<td><a href="view.jsp?category=<%= category %>&bno=<%= notice.getBno() %>"><%= notice.getBtitle() %></a></td>
						<td><%= notice.getName() %></td>
						<td><%= notice.getBwdate() %></td>
						<td><%= notice.getBhit() %></td>
					</tr>
					<%
				}			
				int SeqNo = (dataTotal - ((curPage - 1) * 10)) - dto.getnotice();
				for(BoardVO vo : list)
				{
					%>
					<tr>
						<td><%= SeqNo-- %></td>
						<td><a href="view.jsp?category=<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>"><%= vo.getBtitle() %></a></td>
						<td><%= vo.getBwriter() %></td>
						<td><%= vo.getBwdate() %></td>
						<td><%= vo.getBhit() %></td>
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
	<!--  컨텐츠 끝나는 부분 -->
</section>
<%@ include file="../../include/tail.jsp"%>