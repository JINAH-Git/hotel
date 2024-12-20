<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String acategory = request.getParameter("acategory");
String ano = request.getParameter("ano");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/room.css" />
		<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
	<style>
		input[type="text"]
		{
			width: 100%;
			height: 100%;
			outline: none;
			box-sizing: border-box;
		}
	</style>
<%@ include file="../../include/head.jsp" %>
<%
if(login == null)
{
	response.sendRedirect("index.jsp");
	return;
}

AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);
if(vo == null)
{
	response.sendRedirect("index.jsp");
	return;
}
%>
<script>
let oEditors = [] //oEditors에 값을 넣어준다.

window.addEventListener('load',function()
{
	smartEditor();
	
	$("#atitle").focus();
	
	//수정
	$("#modify").click(function()
	{
		oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
		//스마트 에디터 값을 텍스트컨텐츠로 전달
		var content = document.getElementById("anote").value;

		$("#anote").val(content);
		
		if($("#atitle").val() == "")
		{
			alert("제목을 입력하세요.");
			$("#atitle").focus();
			return;
		}
		if($("#anote").val() == "")
		{
			alert("내용을 입력하세요.");
			$("#anote").focus();
			return;
		}
		$("#modifyFrm").submit();
	})
	
	//취소
	$("#cancel").click(function()
	{
		location.href = "index.jsp?acategory=<%= acategory %>";
		return;
	})
});

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
			<h3>객실 소개 수정</h3>
			<p class="list"><img src="/hotel/image/home.png" width="20px;" height="20px;"> &gt; 호텔 소개 &gt; 객실 소개 수정</p>
			<hr>
			<div class="room">
				<form id="modifyFrm" name="modifyFrm" action="modifyok.jsp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="acategory" value="<%= acategory %>">
					<input type="hidden" name="ano" value="<%= ano %>">
					<div id="pop_info" class="pop_wrap" style="display:block;">
					  	<div class="pop_inner">
						    <p class="rkind">* 객실 이름 
								<input type="text" id="atitle" name="atitle" value="<%= vo.getAtitle() %>">
							</p>
						    <input type="file" id="afname" name="afname">
						    <p>
						    	<textarea style="width: 865px; height: 400px; resize: none; outline: none;" placeholder="객실 정보" id="anote" name="anote"><%= vo.getAnote() %></textarea>	
							</p>
					  	</div>
					  	<!-- //.pop_inner -->
					</div>
					<!-- //.pop_info_ -->
					<input type="button" value="취소" id="cancel">
					<input type="button" value="수정" id="modify">
				</form>
			</div>
			<!-- //.room -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>