<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/write.css" />
	</head>
<%@ include file="../../include/head.jsp" %>
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "N";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";

//ano값을 request에서 받는다.
String ano = request.getParameter("ano");

if(ano == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO를 이용해서 게시물 정보를 BoardVO로 받고,
//조회수를 증가시킨다.
AdminDTO dto = new AdminDTO();
AdminVO  vo  = dto.read(ano,true);
%>
<script>
	function DoDelete(ano)
	{
		if(confirm("해당 게시물을 삭제하시겠습니까?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?ano=" + ano,
			dataType: "html",
			success : function(data)
			{	
				//통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data == "OK")
				{
					alert("게시물이 삭제되었습니다.");
					document.location = "index.jsp?acategory=<%= acategory %>";
				}else
				{
					alert("게시물을 삭제할 수 없습니다.");
				}
			},
			error : function(xhr, status, error) 
			{
				// 통신 오류 발생시
			}
		});
	}
</script>
<style>
	.writetbl
	{
		border-color:#66575A;
		border-width:2px 0px 2px 0px;
		border-style:solid;
	}
	.view_inner
	{
		width:700px;
		min-height:600px;
		margin:85px;
	}
	.view_inner hr
	{
		border-color:#EFEFEF;
		width:705px;
		margin-top:0px;
	}
</style>
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
			<h3>공지사항 내용</h3>
			<p class="list"><img src="/hotel2/image/home.png"> &gt; 호텔 소개 &gt; 공지사항 내용</p>
			<hr>
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
							<%= vo.getAtitle() %>
							<hr style="background-color:#EFEFEF;width:705px;">
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none;" readonly="readonly">
							<%= vo.getAnote() %>
						</td>
					</tr>
					<tr>
						<!-- 첨부파일 등록 구역 -->
						<td style="height:25px;">
							<%
								if(!vo.getAfname().equals(""))
								{
									%>첨부파일: <a href="down.jsp?bno=<%= vo.getAno() %>"><%= vo.getAfname() %></a><%
								}else
								{
								}
							%>
						</td>
					</tr>
				</table>
				<div class="btn">
					<input type="button" value="목록" id="cancel" onclick="javascript:location.href='index.jsp'">
					<%
					if( login != null && login.getLevel().equals("A") || login != null && vo.getEmail().equals(login.getEmail()) )
					{
						%>
						<input type="submit" value="삭제" id="delete" onclick="javascript:DoDelete('<%= ano %>');">
						<input type="submit" value="수정" id="modify" onclick="javascript:location.href='modify.jsp?acategory<%= acategory %>&ano=<%= vo.getAno() %>&page=<%= page %>'">
						<%
					}
					%>
				</div>
				<!-- //.btn -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
</html>