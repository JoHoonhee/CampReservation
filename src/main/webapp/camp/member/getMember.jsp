<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function deleteButton(idx) {
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteMember.do',
				data: { idx: idx },
				success: function(data) {
					location.replace(path + '/index.jsp');
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>회원정보수정</h3>
		<font color="red">*</font>표시는 반드시 기입해주세요.<br>
		<form action="updateMember.do">
		<input type="hidden" name="idx" value="${vo.idx}">
		<table id="memberFormTable">
			<tr>
				<td align="center">아이디</td>
				<td>${vo.id}</td>
			</tr>
			<tr>
				<td align="center">비밀번호<font color="red">*</font></td>
				<td><input type="password" name="password" value="${vo.password}" size="30" placeholder="최소 6자리이상 입력해주세요."></td>
			</tr>
			<tr>
				<td align="center">이름</td><td>${vo.name}</td>
			</tr>
			<tr>
				<td align="center">전화번호<font color="red">*</font></td>
				<td><input type="text" name="tel" value="${vo.tel}" size="20" placeholder="010-0000-0000"></td>
			</tr>
			<tr>
				<td align="center">이메일</td>
				<td><input type="email" name="email" value="${vo.email}" size="20" placeholder="ex)aaa@camping.com"></td>
			</tr>
			<tr>
				<td align="center" colspan="2">
					<input type="submit" value="수정하기">&nbsp;
					<input type="button" value="탈퇴하기" onClick="deleteButton(${vo.idx})">
				</td>
			</tr>
		</table>
		</form>		
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
