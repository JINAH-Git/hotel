<!-- 
23-07-10 ���� | jsp �ۼ���.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
//���� ���� �۾��⿡�� ī�װ������� �޾ƿ�
String category = request.getParameter("category");
//���� ������ ī�װ������� R�� ��������
if(category == null) category = "I";

if(login.getEmail() == null)
{
	%>
	<script>
		alert("�۾��� ������ �����ϴ�. �α��� �� �۾��⸦ �������ּ���.");
		document.location = "/hotel2/user/login.jsp";
	</script>
	<%
}
%>
<script>
	let oEditors = [] //oEditors�� ���� �־��ش�.

	window.onload = function()
	{
		smartEditor();
		
		$("#btitle").focus();
		
		$("#writeFrm").submit(function(){
			
			oEditors.getById["bnote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//����Ʈ ������ ���� �ؽ�Ʈ�������� ����
			var content = document.getElementById("bnote").value;

			$("#bnote").val(content);
			
			if($("#btitle").val() == "")
			{
				alert("������ �Է��ϼ���.");
				$("#btitle").focus();
				return false;
			}
			if($("#bwriter").val() == "")
			{
				alert("�̸��� �Է��ϼ���.");
				$("#bwriter").focus();
				return false;
			}
			if($("#bnote").val() == "")
			{
				alert("������ �Է��ϼ���.");
				$("#bnote").focus();
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
	        elPlaceHolder: "bnote", //textarea�� name�� bnote�� bnote��� ����
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
                //���� �ڵ�
                //oEditors.getById["bnote"].exec("PASTE_HTML", ["�ε��� �Ϸ�� �Ŀ� ������ ���ԵǴ� text�Դϴ�."]);
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
<!-- ������ �����ϴ� �κ� -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>���� ����</h2>
			<hr>
			<ul class="menu">
				<li><a href="../question/index.jsp?acategory=Q">���� ���� ����</a></li>
				<li><a href="../inquiry/index.jsp?category=I" style="background-color: white; padding: 0 30px;">���� ����</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>���� ����</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���� ���� &gt; ���� ����</p>
			<hr>
			<div class="write_inner">
				<form id="writeFrm" name="writeFrm" method="post" action="writeok.jsp" enctype="multipart/form-data">
					<input type="hidden" name="category" value="I">
					<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">����</td>
							<td>
							<input type="text" id="btitle" name="btitle" style="width:650px; height:50px; border:none; font-size:18px;"placeholder="������ �Է��ϼ���">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">�̸�</td>
							<td>
							<input type="text" id="bwriter" name="bwriter" style="width:650px; height:30px; border:none;" readonly="readonly" value="<%= login.getKname() %>">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">����</td>
							<td>
							<textarea id="bnote" name="bnote" style="width:650px; height:290px; resize:none; border:none;"></textarea>
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">÷������</td>
							<td><input type="file" name="attach"></td>
						</tr>
					</table>
					<table border="0" style="width:700px;">
						<tr>
							<td>
							<input type="radio" id="lockop" name="lockop" value="Y">�����
							</td>
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
	<!--  ������ ������ �κ� -->
</section>
<%@ include file="../../include/tail.jsp"%>