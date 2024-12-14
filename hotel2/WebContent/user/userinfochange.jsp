<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- 
������/23.06.30.��, 23.07.03.��, 23.07.05.��, 23.07.12.��/ȸ������ html ���, 2. �̾ Ʋ ��� 3.include���� ����
������/ 23.07.17.�� / ��й�ȣ ���濡�� �Ѿ����
 -->
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<%
request.setCharacterEncoding("euc-kr");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria | ȸ������ ����</title>
		<link rel="stylesheet" href="../style/userinfochange.css">
	</head>

	<body>
	<%@include file="../include/head.jsp" %>
	<script>
	window.addEventListener('load', function() 
	{
		//��ȭ��ȣ ������ �ڵ� �Է�
		$(document).on("keyup", ".numbertext", function() { 
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
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
	});
	
	</script>
	<%
	if(login == null)
	{
		response.sendRedirect("login.jsp");
		return;
	}
	%>
	<section>
	<!-- ������ �����ϴ� �κ� -->
		<div class="main">
		<!-- �ʼ����� �Է¶� -->
		<div>
			<h2 class="necesse">ȸ������ ����</h2>
		</div>
		<!-- �ʼ����� �Է� ���� -->
		<form method="post" name="joinintrofrm" action="/hotel2/user/userinfochangeok.jsp">
		<div class="infodostart">
			<!-- ���� �̸�, �ѱ� �̸� Ŀ��Ʈ -->
			<div class="infodovalue1">ENGLISH NAME</div>
			<div class="infodovalue2">KOREAN NAME</div>
			<br>
			<!-- ���� �̸�, �ѱ� �̸� �Է� ���� ���� -->
			<div class="name">
				<input type="text" class="ename" name="ename" placeholder="���� ����" value=<%=login.getEname() %> onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'');" />
				<input type="text" class="kname" name="kname" placeholder="�ѱ� ����" value=<%=login.getKname() %>>
			</div>
			<!-- ���� �̸�, �ѱ� �̸� �Է� ���� �� -->
				<!-- ������� �Է� ���� ���� -->
				<div class="infodovalue3">BIRTH DATE</div>
				<br>
				<div class="birth">
					<input type="text" class="birthtext" placeholder="1900-01-03" value=<%=login.getBirth() %> readonly>
				</div>
				<!-- ������� �Է� ���� �� -->
				<br>
				<!-- �̸��� �Է� ���� ���� -->
				<div class="email">
					<div class="infodovalue4">ID</div>
					<br>
					<input type="text" class="emailid" placeholder="�̸���" value=<%=login.getEmail() %> readonly>
				</div>
				<!-- �̸��� �Է� ���� �� -->
				<br>
				<!-- ����  �Է� 7,8 �Է� Ŀ��Ʈ ���� -->
				<div class="infodovalue7">GENDER</div>
				<div class="infodovalue8">KOREAN/FOREIGNER</div>
				<br>
				<!-- ����  �Է� 7,8 �Է� Ŀ��Ʈ �� -->
				<br>
				<!-- ����, ������/�ܱ��� ���� ����  -->
				<div class="genderstart">
					<!-- ���� ����  -->
					<div class="gender">
						<input type="radio" id="gender1" name="gender" value="M" <%=login.getGender().equals("M") ? "checked" : "disabled" %> >
							<label for="gender1">��</label>
						<input type="radio" id="gender2" name="gender" value="F" <%=login.getGender().equals("F") ? "checked" : "disabled" %>>
							<label for="gender2">��</label>
					</div>
					<!-- ���� ��-->
					<!-- ������ �ܱ��� ���� -->
					<div class="koreanforeigner">
						<input type="radio" id="korean" name="koreanforeigner1" value="K" <%=login.getKorf().equals("K") ? "checked" : "disabled" %>>
							<label for="korean">������</label>
						<input type="radio" id="foreigner" name="koreanforeigner1" value="F" <%=login.getKorf().equals("F") ? "checked" : "disabled" %>>
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
						<input type="text" class="numbertext" name="numbertext" placeholder="��ȭ��ȣ" value=<%=login.getNumber() %>>
							<p style="text-decoration: underline;"></p>
					</div>
					<!-- ��ȣ �Է� input �� -->
				</div>
				<br>
				<!-- ȸ������, ��� ��ư ���� ���� -->
				<div class="joincancelstart">
					<input type=submit value="Ȯ��" class="joinbutton" id="joinbutton">
					<input type=button value="���" class="cancelbutton" onclick="location.href='userinfoop.jsp'">
				</div>
				<!-- ȸ������, ��� ��ư ���� �� -->
		</div>
		</form>
		<!-- �ʼ����� �Է� �� -->
				
			<!--  ȸ������ ���, �ʼ����� �Է� ��ü �� -->
		</div>
		<!-- //.main -->
		</section>
		<%@include file="../include/tail.jsp" %>