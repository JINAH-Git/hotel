<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
//카테고리 값과 현재 페이지 값을 받는다. 
String category = request.getParameter("category");
if(category == null) category = "I";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";


//bno값을 받는다.
String bno = request.getParameter("bno");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO를 이용해서 게시물 정보를 BoardVO로 받고,
//조회수를 증가시킨다.
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.read(bno,false);


if(login == null)
{
	if(vo.getLockop().equals("Y"))
	{
		vo = dto.read(bno,false);
		response.sendRedirect("index.jsp");
		return;
	}else
	{
		vo = dto.read(bno,true);
	}
}else
{
	if(vo.getLockop().equals("Y"))
	{
		if(login.getLevel().equals("A") || vo.getEmail().equals(login.getEmail()))
		{
			vo = dto.read(bno,true);
		}else
		{
			vo = dto.read(bno,false);
			response.sendRedirect("index.jsp");
			return;
		}
	}else
	{
		vo = dto.read(bno,true);
	}
}
%>
<script>

	window.onload = function(){
		$("#rnote").focus();
	}
	
	//게시글 삭제구역
	function DoDelete(bno)
	{
		if(confirm("해당 게시물을 삭제하시겠습니까?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?bno=" + bno ,
			dataType: "html",
			success : function(data) 
			{	
				//통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data == "OK")
				{
					alert("게시물이 삭제되었습니다.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>&page=<%= curPage %>";
				}else
				{
					alert("권한이 없습니다.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
				}
			},
			error : function(xhr, status, error) 
			{
				// 통신 오류 발생시
			}
		});
	}
	
	//댓글 삭제구역
	function replyDelete(rno)
	{
		if(confirm("댓글을 삭제하시겠습니까?") == false) return;
		
		$.ajax({
			type : "get",
			url: "replydelete.jsp?rno=" + rno,
			dataType: "html",
			success : function(data) 
			{	
				//통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				alert("댓글이 삭제되었습니다.")
				document.location = "view.jsp?category=<%= vo.getCategory() %>&bno=<%= vo.getBno() %>";
			},
			error : function(xhr, status, error) 
			{
				// 통신 오류 발생시
			}
		});
	}
</script>
<!-- 컨텐츠 시작하는 부분 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>고객 문의</h2>
			<hr>
			<ul class="menu">
				<li><a href="../question/index.jsp?acategory=Q">자주 묻는 질문</a></li>
				<li><a href="../inquiry/index.jsp?category=I" style="background-color: white; padding: 0 30px;">고객 문의</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>고객 문의</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 고객 문의 &gt; 고객 문의</p>
			<hr>
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
							<%= vo.getBtitle() %>
							<hr style="background-color:#EFEFEF;width:705px;">
						</td>
					</tr>
					<tr>
						<td id="bwriter" name="bwriter" style="width:700px; height:25px; border:none; outline:none; text-align:right;" readonly="readonly">
							작성자: <%= vo.getName() %> | <%= vo.getBwdate() %>
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none;" readonly="readonly">
							<%= vo.getBnote() %>
						</td>
					</tr>
					<tr>
						<!-- 첨부파일 등록 구역 -->
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
					if(login != null && login.getLevel().equals("A") || login != null && vo.getEmail().equals(login.getEmail()))
					{
						%>
						<input type="submit" value="삭제" id="delete" onclick="javascript:DoDelete('<%= bno %>');">
						<input type="submit" value="수정" id="modify" onclick="javascript:location.href='modify.jsp?category<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>'">
						<%
					}
					%>
				</div>
				<!-- //.btn_area -->
				<br>
				<!-- 댓글 영역 시작 -->
				<%			
				ReplyDTO rdto = new ReplyDTO();
				ArrayList<ReplyVO> list = rdto.list(bno);
				%>
				<%
				if(login != null && login.getLevel().equals("A"))
				{
					%>
					<form id="replyFrm" name="replyFrm" method="post" action="replyok.jsp">
						<input type="hidden" name="bno" value="<%= bno %>">
						<table class="inquiry_reply" id="inquiry_reply">
							<tr>
								<td style="border:none;">
								<textarea name="rnote" id="rnote"></textarea>
								</td>
							</tr>
						</table>
						<input type="submit" class="replybtn" id="replybtn" name="replybtn" value="등록">
					</form>
					<%
				}
				%>
				<%
				for(ReplyVO reply : list)
				{
					%>
					<input type="hidden" name="rno" value="<%= reply.getRno() %>">
					<input type="hidden" name="bno" value="<%= bno %>">
					<table class="inquiry_reply">
						<tr>
							<td style="width:50px">관리자</td>
							<td>
							<div style="vertical-align: middle;">
							<textarea name="rnote" id="rnote" readonly="readonly" style="border:none;"><%= reply.getRnote() %></textarea>
							</div>
							</td>
						</tr>
					</table>
					<%
					if(login != null && login.getLevel().equals("A"))
					{
						%>
						<input type="submit" class="replydelete" id="replydelete" name="replydelete" onclick="javascript:replyDelete('<%= reply.getRno() %>')" value="삭제">
						<%
					}
				}
				%>
				<!-- 댓글 영역 끝 -->
			</div>
			<!-- //.view_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  컨텐츠 끝나는 부분 -->
</section>
<%@ include file="../../include/tail.jsp"%>