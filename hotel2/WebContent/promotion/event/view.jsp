<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/eventview.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
String category = request.getParameter("category");
if(category == null) category = "E";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";
String ano = request.getParameter("ano");
if(ano == null){response.sendRedirect("index.jsp"); return;}

AdminDTO dto = new AdminDTO();
//조회수를 증가시킬 필요가 있습니까?
AdminVO vo = dto.read(ano, true);

%>
<script>
	//게시글 삭제구역
	function DoDelete(ano)
	{
		if(confirm("해당 게시물을 삭제하시겠습니까?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?ano=" + ano ,
			dataType: "html",
			success : function(data) 
			{	
				//통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data == "OK")
				{
					alert("게시물이 삭제되었습니다.")
					document.location = "index.jsp?category=<%= vo.getAcategory() %>&page=<%= curPage %>";
				}else
				{
					alert("권한이 없습니다.")
					document.location = "index.jsp?category=<%= vo.getAcategory() %>";
				}
			},
			error : function(xhr, status, error) 
			{
				// 통신 오류 발생시
			}
		});
	}
</script>
<section style="height:auto;">
<div class="main">
	<div class="menubar">
		<h2>프로모션</h2>
		<hr>
		<ul class="menu">
			<li><a href="../event/index.jsp?category=E" style="background-color: white; padding: 0 30px;">이벤트</a></li>
			<li><a href="../review/index.jsp?category=R">리뷰</a></li>
		</ul>
		<!-- //.menu -->
	</div>
	<!-- //.menubar -->
	<div class="contents">
		<h3>이벤트</h3>
		<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 프로모션 &gt; 이벤트</p>
		<hr>
		<div class="view_inner">
			<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
				<tr>
					<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getAtitle() %>
						<hr>
					</td>
				</tr>
				<tr>
					<td id="bwriter" name="bwriter" style="width:700px; height:25px; border:none; outline:none; text-align:right;" readonly="readonly">
						작성자: <%= vo.getName() %> | <%= vo.getAwdate() %>
					</td>
				</tr>
				<tr>
					<td id="bnote" name="bnote" style="width:700px; border:none; outline:none; ">
					<%= vo.getAnote() %>
					</td>
				</tr>
				<tr>
					<!-- 첨부파일 등록 구역 -->
					<td style="height:25px;">
						<%
							if(!vo.getAfname().equals(""))
							{
								%>
								<div style="text-align:center;" >
								<img src="down.jsp?ano=<%= vo.getAno() %>"/>
								<br>
								 첨부 파일 : <a href="down.jsp?ano=<%= vo.getAno() %>"><%= vo.getAfname() %></a>
								</div>
								<%
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
					<input type="submit" value="수정" id="modify" onclick="javascript:location.href='modify.jsp?acategory<%= category %>&ano=<%= vo.getAno() %>&page=<%= page %>'">
					<%
				}
				%>
			</div>
			<!-- //.btn -->
		</div>
		<!-- //.view_inner -->
	</div>
	<!-- //.contents -->
</div>
</section>
<!-- //.main -->
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>