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
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
//공지사항 글쓰기에서 카테고리값을 받아옴
String acategory = request.getParameter("acategory");
//값이 없으면 카테고리값을 N으로 설정해줌
if(acategory == null) acategory = "N";

//관리자가 아니면 메인화면으로 돌려보낸다
if(login.getLevel() != "A")
{
	%>
	<script>
		//alert("글쓰기 권한이 없습니다.");
		//document.location = "/hotel2/index.jsp";
	</script>
	<%
}
%>
<script>
	let oEditors = [] //oEditors에 값을 넣어준다.
	
	window.onload = function()
	{
		smartEditor();
		
		$("#atitle").focus();
		
		$("#writeFrm").submit(function(){
			
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
	        elPlaceHolder: "anote", //textarea의 name이 anote라서 anote라고 기입
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
<style>
	.write_inner
	{
		width:700px;
		margin:85px;
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
			<h3>공지사항 글쓰기</h3>
			<p class="list"><img src="/hotel/image/home.png"> &gt; 호텔 소개 &gt; 공지사항 글쓰기</p>
			<hr>
			<div class="write_inner">
				<form name="writeFrm" id="writeFrm" action="writeok.jsp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="acategory" value="N">
					<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">제목</td>
							<td>
							<input type="text" id="atitle" name="atitle" style="width:650px; height:50px; border:none; font-size:18px;"placeholder="제목을 입력하세요">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">내용</td>
							<td>
							<textarea id="anote" name="anote" style="width:650px; height:290px; resize:none; border:none;"></textarea>
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">첨부파일</td>
							<td><input type="file" name="afname" id="afname"></td>
						</tr>
					</table>
					<div class="btn">
						<input type="button" value="취소" id="cancel" onclick="javascript:location.href='index.jsp'">
						<input type="submit" value="등록" id="write">
					</div>
				</form>
			</div>
			<!-- //.write_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
</html>