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
//�������� �������� ī�װ��� ���� ����
String acategory = request.getParameter("acategory");
if (acategory == null) acategory = "N";

//����¡ó���� ����
int curPage = 1;
try //������ �����͸� �޴´�.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};
//�Խù� ����� ��´�.
AdminDTO dto = new AdminDTO();
System.out.println(acategory);

ArrayList<AdminVO> list = dto.list(acategory, curPage);

//��ü �Խù��� ��ȸ�Ѵ�.
int dataTotal = dto.gettotal(acategory);
%>
<section>
	<div class="main">
		<div class="menubar">
			<h2>ȣ�� �Ұ�</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">���� �� �Ұ�</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">���� �Ұ�</a></li>
				<li><a href="../service/index.jsp?acategory=F">�δ� �ü�</a></li>
				<li><a href="../notice/index.jsp?acategory=N" style="background-color: white; padding: 0 30px;">��������</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>��������</h3>
			<p class="list"><img src="/hotel2/image/home.png"> &gt; ȣ�� �Ұ� &gt; ��������</p>
			<hr>
			<div class="adminBtn">
				<%
				if(login != null && login.getLevel().equals("A"))
				{
					%>
					<a href="write.jsp" style="text-decoration:none; color:black; position:absolute; right:30px;">�۾���</a>
					<%
				}
				%> 
			</div>
			<!-- //.adminBtn -->
			<table id="noticetb" style="width:708px;">
				<tr>
					<th>�Խñ� ��ȣ</th>
					<th>����</th>
					<th>�ۼ���</th>
					<th>�ۼ���</th>
					<th>��ȸ��</th>
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
						<td>������</td>
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
</section>
<%@ include file="../../include/tail.jsp" %>