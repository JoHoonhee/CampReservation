<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function deleteReserve(idx, start_idx, id) {
		if (confirm('취소하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteCampReservation.do',
				data: { idx: idx },
				success: function(data) {
					// 페이지 유지를 위한 값
					location.replace(path + '/getReserveCheckList.do?start_idx=' + start_idx + '&id=' + id);
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
	
	function writeReview(idx) {
		$.ajax({
			type: 'POST',
			url: path + '/getReserveCheck.do',
			data: { idx: idx },
			success: function(data) {
				location.replace(path + '/getReserveCheck.do?idx=' + idx);
			}
		}) // 비동기 처리
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>예약 확인 목록</h3>
		<form action="<%=path%>/getReserveCheck.do">
		<table id="memberListTable">
			<tr><th>예약번호</th><th>캠핑장명</th><th>이용구분</th><th>예약일</th><th>예약취소</th><th>리뷰작성</th></tr>
			<c:forEach items="${li}" var="vo">
				<tr align="center">
					<td>${vo.idx}</td>
					<td>${vo.camp_name}</td>
					<td>${vo.camp_div}</td>
					<td><fmt:formatDate value="${vo.start_date}" pattern="yyyy-MM-dd" /> ~ <fmt:formatDate value="${vo.end_date}" pattern="yyyy-MM-dd" /></td>
					<td>
						<c:choose>
							<c:when test="${today < vo.start_date}">
								<input type="button" value="취소" onClick="deleteReserve(${vo.idx}, ${start_idx}, '${login_id}')">
							</c:when>
							<c:otherwise>
								기한만료
							</c:otherwise>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${vo.write_review == 'N'}">
								<input type="button" value="작성하기" onClick="writeReview(${vo.idx})">
							</c:when>
							<c:otherwise>
								작성완료
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</table>
		</form>
		<br>
		<c:url value="getReserveCheckList.do" var="url">
			<c:param name="start_idx" value="1" />
			<c:param name="id" value="${login_id}" />
		</c:url>
		<a href="${url}">처음</a>&emsp;
		
		<c:choose>
			<c:when test="${listStartPage > 1}">
				<c:url value="getReserveCheckList.do" var="url">
					<c:param name="start_idx" value="${(listStartPage - 2) * pageSize + 1}" />
					<c:param name="id" value="${login_id}" />
				</c:url>
				<a href="${url}">&lt;이전</a>&emsp;
			</c:when>
			<c:otherwise>
				&lt;이전&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:forEach var="i" begin="${listStartPage}" end="${listEndPage}">
			<c:if test="${i < totalPage + 1}">
				<c:url value="getReserveCheckList.do" var="url">
					<c:param name="start_idx" value="${(i - 1) * pageSize + 1}" />
					<c:param name="id" value="${login_id}" />
				</c:url>
				<a href="${url}">${i}</a>&emsp;
			</c:if>
		</c:forEach>
		
		<c:choose>
			<c:when test="${listEndPage * pageSize + 1 > totalCount}">
				다음&gt;&emsp;
			</c:when>
			<c:otherwise>
				<c:url value="getReserveCheckList.do" var="url">
					<c:param name="start_idx" value="${listEndPage * pageSize + 1}" />
					<c:param name="id" value="${login_id}" />
				</c:url>
				<a href="${url}">다음&gt;</a>&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:url value="getReserveCheckList.do" var="url">
			<c:param name="start_idx" value="${endPage}" />
			<c:param name="id" value="${login_id}" />
		</c:url>
		<a href="${url}">끝</a>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
