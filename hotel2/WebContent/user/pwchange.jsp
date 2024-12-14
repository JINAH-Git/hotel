<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="hotel.dao.*" %>
<%@ page import="hotel.dto.*" %>
<%@ page import="hotel.vo.*" %> 
<%@ page import="hotel.email.*" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria | ȸ������ ����</title>
		<link rel="stylesheet" href="../style/userinfochange.css">
		<link rel="stylesheet" href="../style/uspwchange.css">
	</head>
<%@include file="../include/head.jsp" %>
<%
request.setCharacterEncoding("euc-kr");
String emailid = request.getParameter("emailid");
if(emailid == null || emailid.equals(""))
{
	%>
	<script>
	alert("�߸��� �����Դϴ�.");
	window.location.href="pwfind.jsp";
	</script>
	<%
}else if(emailid != null || !emailid.equals(""))
{
	%>
	<script>
	alert("������ �Ϸ�Ǿ����ϴ�. ��й�ȣ�� �缳�����ּ���.");
	</script>
	<%
}
%>
<script>
	var flag = "false";
	
	window.onload = function(){
		
		$(".pw").keyup(function(){
			samecheck();
		});
		
		$(".pwcheck").keyup(function(){
			samecheck();
		});
		
		$(".joinbutton").click(function(){
			
			if(flag == "false")
			{
				alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				return false;
			}
			
			if(flag == "true")
			{				
				pw = $(".pw").val();
				emailid = $("#id").val();
			
				$.ajax({
					type : "post",
					url: "pwchangeok.jsp?pw=" + pw + "&emailid=" + emailid,
					dataType: "html",
					success : function(data) 
					{	
						// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
						data = data.trim();
						
						alert(data);
						if(data == "��й�ȣ�� ����Ǿ����ϴ�. �α��� �������� �̵��մϴ�.")
						{
							location.href = "login.jsp";	
						}
						return false;
					},
					error : function(xhr, status, error)
					{
						alert("��й�ȣ ���� ����");
					}
				});
				
				
			}
		});		
	}
	
	function samecheck()
	{
		pw = $(".pw").val();
		if(pw == "")
		{
			$(".infodovalue4").html("�� ��й�ȣ�� �Է��ϼ���.");
			return;
		}
		
		pwcheck = $(".pwcheck").val();		
		if(pwcheck == "")
		{
			$(".infodovalue4").html("�� ��й�ȣ Ȯ���� �Է��ϼ���.");
			return;
		}
		
		$.ajax({
			type : "get",
			url: "pwchangeck.jsp?pw=" + pw + "&pwcheck=" + pwcheck,
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				console.log(data);
				flag = data;
				
				//true,false
				switch(data)
				{
				case "false" :
					$(".infodovalue4").html("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
					break;
				case "true" :
					$(".infodovalue4").html("��й�ȣ�� ��ġ�մϴ�.");
					$(".infodovalue4").css("color", "green");
					break;
				}
			},
			error : function(xhr, status, error){}
		});
	}
</script>
<section>
	<div class="main">
	<!-- �ʼ����� �Է¶� -->
		<div class="introduction">
			<div class="introhead">
				<h1> &nbsp;&nbsp; Password Change </h1>
				<p class="pwfindtotaltext"><em>��й�ȣ�� �����մϴ�.</em></p>
			</div>
		</div>
		<form method="post" name="pwchangeok" action="pwchangeok.jsp" style="height: 500px;"> 
			<div class="pwfindtotal">		
				<hr class="line">
				<div class="infodovalue9">PASSWORD *</div>
				<div class="infodovalue4" >CONFIRM PASSWORD *</div>
				<br>
				<span id="msg"></span>
				<div class="password" style="margin-top: 100px;">
					<input type="hidden" id="id" name="id" value="<%= emailid %>">
					<input type="password" class="pw" id="pw" name="pw" placeholder="�� ��й�ȣ">
					<input type="password" class="pwcheck" id="pwcheck" name="pwcheck" placeholder="�� ��й�ȣ Ȯ��"><br>
					<input type="button" class="joinbutton" value="��й�ȣ ����"><br>				
				</div>
				<!-- ��й�ȣ, ��й�ȣ Ȯ�� �Է� ���� �� -->	
			</div>
		</form>
		<!-- �ʼ����� �Է� �� -->
	</div>
	<!-- //.main -->
</section>
<%@include file="../include/tail.jsp" %>