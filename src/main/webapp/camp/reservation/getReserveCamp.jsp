<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<link href="<%=path%>/css/reservation.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/css/datepicker.css" rel="stylesheet" type="text/css">
<script>
	var path = '${pageContext.request.contextPath}';
	function checkVal() {
		if (f1.tel.value == '') {
			alert('연락가능한 연락처를 입력해주세요.');
			f1.tel.focus();
			return false;
		} else if (${login_id == null}) {
			alert('로그인이 필요합니다.');
			location.replace(path + "/index.jsp");
			return false;
		} else {
			if(confirm("예약하시겠습니까?")) {
				return true;
			} else {
				return false;
			}
		}
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>캠핑장 예약</h3>
		<br><br>
		<section id="reserveSectionL">
			<div>
				<img src="<%=path%>/camp/management/files/${imgList.get(0).upload_imgStr}" id="big" width="500" height="300">
				<div id="small_img">
					<c:if test="${imgList.get(0).upload_imgStr != 'no_image.png'}">
					<c:forEach items="${imgList}" var="li">
						<img src="<%=path%>/camp/management/files/${li.upload_imgStr}" class="small" width="120" height="75">
					</c:forEach>
					</c:if>
				</div>
			</div>
		</section>
		<section id="reserveSectionR">
		<form name="f1" action="<%=path%>/insertCampReservation.do" onSubmit="return checkVal();">
			<input type="hidden" name="id" value="${login_id}">
			<input type="hidden" name="name" value="${login_name}">
		<table id="reserveFormTable">
			<tr>
				<td align="right">캠핑장명:</td>
				<td><input type="hidden" name="camp_name" value="${vo.camp_name}">${vo.camp_name}</td>
			</tr>
			<tr>
				<td align="right">이용구분:</td>
				<td>
					<select name="camp_div">
						<c:set var="splitDiv" value="${fn:split(vo.camp_div, ',')}" />
						<c:forEach items="${splitDiv}" var="campDiv">
							<option value="${campDiv}">${campDiv}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">예약날짜:</td>
				<td>
					<input type="text" id="start_date" name="start_date" size="10"> ~ 
					<input type="text" id="end_date" name="end_date" size="10">
				</td>
			</tr>
			<tr>
				<td align="right">연 락 처:</td>
				<td><input type="text" name="tel" id="inputForm" size="15" placeholder="010-0000-0000"></td>
			</tr>
			<tr>
				<td align="center" colspan="2" height="40"><input type="submit" value="예약하기"></td>
			</tr>
		</table>
		</form>
		</section>
	</div>
	<div id="tabmenu" style="width: 70%; margin: auto;">
		<ul class="tabs">
			<li class="tab-link current" data-tab="tab-1">캠핑장 위치</li>
			<li class="tab-link" data-tab="tab-2">캠핑장 정보</li>
			<li class="tab-link" data-tab="tab-3">리뷰</li>
		</ul>
		<div id="tab-1" class="tab-content current">
			<div id="Camp_map" style="width:100%;height:400px;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${KEY}"></script>
			<script>
				var mapContainer = document.getElementById('Camp_map'), // 지도를 표시할 div 
				    mapOption = { 
				        center: new kakao.maps.LatLng(${vo.lat}, ${vo.lng}), // 지도의 중심좌표
				        level: 3 // 지도의 확대 레벨
				    };
				
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(${vo.lat}, ${vo.lng}); 
				
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
				
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
				
				var iwContent = '<div style="padding:5px;">${vo.camp_name}<br>' 
					iwContent = iwContent + '<a href="https://map.kakao.com/link/map/${vo.camp_name},${vo.lat},${vo.lng}" style="color:blue" target="_blank">큰지도보기</a>&nbsp;&nbsp;'
					iwContent = iwContent + '<a href="https://map.kakao.com/link/to/${vo.camp_name},${vo.lat},${vo.lng}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
				    iwPosition = new kakao.maps.LatLng(${vo.lat}, ${vo.lng}); //인포윈도우 표시 위치입니다
				
				// 인포윈도우를 생성합니다
				var infowindow = new kakao.maps.InfoWindow({
				    position : iwPosition, 
				    content : iwContent 
				});
				  
				// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
				infowindow.open(map, marker); 
			</script>
		</div>
		<div id="tab-2" class="tab-content">
			<table id="CampInfo">
				<tr>
					<td>캠핑장명:</td>
					<td>${vo.camp_name}</td>
				</tr>
				<tr>
					<td>화장실 수:</td>
					<td>${vo.toilet}</td>
				</tr>
				<tr>
					<td>샤워장 수:</td>
					<td>${vo.shower_room}</td>
				</tr>
				<tr>
					<td>개수대 수:</td>
					<td>${vo.sink}</td>
				</tr>
				<tr>
					<td>기타부대시설:</td>
					<td>${vo.addtional_1}<br>${vo.addtional_2}</td>
				</tr>
			</table>
		</div>
		<div id="tab-3" class="tab-content">
			<table id="ReviewInfo">
				<tr><td width="150">아이디</td><td>후기</td><td width="150">등록일</td></tr>
				<c:forEach items="${review}" var="rev">
				<tr>
					<td>${rev.id.substring(0, 3)}****</td>
					<td>${rev.review}</td>
					<td><fmt:formatDate value="${rev.review_date}" pattern="yyyy-MM-dd" /></td>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<br><br><br>
</section>
<script src="<%=path%>/js/setupReserveDatepicker.js"></script>
<script src="<%=path%>/js/changeImg.js"></script>
<script src="<%=path%>/js/tabmenu.js"></script>
<%@ include file="../../include/bottom.jsp" %>
