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
			<h2>호텔 소개</h2>
			<hr>
			<ul class="menu">
				<li><a href="../map/" style="background-color: white; padding: 0 30px;">오는 길 소개</a></li>
				<li><a href="../roominfo/index.jsp?acategory=T">객실 소개</a></li>
				<li><a href="../service/index.jsp?acategory=F">부대 시설</a></li>
				<li><a href="../notice/index.jsp?acategory=N">공지사항</a></li>
			</ul>
			<!-- //.menu -->
		</div>
		<!-- //.menubar -->
		<div class="contents">
			<h3>오시는 길 소개</h3>
			<p class="list"><img src="/hotel2/image/home.png" width="20px;" height="20px;"> &gt; 호텔 소개 &gt; 오시는 길 소개</p>
			<hr>
			<div id="map" style="width:870px; height:600px;"></div>
			<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=090ecb89b3627297b4997f632c02c8ef&libraries=services"></script>
			<script>
				var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
					center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
					level: 3 //지도의 레벨(확대, 축소 정도)
				};
				//지도를 생성합니다
				var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
				
				// 주소-좌표 변환 객체를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();

				// 주소로 좌표를 검색합니다
				geocoder.addressSearch('전라북도 전주시 덕진구 금암동 667-52', function(result, status) {

			    // 정상적으로 검색이 완료됐으면 
		        if(status === kakao.maps.services.Status.OK) 
		        {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords
			        });
			        // 인포윈도우로 장소에 대한 설명을 표시합니다
			        var infowindow = new kakao.maps.InfoWindow({
			            content: '<div style="width:150px;text-align:center;padding:6px 0;">Agleria Hotel</div>'
			        });
			        infowindow.open(map, marker);
			        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
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