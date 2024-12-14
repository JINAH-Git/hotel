<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/write.css" />
<%
//ī�װ��� ���� ���� ������ ���� �޴´�. 
String category = request.getParameter("category");
if(category == null) category = "I";
String curPage = request.getParameter("page");
if(curPage == null) curPage = "1";


//bno���� �޴´�.
String bno = request.getParameter("bno");

if(bno == null)
{
	response.sendRedirect("index.jsp");
	return;
}

//BoardDTO�� �̿��ؼ� �Խù� ������ BoardVO�� �ް�,
//��ȸ���� ������Ų��.
BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.read(bno,false);


if(login == null)
{
	if(vo.getLockop().equals("Y"))
	{
		vo = dto.read(bno,false);
		response.sendRedirect("index.jsp");
		return;
	}else
	{
		vo = dto.read(bno,true);
	}
}else
{
	if(vo.getLockop().equals("Y"))
	{
		if(login.getLevel().equals("A") || vo.getEmail().equals(login.getEmail()))
		{
			vo = dto.read(bno,true);
		}else
		{
			vo = dto.read(bno,false);
			response.sendRedirect("index.jsp");
			return;
		}
	}else
	{
		vo = dto.read(bno,true);
	}
}
%>
<script>

	window.onload = function(){
		$("#rnote").focus();
	}
	
	//�Խñ� ��������
	function DoDelete(bno)
	{
		if(confirm("�ش� �Խù��� �����Ͻðڽ��ϱ�?") == false) return;
		
		$.ajax({
			type : "get",
			url: "delete.jsp?bno=" + bno ,
			dataType: "html",
			success : function(data) 
			{	
				//����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data == "OK")
				{
					alert("�Խù��� �����Ǿ����ϴ�.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>&page=<%= curPage %>";
				}else
				{
					alert("������ �����ϴ�.")
					document.location = "index.jsp?category=<%= vo.getCategory() %>";
				}
			},
			error : function(xhr, status, error) 
			{
				// ��� ���� �߻���
			}
		});
	}
	
	//��� ��������
	function replyDelete(rno)
	{
		if(confirm("����� �����Ͻðڽ��ϱ�?") == false) return;
		
		$.ajax({
			type : "get",
			url: "replydelete.jsp?rno=" + rno,
			dataType: "html",
			success : function(data) 
			{	
				//����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				alert("����� �����Ǿ����ϴ�.")
				document.location = "view.jsp?category=<%= vo.getCategory() %>&bno=<%= vo.getBno() %>";
			},
			error : function(xhr, status, error) 
			{
				// ��� ���� �߻���
			}
		});
	}
</script>
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
			<div class="view_inner">
				<table border="0" class="writetbl" style="width:700px; height:300px; border-collapse:collapse;">
					<tr>
						<td id="btitle" name="btitle" style="width:700px; height:50px; border:none; outline:none; font-size:18px;" readonly="readonly">
							<%= vo.getBtitle() %>
							<hr style="background-color:#EFEFEF;width:705px;">
						</td>
					</tr>
					<tr>
						<td id="bwriter" name="bwriter" style="width:700px; height:25px; border:none; outline:none; text-align:right;" readonly="readonly">
							�ۼ���: <%= vo.getName() %> | <%= vo.getBwdate() %>
						</td>
					</tr>
					<tr>
						<td id="bnote" name="bnote" style="width:700px; border:none; outline:none;" readonly="readonly">
							<%= vo.getBnote() %>
						</td>
					</tr>
					<tr>
						<!-- ÷������ ��� ���� -->
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
					if(login != null && login.getLevel().equals("A") || login != null && vo.getEmail().equals(login.getEmail()))
					{
						%>
						<input type="submit" value="����" id="delete" onclick="javascript:DoDelete('<%= bno %>');">
						<input type="submit" value="����" id="modify" onclick="javascript:location.href='modify.jsp?category<%= category %>&bno=<%= vo.getBno() %>&page=<%= page %>'">
						<%
					}
					%>
				</div>
				<!-- //.btn_area -->
				<br>
				<!-- ��� ���� ���� -->
				<%			
				ReplyDTO rdto = new ReplyDTO();
				ArrayList<ReplyVO> list = rdto.list(bno);
				%>
				<%
				if(login != null && login.getLevel().equals("A"))
				{
					%>
					<form id="replyFrm" name="replyFrm" method="post" action="replyok.jsp">
						<input type="hidden" name="bno" value="<%= bno %>">
						<table class="inquiry_reply" id="inquiry_reply">
							<tr>
								<td style="border:none;">
								<textarea name="rnote" id="rnote"></textarea>
								</td>
							</tr>
						</table>
						<input type="submit" class="replybtn" id="replybtn" name="replybtn" value="���">
					</form>
					<%
				}
				%>
				<%
				for(ReplyVO reply : list)
				{
					%>
					<input type="hidden" name="rno" value="<%= reply.getRno() %>">
					<input type="hidden" name="bno" value="<%= bno %>">
					<table class="inquiry_reply">
						<tr>
							<td style="width:50px">������</td>
							<td>
							<div style="vertical-align: middle;">
							<textarea name="rnote" id="rnote" readonly="readonly" style="border:none;"><%= reply.getRnote() %></textarea>
							</div>
							</td>
						</tr>
					</table>
					<%
					if(login != null && login.getLevel().equals("A"))
					{
						%>
						<input type="submit" class="replydelete" id="replydelete" name="replydelete" onclick="javascript:replyDelete('<%= reply.getRno() %>')" value="����">
						<%
					}
				}
				%>
				<!-- ��� ���� �� -->
			</div>
			<!-- //.view_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  ������ ������ �κ� -->
</section>
<%@ include file="../../include/tail.jsp"%>