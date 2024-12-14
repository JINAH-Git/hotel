<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<link rel="stylesheet" type="text/css" href="/hotel2/style/contents.css" />
<link rel="stylesheet" type="text/css" href="/hotel2/style/event.css" />
<%@include file="../../include/head.jsp" %>
<%
String acategory = request.getParameter("category");
if (acategory == null) acategory = "E";

//�Խù� ���
AdminDTO dto = new AdminDTO();
ArrayList<AdminVO> list = dto.list(acategory);

%>
<section style="height:auto;">
<div class="main">
	<div class="menubar">
		<h2>���θ��</h2>
		<hr>
		<ul class="menu">
			<li><a href="../event/index.jsp?acategory=E" style="background-color: white; padding: 0 30px;">�̺�Ʈ</a></li>
			<li><a href="../review/index.jsp?category=R">����</a></li>
		</ul>
		<!-- //.menu -->
	</div>
	<!-- //.menubar -->
	<div class="contents">
		<h3>�̺�Ʈ</h3>
		<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ���θ�� &gt; �̺�Ʈ</p>
		<hr>
		<div class="event_inner">
			<div class="event_write">
				<span class="adminBtn">
					<% 
					if( login == null || login.getLevel().equals("U")){}
					else if(login.getLevel().equals("A"))
					{
						%>
						<a href="write.jsp">�۾���</a>
						<%
					}
					%>
				</span>
			</div>
			<!-- //.event_write -->
			<div class="event_slt">
			<%
			for(AdminVO vo : list)
			{
				if(vo.getAfname().equals("") || vo.getAfname() == null)
				{
					%>
					<div class="event_core">
					<a href="view.jsp?acategory=<%= vo.getAcategory() %>&ano=<%= vo.getAno() %>"><img src="../../image/none.jpg"/></a>
					<br>
					<a href="view.jsp?acategory=<%= vo.getAcategory() %>&ano=<%= vo.getAno() %>"><%= vo.getAtitle() %></a>
					</div>
					<%
				}else
				{
					%>
					<div class="event_core">
					<a href="view.jsp?acategory=<%= vo.getAcategory() %>&ano=<%= vo.getAno() %>"><img src="down.jsp?ano=<%= vo.getAno() %>"/></a>
					<br>
					<a href="view.jsp?acategory=<%= vo.getAcategory() %>&ano=<%= vo.getAno() %>"><%= vo.getAtitle() %></a>
					</div>
					<%
				}
			}
			%>
			</div>
			<!-- //.event_slt -->
		</div>
		<!-- //.event_inner -->
	</div>
	<!-- //.contents -->
</div>
</section>
<!-- //.main -->
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>