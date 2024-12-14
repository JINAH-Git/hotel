<!-- 
�ۼ���: �念��
�ۼ���: 23.07.10 (��)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
String checkin  = request.getParameter("checkin");
String checkout = request.getParameter("checkout");
String night    = request.getParameter("night");
String rtype    = request.getParameter("rtype");
String adcnt    = request.getParameter("adult");
String chcnt    = request.getParameter("child");
String kidcnt   = request.getParameter("kid");

if(adcnt == null || chcnt == null || kidcnt == null)
{
	%>
	<script>
		alert("�Է��� �����Ͱ� �ùٸ��� �ʽ��ϴ�.");
		location.href = "step1.jsp";
	</script>
	<%
}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>���� 2�ܰ�</title>		
		<link rel="stylesheet" type="text/css" href="../../style/resv.css" />
	</head>

<%@ include file="../../include/head.jsp" %>
<%
if(login == null)
{	
	response.sendRedirect("../../user/login.jsp");
	return;
}

//�̸��Ϸ� ������ ������ ������ �ִ��� ��ȸ
ReserDTO dto = new ReserDTO();
ReserVO resvinfo = dto.reademail(login.getEmail());
int resvno = resvinfo.getResvno();
if(resvno != 0)
{
	//������ ������ ������ �ִٸ�
	%>
	<script>
		alert("������ ������ ������ �ֽ��ϴ�.");
		location.href = "../confirm.jsp?resvno=" + <%= resvno %>;
	</script>
	<%
}
%>
<section>
	<div class="main">
		<div class="stepWrap">
			<ul class="step">
				<li id="step1">1</li>&nbsp; &ndash; &nbsp;
				<li id="step2" style="background-color: brown; color: white;">2</li>&nbsp; &ndash; &nbsp;
				<li id="step3">3</li>
			</ul>
		</div>
		<!-- //.stepWrap -->
		<p>���� ����</p>
		<div id="contents2" style="width: 1000px; margin: 0 auto;">
			<form action="step3.jsp" method="post">
				<input type="hidden" value=<%= checkin %> name="checkin">
				<input type="hidden" value=<%= checkout %> name="checkout">
				<input type="hidden" value=<%= night %> name="night">
				<input type="hidden" value=<%= rtype %> name="rtype">
				<input type="hidden" value=<%= adcnt %> name="adult">
				<input type="hidden" value=<%= chcnt %> name="child">
				<input type="hidden" value=<%= kidcnt %> name="kid">
				<table>
					<tr>
						<%
						String roomimg = "";
						if(rtype.equals("S"))  roomimg = "standard.jpg";
						if(rtype.equals("D"))  roomimg = "double.jpg";
						if(rtype.equals("F"))  roomimg = "family.jpg";
						if(rtype.equals("ST")) roomimg = "suite.jpg";
						%>
						<td rowspan="2"><img src="/hotel2/image/<%= roomimg %>" width="400px;" height="300px;"></td>
						<td>
							<div style="width: 600px; padding: 15px 20px;">
								- ���� ������ 10%�� �ΰ���ġ���� �ΰ��˴ϴ�.<br>
								- üũ���� 15:00, üũ�ƿ��� 12:00���Դϴ�.<br>
								- ���(No-Show)�� ���� ����� ȯ���� �Ұ��մϴ�.<br>
								- ��ü����� 063 - 252 - 1234 ����ó�� ���ǹٶ��ϴ�.	<br>
								- �̼������� ���, ���� ��ȣ�� ���ݿ� ���Ͽ� üũ�� �� ������ �����մϴ�.<br>
								- ���ĺ�ȭ �Ǵ� õ������ ���� �Ұ��׷��� ��Ȳ���� ȣ���� ������ ������ �Ұ��� ���, 
								ȣ���� ���� (�޴���ȭ ����, Ȩ������ ���� ��)�� ���Ͽ� ������ ��ҵǰų� ȣ�� ���� �̿��� ���ѵ� �� �ֽ��ϴ�.<br>
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="width: 600px; padding: 15px 20px;">
								<b>Requests</b> <br>
								<textarea placeholder="ȣ�� �̿�� �����Ͻ� ������ �����ø� �Է��� �ּ���." name="req" style="width: 600px; height: 70px; outline: none; resize: none; font-size: 16px;"></textarea>
							</div>
						</td>
					</tr>
				</table>
				<table style="margin-top: 70px;">
					<tr>
						<td>
							<div style="width: 1000px; padding: 15px 20px; text-align: center; font-size: 24px; font-weight: bold;">
								�� ���ǻ���, ��� �� ȯ�� ������ ��� Ȯ�����ּ���.
							</div>
						</td>
					</tr>
					<tr>
						<td>
							<div style="width: 1000px; padding: 15px 20px; text-align: center; font-size: 24px; font-weight: bold;">
								<input type="submit" value="Ȯ��" style="background: #DFDFE3; padding: 5px 10px; font-size: 24px; border-radius: 5%; border: 1px solid #DFDFE3; cursor: pointer;">
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
		<!-- //#contents2 -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>