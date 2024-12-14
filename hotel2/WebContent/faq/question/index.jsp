<!-- 
23-07-10 ���� | jsp �ۼ���.
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="../../include/head.jsp" %>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<%
//���� ���� ������ ī�װ� ���� ����
String acategory = request.getParameter("acategory");
if (acategory == null) acategory = "Q";

//ano���� request���� �޴´�.
String ano = request.getParameter("ano");

//����¡ó���� ����
int curPage = 1;
try //������ �����͸� �޴´�.
{
	curPage = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

AdminDTO dto = new AdminDTO();
System.out.println(acategory);

ArrayList<AdminVO> list = dto.list(acategory, curPage);

int dataTotal = dto.gettotal(acategory);
%>
<style>
	.question_inner
	{
		width:700px;
		height:600px;
		margin:85px;
	}
	.search_area
	{
		position:relative;
		bottom:53px;
	}
	#qtable
	{
		height:50px;
	}
	.ul_area
	{
		height:500px;
	}
	.ul_area > hr
	{
		width:700px;
		height:2px;
		background-color:black;
	}
</style>
<!-- ������ �����ϴ� �κ� -->
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
<script>
	window.addEventListener('load',function()
	{		
		$("#qlist0").click(function(){
			if($("#qnote0").css('display') == 'none')
			{
				$("#qnote0").css('display','block');
			}else
			{
				$("#qnote0").css('display','none');
			}
		});
		$("#qlist1").click(function(){
			if($("#qnote1").css('display') == 'none')
			{
				$("#qnote1").css('display','block');
			}else
			{
				$("#qnote1").css('display','none');
			}
		});
		$("#qlist2").click(function(){
			if($("#qnote2").css('display') == 'none')
			{
				$("#qnote2").css('display','block');
			}else
			{
				$("#qnote2").css('display','none');
			}
		});		
		$("#qlist3").click(function(){
			if($("#qnote3").css('display') == 'none')
			{
				$("#qnote3").css('display','block');
			}else
			{
				$("#qnote3").css('display','none');
			}
		});		
		$("#qlist4").click(function(){
			if($("#qnote4").css('display') == 'none')
			{
				$("#qnote4").css('display','block');
			}else
			{
				$("#qnote4").css('display','none');
			}
		});		
		$("#qlist5").click(function(){
			if($("#qnote5").css('display') == 'none')
			{
				$("#qnote5").css('display','block');
			}else
			{
				$("#qnote5").css('display','none');
			}
		});		
		$("#qlist6").click(function(){
			if($("#qnote6").css('display') == 'none')
			{
				$("#qnote6").css('display','block');
			}else
			{
				$("#qnote6").css('display','none');
			}
		});	
		$("#qlist7").click(function(){
			if($("#qnote7").css('display') == 'none')
			{
				$("#qnote7").css('display','block');
			}else
			{
				$("#qnote7").css('display','none');
			}
		});	
	});
	
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
				alert("�Խù��� �����Ǿ����ϴ�.");
				document.location = "index.jsp?acategory=<%= acategory %>";
			},
			error : function(xhr, status, error) 
			{
				// ��� ���� �߻���
			}
		});
	}
</script>
<!-- ���� ������ ����  -->
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
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; �� ���� &gt; ���� ���� ����</p>
			<hr>
			<%
				if( login != null && login.getLevel().equals("A") )
				{
					%>
					<a href="write.jsp" id="qwrite" name="qwrite" style="text-decoration:none; color:black; position:absolute; right:30px;">�۾���</a>
					<%
				}
			%>
			<div class="question_inner">
				<div class="drop_menu">
					<ul class="ul_area">			
						<%
						for(int i = 0; i < list.size(); i++ )
						{
							%>
							<hr>
							<li id="qlist<%= i %>" style="height:50px; font-size:22px;"><%= list.get(i).getAtitle() %></li>
							<li id="qnote<%= i %>" style="height:50px; font-size:18px; text-align:left; display:none;">
							<%= list.get(i).getAnote() %> <!-- null �����͸� �ҷ��������� ���� -->
							</li>
							<div style="float:right;">
							<%
							if( login != null && login.getLevel().equals("A") )
							{
								%>
								<input type="submit" value="����" onclick="javascript:location.href='modify.jsp?acategory<%= acategory %>&ano=<%= list.get(i).getAno() %>&page=<%= page %>'"> 
								|
								<input type="submit" value="����" onclick="javascript:DoDelete('<%= list.get(i).getAno() %>');">
								<%
							}
							%>
							</div>
							<%
						}
						%>
					</ul>
				</div>
				<!-- //.drop_menu -->
			</div>
			<!-- //.question_inner -->
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
	<!--  ������ ������ �κ� -->
</section>
<%@ include file="../../include/tail.jsp"%>