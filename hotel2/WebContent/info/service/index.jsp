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
	if(confirm("해당 부분을 삭제하시겠습니까?") == true)
	{
		location.href = "delete.jsp?ano=" + ano;
		return;
	}
}
</script>
<section>
	<div class="main">
		<div class="menubar">
			<h2>호텔 소개</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">오는 길 소개</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">객실 소개</a></li>
				<li><a href="../service/index.jsp?acategory=F" style="background-color: white; padding: 0 30px;">부대 시설</a></li>
				<li><a href="../notice/index.jsp?acategory=N">공지사항</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>부대 시설</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 호텔 소개 &gt; 부대 시설</p>
			<hr>
			<%
			if( login != null && login.getLevel().equals("A") )
			{
				%>
				<input type="button" id="write" value="추가">
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
					<a href="modify.jsp?ano=<%= vo.getAno() %>&acategory=<%= acategory %>">수정</a>
					<a href="javascript:DoDelete(<%= vo.getAno() %>)">삭제</a>
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