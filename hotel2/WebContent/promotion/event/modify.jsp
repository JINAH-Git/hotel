<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/evtmodify.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
String category = request.getParameter("category");
if(category == null) category = "E";
String ano = request.getParameter("ano");
if(ano == null){response.sendRedirect("index.jsp"); return;}

//DTO에서 게시물 정보를 VO로 받는다
AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);

//로그인하지 않았으면 종료
if(login == null)
{
	System.out.println("로그인상태가 아닙니다.");
	response.sendRedirect("index.jsp");
	return;
}

//관리자가 아니면 종료
if(!login.getLevel().equals("A"))
{
	System.out.println("권한이 없습니다.");
	response.sendRedirect("index.jsp");
	return;
}

%>
<script>
	let oEditors = [] //oEditors에 값을 넣어준다.

	window.onload = function()
	{
		smartEditor();
		
		$("#atitle").focus();
		
		$("#modifyfrm").submit(function(){
			
			oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//스마트 에디터 값을 텍스트컨텐츠로 전달
			var content = document.getElementById("anote").value;

			$("#anote").val(content);
			
			if($("#atitle").val() == "")
			{
				alert("제목을 입력하세요.");
				$("#atitle").focus();
				return false;
			}
			if($("#anote").val() == "")
			{
				alert("내용을 입력하세요.");
				$("#anote").focus();
				return false;
			}
			if(confirm("내용을 저장하겠습니까?") == false)
			{
				return false;
			}
			return true;
		})
	}
	
	smartEditor = function() //
	{
		nhn.husky.EZCreator.createInIFrame(
		{
			oAppRef: oEditors,
	        elPlaceHolder: "anote", //textarea의 name이 bnote라서 bnote라고 기입
		    sSkinURI: "../../editor/SmartEditor2Skin.html",
			htParams : 
			{
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		        bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			    bSkipXssFilter : true,			// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
				SE2M_FontName: 
				{
		            htMainFont: {'id': '돋움체','name': '돋움체', 'size': '11', 'url': '','cssUrl': ''} // 기본 글꼴 설정
			    }
		    },
			fOnAppLoad : function()
			{       
            },
	        fCreator: "createSEditor2"
		});
    }	
</script>
<section>
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
		<div class="write_inner">
			<form name="modifyfrm" id="modifyfrm" method="post" action="modifyok.jsp" enctype="multipart/form-data">
				<input type="hidden" name="ano" value="<%= ano %>">
				<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
					<tr>
						<td style="background-color:#f5f5f7; padding-bottom:10px;">제목</td>
						<td>
						<input type="text" id="atitle" name="atitle" value="<%= vo.getAtitle() %>" style="width:650px; height:50px; border:none; font-size:18px;">
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">내용</td>
						<td>
						<textarea id="anote" name="anote" style="width:650px; height:290px; resize:none; border:none; outline:none;"><%= vo.getAnote() %></textarea>
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">첨부파일</td>
						<td>
						<%
						if(vo.getAfname() != null && !vo.getAfname().equals(""))
						{
							%>
							<input type="file" name="attach">
							<br>
							<a href="down.jsp?ano=<%= ano %>"><%= vo.getAfname() %></a>
							<%
						}else
						{
							%>
							<input type="file" name="attach">
							<%
						}
						%>	
						</td>
					</tr>
				</table>
				<div class="btn">
					<input type="button" value="취소" id="cancel" onclick="javascript:location.href='index.jsp'">
					<input type="submit" value="등록" id="write">
				</div>
			</form>
		</div>
		<!-- //.modify_inner -->
	</div>
	<!-- //.contents -->
</div>
<!-- //.main -->
</section>
<!--  컨텐츠 끝나는 부분 -->
<%@ include file="../../include/tail.jsp"%>