<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
�ۼ���: ������
�ۼ���: 23.06.30.��, 23.07.03.��, 23.07.05.��, 23.07.13.��, 23.07.19.��, 23.07.20.��
1. ȸ������ html ���, 2. �̾ Ʋ ��� 3.�̸��� �� �޾Ƽ� �ֱ� 4.��й�ȣ ���� 5.���� �Ϸ� ����
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%
UserDTO dto = new UserDTO();
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>ȸ������ - ������� �� ȸ������</title>
		<link rel="stylesheet" href="../style/join.css">
	</head>
	<body>
	<%@include file="../include/head.jsp" %>
		<script>
		//���� ���� ����
		var enameflag   = false;
		var knameflag   = false;
		var birthflag   = false;
		var emailflag   = false; //���̵� üũ
		var codeflag    = false;
		var pwflag      = false;
		var pwcheckflag = false;
		var numberflag  = false;
		
		//var emailval = "";
		////windowâ ����
		window.onload = function()
		{
			
			//üũ�ڽ� ��ü ����
			$(".checkbox_group").on("click","#check_all",function()
			{
				  var checked = $(this).is(":checked");
				  if(checked)
				  {
				  	$(this).parents(".checkbox_group").find('input').prop("checked", true);
				  } else 
				  {
				  	$(this).parents(".checkbox_group").find('input').prop("checked", false);
				  }
			});
			
			//üũ�ڽ� ���� ����
			$(".checkbox_group").on("click", ".normal", function() 
			{
			    var is_checked = true;
			    
			    $(".checkbox_group .normal").each(function()
	    		{
			        is_checked = is_checked && $(this).is(":checked");
			    });
			    
			    $("#check_all").prop("checked", is_checked);
			});
			
			//�ѱ� �̸� �ѱ۸� �ޱ�
		    $(".kname").keyup(function (event)
    		{
	            regexp = /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
	            v = $(this).val();
	            if (regexp.test(v)) 
	            {
	                //alert("�ѱ۸� �Է°��� �մϴ�.");
	                //$(".infodovalue2").html("�ѱ۸� �Է°��� �մϴ�.");
	                $(this).val(v.replace(regexp, ''));
	            }
	        });
			
			//������� ������ �ڵ��Է�
			$(document).on("keyup", ".birthtext", function() 
			{
		    	$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/([0-9]{4})+([0-9]{2})+([0-9]{2})$/,"$1-$2-$3").replace("--", "-"));
		    });
		
			
			//��ȭ��ȣ ������ �ڵ� �Է�
			$(document).on("keyup", ".numbertext", function() 
			{ 
				$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
			});
			
			
			//ȸ������ ��� ��ư ������ ��
			$(".cancelbutton").click(function()
			{
				if(confirm("ȸ�������� ����ϰڽ��ϱ�?") == false)
				{
					return;
				}
				document.location = "/hotel2/index.jsp";
			});
					
			
			//ȸ������ ��ư ������ ��
			$(".joinbutton").click(function()   //�͸� �Լ�
			{  	
				var agreop = $("#check_1").is(":checked");
				if(agreop != true)
				{
					alert("������ǿ� �����ϼž� ȸ�������� ������ �� �ֽ��ϴ�.");
					$("#check_1").focus();
					return false;
				}
				//�����̸�
				var ename = $(".ename").val();
				if(ename == "")
				{
					$(".infodovalue1").html("�����̸��� �Է��ϼ���.");
					$(".ename").focus();
					enameflag = false;
					return false;
				}
				//�ѱ��̸�
				var kname = $(".kname").val();
				if(kname == "")
				{
					$(".infodovalue2").html("�ѱ��̸��� �Է��ϼ���.");
					$(".kname").focus();
					enameflag = false;
					return false;
				}
				//�������
				var birth = $(".birthtext").val();
				if(birth == "")
				{
					$(".infodovalue3").html("��������� �Է��ϼ���.");
					$(".birthtext").focus();
					birthflag = false;
					return false;
				}
				//���̵�(�̸���)
				var emailid = $(".emailid").val();
				if(emailid == "")
				{
					$(".infodovalue4").html("�̸����� �Է��ϼ���.");
					$(".infodovalue4").css("color", "red");
					$(".emailid").focus();
					emailflag = false;
					return false;
				}else if(!emailflag)
				{
					alert("�̸��� ���� ��, �ڵ带 �Է����ּ���.");
					$(".emailcode").focus();
					emailflag = false;
					return false;
				}
				
				//�ڵ��ȣ
				var emailcode = $(".emailcode").val();
				if(emailcode == "")
				{
					$(".emailcheck").html("������ȣ�� �Է��ϼ���.");
					$(".emailcheck").css("color", "red");
					$(".emailcode").focus();
					codeflag = false;
					return false;
				}
				
			
				//��й�ȣ
				var pw = $("#pw").val();
				if(pw == "")
				{
					$(".infodovalue5").html("��й�ȣ�� �Է����ּ���.");
					$(".infodovalue5").css("color", "red");
					$("#pw").focus();
					return false;
				}
				//��й�ȣ Ȯ��
				var pwcheck = $("#pwcheck").val();
				if(pwcheck == "")
				{
					$(".infodovalue6").html("��й�ȣ Ȯ���� �Է��ϼ���.");
					$(".infodovalue6").css("color", "red");
					$("#pwcheck").focus();
					return false;
				}
				
				//��й�ȣ ��ġ ����
				if(pwcheck != pw)
				{
					alert("��й�ȣ ��ġ�� Ȯ�����ּ���.");
					$("#pwcheck").focus();
					return false;
					
				}
				//��ȭ��ȣ
				var number = $(".numbertext").val(); 
				if(number == "")
				{
					$(".infodovalue9").html("����ó�� �Է��ϼ���.");
					$(".number").focus();
					return false;
				}
				
				$("#joinfrm").submit();
			});	
			
			//�̸��� �Է� Ȯ�� 
			$(".emailid").keyup(function()
			{
				$(".infodovalue4").html("ID *");
			});
			
			
			//��й�ȣ Ȯ��
			$("#pwcheck").keyup(function()
			{
				var pass1 = $("#pw").val();
				var pass2 = $("#pwcheck").val();
				
				if(pass1 != "" || pass2 != "")
				{
					if(pass1 == pass2)
					{
						$(".infodovalue6").html("��й�ȣ�� ��ġ�մϴ�.");
						$(".infodovalue6").css("color", "green");
					}else
					{
						$(".infodovalue6").html("��й�ȣ�� ����ġ�մϴ�.");
						$(".infodovalue6").css("color", "red");
					}
				}
			});
			
			//�̸��� ���� ��ư
			$(".emailbtn").click(function()
			{
				alert("�ڵ带 �������Դϴ�.");
				var email = $(".emailid").val();
				
				$.ajax(
				{					
					type : "get",     // ��� 2���� (get��� or post���)
					url: "emailcheck.jsp?email=" + email , //ȣ�� �� ������ �����ؼ� �����͸� �޾ƿ�.
					dataType: "html",  //�Ѿ���� ������ ���¸� ����. html, xml, json�� ����.
					success : function(data) 
					{	
						// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
						data = data.trim();
						alert(data);
						if(data == "�Է��Ͻ� �̸��Ϸ� �ڵ带 �߼��Ͽ����ϴ�. �ڵ带 �Է����ּ���.")
						{
							 $(".emailcode").focus();
						}
					},
					complete : function(data) 
					{	
						// ����� �����ϰų� �����߾ �� �Լ��� Ÿ�Եȴ�.
					},
					error : function(xhr, status, error) 
					{
						// ��� ���� �߻���
						alert("�̸��� ���� �����Դϴ�.");
					}
				});
			});
			
			//�ڵ� ����
			$(".codebtn").click(function()
			{
				var ecode = $(".emailcode").val();
				$.ajax(
				{					
					type : "post",     // ��� 2���� (get��� or post���)
					url: "codecheck.jsp?ecode=" + ecode , //ȣ�� �� ������ �����ؼ� �����͸� �޾ƿ�.
					dataType: "html",  
					success : function(data) 
					{	
						// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
						data = data.trim();
						alert(data);
						if(data == "�ڵ尡 �Էµ��� �ʾҽ��ϴ�.")
						{
							$(".emailcode").focus();
						}else if(data == "���� �Ϸ�Ǿ����ϴ�.")
						{
							emailflag = true;
						}
					},
					complete : function(data) 
					{	
						// ����� �����ϰų� �����߾ �� �Լ��� Ÿ�Եȴ�.
					},
					error : function(xhr, status, error) 
					{
						// ��� ���� �߻���
						alert("�����Դϴ�.");
					}
				});
			});
			
		}
	
		</script>
	<section>
		<!-- ������ �����ϴ� �κ� -->
		<div class="main">
			<!-- ȸ������ ǥ�� ���� -->
			<div class="introduction">
				<h1 class="introhead"> &nbsp; &nbsp; JOIN</h1>
				<div class="introtext"><p> &nbsp; Alegria ���� ���� ȯ���մϴ�.</p></div>	
			</div>	
			<!-- ȸ������ ǥ�� �� -->
			<!-- 1 ���� ����, 2 ������� �� ȸ������ �ܰ� ǥ�� ����-->
			<div class="stepwrap">
				<div class="firstimge">1</div>
				<div class="second"></div>
				<div class="third"> &nbsp;&nbsp;&nbsp; ������� �� ȸ������ �Է�</div>	 
			</div>
			<!-- 1 ���� ����, 2 ������� �� ȸ������ �ܰ� ǥ�� ��-->
			<!--  ȸ������ ���, �ʼ����� �Է� ��ü ����-->
			<form method="post" id="joinfrm" name="joinintrofrm" action="joinok.jsp">
			<div class="jointotal">
				<!-- ȸ������ ��� ���� -->
				<div class="joindostart">
					<div class="joindostarthead"><h2>ȸ������ ���</h2></div>
					<div class="joindostarttext">
						Alegert�� ü������ ȸ�� ���� ������ ���Ͽ� �Ʒ��� ���� ���������� �������̿� �� �����ϰ��� �մϴ�.<br>
						������ �ڼ��� ������ �� ���� ���θ� �����Ͽ� �ֽñ� �ٶ��ϴ�.
					</div>
					<hr class="jointotalline">
					<!-- ���� üũ �ڽ� �ٷ� �� -->
					<!-- ȸ������ ��� ���� -->
					<!-- üũ�ڽ� ���� -->
					
					<div class="checkbox_group">
					
					<input type="checkbox" id="check_all">
						<label for="check_all">��ü����</label>
						<p class="joindochecktext1">
						�Ʒ� ���� �׸��� ���� Ȯ�� �� �� �׸񸶴� ���������� �����Ͻ� �� �ֽ��ϴ�.<br>
						��ü ���� �� üũ�Ǵ� ���� �׸񿡴� ���õ��� �׸��� ���ԵǾ� �ֽ��ϴ�.
						</p>
						<hr class="jointotalline2">
						<input type="checkbox" id="check_1" class="normal" name="agreop" value="Y">
						<!-- ���� ���� ���� �� �̿뿡 ���� ���� ����-->
						<label for="check_1">[�ʼ�] �������� ���� �� �̿뿡 ���� ����</label>
							<!-- �������� ���� �� �̿뿡 ���� ���� �ȿ� ���� ���� -->
							<div class="joindochecktexthead1">
								<p class="joindochecktext2">
								Alegert�� �Ʒ��� ���� ���������� ���� �� �̿��ϰ� �ֽ��ϴ�.<br>
								�������� ó���� ���� ���� ������ Alegert Ȩ�������� '��������ó����ħ'�� �����Ͻʽÿ�.
								<br>
								<br>
								�� �������� ���� �� �̿� ���Ǽ��� ����� ����Ǵ� �κ��� �� ���Ǽ��� ������ �켱�մϴ�.
								</p>
								<!-- ���� ���� ���� �� �̿뿡 ���� ���� �� -->
								<!-- table ���� -->
								<table border="1" class="table1">
									<tr>
										<th>���� �׸�</th>
										<th>���� ����</th>
										<th>���� �Ⱓ</th>
									</tr>
									<tr>
										<td>ȸ�� ID, ��й�ȣ, �̸�, �������, ����, ����, �޴��� ��ȣ</td>
										<td>���� �̿��� �ĺ� �� ����, 14�� �̻� ���� Ȯ��</td>
										<td rowspan="3" style="text-decoration: underline;"><b>ȸ�� Ż�� �Ǵ� 5�Ⱓ �̿� ���� ���� ��</b></td>
									</tr>
									<tr>
										<td>�޴��� ��ȣ, �̸��� �ּ�</td>
										<td>��� ������ ���� ���� �� �ο����� ó�� ���� �ǻ����</td>
									</tr>
									<tr>
										<td>�ּ�</td>
										<td>����� ī��߼�</td>
									</tr>
								</table>
								<!-- table �� -->
								<p class="joindochecktext3"> * ���� �������� ���� �� �̿뿡 ���� ���Ǹ� �ź��� �Ǹ��� ������ ���Ǹ� �ź��Ͻ� ��� ȸ������, ����� ���� �̿��� �Ұ��մϴ�.</p>
								<hr>
							</div>
							<!-- �������� ���� �� �̿뿡 ���� ���� �ȿ� ���� �� -->
							<!-- ������ Ȱ�� �� ������ ���� ������ ���� ���� ���� �̿� ���� -->
							<input type="checkbox" id="check_2" class="normal">
							<label for="check_2">[����] ������ Ȱ�� �� ������ ���� ������ ���� ���� ���� �̿� ����</label>
							<!-- ������ Ȱ�� �� ������ ���� ������ ���� ���� ���� �̿� ���� �ȿ� ���� ���� -->
							<div class="joindochecktexthead2">
								<p class="joindochecktext2"> Alegert�� ȸ������ ���� ����, ���λ�ǰ �� �Ż�ǰ �ȳ�, �̺�Ʈ �� ���� ���� ���� ������ ���� ���������� ���� �� �̿��ϴ� �Ϳ� ���� �մϴ�.</p>
								<!-- üũ�ڽ� ���� -->
								<div class="joindocheckbox">
									<input type="checkbox" value="agree1" id="check_3" class="normal">
										<label for="check_3">SMS ���ŵ���</label>
									<input type="checkbox" value="agree2" id="check_4" class="normal">
										<label for="check_4">E-MAIL ���ŵ��� </label>
									<input type="checkbox" value="agree3" id="check_5" class="normal">
										<label for="check_5">��ȭ ���ŵ��� </label>
								</div>
								<!-- üũ�ڽ� �� -->
								<!-- �� ��° ���̺� ���� -->
								<table border="1" class="table2">
									<tr>
										<th>���� �׸�</th>
										<th>���� ����</th>
										<th>���� �Ⱓ</th>
									</tr>
									<tr>
										<td>�̸���, �޴�����ȣ, �ּ�</td>
										<td>��� �� ��ǰ���� �ȳ� / ������ Ȱ��</td>
										<td style="text-decoration: underline;"><b>ȸ��Ż�� �Ǵ� 5�Ⱓ �̿���� ���� ��</b></td>
									</tr>
								</table>
								<p class="joindochecktext3">* �� �������� �������̿뿡 ���� ���Ǹ� �ź��� �� ������ ���� �ź� �� ���� �� �̺�Ʈ ���� �ȳ� ���� ���񽺰� ���ѵ˴ϴ�.</p>
								<hr>
							</div>
							<!-- ������ Ȱ�� �� ������ ���� ������ ���� ���� ���� �̿� ���� �ȿ� ���� �� -->
					</div>
					<!-- üũ�ڽ� �� -->
				</div>
				<!-- ȸ������ ��� �� -->
					<br>
					<br>
					<!-- �ʼ����� �Է¶� -->
					<div>
						<h2 class="necesse">�ʼ����� �Է�</h2>
					</div>
					<!-- �ʼ����� �Է� ���� -->
					<div class="infodostart">
						<!-- ���� �̸�, �ѱ� �̸� Ŀ��Ʈ -->
						<div class="infodovalue1">ENGLISH NAME *</div>
						<div class="infodovalue2">KOREAN NAME *</div>
						<br>
						<!-- ���� �̸�, �ѱ� �̸� �Է� ���� ���� -->
						<div class="name">
							<input type="text" name="ename" class="ename" placeholder="���� ����" onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'');" />
							<input type="text" name="kname" class="kname" placeholder="�ѱ� ����" >
						</div>
						<!-- ���� �̸�, �ѱ� �̸� �Է� ���� �� -->
							<!-- ������� �Է� ���� ���� -->
							<div class="infodovalue3">BIRTH DATE *</div>
							<br>
							<div class="birth">
								<input type="text" name="birth" class="birthtext" placeholder="ex) 1900-01-03">
							</div>
							<!-- ������� �Է� ���� �� -->
							<br>
							<!-- �̸��� �Է� ���� ���� -->
							<div class="email">
								<div class="infodovalue4">ID *</div>
								<br>
									<input type="text" name="email" class="emailid" placeholder="ex) ezen@naver.com">
								<!-- ���� ��ư -->
								<input type="button" class="emailbtn" value="�� ��">
							</div>
							<!-- �̸��� �Է� ���� �� -->
							<br>
							<!-- �̸��� !����! ���� ���� -->
							<div class="emailcheck">EMAIL CODE *</div>
							<div>
								<input type="email" name="token" class="emailcode" placeholder="�̸��� �ڵ带 �Է����ּ���.">
								<input type="button" class="codebtn" value="Ȯ��">
							</div>	
							<!-- �̸��� !����! ���� �� -->
							<br>
							<!-- ��й�ȣ, ��й�ȣ Ȯ�� 5,6 �Է� Ŀ��Ʈ ���� -->
							<div class="infodovalue5">PASSWORD *</div>
							<div class="infodovalue6">CONFIRM PASSWORD *</div>
							<!-- ��й�ȣ, ��й�ȣ Ȯ�� �Է� Ŀ��Ʈ �� -->
							<br>
							<!-- ��й�ȣ, ��й�ȣ Ȯ�� �Է� ���� ���� -->
							<div class="password">
								<input type="password" name="pw" id="pw" placeholder="��й�ȣ">
								<input type="password" name="pwcheck" id="pwcheck" placeholder="��й�ȣ Ȯ��">
							</div>
							<!-- ��й�ȣ, ��й�ȣ Ȯ�� �Է� ���� �� -->
							<br>
							<!-- ����  �Է� 7,8 �Է� Ŀ��Ʈ ���� -->
							<div class="infodovalue7">GENDER *</div>
							<div class="infodovalue8">KOREAN/FOREIGNER *</div>
							<br>
							<!-- ����  �Է� 7,8 �Է� Ŀ��Ʈ �� -->
							<br>
							<!-- ����, ������/�ܱ��� ���� ����  -->
							<div class="genderstart">
								<!-- ���� ����  -->
								<div class="gender">
									<input type="radio" id="gender1" name="gender" value="M" checked>
										<label for="gender1">��</label>
									<input type="radio" id="gender2" name="gender" value="F">
										<label for="gender2">��</label>
								</div>
								<!-- ���� ��-->
								<!-- ������ �ܱ��� ���� -->
								<div class="koreanforeigner">
									<input type="radio" id="korean" name="korf" value="K" checked>
										<label for="korean">������</label>
									<input type="radio" id="foreigner" name="korf" value="F">
										<label for="foreigner">�ܱ���</label>
								</div>
								<!-- ������ �ܱ��� �� -->
							</div>
							<!-- ���� �̸�, �ѱ� �̸� �Է� ���� ��  -->
							<br>
							<!-- �ڵ��� ��ȣ �Է� ���� ���� -->
							<div class=numberstart>
								<!-- number �ڸ�Ʈ -->
								<div class="infodovalue9">NUMBER *</div>
								<br>
								<!-- ��ȣ �Է� input ���� -->
								<div class="number">
									<input type="text" name="number" class="numbertext" placeholder="ex) 010-1234-5678">
										<p style="text-decoration: underline;"></p>
								</div>
								<!-- ��ȣ �Է� input �� -->
							</div>
							<br>
							<!-- ȸ������, ��� ��ư ���� ���� -->
							<div class="joincancelstart">
								<input type=button value="ȸ������" class="joinbutton">
								<input type=button value="���" class="cancelbutton">
							</div>
							<!-- ȸ������, ��� ��ư ���� �� -->
					</div>
					<!-- �ʼ����� �Է� �� -->
				
				
			</div>
			<!--  ȸ������ ���, �ʼ����� �Է� ��ü �� -->
			</form>
		</div>
		<!-- //.main -->
		</section>
		<%@include file="../include/tail.jsp" %>

		