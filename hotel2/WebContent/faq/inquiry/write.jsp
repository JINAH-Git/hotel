<!-- 
23-07-10 성재 | jsp 작성함.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
//고객 문의 글쓰기에서 카테고리값을 받아옴
String category = request.getParameter("category");
//값이 없으면 카테고리값을 R로 설정해줌
if(category == null) category = "I";

if(login.getEmail() == null)
{
	%>
	<script>
		alert("글쓰기 권한이 없습니다. 로그인 후 글쓰기를 진행해주세요.");
		document.location = "/hotel2/user/login.jsp";
	</script>
	<%
}
%>
<script>
	let oEditors = [] //oEditors에 값을 넣어준다.

	window.onload = function()
	{
		smartEditor();
		
		$("#btitle").focus();
		
		$("#writeFrm").submit(function(){
			
			oEditors.getById["bnote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//스마트 에디터 값을 텍스트컨텐츠로 전달
			var content = document.getElementById("bnote").value;

			$("#bnote").val(content);
			
			if($("#btitle").val() == "")
			{
				alert("제목을 입력하세요.");
				$("#btitle").focus();
				return false;
			}
			if($("#bwriter").val() == "")
			{
				alert("이름을 입력하세요.");
				$("#bwriter").focus();
				return false;
			}
			if($("#bnote").val() == "")
			{
				alert("내용을 입력하세요.");
				$("#bnote").focus();
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
<style>
	.write_inner
	{
		width:700px;
		margin:85px;
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
			<div class="write_inner">
				<form id="writeFrm" name="writeFrm" method="post" action="writeok.jsp" enctype="multipart/form-data">
					<input type="hidden" name="category" value="I">
					<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">제목</td>
							<td>
							<input type="text" id="btitle" name="btitle" style="width:650px; height:50px; border:none; font-size:18px;"placeholder="제목을 입력하세요">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">이름</td>
							<td>
							<input type="text" id="bwriter" name="bwriter" style="width:650px; height:30px; border:none;" readonly="readonly" value="<%= login.getKname() %>">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">내용</td>
							<td>
							<textarea id="bnote" name="bnote" style="width:650px; height:290px; resize:none; border:none;"></textarea>
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">첨부파일</td>
							<td><input type="file" name="attach"></td>
						</tr>
					</table>
					<table border="0" style="width:700px;">
						<tr>
							<td>
							<input type="radio" id="lockop" name="lockop" value="Y">비공개
							</td>
						</tr>
					</table>
					<div class="btn">
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