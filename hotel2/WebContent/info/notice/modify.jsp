<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
		<link rel="stylesheet" type="text/css" href="../../style/modify.css" />
		<script src="/hotel2/js/includeHTML.js"></script>
		<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	</head>
<%@ include file="../../include/head.jsp" %>
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "N";
String curPage = request.getParameter("page");
if( curPage == null) curPage = "1";

//�������� �Խñ� ��ȣ�� �޴´�.
String ano = request.getParameter("ano");

//DTO���� �Խù� ������ VO�� �޴´�
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);

//�α������� �ʾ����� ����
if( login == null )
{
	System.out.println("�α��λ��°� �ƴմϴ�.");
	response.sendRedirect("index.jsp");
	return;
}

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� ����
if( !login.getLevel().equals("A") )
{
	System.out.println("������ �����ϴ�.");
	response.sendRedirect("index.jsp");
	return;
}
%>
<script>
	let oEditors = [] //oEditors�� ���� �־��ش�.
	
	window.onload = function()
	{
		smartEditor();
		
		$("#atitle").focus();
		
		$("#modify").click(function(){
			
			oEditors.getById["anote"].exec("UPDATE_CONTENTS_FIELD", []);  
			//����Ʈ ������ ���� �ؽ�Ʈ�������� ����
			var content = document.getElementById("anote").value;

			$("#anote").val(content);
			
			//����,���� ���� ��� �ִ��� �˻��Ѵ�.
			if($("#atitle").val() == "")
			{
				$("#atitle").focus();
				alert("������ ����ֽ��ϴ�.");
				return;
			}
			if($("#anote").val() == "")
			{
				$("#anote").focus();
				alert("������ ����ֽ��ϴ�.");
				return;
			}
			if(confirm("����� ������ �����Ͻðڽ��ϱ�?") == false)
			{
				return;
			}
			$("#modifyFrm").submit();
		});
		
		$("#cancel").click(function(){
			if(confirm("�Խñ� ������ ����Ͻðڽ��ϱ�?") == false) return;
			//�����ִ� �Խñ� ȭ������ ���ư���
			document.location = "view.jsp?acategory=<%= acategory %>&ano=<%= ano %>";
		});
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
                //���� �ڵ�
                //oEditors.getById["anote"].exec("PASTE_HTML", ["�ε��� �Ϸ�� �Ŀ� ������ ���ԵǴ� text�Դϴ�."]);
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
			<h2>ȣ�� �Ұ�</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/">���� �� �Ұ�</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">���� �Ұ�</a></li>
				<li><a href="../service/index.jsp?acategory=F">�δ� �ü�</a></li>
				<li><a href="../notice/index.jsp?acategory=N" style="background-color: white; padding: 0 30px;">��������</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>�������� ����</h3>
			<p class="list"><img src="/hotel2/image/home.png"> &gt; ȣ�� �Ұ� &gt; �������� �ۼ���</p>
			<hr>
			<div class="write_inner">
				<form name="writeFrm" id="writeFrm" action="modifyok.jsp" method="post" enctype="multipart/form-data">
					<input type="hidden" name="ano" value="<%= ano %>">
					<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:10px;">����</td>
							<td>
							<input type="text" id="atitle" name="atitle" style="width:650px; height:50px; border:none; font-size:18px;"placeholder="������ �Է��ϼ���"
							value="<%= vo.getAtitle() %>">
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">����</td>
							<td>
							<textarea id="anote" name="anote" style="width:650px; height:290px; resize:none; border:none;"><%= vo.getAnote() %></textarea>
							<hr style="width:650px;">
							</td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">÷������</td>
							<td>
							<input type="file" name="afname" id="afname">
							<%
								if(!vo.getAfname().equals(""))
								{
									%><a href="down.jsp?ano=<%= vo.getAno() %>"><%= vo.getAfname() %></a><%
								}else
								{
									%> | ��ϵ� ÷�������� �����ϴ�.<%
								}
							%>
							</td>
						</tr>
					</table>
					<div class="btn">
						<input type="button" value="���" id="cancel" onclick="javascript:location.href='index.jsp'">
						<input type="submit" value="���" id="modify">
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