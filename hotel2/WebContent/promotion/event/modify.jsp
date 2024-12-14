<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/evtmodify.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<script type="text/javascript" src="../../editor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<%
String category = request.getParameter("category");
if(category == null) category = "E";
String ano = request.getParameter("ano");
if(ano == null){response.sendRedirect("index.jsp"); return;}

//DTO���� �Խù� ������ VO�� �޴´�
AdminDTO dto = new AdminDTO();
AdminVO vo = dto.read(ano, false);

//�α������� �ʾ����� ����
if(login == null)
{
	System.out.println("�α��λ��°� �ƴմϴ�.");
	response.sendRedirect("index.jsp");
	return;
}

//�����ڰ� �ƴϸ� ����
if(!login.getLevel().equals("A"))
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
		
		$("#modifyfrm").submit(function(){
			
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
			<li><a href="../event/index.jsp?category=E" style="background-color: white; padding: 0 30px;">�̺�Ʈ</a></li>
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
			<form name="modifyfrm" id="modifyfrm" method="post" action="modifyok.jsp" enctype="multipart/form-data">
				<input type="hidden" name="ano" value="<%= ano %>">
				<table border="0" class="writetbl" style="width:700px; height:100%; border-collapse:collapse;">
					<tr>
						<td style="background-color:#f5f5f7; padding-bottom:10px;">����</td>
						<td>
						<input type="text" id="atitle" name="atitle" value="<%= vo.getAtitle() %>" style="width:650px; height:50px; border:none; font-size:18px;">
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">����</td>
						<td>
						<textarea id="anote" name="anote" style="width:650px; height:290px; resize:none; border:none; outline:none;"><%= vo.getAnote() %></textarea>
						<hr style="width:650px;">
						</td>
					</tr>
					<tr>
						<td style="background-color:#f5f5f7;">÷������</td>
						<td>
						<%
						if(vo.getAfname() != null && !vo.getAfname().equals(""))
						{
							%>
							<input type="file" name="attach">
							<br>
							<a href="down.jsp?ano=<%= ano %>"><%= vo.getAfname() %></a>
							<%
						}else
						{
							%>
							<input type="file" name="attach">
							<%
						}
						%>	
						</td>
					</tr>
				</table>
				<div class="btn">
					<input type="button" value="���" id="cancel" onclick="javascript:location.href='index.jsp'">
					<input type="submit" value="���" id="write">
				</div>
			</form>
		</div>
		<!-- //.modify_inner -->
	</div>
	<!-- //.contents -->
</div>
<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>