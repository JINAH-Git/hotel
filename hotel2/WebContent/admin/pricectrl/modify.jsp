<!-- 
�ۼ���: ������
�ۼ���: 23.06.30.�� 
�ۼ���: 23.07.06.��
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../../include/head.jsp"%>
<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
<link rel="stylesheet" type="text/css" href="../../style/adprice.css" />
<script src="./js/jquery-3.7.0.js"></script>
<%
if(login.getLevel() == null || login.getLevel().equals("U"))
{
	%>
	<script>
	alert("���� ������ �����ϴ�.");
	window.location.href="../../index.jsp";
	</script>
	<%
}
//���� ���� ��������
RoomctrDTO dto = new RoomctrDTO();
RoomctrVO vo = new RoomctrVO();

//���Ĵٵ�� ����
vo = dto.priceread("S"); 
int stdadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int stdchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//������ ����
vo = dto.priceread("D"); 
int dbadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int dbchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//�йи��� ����
vo = dto.priceread("F"); 
int famadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int famchpri = Integer.parseInt(vo.getChprice().replace(",", ""));

//����Ʈ�� ����
vo = dto.priceread("ST"); 
int suitadpri = Integer.parseInt(vo.getAdprice().replace(",", ""));
int suitchpri = Integer.parseInt(vo.getChprice().replace(",", ""));
%>
<!-- ������ �����ϴ� �κ� -->
<script>
	function onlyNumber(obj) {
	  obj.value = obj.value.replace(/[^0-9]/g, "");
	}
	
	window.onload = function()
	{
		$("#stdadpri").focus();
			
		$("#btnSubmit").click(function(){
			//��� ������ ���������� Ȯ���Ѵ�.
			if($("#stdadpri").val() == "")	{	alert("���Ĵٵ� ���� ���� ������ ������ �ּ���.");		$("#stdadpri").focus();		return;	}
			if($("#stdchpri").val() == "")	{	alert("���Ĵٵ� ���� ��� ������ ������ �ּ���");		$("#stdchpri").focus();		return;	}
			if($("#dbadpri").val() == "")	{	alert("���� ���� ���� ������ ������ �ּ���");			$("#dbadpri").focus();		return;	}
			if($("#dbchpri").val() == "")	{	alert("���� ���� ��� ������ ������ �ּ���");		$("#dbchpri").focus();		return;	}
			if($("#famadpri").val() == "")	{	alert("�йи� ���� ���� ������ ������ �ּ���");		$("#famadpri").focus();		return;	}
			if($("#famchpri").val() == "")	{	alert("�йи� ���� ��� ������ ������ �ּ���");		$("#famchpri").focus();		return;	}
			if($("#suitadpri").val() == "")	{	alert("����Ʈ ���� ���� ������ ������ �ּ���");		$("#suitadpri").focus();	return;	}
			if($("#suitchpri").val() == "")	{	alert("����Ʈ ���� ��� ������ ������ �ּ���");		$("#suitchpri").focus();	return;	}
			
			if(confirm("������ ������ �����Ͻðڽ��ϱ�?") == false)	return;	
			
			$("#priceFrm").submit();
		});
		
		$("#btnCancel").click(function(){
			if(confirm("���� ������ ����Ͻðڽ��ϱ�?") == false) return;
			document.location = "index.jsp";
		});
	}
</script>
<section>
<div class="main">
	<div class="menubar">
		<h2>������ ������</h2>
		<hr>
		<ul class="menu">
			<li><a href="../userctrl/">ȸ�� ���� ����</a></li>
			<li><a href="../pricectrl/" style="background-color: whitew; padding: 0 30px;">���� ���� ����</a></li>
			<li><a href="../resvctrl/">���� ���� ��ȸ</a></li>
		</ul>
		<!-- //.menu -->
	</div>
	<!-- //.menubar -->
	<div class="contents">
		<h3>���� ���� ����</h3>
		<p class="list"><img src="../../image/home.png" width="20px;" height="20px;"> &gt; ������ ������ &gt; ���� ���� ����</p>
		<br>
		<hr>
	<form id="priceFrm" name="priceFrm" method="post" action="modifyok.jsp">		
	<table border="0">
		<tr>
			<td><br></td>
		</tr>
		<tr>
			<td>
				<table border="1" id="pricetable">
					<tr class="T">
						<td style="width:100px">����</td>
						<td style="width:350px">���� ���� ����</td>
						<td style="width:350px">���� ��� ����</td>
					</tr>
					<tr>
						<td	class="S">���Ĵٵ�</td>
						<td><input type="text" id="stdadpri" name="stdadpri" maxlength="9" value="<%= stdadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="stdchpri" name="stdchpri" maxlength="9" value="<%= stdchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="D">����</td>
						<td><input type="text" id="dbadpri" name="dbadpri" maxlength="9" value="<%= dbadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="dbchpri" name="dbchpri" maxlength="9" value="<%= dbchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="F">�йи�</td>
						<td><input type="text" id="famadpri" name="famadpri" maxlength="9" value="<%= famadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="famchpri" name="famchpri" maxlength="9" value="<%= famchpri  %>" onKeyup="onlyNumber(this)"></td>
					</tr>
					<tr>
						<td class="ST">����Ʈ</td>
						<td><input type="text" id="suitadpri" name="suitadpri" maxlength="9" value="<%= suitadpri  %>" onKeyup="onlyNumber(this)"></td>
						<td><input type="text" id="suitchpri" name="suitchpri" maxlength="9" value="<%= suitchpri  %>" onKeyup="onlyNumber(this)"></td>	
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td style="text-align:center;">
				<br>
				�ؼ����� : 1��, 2��, 7��, 8��, 9��, 12��
				<br> 
				�غ񼺼��� : 3��, 4��, 5��, 6��, 10��, 11��
				<br>
				�ذ����� 10��� �̸����� ���� �����մϴ�.
				<br>
				<br>
			</td>
		</tr>
		<tr>
			<td>
			<input type="button" id="btnSubmit" value="����">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" id="btnCancel" value="���">
			</td>
		</tr>
	</table>
	</form>
	</div>
	<!-- //.contents -->
</div>
<!-- //.main -->
</section>
<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp"%>