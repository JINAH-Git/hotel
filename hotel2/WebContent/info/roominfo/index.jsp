<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "T";
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/room.css" />	
	</head>
	<style>
		.pop_inner
		{
			border: 3px solid brown;
			width: 850px;
			height: 600px;
			overflow-x: hidden;
			overflow-y: scroll;
			position: absolute;
			top: 0;
			z-index: 100;
			background: #fff;
		}
		
		.rkind
		{
			font-size: 24px;
			font-weight: bold;
			color: brown;
			padding: 0 0 0 20px;
			width: 200px;
		}
		
		.btn_close
		{
			position: absolute;
			top: 16px;
			right: 0;
			padding: 5px 10px 0 0;
			font-size: 24px;
			cursor: pointer;
		}
		
		.pop_inner hr
		{
			height: 2px;
			background: brown;
		}
		
	</style>
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
				<li><a href="../roominfo/index.jsp?acategory=T" style="background-color: white; padding: 0 30px;">객실 소개</a></li>
				<li><a href="../service/index.jsp?acategory=F">부대 시설</a></li>
				<li><a href="../notice/index.jsp?acategory=N">공지사항</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>객실 소개</h3>
			<p class="list"><img src="/hotel/image/home.png" width="20px;" height="20px;"> &gt; 호텔 소개 &gt; 객실 소개</p>
			<hr>
			<div style="height: 30px;">
			<%
			if(login != null && login.getLevel().equals("A") )
			{
				%>
				<input type="button" id="write" value="추가">
				<%
			}
			%>
			</div>
				<div class="room">
				<%
				AdminDTO dto = new AdminDTO();
				ArrayList<AdminVO> list = dto.list(acategory);
				for(int i = 0; i < list.size(); i++)
				{
					%>
						<div class="btn_open" name="#pop_info_<%= i + 1 %>" style="background-image:url('/hotel2/aupload/<%= list.get(i).getApname() %>'); background-repeat : no-repeat; background-size : cover;"><%= list.get(i).getAtitle() %></div>
					<%
				}
				%>
				<%
				for(int i = 0; i < list.size(); i++)
				{
					%>
					<!-- 팝업<%= i + 1 %> -->
					<div id="pop_info_<%= i + 1 %>" class="pop_wrap" style="display:none;">
					  	<div class="pop_inner">
						    <p class="rkind"><%= list.get(i).getAtitle() %></p>
						    <div class="adminBtn">
								<%
					    		if( login != null && login.getLevel().equals("A") )
					    		{
					    			%>
					    			<a href="javascript:DoDelete(<%= list.get(i).getAno() %>)" id="delete">삭제</a>
					    			<a href="modify.jsp?ano=<%= list.get(i).getAno() %>&acategory=<%= acategory %>" id="modify">수정</a>
					    			<%
					    		}
					    		%>
							</div>
						    <a class="btn_close">&#10007;</a>
						    <hr>
						    <img src="/hotel2/aupload/<%= list.get(i).getApname() %>" width="600px" height="300px;">
						    <p><%= list.get(i).getAnote() %></p>
					  	</div>
					</div>
					<%
				}
				%>	
			</div>
			<!-- //.room -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
<script src="../../js/room.js"></script>