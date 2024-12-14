<!-- 
23-07-10 ���� | jsp �ۼ���.
23-07-11 ���� | jsp �߰� �ۼ���.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/notice.css" />
<%@include file="../../include/head.jsp" %>
<%
//���� �������� ī�װ��� ���� ����
String category = request.getParameter("category");
if (category == null) category = "R";

//����¡ó���� ����
int curPage = 1;
try //������ �����͸� �޴´�.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};
//�Խù� ����� ��´�.
BoardDTO dto = new BoardDTO();

ArrayList<BoardVO> list = dto.list(category, curPage);

//��ü �Խù��� ��ȸ�Ѵ�.
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
<!-- ������ �����ϴ� �κ� -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>���θ��</h2>
			<hr>
			<ul class="menu">
				<li><a href="../event/index.jsp?acategory=E">�̺�Ʈ</a></li>
				<li><a href="../review/index.jsp?category=R" style="background-color: white; padding: 0 30px;">����</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>����</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���θ�� &gt; ����</p>
			<hr>
			<div class="adminBtn">
				<%
				//�׽�Ʈ ������ �� �ּ� �����ϱ�
				if( login != null )
				{
					%>
					<a href="write.jsp" style="float:right;">�۾���</a>
					<%
				}
				%>
			</div>
			<!-- //.event_write -->
			<table id="noticetb">
				<tr>
					<th>�Խñ� ��ȣ</th>
					<th>����</th>
					<th>�ۼ���</th>
					<th>�ۼ���</th>
					<th>��ȸ��</th>
				</tr>
				<% 
				if( notice == null || notice.equals(""))
				{
					%>
					<tr>
						<td style="font-weight:bolder;">����</td>
						<td>��ϵ� ���������� �����ϴ�.</td>
						<td>������</td>
						<td>0000-00-00</td>
						<td>0</td>
					</tr>
					<%
				}else
				{
					%>
					<tr>
						<td style="font-weight:bolder;">����</td>
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
			
			//����¡ �κ�
			if(startBlock > 1)	{ %> <a href="index.jsp?page=<%= startBlock - 1 %>">��</a>	<% }
			for(int i = startBlock; i < endBlock; i++)
			{	if( i == curPage)
				{ %> <span style="background-color:darkgray">
				<a href="index.jsp?page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span><%
				}else
				{ %> <a href="index.jsp?page=<%= i %>"><%= i %></a> <% }
			}
			if(endBlock < totalPage)
			{ %>	<a href="index.jsp?page=<%= endBlock %>">��</a> <% }
			%>
			</div>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  ������ ������ �κ� -->
</section>
<%@ include file="../../include/tail.jsp"%>