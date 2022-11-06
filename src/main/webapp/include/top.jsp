<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>CampingReservation</title>
	<link href="css/style.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="<%=path%>/js/address.js"></script>
</head>
<body>
<header>
	<p>
	<font size="15px"><b>Camp Reservation</b></font>
	<img src="<%=path%>/img/car.png">
	</p>
</header>
<hr>
<nav>
	<div style="float: left; margin-left: 30px;">
		&emsp;&emsp;<a href="<%=path%>/index.jsp">Home</a>
		&emsp;&emsp;<a href="<%=path%>/getReserveCampList.do">캠핑장찾기</a>
		<c:if test="${login_id != null}">
			&emsp;&emsp;<a href="<%=path%>/getReserveCheckList.do?id=${login_id}">예약확인</a>
		</c:if>
		<c:if test="${login_role == 'ROLE_MANAGER' || login_role == 'ROLE_ADMIN'}">
			&emsp;&emsp;&emsp;&emsp;<a href="<%=path%>/getManageCampList.do">캠핑장관리</a>
		</c:if>
		<c:if test="${login_role == 'ROLE_ADMIN'}">
			&emsp;&emsp;<a href="<%=path%>/getMemberList.do">회원권한관리</a>
			&emsp;&emsp;<a href="<%=path%>/insertCampJson.do">최초캠프장등록</a>
		</c:if>
	</div>
	<div style="float: right; margin-right: 30px;">
		<c:choose>
			<c:when test="${login_id != null}">
				<a href="<%=path%>/getMember.do?id=${login_id}">나의정보</a>&emsp;&emsp;
				<a href="<%=path%>/logout.do">로그아웃</a>&emsp;&emsp;
			</c:when>
			<c:otherwise>
				<a href="<%=path%>/formMember.do">회원가입</a>&emsp;&emsp;
			</c:otherwise>
		</c:choose>
	</div>
</nav>
<hr>