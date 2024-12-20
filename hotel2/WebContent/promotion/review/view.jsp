<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
String category = request.getParameter("category");
if(category == null) category = "R";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";

//bno값을 request에서 받는다.
String bno = request.getParameter("bno");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO를 이용해서 게시물 정보를 BoardVO로 받고,
//조회수를 증가시킨다.
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.read(bno,true);
%>
<script>
	function DoDelete(bno)
	{
		if(confirm("해당 게시물을 삭제하시겠습니까?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?bno=" + bno,
			dataType: "html",
			success : function(data)
			{	
				//통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data == "OK")
				{
					alert("게시물이 삭제되었습니다.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
				}else
				{
					alert("권한이 없습니다.");
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
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
	.view_inner
	{
		width:700px;
		min-height:600px;
		margin:85px;
	}
	.list_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.modify_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.delete_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.btn_area
	{
		position:relative;
		top:30px;
	}
	.writetbl
	{
		border-color:#66575A;
		border-width:2px 0px 2px 0px;
		border-style:solid;
	}
	.writetbl hr
	{
		background-color:#EFEFEF;
		width:705px;
		margin-top:0px;
	}
</style>
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>프로모션</h2>
			<hr>
			<ul class="menu">
				<li><a href="../event/index.jsp?category=E">이벤트</a></li>
				<li><a href="../review/index.jsp?category=R" style="background-color: white; padding: 0 30px;">리뷰</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>리뷰</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 프로모션 &gt; 리뷰</p>
			<hr>
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getBtitle() %>
						<hr>
						</td>
					</tr>
					<tr>
						<td id="bwriter" name="bwriter" style="width:700px; height:25px; text-align:right; border:none; outline:none;" readonly="readonly">
							작성자: <%= vo.getName() %> | <%= vo.getBwdate() %>
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getBnote() %>
						</td>
					</tr>
					<tr>
						<td style="height:25px;">
							<%
								if(!vo.getBfname().equals(""))
								{
									%>첨부파일: <a href="down.jsp?bno=<%= vo.getBno() %>"><%= vo.getBfname() %></a><%
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
						<input type="submit" value="삭제" id="delete" onclick="javascript:DoDelete('<%= bno %>');">
						<input type="submit" value="수정" id="modify" onclick="javascript:location.href='modify.jsp?category<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>'">
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
	<!-- //.main -->
</section>
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>