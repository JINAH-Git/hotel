<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/notice.css" />
<%
//���� ���� �������� ī�װ��� ���� ����
String category = request.getParameter("category");
if (category == null) category = "I";

String rno = request.getParameter("rno");

//����¡ó���� ����
int curPage = 1;
try //������ �����͸� �޴´�.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};
//�Խù� ����� ��´�.
BoardDTO   dto = new BoardDTO();
ReplyDTO reply = new ReplyDTO();
System.out.println(category);

ArrayList<BoardVO> list = dto.list(category, curPage);
ReplyVO rvo = reply.read(rno);

//��ü �Խù��� ��ȸ�Ѵ�.
int dataTotal = dto.gettotal(category);

//���
ReplyDTO replyok = new ReplyDTO();
%>
<style>
	tr
	{
		text-align:center;
	}
	.inquiry_write
	{
		position:absolute;
		right:0;
		top:50px;
		width:650px;
		height:100px;
		margin:85px;
	}
</style>
<!-- ������ �����ϴ� �κ� -->
<script>
	function writerchk(){
		if(!login.getLevel().equals("A") || !vo.getEmail().equals(login.getEmail()))
		{
			alert("����� ó�� �� �ۼ��� �Դϴ�.");
			return;
		}
	}
</script>
<section>
	<div class="main">
		<div class="menubar">
			<h2>���� ����</h2>
			<hr>
			<ul class="menu">
				<li><a href="../question/index.jsp?acategory=Q">���� ���� ����</a></li>
				<li><a href="../inquiry/index.jsp?category=I" style="background-color: white; padding: 0 30px;">���� ����</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>���� ����</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���� ���� &gt; ���� ����</p>
			<hr>
			<div class="adminBtn">
				<%
				if( login != null )
				{
					%>
					<a href="write.jsp" style="float:right;">�۾���</a>
					<%
				}
				%>
			</div>
			<table id="noticetb">
				<tr>
					<th>�Խñ� ��ȣ</th>
					<th>����</th>
					<th>�ۼ���</th>
					<th>�ۼ���</th>
					<th>��ȸ��</th>
				</tr>
				<%
				int SeqNo = dataTotal - ((curPage - 1) * 10);
				for(BoardVO vo : list)
				{
					%>
					<tr>
						<td><%= SeqNo-- %></td>
						<td><a href="view.jsp?category=<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>" onclick="writerchk">
							<%= vo.getBtitle() %>
							<%
							if(vo.getLockop().equals("Y"))
							{
								%>
								<img src="/hotel2/image/lock.png" />
								<%
							}
							if( replyok.rcount(vo.getBno()) == null || replyok.rcount(vo.getBno()).equals("")){}
							else
							{	
								%><span style="color:red;">(�亯 �Ϸ�)</span><%
							}
							%>
							</a>
						</td>
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
			<!-- //.reivew_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!-- ������ ������ �κ� -->
</section>
<%@ include file="../../include/tail.jsp"%>