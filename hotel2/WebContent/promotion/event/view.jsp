<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/eventview.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
String category = request.getParameter("category");
if(category == null) category = "E";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";
String ano = request.getParameter("ano");
if(ano == null){response.sendRedirect("index.jsp"); return;}

AdminDTO dto = new AdminDTO();
//��ȸ���� ������ų �ʿ䰡 �ֽ��ϱ�?
AdminVO vo = dto.read(ano, true);

%>
<script>
	//�Խñ� ��������
	function DoDelete(ano)
	{
		if(confirm("�ش� �Խù��� �����Ͻðڽ��ϱ�?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?ano=" + ano ,
			dataType: "html",
			success : function(data) 
			{	
				//����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data == "OK")
				{
					alert("�Խù��� �����Ǿ����ϴ�.")
					document.location = "index.jsp?category=<%= vo.getAcategory() %>&page=<%= curPage %>";
				}else
				{
					alert("������ �����ϴ�.")
					document.location = "index.jsp?category=<%= vo.getAcategory() %>";
				}
			},
			error : function(xhr, status, error) 
			{
				// ��� ���� �߻���
			}
		});
	}
</script>
<section style="height:auto;">
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
		<div class="view_inner">
			<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
				<tr>
					<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getAtitle() %>
						<hr>
					</td>
				</tr>
				<tr>
					<td id="bwriter" name="bwriter" style="width:700px; height:25px; border:none; outline:none; text-align:right;" readonly="readonly">
						�ۼ���: <%= vo.getName() %> | <%= vo.getAwdate() %>
					</td>
				</tr>
				<tr>
					<td id="bnote" name="bnote" style="width:700px; border:none; outline:none; ">
					<%= vo.getAnote() %>
					</td>
				</tr>
				<tr>
					<!-- ÷������ ��� ���� -->
					<td style="height:25px;">
						<%
							if(!vo.getAfname().equals(""))
							{
								%>
								<div style="text-align:center;" >
								<img src="down.jsp?ano=<%= vo.getAno() %>"/>
								<br>
								 ÷�� ���� : <a href="down.jsp?ano=<%= vo.getAno() %>"><%= vo.getAfname() %></a>
								</div>
								<%
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
					<input type="submit" value="����" id="modify" onclick="javascript:location.href='modify.jsp?acategory<%= category %>&ano=<%= vo.getAno() %>&page=<%= page %>'">
					<%
				}
				%>
			</div>
			<!-- //.btn -->
		</div>
		<!-- //.view_inner -->
	</div>
	<!-- //.contents -->
</div>
</section>
<!-- //.main -->
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>