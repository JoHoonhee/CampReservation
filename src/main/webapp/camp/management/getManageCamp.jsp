<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
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
			if ($('#camp_div').val() == '') {
				alert("캠핑장 구분을 선택해 주세요.");
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
			} // if
			
			$.ajax({
				type : 'POST',
				url : path + '/updateCamp.do',
				dataType:'text',
				data : {
					camp_name: $('#camp_name').val(),
					camp_div: $('#camp_div').val(),
					common_camp: $('#common_camp').val(),
					car_camp: $('#car_camp').val(),
					glamping: $('#glamping').val(),
					caravan: $('#caravan').val(),
					toilet: $('#toilet').val(),
					shower_room: $('#shower_room').val(),
					sink: $('#sink').val(),
					addtional_1: $('#addtional_1').val(),
					addtional_2: $('#addtional_2').val(),
				},
				success : function(data) {
					alert("수정완료!");
					location.replace(path + '/getManageCampList.do');
				} // success
			}) // ajax
		}); // click
	}) // ready

	function listButton() {
		location.href="getManageCampList.do"
	}
	
	function deleteButton(idx, str) {
		var encodeStr = encodeURI(str);
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteCampImg.do',
				data: { idx_img: idx },
				success: function(data) {
					// 페이지 유지를 위한 값 넘기기
					location.replace(path + '/getManageCamp.do?camp_name=' + encodeStr);
				}
			}) // ajax
		} // 삭제 확인
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>캠핑장 정보 수정</h3>
		<table id="campFormTable">
			<tr><th colspan="2">캠핑장 정보</th></tr>
			<tr>
				<td align="center" style="width: 150px;">캠핑장명</td>
				<td><input type="hidden" name="camp_name" id="camp_name" value="${vo.camp_name}">${vo.camp_name}</td>
			</tr>
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
			<tr><th colspan="2">야영장 수</th></tr>
			<tr><td align="center">일반야영장</td><td><input type="text" name="common_camp" id="common_camp" value="${vo.common_camp}"></td></tr>
			<tr><td align="center">자동차야영장</td><td><input type="text" name="car_camp" id="car_camp" value="${vo.car_camp}"></td></tr>
			<tr><td align="center">글램핑</td><td><input type="text" name="glamping" id="glamping" value="${vo.glamping}"></td></tr>
			<tr><td align="center">카라반</td><td><input type="text" name="caravan" id="caravan" value="${vo.caravan}"></td></tr>
			<tr><th colspan="2">편의시설</th></tr>
			<tr><td align="center">화장실</td><td><input type="text" name="toilet" id="toilet" value="${vo.toilet}"></td></tr>
			<tr><td align="center">샤워실</td><td><input type="text" name="shower_room" id="shower_room" value="${vo.shower_room}"></td></tr>
			<tr><td align="center">개수대</td><td><input type="text" name="sink" id="sink" value="${vo.sink}"></td></tr>
			<tr><td align="center">부대시설_1</td><td><textarea name="addtional_1" id="addtional_1" rows="3" cols="35">${vo.addtional_1}</textarea></td></tr>
			<tr><td align="center">부대시설_2</td><td><textarea name="addtional_2" id="addtional_2" rows="3" cols="35">${vo.addtional_2}</textarea></td></tr>
			<tr>
				<td align="center" colspan="2">
					<input type="button" value="목록보기" onClick="listButton()">&emsp;
					<input type="button" value="정보수정" id="submitButton">
				</td>
			</tr>
		</table>
		<br>
		<hr>
		<h3>캠핑장 사진 추가/삭제</h3>
		<form name="f1" action="<%=path%>/insertCampImg.do" method="post" encType="multipart/form-data">
		<table id="imgFormTable_input">
		<tr align="right">
			<td>
				<input type="hidden" name="camp_name" value="${vo.camp_name}">
				<input type="file" name="upload_img">
				<input type="submit" value="등록">
			</td>
		</tr>
		</table>
		</form>
		<table id="imgFormTable">
			<tr><th>번호</th><th>사진(미리보기)</th><th>사진이름</th><th>캠프장명</th><th>삭제</th></tr>
			<c:forEach items="${imgList}" var="li">
				<tr align="center">
					<td>${li.idx_img}</td>
					<td><img src="<%=path%>/camp/management/files/${li.upload_imgStr}" width=100 height=100></td>
					<td>${li.upload_imgStr}</td>
					<td>${li.camp_name}</td>
					<td align="center"><input type="button" value="삭제" onClick="deleteButton(${li.idx_img}, '${vo.camp_name}')"></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
