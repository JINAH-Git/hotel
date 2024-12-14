<!-- 
������ / 23.07.05.��, 23.07.06.�� /������ ���� �Ϸ�
������/ 23.07.17.�� / ������, ��� ����
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>��й�ȣ ã��</title>
		<link rel="stylesheet" type="text/css" href="../style/uspwfnd.css" />
	</head>
	<%@ include file="../include/head.jsp"%>
		<script>
		window.addEventListener('load', function()
		{
			$(".birthtext").keyup(function(){
				samecheck();
			});
			
			$(".emailid").keyup(function(){
				samecheck();
			});
			
			//������� �Է�
			$(document).on("keyup", ".birthtext", function() {
		     $(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/([0-9]{4})+([0-9]{2})+([0-9]{2})$/,"$1-$2-$3").replace("--", "-"));
		    });
			
			$(".emailbutton").click(function(){
				if(checkCode == "false")
				{
					alert("������ ��ġ���� �ʽ��ϴ�. ��й�ȣ ã�⸦ ������ �� �����ϴ�.");
					return false;
				}
				if(checkCode == "ERROR")
				{
					alert("������ �Է����ּ���.");
					return false;
				}
				if(checkCode == "true")
				{
					alert("���� Ȯ�� �Ǿ����ϴ�. �̸��� �߼۱��� ��ø� ��ٷ��ּ���")
					emailid = $(".emailid").val();
					$.ajax({
						type : "get",
						url: "pwfindck.jsp?emailid=" + emailid,
						dataType: "html",	//html,xml,json
						success : function(data) 
						{	
							//�̸��� ������
							data = data.trim();
							alert(data);
							if(data == "�Է��Ͻ� �̸��Ϸ� �ڵ带 �߼��Ͽ����ϴ�. �ڵ带 �Է����ּ���.")
							{
								 $(".ecode").focus();
							}
						},
						error : function(xhr, status, error){alert("���� �ڵ� �߼� ����");}
					});
				}
			});
		});
		
		//���¸� �����ϱ� ���� ����
		var checkCode = "ERROR"
		
		function samecheck()
		{
			checkCode = "ERROR"
			
			birthtext = $(".birthtext").val();
			if(birthtext == "")
			{
				$("#msg").html("��������� �Է��ϼ���");
				return;
			}
			
			emailid = $(".emailid").val();		
			if(emailid == "")
			{
				$("#msg").html("���̵� �Է��ϼ���");
				return;
			}
			
			$.ajax({
				type : "get",
				url: "pwfindok.jsp?birthtext=" + birthtext + "&emailid=" + emailid,
				dataType: "html",	//html,xml,json
				success : function(data) 
				{	
					// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
					data = data.trim();
					console.log(data);
					
					checkCode = data;
					
					//true,false
					switch(data)
					{
					case "false" :
						$("#msg").html("�Է��Ͻ� ������ ��ġ���� �ʽ��ϴ�.");
						break;
					case "true" :
						$("#msg").html("�Է��Ͻ� ������ ��ġ�մϴ�.");
						break;
					case "ERROR" :
						$("#msg").html("������ �Է����ּ���.");
						break;
					}
				},
				error : function(xhr, status, error){}
			});
		}
		</script>
		<!-- ������ �����ϴ� �κ� -->
		<div class="main">
			<!-- �α��� ǥ�� ���� -->
			<div class="introduction">
				<div class="introhead">
					<h1> &nbsp;&nbsp; Identification</h1>
					<p class="pwfindtotaltext"><em>ȸ�������� �̸��� �ּҿ� �Է��� �̸��� �ּҰ� ���ƾ�, ������ȣ�� ���� �� �ֽ��ϴ�.</em></p>
				</div>
			</div>
			<!-- ��й�ȣ ã�� �� ���� -->
			<form method="post" action="pwfindfin.jsp" name="pwfindfin" id="pwfindfin">
				<!-- ��й�ȣ ã��  -->
				<div class="pwfindtotal">
					<hr class="line">
					<!-- ������� �ڸ�Ʈ -->
					<div class="infodovalue9">BIRTH DATE*</div>
					<br>
					<div class="birth">
						<input type="text" class="birthtext" name="birthtext" placeholder="1900-01-03">
					</div>
					<!-- �̸��� �Է� ���� ���� -->
					<br>
					<div class="email">
						<div class="infodovalue4">ID *</div>
						<br>
						<input type="text" class="emailid" name="emailid" placeholder="�̸���">
						<input type="button" value="������ȣ �ޱ�" class="emailbutton" name="emailbutton">
					</div>
					<br>
					<!-- ������ȣ Ȯ�� ���� -->
					<div class="codestart">
						<div class="codecomment">Verification Code *</div> <span id="msg"></span>
						<br>
						<input type="text" class="ecode" name="ecode" placeholder="������ȣ�� �Է����ּ���.">					
						<input type="submit" value="Ȯ��" class="codestartcheck">
					</div>
				</div>
			</form>
			<!-- ��й�ȣ ã�� �� ��  -->
			<div id="txtGuide"></div>
		</div>
		<!-- //.main -->
	<!--  ������ ������ �κ� -->
<%@ include file="../../include/tail.jsp" %>