<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/top.jsp" %>
<script>
	function idCheck() {
		if (f1.id.value=="") {
			alert("아이디를 입력해주세요!");
			f1.id.focus();
			return false;
		} else if (f1.password.value=="") {
			alert("비밀번호를 입력해주세요!");
			f1.password.focus();
			return false;
		}
	}
</script>
<section id="main_background">
	<br>
	<div id="login" align="right">
		<form name="f1" action="login.do" method="POST" onSubmit="return idCheck()">
		<table id="formLogin">
			<tr align="center">
			<td>
				<c:choose>
					<c:when test="${login_check == null || login_check == 'F'}">
						<h3>로그인</h3>
						<input type="text" name="id" placeholder="아이디" value="admin111"><br><br>
						<input type="password" name="password" placeholder="비밀번호" value="admin111"><br><br>
						<input type="submit" value="로그인">
					</c:when>
					<c:otherwise>
						<font color='green'><b>${login_name}</b></font> 님 환영합니다!
					</c:otherwise>
				</c:choose>
			</td>
			</tr>
		</table>
		</form>
	</div>
	<br>
</section>
<%@ include file="./include/bottom.jsp" %>
