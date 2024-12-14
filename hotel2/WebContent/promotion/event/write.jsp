<!-- 
23-07-10 ���� | jsp �ۼ���.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/event.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
String category = request.getParameter("category");
//���� ������ ī�װ������� R�� ��������
if(category == null) category = "E";

if(!login.getLevel().equals("A"))
{
	%>
	<script>
		alert("�۾��� ������ �����ϴ�.");
		document.location = "/hotel2/index.jsp";
	</script>
	<%
}
%>
<script>
	let oEditors = [] //oEditors�� ���� �־��ش�.

	window.onload = function()
	{
		smartEditor();
		
		$("#atitle").focus();
		
		$("#writeFrm").submit(function(){
			
			oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//����Ʈ ������ ���� �ؽ�Ʈ�������� ����
			var content = document.getElementById("anote").value;

			$("#anote").val(content);
			
			if($("#atitle").val() == "")
			{
				alert("������ �Է��ϼ���.");
				$("#atitle").focus();
				return false;
			}
			if($("#anote").val() == "")
			{
				alert("������ �Է��ϼ���.");
				$("#anote").focus();
				return false;
			}
			if(confirm("������ �����ϰڽ��ϱ�?") == false)
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
	        elPlaceHolder: "anote", //textarea�� name�� bnote�� bnote��� ����
		    sSkinURI: "../../editor/SmartEditor2Skin.html",
			htParams : 
			{
				bUseToolbar : true,				// ���� ��� ���� (true:���/ false:������� ����)
	            bUseVerticalResizer : true,		// �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
		        bUseModeChanger : true,			// ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
			    bSkipXssFilter : true,			// client-side xss filter ���� ���� (true:������� ���� / �׿�:���)
				SE2M_FontName: 
				{
		            htMainFont: {'id': '����ü','name': '����ü', 'size': '11', 'url': '','cssUrl': ''} // �⺻ �۲� ����
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
		<h2>���θ��</h2>
		<hr>
		<ul class="menu">
			<li><a href="../event/index.jsp?acategory=E" style="background-color: white; padding: 0 30px;">�̺�Ʈ</a></li>
			<li><a href="../review/index.jsp?category=R">����</a></li>
		</ul>
		<!-- //.menu -->
	</div>
	<!-- //.menubar -->
	<div class="contents">
		<h3>�̺�Ʈ</h3>
		<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���θ�� &gt; �̺�Ʈ</p>
		<hr>
		<div class="write_inner">
			<form id="writeFrm" name="writeFrm" method="post" action="writeok.jsp" enctype="multipart/form-data">
				<input type="hidden" name="category" value="E">
				<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
					<tr>
						<td style="background-color:#f5f5f7; padding-bottom:10px;">����</td>
						<td>
						<input type="text" id="atitle" name="atitle" style="width:650px; height:50px; border:none; font-size:18px;" placeholder="������ �Է��ϼ���">
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">����</td>
						<td>
						<textarea id="anote" name="anote" style="width:650px; height:290px; resize:none; border:none; outline:none;"></textarea>
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">÷������</td>
						<td><input type="file" name="attach"></td>
					</tr>
				</table>
				<div class="btn">
					<input type="button" value="���" id="cancel" onclick="javascript:location.href='index.jsp'">
					<input type="submit" value="���" id="write">
				</div>
			</form>
		</div>
	</div>
	<!-- //.contents -->
</div>
<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>