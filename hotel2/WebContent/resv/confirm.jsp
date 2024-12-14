<!-- 
�ۼ���: �念��
�ۼ���: 23.07.10 (��)
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>����Ȯ��</title>		
		<link rel="stylesheet" type="text/css" href="../style/resv.css" />
	</head>
<%@ include file="../include/head.jsp" %>
<%
ReserDTO dto = new ReserDTO();
ReserVO vo = null;
String roomimg = "standard.jpg"; //���Ĵٵ������ �ʱ�ȭ
//�α��� ���¿��� ����Ȯ�� �ϴ� ���
if(login != null)
{	
	vo = dto.reademail(login.getEmail());
	if(vo.getResvno() == 0)
	{
		%>
		<script>
			alert("���������� �����ϴ�.");
			location.href = "./../index.jsp";
		</script>
		<%
		return;
	}
	if(vo.getRtype().equals("D"))  roomimg  = "double.jpg";
	if(vo.getRtype().equals("F"))  roomimg  = "family.jpg";
	if(vo.getRtype().equals("ST")) roomimg = "suite.jpg";
}
else //��α��� ���¿��� ���� Ȯ���ϴ� ���
{	
	String resvno = request.getParameter("resvno");
	if(resvno == null)
	{
		response.sendRedirect("findresv.jsp");
		return;
	}
	vo = dto.readresvno(Integer.parseInt(resvno));
	if(vo.getResvno() == 0)
	{
		%>
		<script>
			alert("��ȸ�Ͻ� �����ȣ�� ���������� �����ϴ�.");
			location.href = "findresv.jsp";
		</script>
		<%
		return;
	}
	if(vo.getRtype().equals("D"))  roomimg  = "double.jpg";
	if(vo.getRtype().equals("F"))  roomimg  = "family.jpg";
	if(vo.getRtype().equals("ST")) roomimg = "suite.jpg";
}
%>
<script>
	window.addEventListener('load',function()
	{
		//���ư��� ��ư Ŭ���ϸ� �������� �̵��Ѵ�.
		$("#return").click(function(){
			location.href = "../index.jsp";
		})
		
	});
	
	function cancel(resvno)
	{
		if(!confirm("������ ����Ͻðڽ��ϱ�?") == false)
		{
			location.href = "delete.jsp?resvno=" + resvno;			
		}
	}
</script>
<section>
	<div class="main">
		<p>���� Ȯ��</p>
		<table style="position: relative;">
			<tr>
				<td rowspan="2"><img src="/hotel2/image/<%= roomimg %>" width="500px;" height="320px;"></td>
				<td>
					<div style="width: 600px; padding: 15px 20px;">
						<table border="1" style="width: 400px; height: 500px; text-align: center; position: absolute; border-collapse:collapse;
						border-colo:#66575A;border-left:none;border-right:none;border-width:2px 0px 2px 0px; top: 0; right: 0">
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">���� ��ȣ</td>
							</tr>
							<tr>
								<td><%= vo.getResvno() %></td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">���� �ο�</td>
							</tr>
							<tr>
								<td>���� <%= vo.getAdcnt() %>��,��� <%= vo.getChcnt() %>��,���� <%= vo.getKidcnt() %>��</td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">üũ�� ��¥ - üũ�ƿ� ��¥</td>
							</tr>
							<tr>
								<td><%= vo.getCheckindate() %> - <%= vo.getCheckoutdate() %></td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">�� ���� �ݾ�(���� 10% VAT ����)</td>
							</tr>
							<tr>
								<td><%= vo.getTotalprice() %> KRW</td>
							</tr>
							<tr>
								<td style="font-weight: bold; background-color:#F5F5F7">��û ����</td>
							</tr>
							<tr>
								<td style="height: 50px;"><%= vo.getRequest() %></td>
							</tr>
						</table>	
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div style="position: absolute; top: 330px; left: 0">
						- ���� ������ 10%�� �ΰ���ġ���� �ΰ��˴ϴ�.<br>
						- üũ���� 15:00, üũ�ƿ��� 12:00���Դϴ�.<br>
						- ���(No-Show)�� ���� ����� ȯ���� �Ұ��մϴ�.<br>
						- �̼������� ���, ���� ��ȣ�� ���ݿ� ���Ͽ� üũ�� �� ������ �����մϴ�.<br>
					</div>
				</td>
			</tr>
			<tr>
				<td>
					<div style="position: absolute; top: 460px; left: 0;">
						<%
						if(login != null)
						{
							%>
							<input type="button" class="cnclbtn" value="�������" onclick="cancel(<%= vo.getResvno() %>)" >
							<%
						}
						%>
						<input type="button" class="rtnbtn" value="���ư���" id="return">
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!-- //.main -->
</section>
<%@ include file="../include/tail.jsp" %>
