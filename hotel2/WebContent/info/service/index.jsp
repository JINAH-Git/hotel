<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "F";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/service.css" />	
	</head>
<%@ include file="../../include/head.jsp" %>
<script>
window.addEventListener('load',function()
{
	$("#write").click(function(){
		location.href = "write.jsp?acategory=<%= acategory %>";
		return;
	})
});

function DoDelete(ano)
{
	if(confirm("�ش� �κ��� �����Ͻðڽ��ϱ�?") == true)
	{
		location.href = "delete.jsp?ano=" + ano;
		return;
	}
}
</script>
<section>
	<div class="main">
		<div class="menubar">
			<h2>ȣ�� �Ұ�</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">���� �� �Ұ�</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">���� �Ұ�</a></li>
				<li><a href="../service/index.jsp?acategory=F" style="background-color: white; padding: 0 30px;">�δ� �ü�</a></li>
				<li><a href="../notice/index.jsp?acategory=N">��������</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>�δ� �ü�</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ȣ�� �Ұ� &gt; �δ� �ü�</p>
			<hr>
			<%
			if( login != null && login.getLevel().equals("A") )
			{
				%>
				<input type="button" id="write" value="�߰�">
				<%
			}
			%>
			<div class="service">
			<%
			AdminDTO dto = new AdminDTO();
			ArrayList<AdminVO> list = dto.list(acategory);
			for(AdminVO vo : list)
			{
				%>
				<h4>&nbsp;&nbsp;&nbsp;<%= vo.getAtitle() %></h4>
				<div class="img" style="background-image: url('/hotel2/aupload/<%= vo.getApname() %>'); background-repeat : no-repeat; background-size : cover;"></div>
				<div class="info"><%= vo.getAnote() %></div>
				<div class="adminBtn" style="height: 20px;">
				<%
				if(login != null && login.getLevel().equals("A") )
				{
					%>
					<a href="modify.jsp?ano=<%= vo.getAno() %>&acategory=<%= acategory %>">����</a>
					<a href="javascript:DoDelete(<%= vo.getAno() %>)">����</a>
					<%
				}
				%>
				</div>
				<!-- //.adminBtn -->
				<%
			}
			%>
			</div>
			<!-- //.service -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
</html>