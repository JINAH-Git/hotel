<!-- 
23-07-10 성재 | jsp 작성함.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/modify.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
String category = request.getParameter("category");
if(category == null) category = "R";
String curPage = request.getParameter("page");
if( curPage == null) curPage = "1";

//게시글 번호를 받는다
String bno = request.getParameter("bno");

//DTO에서 게시물 정보를 VO로 받는다
BoardDTO dto = new BoardDTO();
BoardVO   vo = dto.read(bno,false);

//로그인하지 않았으면 종료
if( login == null )
{
	System.out.println("로그인상태가 아닙니다.");
	response.sendRedirect("index.jsp");
	return;
}

//해당 게시물 작성자가 아니면 종료
if(!login.getEmail().equals(vo.getEmail()))
{
	System.out.println("권한이 없습니다.");
	response.sendRedirect("index.jsp");
	return;
}
%>
<style>
	.modify_inner
	{
		width:700px;
		margin:85px;
	}
	.write_btn
	{
		position:relative;
		left:300px;
		top:50px;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.cancel_btn
	{
		position:relative;
		left:330px;
		top:50px;
		width:70px;
		height:45px;
		font-size:18px;
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
<script>
	let oEditors = [] //oEditors에 값을 넣어준다.
	
	window.onload = function()
	{
		smartEditor();
		
		$("#btitle").focus();
		
		$("#modify").click(function(){
			
			oEditors.getById["bnote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//스마트 에디터 값을 텍스트컨텐츠로 전달
			var content = document.getElementById("bnote").value;

			$("#bnote").val(content);
			
			//제목,내용 값이 비어 있는지 검사한다.
			if($("#btitle").val() == "")
			{
				$("#btitle").focus();
				alert("제목이 비어있습니다.");
				return;
			}
			if($("#bwriter").val() == "")
			{
				$("#bwriter").focus();
				alert("이름을 입력해주세요.");
				return;
			}
			if($("#bnote").val() == "")
			{
				$("#bnote").focus();
				alert("내용이 비어있습니다.");
				return;
			}
			if(confirm("변경된 내용을 저장하시겠습니까?") == false)
			{
				return;
			}
			$("#modifyFrm").submit();
		});
		
		$("#btncancel").click(function(){
			if(confirm("게시글 수정을 취소하시겠습니까?") == false) return;
			//보고있던 게시글 화면으로 돌아간다
			document.location = "view.jsp?category=<%= category %>&bno=<%= bno %>";
		});
	}
	
	smartEditor = function() //
	{
		nhn.husky.EZCreator.createInIFrame(
		{
			oAppRef: oEditors,
	        elPlaceHolder: "bnote", //textarea의 name이 bnote라서 bnote라고 기입
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
                //예제 코드
                //oEditors.getById["bnote"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
            },
	        fCreator: "createSEditor2"
		});
    }	
</script>
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
			<div class="modify_inner">
				<form name="modifyFrm" id="modifyFrm" method="post" action="modifyok.jsp" enctype="multipart/form-data">
					<input type="hidden" name="bno" value="<%= bno %>">
					<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">제목</td>
							<td>
							<input type="text" name="btitle" style="width:650px; height:50px; border:none; font-size:18px;" placeholder="제목을 입력하세요" value="<%= vo.getBtitle() %>">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">이름</td>
							<td>
							<input type="text" id="bwriter" name="bwriter" style="width:650px; height:30px; border:none;" readonly="readonly" value="<%= vo.getName() %>">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">내용</td>
							<td>
							<textarea id="bnote" name="bnote" style="width:650px; height:290px; resize:none; border:none; outline:none;"><%= vo.getBnote() %></textarea>
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">첨부파일</td>
							<td>
							<input type="file" name="attach">
							<%
								if(!vo.getBfname().equals(""))
								{
									%><a href="down.jsp?no=<%= vo.getBno() %>"><%= vo.getBfname() %></a><%
								}else
								{
									%> | 등록된 첨부파일이 없습니다.<%
								}
							%>
							</td>
						</tr>
					</table>
					<div class="btn">
						<input type="button" value="취소" id="cancel" onclick="javascript:location.href='index.jsp'">
						<input type="submit" value="등록" id="modify">
					</div>
				</form>
			</div>
			<!-- //.modify_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  컨텐츠 끝나는 부분 -->
</section>
<%@ include file="../../include/tail.jsp"%>