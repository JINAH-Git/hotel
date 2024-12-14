<!-- 
�ۼ���: 23.07.19.��
�ۼ���: ������
���̵� ������ ����
 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>�α��� | ȣ��</title>
		<link rel="stylesheet" href="../style/login.css">
	</head>

	<%@include file="../include/head.jsp" %>
		<script>
		window.onload = function()
		{
			$("#useremail").focus();
			
			//�α��� ��ư ������ �� ���
			$("#login_button").click(function()
			{
				if($("#useremail").val() == "")
				{
					alert("���̵� �Է����ּ���.");
					$("#useremail").focus();		
					return false;
				}
				if($("#userpw").val() == "")
				{
					alert("��й�ȣ�� �Է����ּ���.");
					$("#userpw").focus();
					return false;
				}		
				return true;
			});
			
			//���̵� ������ ����
			$(document).ready(function()
			{
				// ����� ��Ű���� �����ͼ� ID ĭ�� �־��ش�. ������ �������� ��.
			    var key = getCookie("login");
			    $("#useremail").val(key); 
		     
			    // �� ���� ID�� �����ؼ� ó�� ������ �ε� ��, �Է� ĭ�� ����� ID�� ǥ�õ� ���¶��,
			    if($("#useremail").val() != "")
			    { 
		        	$("#checidkbox").attr("checked", true); // ID �����ϱ⸦ üũ ���·� �α�.
	    		}
		     
			    $("#checidkbox").change(function() // üũ�ڽ��� ��ȭ�� �ִٸ�,
	    		{
			        if($("#checidkbox").is(":checked")) // ID �����ϱ� üũ���� ��,
			        {
			            setCookie("login", $("#useremail").val(), 7); // 7�� ���� ��Ű ����
			        }
			        else // ID �����ϱ� üũ ���� ��,
			        {
			            deleteCookie("login");
			        }
		    	});
		     
			    // ID �����ϱ⸦ üũ�� ���¿��� ID�� �Է��ϴ� ���, �̷� ���� ��Ű ����.
			    $("#useremail").keyup(function() // ID �Է� ĭ�� ID�� �Է��� ��,
	    		{
			        if($("#checidkbox").is(":checked")) // ID �����ϱ⸦ üũ�� ���¶��,
			        {
		            	setCookie("login", $("#useremail").val(), 7); // 7�� ���� ��Ű ����
			        }
			    });
	
				// ��Ű �����ϱ� 
				// setCookie => saveid�Լ����� �Ѱ��� �ð��� ����ð��� ���ؼ� ��Ű�� �����ϰ� �����ִ� ����
				function setCookie(cookieName, value, exdays) 
				{
					var exdate = new Date();
					exdate.setDate(exdate.getDate() + exdays);
					var cookieValue = escape(value)
							+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
					document.cookie = cookieName + "=" + cookieValue;
				}
	
				// ��Ű ����
				function deleteCookie(cookieName) 
				{
					var expireDate = new Date();
					expireDate.setDate(expireDate.getDate() - 1);
					document.cookie = cookieName + "= " + "; expires="
							+ expireDate.toGMTString();
				}
	     
				// ��Ű ��������
				function getCookie(cookieName) 
				{
					cookieName = cookieName + '=';
					var cookieData = document.cookie;
					var start = cookieData.indexOf(cookieName);
					var cookieValue = '';
					if (start != -1)  // ��Ű�� �����ϸ�
					{
						start += cookieName.length;
						var end = cookieData.indexOf(';', start);
						if (end == -1) // ��Ű ���� ������ ��ġ �ε��� ��ȣ ���� 
						{
							end = cookieData.length;
						}
			                console.log("end��ġ  : " + end);
							cookieValue = cookieData.substring(start, end);
					}
					return unescape(cookieValue);
				}
			});
		}
	</script>
	<!-- ������ �����ϴ� �κ� -->
	<section>
		<div class="main">
			<!-- �α��� ǥ�� ���� -->
			<div class="introduction">
				<div class="introhead"><h1> &nbsp;&nbsp; SIGN IN</h1></div>
				<div class="introtext"><p> &nbsp; �ӹ��� ��� ������ Ư�������ϴ�.</p></div>
			</div>
			<!-- �α��� ǥ�� �� -->
			<!-- ���̵� �α��� �Է� â ���� -->
			<form method="post" action="loginok.jsp" name="login" id="login">
			<!-- ���̵�, ��й�ȣ ����  -->
			<div class="logintotal">
				<hr class="line">
				<!-- ���̵� �α���, ���̵�, ��й�ȣ, ���̵� ����, ȸ������, ��й�ȣ ã�� ���� -->
				<ul class="tabType">
					<li class="on">
						<h3>���̵� �α���</h3>
						<input type="text" name="useremail" id="useremail" style="font-size:20px;" placeholder="���̵�">
						<input type="password" name="userpw" id="userpw" style="font-size:20px;" placeholder="��й�ȣ">
							<span id="checkidboxfrm">
								<input type="checkbox" name="checkidbox" id="checidkbox">
								<label for="checkidbox">���̵� ����</label>
							</span>
						<input type="submit" name="login_button" id="login_button" value="�α���">
						<!-- ȸ������, ���̵�/��й�ȣ ã�� ���� -->
						<div id="loginlink">
							<a href="join.jsp" id="login_join">ȸ������ ></a>
							<a href="pwfind.jsp" id="pw_find">��й�ȣ ã�� ></a>
						</div>
						<!-- ȸ������, ��й�ȣ ã�� �� -->
					</li>
				</ul>
				<!-- ���̵� �α���, ���̵�, ��й�ȣ, ���̵� ����, ȸ������, ���̵�/��й�ȣ ã�� �� -->
			</div>
			<!-- ���̵�, ��й�ȣ ��  -->
			</form>
			<!-- ���̵� �α��� �Է� â �� -->
			<!-- �α��ν� ���ǻ��� ����-->
			<ul id="txtGuide">
				<li>
					* �̿��� ��й�ȣ 5ȸ �̻� ������ ������ ���� �˴ϴ�.
				</li>
				<li>
					* ���� Ȥ�� ����縦 ���� ������ �¶��� ��ȸ�� �Ұ��Ͽ��� ����Ƿ� ���� ��Ź�帳�ϴ�.
				</li>
				<li>
					* ����ó ���� ������ ����Ǹ� ������Ʈ���� ȸ�������� �������ֽñ� �ٶ��ϴ�.
				</li>
			</ul>
			<!-- �α��ν� ���ǻ��� �� -->
		</div>	
		<!-- ���̵� �α��� â �� -->
	<!-- //.main -->
	</section>
	<!--  ������ ������ �κ� -->
	<%@include file="../include/tail.jsp" %>