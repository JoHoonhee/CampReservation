<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	function checkVal() {
		if (f1.review.value == '') {
			alert('리뷰를 남겨주세요.');
			f1.review.focus();
			return false;
		} else {
			if(confirm("작성이 완료되었습니까?")) {
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
		<h3>리뷰작성</h3>
		<form name="f1" action="<%=path%>/insertReview.do" onSubmit="return checkVal();">
			<input type="hidden" name="idx" value="${vo.idx}">
			<input type="hidden" name="id" value="${login_id}">
			<input type="hidden" name="name" value="${login_name}">
			<input type="hidden" name="camp_name" value="${vo.camp_name}">
		<table id="reviewFormTable">
			<tr><th>캠핑장명</th><td>${vo.camp_name}</td></tr>
			<tr><th>이용구분</th><td>${vo.camp_div}</td></tr>
			<tr><th>예약자</th><td>${vo.name}</td></tr>
			<tr style="border-bottom-style: double;">
				<th>예약일</th>
				<td>
					<fmt:formatDate value="${vo.start_date}" pattern="yyyy-MM-dd" /> ~ 
					<fmt:formatDate value="${vo.end_date}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			<tr><th>리뷰작성</th><td><textarea name="review" rows="6" cols="30" placeholder="한 줄 후기 남겨주세요."></textarea></td></tr>
			<tr><td align="center" colspan="2"><input type="submit" value="리뷰작성"></td></tr>
		</table>
		</form>
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
