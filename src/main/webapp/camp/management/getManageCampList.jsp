<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function deleteButton(str, idx, searchC, searchK) {
		var encodeSearchK = encodeURI(searchK);
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteCamp.do',
				data: { camp_name: str },
				success: function(data) {
					// 페이지 유지를 위해 넘기는 값
					location.replace(path + '/getManageCampList.do?start_idx=' + idx + '&searchCondition=' + searchC + '&searchKeyword=' + encodeSearchK);
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>캠핑장 관리(<a href="formCamp.do">캠핑장 <font color="yellow">등록</font></a>)</h3>
		<form action="getManageCampList.do">
			<select name="searchCondition" id="searchCondition">
				<option value="camp_name">캠핑장명</option>
				<option value="addr">주소</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력해주세요">
			<input type="submit" id="searchBtn" value="검색">
		</form>
		<br>
		<table class="campListTable">
			<tr><th width="350">캠핑장명(정보수정)</th><th width="250">구분</th><th width="400">주소</th><th width="50">DEL</th></tr>
			<c:forEach items="${li}" var="vo">
				<tr>
					<td>
						<c:url value="getManageCamp.do" var="url">
							<c:param name="camp_name" value="${vo.camp_name}" />
						</c:url>
						<a href="${url}">${vo.camp_name}</a>
					</td>
					<td>${vo.camp_div}</td>
					<td>${vo.addr}</td>
					<td align="center"><input type="button" value="삭제" onClick="deleteButton('${vo.camp_name}', '${start_idx}', '${searchCondition}', '${searchKeyword}')"></td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<c:url value="getManageCampList.do" var="url">
			<c:param name="start_idx" value="1" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">처음</a>&emsp;
		
		<c:choose>
			<c:when test="${listStartPage > 1}">
				<c:url value="getManageCampList.do" var="url">
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
				<c:url value="getManageCampList.do" var="url">
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
				<c:url value="getManageCampList.do" var="url">
					<c:param name="start_idx" value="${listEndPage * pageSize + 1}" />
					<c:param name="searchCondition" value="${searchCondition}" />
					<c:param name="searchKeyword" value="${searchKeyword}" />
				</c:url>
				<a href="${url}">다음&gt;</a>&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:url value="getManageCampList.do" var="url">
			<c:param name="start_idx" value="${endPage}" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">끝</a>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
