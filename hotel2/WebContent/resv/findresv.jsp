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
		<title>�����ȣ�� ����Ȯ��</title>		
		<link rel="stylesheet" type="text/css" href="../style/resv.css" />
	</head>
	<script>
		window.addEventListener('load',function()
		{
			$("#resvno").focus();
			$("#resvBtn").click(function(){
				if($("#resvno").val() == "")
				{
					alert("��ȣ�� �Է����ּ���.");
					$("#resvno").focus();				
					return false;
				}
				$("#resvFrm").submit();
			});
		});
	</script>
<%@ include file="../../include/head.jsp" %>
<section>
	<div class="main">
		<p style="margin-top: 130px; font-size: 34px;">���� Ȯ��</p>		
		<div id="contents" style="text-align: center; padding: 50px 0;">
			<form id="resvFrm" action="/hotel2/resv/confirm.jsp">
				<input type="text" id="resvno" name="resvno" placeholder="�����ȣ" style="width: 300px; height: 50px; margin: 0 auto; font-size: 25px; outline: none;"><br>
				<input type="button" id="resvBtn" value="��ȸ�ϱ�" style="background: #DFDFE3; padding: 5px 10px; font-size: 24px; border-radius: 5%; border: 1px solid #DFDFE3; cursor: pointer; margin-top: 50px;">
			</form>
		</div>
		<!-- //#contents -->
	</div>
	<!-- //.main -->
</section>
<%@ include file="../../include/tail.jsp" %>
