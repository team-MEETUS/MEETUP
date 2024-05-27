<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>메인페이지</h1>
	<c:if test="${not empty sessionScope.loginMember}">
		<div><a href="member?cmd=myMenu">마이페이지</a></div>
		<div><a href="member?cmd=logout">로그아웃</a></div>
		<div><a href="crew?cmd=list">모임</a></div>
		<div><a href="meeting?cmd=list">정모</a></div>
		<div><a href="board?cmd=listBoard">게시판</a></div>
	</c:if>
	<c:if test="${empty sessionScope.loginMember}">
		<div><a href="member?cmd=login">로그인</a></div>
		<div><a href="member?cmd=signup">회원가입</a></div>
		<div><a href="crew?cmd=list">모임</a></div>
		<div><a href="meeting?cmd=list">정모</a></div>
		<div><a href="board?cmd=listBoard">게시판</a></div>
	</c:if>
</body>
</html>