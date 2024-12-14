<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
String category = request.getParameter("category");
if(category == null) category = "R";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";

//bno���� request���� �޴´�.
String bno = request.getParameter("bno");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO�� �̿��ؼ� �Խù� ������ BoardVO�� �ް�,
//��ȸ���� ������Ų��.
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.read(bno,true);
%>
<script>
	function DoDelete(bno)
	{
		if(confirm("�ش� �Խù��� �����Ͻðڽ��ϱ�?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?bno=" + bno,
			dataType: "html",
			success : function(data)
			{	
				//����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data == "OK")
				{
					alert("�Խù��� �����Ǿ����ϴ�.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
				}else
				{
					alert("������ �����ϴ�.");
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
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
	.view_inner
	{
		width:700px;
		min-height:600px;
		margin:85px;
	}
	.list_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.modify_btn
	{
		position:relative;
		width:70px;
		height:45px;
		font-size:18px;
	}
	.delete_btn
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
			<h2>���θ��</h2>
			<hr>
			<ul class="menu">
				<li><a href="../event/index.jsp?category=E">�̺�Ʈ</a></li>
				<li><a href="../review/index.jsp?category=R" style="background-color: white; padding: 0 30px;">����</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>����</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���θ�� &gt; ����</p>
			<hr>
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getBtitle() %>
						<hr>
						</td>
					</tr>
					<tr>
						<td id="bwriter" name="bwriter" style="width:700px; height:25px; text-align:right; border:none; outline:none;" readonly="readonly">
							�ۼ���: <%= vo.getName() %> | <%= vo.getBwdate() %>
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none; font-size:18px;" readonly="readonly">
						<%= vo.getBnote() %>
						</td>
					</tr>
					<tr>
						<td style="height:25px;">
							<%
								if(!vo.getBfname().equals(""))
								{
									%>÷������: <a href="down.jsp?bno=<%= vo.getBno() %>"><%= vo.getBfname() %></a><%
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
						<input type="submit" value="����" id="delete" onclick="javascript:DoDelete('<%= bno %>');">
						<input type="submit" value="����" id="modify" onclick="javascript:location.href='modify.jsp?category<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>'">
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
	<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>