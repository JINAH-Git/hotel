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
		<link rel="stylesheet" type="text/css" href="../../style/modify.css" />
		<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
<%@ include file="../../include/head.jsp" %>
<%
if(login == null)
{
	response.sendRedirect("index.jsp?acategory=F");
	return;
}
UserDTO dto = new UserDTO();
UserVO user = dto.read(login.getEmail());
if(!user.getLevel().equals("A"))
{
	response.sendRedirect("index.jsp?acategory=F");
	return;
}
AdminDTO dto2 = new AdminDTO();
AdminVO vo = dto2.read(ano, false);
%>
<script>
let oEditors = [] //oEditors�� ���� �־��ش�.

window.addEventListener('load',function()
{
	smartEditor();
	
	$("#atitle").focus();
	
	//����
	$("#modify").click(function()
	{
		oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
		//����Ʈ ������ ���� �ؽ�Ʈ�������� ����
		var content = document.getElementById("anote").value;

		$("#anote").val(content);
		
		if($("#atitle").val() == "")
		{
			alert("������ �Է��ϼ���.");
			$("#atitle").focus();
			return;
		}
		if($("#anote").val() == "")
		{
			alert("������ �Է��ϼ���.");
			$("#anote").focus();
			return;
		}
		$("#modifyFrm").submit();
	})
	
	//���
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
            //���� �ڵ�
            //oEditors.getById["anote"].exec("PASTE_HTML", ["�ε��� �Ϸ�� �Ŀ� ������ ���ԵǴ� text�Դϴ�."]);
        },
        fCreator: "createSEditor2"
	});
}	
</script>
<section>
	<div class="main">
		<div class="menubar">
			<h2>ȣ�� �Ұ�</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">���� �� �Ұ�</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">���� �Ұ�</a></li>
				<li><a href="../service/index.jsp?acategory=F" style="background-color: white; padding: 0 30px;">�δ� �ü�</a></li>
				<li><a href="../notice/index.jsp?acategory=N">��������</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>�δ� �ü� ����</h3>
			<p class="list"><img src="/hotel/image/home.png" width="20px;" height="20px;"> &gt; ȣ�� �Ұ� &gt; �δ� �ü� ����</p>
			<hr>
			<form id="modifyFrm" name="modifyFrm"  action="modifyok.jsp" method="post" enctype="multipart/form-data">	
				<input type="hidden" name="acategory" value="<%= acategory %>">
				<input type="hidden" name="ano" value="<%= ano %>">
				<div class="service">
					�ü� �̸� : <input type="text" name="atitle" id="atitle" value="<%= vo.getAtitle() %>">
					<textarea style="width: 700px; height: 300px; resize: none; outline: none;" placeholder="�ü� ����" name="anote" id="anote"><%= vo.getAnote() %></textarea>
					<input type="file" name="afname" id="afname">
				</div>
				<input type="button" value="���" id="cancel">
				<input type="button" value="����" id="modify">
			</form>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>