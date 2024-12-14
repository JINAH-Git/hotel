<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Alegria Hotel</title>
		<link rel="stylesheet" type="text/css" href="../../style/contents.css" />
	</head>
<%@ include file="../../include/head.jsp" %>
<section>
	<div class="main">
		<div class="menubar">
			<h2>ȣ�� �Ұ�</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/" style="background-color: white; padding: 0 30px;">���� �� �Ұ�</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">���� �Ұ�</a></li>
				<li><a href="../service/index.jsp?acategory=F">�δ� �ü�</a></li>
				<li><a href="../notice/index.jsp?acategory=N">��������</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>���ô� �� �Ұ�</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; ȣ�� �Ұ� &gt; ���ô� �� �Ұ�</p>
			<hr>
			<div id="map" style="width:870px; height:600px;"></div>
			<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=090ecb89b3627297b4997f632c02c8ef&libraries=services"></script>
			<script>
				var container = document.getElementById('map'); //������ ���� ������ DOM ���۷���
				var options = { //������ ������ �� �ʿ��� �⺻ �ɼ�
					center: new kakao.maps.LatLng(33.450701, 126.570667), //������ �߽���ǥ.
					level: 3 //������ ����(Ȯ��, ��� ����)
				};
				//������ �����մϴ�
				var map = new kakao.maps.Map(container, options); //���� ���� �� ��ü ����
				
				// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
				var geocoder = new kakao.maps.services.Geocoder();

				// �ּҷ� ��ǥ�� �˻��մϴ�
				geocoder.addressSearch('����ϵ� ���ֽ� ������ �ݾϵ� 667-52', function(result, status) {

			    // ���������� �˻��� �Ϸ������ 
		        if(status === kakao.maps.services.Status.OK) 
		        {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        // ��������� ���� ��ġ�� ��Ŀ�� ǥ���մϴ�
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			        // ����������� ��ҿ� ���� ������ ǥ���մϴ�
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">Agleria Hotel</div>'
			        });
			        infowindow.open(map, marker);
			        // ������ �߽��� ��������� ���� ��ġ�� �̵���ŵ�ϴ�
			        map.setCenter(coords);
			    } 
			});
			</script>
		</div>
		<!-- //.contents -->
	</div>
	<!-- //.main -->
</section>

<%@ include file="../../include/tail.jsp" %>