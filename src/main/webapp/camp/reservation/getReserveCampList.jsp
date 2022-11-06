<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<section>
	<br>
	<div align="center">
		<h3>캠핑장 찾기</h3>
		<form action="getReserveCampList.do">
			<select name="searchCondition" id="searchCondition">
				<option value="camp_name">캠핑장명</option>
				<option value="addr">주소</option>
			</select>
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="검색어를 입력해주세요">
			<input type="submit" id="searchBtn" value="검색">
		</form>
		<br>
		<table class="campListTable">
			<tr><th>캠핑장명(예약)</th><th>구분</th><th>주소</th></tr>
			<c:forEach items="${li}" var="vo">
				<tr>
					<td>
						<c:url value="getReserveCamp.do" var="url">
							<c:param name="camp_name" value="${vo.camp_name}" />
						</c:url>
						<a href="${url}">${vo.camp_name}</a>
					</td>
					<td>${vo.camp_div}</td>
					<td>${vo.addr}</td>
				</tr>
			</c:forEach>
		</table>
		<br>
		<c:url value="getReserveCampList.do" var="url">
			<c:param name="start_idx" value="1" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">처음</a>&emsp;
		
		<c:choose>
			<c:when test="${listStartPage > 1}">
				<c:url value="getReserveCampList.do" var="url">
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
				<c:url value="getReserveCampList.do" var="url">
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
				<c:url value="getReserveCampList.do" var="url">
					<c:param name="start_idx" value="${listEndPage * pageSize + 1}" />
					<c:param name="searchCondition" value="${searchCondition}" />
					<c:param name="searchKeyword" value="${searchKeyword}" />
				</c:url>
				<a href="${url}">다음&gt;</a>&emsp;
			</c:otherwise>
		</c:choose>
		
		<c:url value="getReserveCampList.do" var="url">
			<c:param name="start_idx" value="${endPage}" />
			<c:param name="searchCondition" value="${searchCondition}" />
			<c:param name="searchKeyword" value="${searchKeyword}" />
		</c:url>
		<a href="${url}">끝</a>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
