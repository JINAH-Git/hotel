<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ include file="../../include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/admresv.css" />
<script src="/hotel2/js/jquery-3.7.0.js"></script>
<%
if(login == null || login.getLevel() == null || login.getLevel().equals("U"))
{
	%>
	<script>
	alert("���� ������ �����ϴ�.");
	window.location.href="../../index.jsp";
	</script>
	<%
}

ReserDTO dto = new ReserDTO();
//Date now = new Date();//���� ��¥ ��������?

//���� Ÿ�Կ� ���� �������� �������� 		
ArrayList<ReserVO> list1 = dto.list("S");
ArrayList<ReserVO> list2 = dto.list("D");
ArrayList<ReserVO> list3 = dto.list("F");
ArrayList<ReserVO> list4 = dto.list("ST");

//��¥ �� �ϱ� ����
LocalDate now = LocalDate.now();
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
int today = Integer.parseInt(now.format(formatter));
%>
<!-- ������ �����ϴ� �κ� -->
<section>
	<!-- ������ �����ϴ� �κ� -->
	<script>
	//���� Ÿ�� ��
	$(function(){
		$('.cont_area > div').hide();
		$('.list2 a').click(function () {
			$('.cont_area > div').hide().filter(this.hash).fadeIn();
			$('.list2 a').removeClass('active');
			$(this).addClass('active');
			return false;
		}).filter(':eq(0)').click();
	});
	</script>
	<div class="main">
		<div class="menubar">
			<h2>������ ������</h2>
			<hr>
			<ul class="menu">
				<li><a href="../userctrl/">ȸ�� ���� ����</a></li>
				<li><a href="../pricectrl/">���� ���� ����</a></li>
				<li><a href="../resvctrl/" style="background-color: white;  padding: 0 30px;">���� ���� ��ȸ</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>���� ���� ��ȸ</h3>
			<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; ������ ������ &gt; ���� ���� ��ȸ</p>
			<br>
			<hr>
			<div class="tab_menu">
				<ul class="list2">
					<li><a href="#tab1"> ���Ĵٵ� </a></li>
					<li><a href="#tab2"> ���� </a></li>
					<li><a href="#tab3"> �йи� </a></li>
					<li><a href="#tab4"> ����Ʈ </a></li>
				</ul>
			<!-- ���� -->
				<div class="cont_area" style="overflow-x:hidden;">
					<div id="tab1">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">����<br>Ÿ��</td>
								<td width="50px">����<br>��ȣ</td>
								<td width="100px">������ ����</td>
								<td width="90px">üũ��<br>��¥</td>
								<td width="90px">üũ�ƿ�<br>��¥</td>
								<td width="100px">���� �ο�</td>
								<td width="90px">���� ����</td>
								<td width="80px">�� <br> ���� �ݾ�</td>
								<td width="130px">��û����</td>
							</tr>
							<%
							if(list1.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">���Ĵٵ� �뿡 ��ȸ�� ���� ������ �����ϴ�.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list1)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">���Ĵٵ� ��</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>���� <%= vo.getAdcnt() %>�� <br> ��� <%= vo.getChcnt() %>��<br> ��� <%= vo.getKidcnt() %>��</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "��û���� ����" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}
							%>
					</table>
					</div>
					<div id="tab2">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">����<br>Ÿ��</td>
								<td width="50px">����<br>��ȣ</td>
								<td width="100px">������ ����</td>
								<td width="90px">üũ��<br>��¥</td>
								<td width="90px">üũ�ƿ�<br>��¥</td>
								<td width="100px">���� �ο�</td>
								<td width="90px">���� ����</td>
								<td width="80px">�� <br> ���� �ݾ�</td>
								<td width="130px">��û����</td>
							</tr>
							<%
							if(list2.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">���� �뿡 ��ȸ�� ���� ������ �����ϴ�.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list2)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">���� ��</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>���� <%= vo.getAdcnt() %>�� <br> ��� <%= vo.getChcnt() %>��<br> ��� <%= vo.getKidcnt() %>��</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "��û���� ����" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}

							%>
						</table>
					</div>
					<div id="tab3">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">����<br>Ÿ��</td>
								<td width="50px">����<br>��ȣ</td>
								<td width="100px">������ ����</td>
								<td width="90px">üũ��<br>��¥</td>
								<td width="90px">üũ�ƿ�<br>��¥</td>
								<td width="100px">���� �ο�</td>
								<td width="90px">���� ����</td>
								<td width="80px">�� <br> ���� �ݾ�</td>
								<td width="130px">��û����</td>
							</tr>
							<%
							if(list3.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">�йи� �뿡 ��ȸ�� ���� ������ �����ϴ�.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list3)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">�йи� ��</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>���� <%= vo.getAdcnt() %>�� <br> ��� <%= vo.getChcnt() %>��<br> ��� <%= vo.getKidcnt() %>��</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "��û���� ����" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}

							%>
						</table>
					</div>
					<div id="tab4">
						<table id="usertable" border="1">
							<tr style="background-color:#e4e4e4; font-weight:bold;">
								<td width="70px">����<br>Ÿ��</td>
								<td width="50px">����<br>��ȣ</td>
								<td width="100px">������ ����</td>
								<td width="90px">üũ��<br>��¥</td>
								<td width="90px">üũ�ƿ�<br>��¥</td>
								<td width="100px">���� �ο�</td>
								<td width="90px">���� ����</td>
								<td width="80px">�� <br> ���� �ݾ�</td>
								<td width="130px">��û����</td>
							</tr>
							<%
							if(list4.isEmpty())
							{
								%>
								<tr style="height:70px;">
									<td colspan="9">����Ʈ �뿡 ��ȸ�� ���� ������ �����ϴ�.</td>
								</tr>
								<%
							}
							for(ReserVO vo : list4)
							{
								int indate = Integer.parseInt(vo.getCheckindate().replace("-", ""));
								int outdate = Integer.parseInt(vo.getCheckoutdate().replace("-", ""));
								
								if(today > indate && today > outdate){}
								else
								{
									%>
									<tr style="height:70px;">
										<td style="background-color:#e4e4e4;">����Ʈ ��</td>
										<td><%= vo.getResvno() %></td>
										<td><%= vo.getEname() %></td>
										<td><%= vo.getCheckindate() %></td>
										<td><%= vo.getCheckoutdate() %></td>
										<td>���� <%= vo.getAdcnt() %>�� <br> ��� <%= vo.getChcnt() %>��<br> ��� <%= vo.getKidcnt() %>��</td>
										<td><%= vo.getResvdate() %></td>
										<td><%= vo.getTotalprice() %></td>
										<%
										if(vo.getRequest().equals("null") || vo.getRequest() == null)
										{
											%><td><%= "��û���� ����" %></td><%
										}else
										{
											%><td><%= vo.getRequest() %></td><%
										}
										%>
									</tr>
									<%
								}
							}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>