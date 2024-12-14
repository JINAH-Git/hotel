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
<%
String acategory = request.getParameter("acategory");
if(acategory == null) acategory = "N";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";

//ano���� request���� �޴´�.
String ano = request.getParameter("ano");

if(ano == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO�� �̿��ؼ� �Խù� ������ BoardVO�� �ް�,
//��ȸ���� ������Ų��.
AdminDTO dto = new AdminDTO();
AdminVO  vo  = dto.read(ano,true);
%>
<script>
	function DoDelete(ano)
	{
		if(confirm("�ش� �Խù��� �����Ͻðڽ��ϱ�?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?ano=" + ano,
			dataType: "html",
			success : function(data)
			{	
				//����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data == "OK")
				{
					alert("�Խù��� �����Ǿ����ϴ�.");
					document.location = "index.jsp?acategory=<%= acategory %>";
				}else
				{
					alert("�Խù��� ������ �� �����ϴ�.");
				}
			},
			error : function(xhr, status, error) 
			{
				// ��� ���� �߻���
			}
		});
	}
</script>
<style>
	.writetbl
	{
		border-color:#66575A;
		border-width:2px 0px 2px 0px;
		border-style:solid;
	}
	.view_inner
	{
		width:700px;
		min-height:600px;
		margin:85px;
	}
	.view_inner hr
	{
		border-color:#EFEFEF;
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
			<p class="list"><img src="/hotel2/image/home.png"> &gt; ȣ�� �Ұ� &gt; �������� ����</p>
			<hr>
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
							<%= vo.getAtitle() %>
							<hr style="background-color:#EFEFEF;width:705px;">
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none;" readonly="readonly">
							<%= vo.getAnote() %>
						</td>
					</tr>
					<tr>
						<!-- ÷������ ��� ���� -->
						<td style="height:25px;">
							<%
								if(!vo.getAfname().equals(""))
								{
									%>÷������: <a href="down.jsp?bno=<%= vo.getAno() %>"><%= vo.getAfname() %></a><%
								}else
								{
								}
							%>
						</td>
					</tr>
				</table>
				<div class="btn">
					<input type="button" value="���" id="cancel" onclick="javascript:location.href='index.jsp'">
					<%
					if( login != null && login.getLevel().equals("A") || login != null && vo.getEmail().equals(login.getEmail()) )
					{
						%>
						<input type="submit" value="����" id="delete" onclick="javascript:DoDelete('<%= ano %>');">
						<input type="submit" value="����" id="modify" onclick="javascript:location.href='modify.jsp?acategory<%= acategory %>&ano=<%= vo.getAno() %>&page=<%= page %>'">
						<%
					}
					%>
				</div>
				<!-- //.btn -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
</html>