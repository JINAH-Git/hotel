<!-- 
�ۼ���: ������  / �ۼ���: 23.06.30.�� 
�ۼ���: ������ / �ۼ���: 23.07.06.�� 
�ۼ���: ������ / �ۼ���: 23.07.10.�� - jsp��ȯ
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
	alert("���� ������ �����ϴ�.");
	window.location.href="../../index.jsp";
	</script>
	<%
}
//�˻� ����(option), �˻���(search)
String option = request.getParameter("option");
String search = request.getParameter("search");

//�Խù� ��� �޾ƿ���
int curPage = 1;
try
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

//ȸ�� ���� ��� �޾ƿ���
UserDTO dto = new UserDTO();
ArrayList<UserVO> list = dto.list(curPage);
int dataTotal = dto.gettotal();

//�˻��� ��������, �������� ������ list�޾ƿ���
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
<!-- ������ �����ϴ� �κ� -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>������ ������</h2>
			<hr>
			<ul class="menu">
				<li><a href="../userctrl/" style="background-color: white; padding: 0 30px;">ȸ�� ���� ����</a></li>
				<li><a href="../pricectrl/">���� ���� ����</a></li>
				<li><a href="../resvctrl/">���� ���� ��ȸ</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>ȸ�� ���� ����</h3>
			<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; ������ ������ &gt; ȸ�� ���� ����</p>
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
						<td width="200px">�̸���</td>
						<td width="120px">���� �̸�</td>
						<td width="80px">�ѱ� �̸�</td>
						<td width="90px">�������</td>
						<td width="40px">����</td>
						<td width="70px">������<br>��<br>�ܱ���</td>
						<td width="120px">�ڵ��� ��ȣ</td>
						<td width="100px">������</td>
					</tr>
					<%
					if(dataTotal == 0)
					{
						%>
						<tr>
							<td style="text-align:center;height:100px;" colspan="10">��ȸ�� ȸ�� ������ �����ϴ�.</td>
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
						
						//�Ϲ� ����¡,�˻��� ����¡ ���� ���� 2���� ����
						if(option == null || search == null)
						{	if(startBlock > 1)	{ %> <a href="index.jsp?page=<%= startBlock - 1 %>">��</a>	<% }
							for(int i = startBlock; i < endBlock; i++)
							{	if( i == curPage)
								{ %> <span style="background-color:darkgray">
								<a href="index.jsp??page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span><%
								}else
								{ %> <a href="index.jsp?page=<%= i %>"><%= i %></a> <% }
							}
							if(endBlock < totalPage)
							{ %>	<a href="index.jsp?page=<%= endBlock %>">��</a> <% }
						}else
						{	if(startBlock > 1)
							{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= startBlock - 1 %>">����</a> <% }
							for(int i = startBlock; i < endBlock; i++)
							{	if( i == curPage)
								{ %> <span style="background-color:darkgray">
								<a href="index.jsp??option=<%= option %>&search=<%= search %>&page=<%= i %>">&nbsp;<%= i %>&nbsp;</a></span> <%
								}else
								{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= i %>"><%= i %></a> <% }
							}
							if(endBlock < totalPage)
							{ %> <a href="index.jsp?option=<%= option %>&search=<%= search %>&page=<%= endBlock %>">����</a> <% }
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
						<option id="E" class="E" value="E">�̸���</option>
						<option id="N" class="N" value="N">���� �̸�</option>
						<option id="B" class="B" value="B">�������</option>
						<option id="P" class="P" value="P">�ڵ��� ��ȣ</option>
					</select>
					<input type="text" id="search" name="search" placeholder="�˻�� �Է��ϼ���">
					&nbsp;&nbsp;
					<input type="submit" id="searchBtn" name="searchBtn" value="�˻�">
				</form>
				</td>
			</tr>
		</table>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>