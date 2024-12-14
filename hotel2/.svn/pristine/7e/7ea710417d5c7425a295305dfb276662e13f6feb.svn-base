<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "Q";
String curPage = request.getParameter("page");
if( curPage == null) curPage = "1";

//자주 묻는 질문의 게시글 번호를 받는다.
String ano = request.getParameter("ano");

//DTO에서 게시물 정보를 VO로 받는다
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);

//해당 게시물 작성자가 아니면 종료
if( login == null || login.getLevel().equals("U") )
{
	return;
}
%>
<style>
	.modify_inner
	{
		width:700px;
		min-height:600px;
		margin:85px;
	}
	.btn_area
	{
		position:relative;
		top:30px;
	}
	.write_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.cancel_btn
	{
		position:relative;
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
		
		$("#atitle").focus();
		
		$("#write").click(function(){
			
			oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//스마트 에디터 값을 텍스트컨텐츠로 전달
			var content = document.getElementById("anote").value;

			$("#anote").val(content);
			
			//제목,내용 값이 비어 있는지 검사한다.
			if($("#atitle").val() == "")
			{
				$("#atitle").focus();
				alert("제목이 비어있습니다.");
				return;
			}
			if($("#anote").val() == "")
			{
				$("#anote").focus();
				alert("내용이 비어있습니다.");
				return;
			}
			if(confirm("변경된 내용을 저장하시겠습니까?") == false)
			{
				return;
			}
			$("#modifyFrm").submit();
		});
		
		$("#cancelbtn").click(function(){
			if(confirm("게시글 수정을 취소하시겠습니까?") == false) return;
			//보고있던 게시글 화면으로 돌아간다
			document.location = "index.jsp?acategory=<%= acategory %>";
		});
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
                //예제 코드
                //oEditors.getById["anote"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
            },
	        fCreator: "createSEditor2"
		});
    }	
</script>
<!-- 메인 컨텐츠 시작 -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>고객 문의</h2>
			<hr>
			<ul class="menu">
				<li><a href="../question/index.jsp?acategory=Q" style="background-color: white; padding: 0 30px;">자주 묻는 질문</a></li>
				<li><a href="../inquiry/index.jsp?category=I">고객 문의</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>자주 묻는 질문</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 고객 문의 &gt; 고객 문의</p>
			<hr>
			<div class="modify_inner">
				<form id="modifyFrm" name="modifyFrm" method="post" action="modifyok.jsp">
					<input type="hidden" name="ano" value="<%= ano %>">
					<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:20px;">제목</td>
							<td>
							<input type="text" name="atitle" id="atitle" style="width:650px; height:50px; border:none; font-size:18px;"
							 placeholder="제목을 입력하세요" value="<%= vo.getAtitle() %>"><hr style="width:650px;"></td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">내용</td>
							<td>
								<textarea name="anote" id="anote" style="width:650px; height:290px; resize:none; border:none; outline:none;" placeholder="내용을 입력하세요">
								<%= vo.getAnote() %>
								</textarea>
							</td>
						</tr>
					</table>
					<div class="btn_area">
						<input type="button" value="취소" id="cancel" onclick="javascript:location.href='index.jsp'">
						<input type="submit" value="등록" id="write">
					</div>
				</form>
			</div>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  컨텐츠 끝나는 부분 -->
</section>
<%@ include file="../../include/tail.jsp"%>