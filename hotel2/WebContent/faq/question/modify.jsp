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

//���� ���� ������ �Խñ� ��ȣ�� �޴´�.
String ano = request.getParameter("ano");

//DTO���� �Խù� ������ VO�� �޴´�
AdminDTO dto = new AdminDTO();
AdminVO   vo = dto.read(ano,false);

//�ش� �Խù� �ۼ��ڰ� �ƴϸ� ����
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
<!-- ������ �����ϴ� �κ� -->
<script>
	let oEditors = [] //oEditors�� ���� �־��ش�.
	
	window.onload = function()
	{
		smartEditor();
		
		$("#atitle").focus();
		
		$("#write").click(function(){
			
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
		
		$("#cancelbtn").click(function(){
			if(confirm("�Խñ� ������ ����Ͻðڽ��ϱ�?") == false) return;
			//�����ִ� �Խñ� ȭ������ ���ư���
			document.location = "index.jsp?acategory=<%= acategory %>";
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
<!-- ���� ������ ���� -->
<section>
	<div class="main">
		<div class="menubar">
			<h2>�� ����</h2>
			<hr>
			<ul class="menu">
				<li><a href="../question/index.jsp?acategory=Q" style="background-color: white; padding: 0 30px;">���� ���� ����</a></li>
				<li><a href="../inquiry/index.jsp?category=I">�� ����</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>���� ���� ����</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; �� ���� &gt; �� ����</p>
			<hr>
			<div class="modify_inner">
				<form id="modifyFrm" name="modifyFrm" method="post" action="modifyok.jsp">
					<input type="hidden" name="ano" value="<%= ano %>">
					<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
						<tr>
							<td style="background-color:#f5f5f7; padding-bottom:20px;">����</td>
							<td>
							<input type="text" name="atitle" id="atitle" style="width:650px; height:50px; border:none; font-size:18px;"
							 placeholder="������ �Է��ϼ���" value="<%= vo.getAtitle() %>"><hr style="width:650px;"></td>
						</tr>
						<tr>
							<td style="background-color:#f5f5f7;">����</td>
							<td>
								<textarea name="anote" id="anote" style="width:650px; height:290px; resize:none; border:none; outline:none;" placeholder="������ �Է��ϼ���">
								<%= vo.getAnote() %>
								</textarea>
							</td>
						</tr>
					</table>
					<div class="btn_area">
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