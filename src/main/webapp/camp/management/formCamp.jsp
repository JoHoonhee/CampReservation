<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script src="<%=path%>/js/setupFormDatepicker.js"></script>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	$(document).ready(function() {
		$('#submitButton').click(function() {
			// 체크박스 값을 배열에 저장
			var checkVal = new Array();
			$('input:checkbox[name=check_div]:checked').each(function() {
				checkVal.push(this.value);
			});
			$('#camp_div').val(checkVal);
			// 필수 입력 확인
			if ($('#camp_name').val() == '') {
				alert("캠핑장 이름을 입력해 주세요.");
				$('#camp_name').focus();
				return false;
			} else if ($('#camp_div').val() == '') {
				alert("캠핑장 구분을 선택해 주세요.");
				return false;
			} else if ($('#roadAddress').val() == '') {
				alert("주소를 입력해 주세요.");
				return false;
			} else if ($('#lat').val() == '') {
				alert("위도를 입력해 주세요.");
				$('#lat').focus();
				return false;
			} else if ($('#lng').val() == '') {
				alert("경도를 입력해 주세요.");
				$('#lng').focus();
				return false;
			} else if ($('#common_camp').val() == '') {
				alert("일반야영장 수를 입력해 주세요.");
				$('#common_camp').focus();
				return false;
			} else if ($('#car_camp').val() == '') {
				alert("자동차야영장 수를 입력해 주세요.");
				$('#car_camp').focus();
				return false;
			} else if ($('#glamping').val() == '') {
				alert("글램핑장 수를 입력해 주세요.");
				$('#glamping').focus();
				return false;
			} else if ($('#caravan').val() == '') {
				alert("카라반 수를 입력해 주세요.");
				$('#caravan').focus();
				return false;
			} else if ($('#toilet').val() == '') {
				alert("화장실 수를 입력해 주세요.");
				$('#toilet').focus();
				return false;
			} else if ($('#shower_room').val() == '') {
				alert("샤워실 수를 입력해 주세요.");
				$('#shower_room').focus();
				return false;
			} else if ($('#sink').val() == '') {
				alert("개수대 수를 입력해 주세요.");
				$('#sink').focus();
				return false;
			}
				
			$.ajax({
				type : "POST",
				url : path + "/insertCamp.do",
				dataType:'text',
				data : {
					camp_name: $('#camp_name').val(),
					camp_div: $('#camp_div').val(),
					addr: $('#roadAddress').val() + ' ' + $('#detailAddress').val(),
					lat: $('#lat').val(),
					lng: $('#lng').val(),
					common_camp: $('#common_camp').val(),
					car_camp: $('#car_camp').val(),
					glamping: $('#glamping').val(),
					caravan: $('#caravan').val(),
					toilet: $('#toilet').val(),
					shower_room: $('#shower_room').val(),
					sink: $('#sink').val(),
					addtional_1: $('#addtional_1').val(),
					addtional_2: $('#addtional_2').val(),
					approval_date: $('#approval_date').val()
				},
				success : function(data) {
					alert("저장완료!");
					$('#camp_name').val('');
					$('#postcode').val('');
					$('#roadAddress').val('');
					$('#detailAddress').val('');
					$('#lat').val('0');
					$('#lng').val('0');
					$('#common_camp').val('0');
					$('#car_camp').val('0');
					$('#glamping').val('0');
					$('#caravan').val('0');
					$('#toilet').val('0');
					$('#shower_room').val('0');
					$('#sink').val('0');
					$('#addtional_1').val('');
					$('#addtional_2').val('');
					$('#approval_date').datepicker('setDate', 'today');
				}  // success
			})  // ajax
		});  // click
		
		// 날짜 선택할 수 있는 달력
		$(function() {
			$('#approval_date').datepicker();
			$('#approval_date').datepicker('setDate', 'today');
		});
		
	})  // ready
	
	function listButton() {
		location.href="getManageCampList.do"
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>캠핑장 등록</h3>
		<table id="campFormTable">
			<tr><th colspan="2">캠핑장 정보</th></tr>
			<tr><td align="center" style="width: 150px;">캠핑장명</td><td><input type="text" name="camp_name" id="camp_name"></td></tr>
			<tr>
				<td align="center">구분</td>
				<td>
					<div style="float: left;">
					<input type="checkbox" name="check_div" id="check_div1" value="일반야영장">일반야영장<br>
					<input type="checkbox" name="check_div" id="check_div2" value="자동차야영장">자동차야영장
					</div>
					<div style="float: left; margin-left: 5px;">
					<input type="checkbox" name="check_div" id="check_div3" value="글램핑">글램핑<br>
					<input type="checkbox" name="check_div" id="check_div4" value="카라반">카라반
					</div>
					<input type="hidden" name="camp_div" id="camp_div">
				</td>
			</tr>
			<tr>
				<td align="center">주소</td>
				<td>
					<input type="text" name="postcode" id="postcode" placeholder="우편번호">
					<input type="button" onclick="postCode()" value="우편번호 찾기"><br>
					<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소" size=45><br>
					<input type="hidden" name="jibunAddress" id="jibunAddress" placeholder="지번주소">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소" size=45>
					<input type="hidden" name="extraAddress" id="extraAddress" placeholder="참고항목">
				</td>
			</tr>
			<tr><td align="center">위도</td><td><input type="text" name="lat" id="lat" value="0"></td></tr>
			<tr><td align="center">경도</td><td><input type="text" name="lng" id="lng" value="0"></td></tr>
			<tr><th colspan="2">야영장 수</th></tr>
			<tr><td align="center">일반야영장</td><td><input type="text" name="common_camp" id="common_camp" value="0"></td></tr>
			<tr><td align="center">자동차야영장</td><td><input type="text" name="car_camp" id="car_camp" value="0"></td></tr>
			<tr><td align="center">글램핑</td><td><input type="text" name="glamping" id="glamping" value="0"></td></tr>
			<tr><td align="center">카라반</td><td><input type="text" name="caravan" id="caravan" value="0"></td></tr>
			<tr><th colspan="2">편의시설</th></tr>
			<tr><td align="center">화장실</td><td><input type="text" name="toilet" id="toilet" value="0"></td></tr>
			<tr><td align="center">샤워실</td><td><input type="text" name="shower_room" id="shower_room" value="0"></td></tr>
			<tr><td align="center">개수대</td><td><input type="text" name="sink" id="sink" value="0"></td></tr>
			<tr><td align="center">부대시설_1</td><td><textarea name="addtional_1" id="addtional_1" rows="3" cols="35"></textarea></td></tr>
			<tr><td align="center">부대시설_2</td><td><textarea name="addtional_2" id="addtional_2" rows="3" cols="35"></textarea></td></tr>
			<tr><td align="center">허가일</td><td><input type="text" name="approval_date" id="approval_date" placeholder="yyyy-MM-dd"></td></tr>
			<tr>
				<td align="center" colspan="2">
					<input type="button" value="목록보기" onClick="listButton()">&emsp;
					<input type="button" value="캠핑장등록" id="submitButton">
				</td>
			</tr>
		</table>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
