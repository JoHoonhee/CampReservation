<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function updateButton(idx, start_idx, searchC, searchK) {
		if (confirm('변경하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/updateMemberAuthority.do',
				data: {
					idx: idx,
					role: $("input[name='role']:checked").val()
				},
				success: function(data) {
					// 페이지를 유지하기 위한 부분
					location.replace(path + '/getMemberList.do?start_idx=' + start_idx + '&searchCondition=' + searchC + '&searchKeyword=' + searchK);
				}
			}) // 비동기 처리
		} // 변경 확인
	}
	
	function deleteButton(idx, start_idx, searchC, searchK) {
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteMemberAdmin.do',
				data: { idx: idx },
				success: function(data) {
					// 페이지를 유지하기 위한 부분
					location.replace(path + '/getMemberList.do?start_idx=' + start_idx + '&searchCondition=' + searchC + '&searchKeyword=' + searchK);
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>회원 권한 관리</h3>
		<form action="getMemberList.do">
			<select name="searchCondition" id="searchCondition">
				<option value="id">아이디</option>
				<option value="name">이름</option>
				<option value="role">권한</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력해주세요">
			<input type="submit" id="searchBtn" value="검색">
		</form>
		<br>
		<table id="memberListTable">
			<tr><th>회원번호</th><th>아이디</th><th>이름</th><th>권한</th><th>권한선택</th><th>변경/삭제</th></tr>
			<c:forEach items="${li}" var="vo">
				<tr>
					<td align="center">${vo.idx}</td>
					<td align="center">${vo.id}</td>
					<td align="center">${vo.name}</td>
					<td style="width: 150px;">${vo.role}</td>
					<td style="width: 380px;">
						<input type="radio" name="role" value="ROLE_MEMBER">일반회원&nbsp;&nbsp;
						<input type="radio" name="role" value="ROLE_MANAGER">캠핑장매니저&nbsp;&nbsp;
						<input type="radio" name="role" value="ROLE_ADMIN">시스템관리자&nbsp;&nbsp;
					</td>
					<td align="center" style="width: 110px;">
						<input type="button" value="변경" onClick="updateButton('${vo.idx}', '${start_idx}', '${searchCondition}', '${searchKeyword}')">&nbsp;
						<input type="button" value="삭제" onClick="deleteButton('${vo.idx}', '${start_idx}', '${searchCondition}', '${searchKeyword}')">
					</td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<c:url value="getMemberList.do" var="url">
			<c:param name="start_idx" value="1" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">처음</a>&emsp;
		
		<c:choose>
			<c:when test="${listStartPage > 1}">
				<c:url value="getMemberList.do" var="url">
					<c:param name="start_idx" value="${(listStartPage - 2) * pageSize + 1}" />
					<c:param name="searchCondition" value="${searchCondition}" />
					<c:param name="searchKeyword" value="${searchKeyword}" />
				</c:url>
				<a href="${url}">&lt;이전</a>&emsp;
			</c:when>
			<c:otherwise>
				&lt;이전&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:forEach var="i" begin="${listStartPage}" end="${listEndPage}">
			<c:if test="${i < totalPage + 1}">
				<c:url value="getMemberList.do" var="url">
					<c:param name="start_idx" value="${(i - 1) * pageSize + 1}" />
					<c:param name="searchCondition" value="${searchCondition}" />
					<c:param name="searchKeyword" value="${searchKeyword}" />
				</c:url>
				<a href="${url}">${i}</a>&emsp;
			</c:if>
		</c:forEach>
		
		<c:choose>
			<c:when test="${listEndPage * pageSize + 1 > totalCount}">
				다음&gt;&emsp;
			</c:when>
			<c:otherwise>
				<c:url value="getMemberList.do" var="url">
					<c:param name="start_idx" value="${listEndPage * pageSize + 1}" />
					<c:param name="searchCondition" value="${searchCondition}" />
					<c:param name="searchKeyword" value="${searchKeyword}" />
				</c:url>
				<a href="${url}">다음&gt;</a>&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:url value="getMemberList.do" var="url">
			<c:param name="start_idx" value="${endPage}" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">끝</a>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
