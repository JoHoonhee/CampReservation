<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../include/top.jsp" %>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	$(document).ready(function() {
		$('#idCheck').click(function() {
			var dataStr = { id : $('#id').val() };
			$.ajax({
				type : "GET",
				url : path + "/idCheck.do",
				data : dataStr,
				success : function(data) {
					if (data == 0) {
						alert("사용 가능한 아이디 입니다.");
					} else {
						alert("아이디가 이미 사용 중입니다.");
						$('#id').val("");
						$('#id').focus();
					} // if
				}  // success
			})  // ajax
		});  // click
	})  // ready
	
	function submitCheck() {
		if (f1.id.value == "") {
			alert("아이디를 입력해주세요.");
			f1.id.focus();
			return false;
		} else if (f1.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			f1.password.focus();
			return false;
		} else if (f1.password.value.length < 6) {
			alert("비밀번호를 6자리 이상 입력해주세요.");
			f1.password.focus();
			return false;
		} else if (f1.name.value == "") {
			alert("이름을 입력해주세요.");
			f1.name.focus();
			return false;
		} else if (f1.tel.value == "") {
			alert("전화번호를 입력해주세요.");
			f1.tel.focus();
			return false;
		} else if (f1.tel.value.length != 13) {
			alert("전화번호를 양식을 확인해주세요.(예: 010-1234-5678)");
			f1.tel.focus();
			return false;
		} else {
			alert("가입완료!");
		}
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>회원가입</h3>
		<font color="red">*</font>표시는 반드시 기입해주세요.<br>
		<form name="f1" action="insertMember.do" onSubmit="return submitCheck()">
		<table id="memberFormTable">
			<tr>
				<td align="center">아이디<font color="red">*</font></td>
				<td><input type="text" name="id" id="id">&emsp;<input type="button" value="중복확인" id="idCheck"></td>
			</tr>
			<tr>
				<td align="center">비밀번호<font color="red">*</font></td>
				<td><input type="password" name="password" id="password" size="30" placeholder="최소 6자리이상 입력해주세요."></td>
			</tr>
			<tr>
				<td align="center">이름<font color="red">*</font></td><td><input type="text" name="name" id="name" size="13"></td>
			</tr>
			<tr>
				<td align="center">전화번호<font color="red">*</font></td><td><input type="text" name="tel" id="tel" size="20" placeholder="010-0000-0000"></td>
			</tr>
			<tr>
				<td align="center">이메일</td><td><input type="email" name="email" size="20" placeholder="ex)aaa@camping.com"></td>
			</tr>
			<tr>
				<td align="center" colspan="2"><input type="submit" value="가입하기"></td>
			</tr>
		</table>
		</form>		
	</div>
	<br>
</section>
<%@ include file="../../include/bottom.jsp" %>
