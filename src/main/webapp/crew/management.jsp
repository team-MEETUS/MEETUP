<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<style>
	.container {
		width: 1024px;
		margin: 0 auto;
	}
	/* 모임 메뉴 */
	.crew-menu__items {
		display: flex;
		justify-content: center;
		list-style: none;
		padding: 0;
		margin: 30px 0;
		font-size: 20px;
	}
	.crew-menu__items li {
		margin: 0 50px;
	}
	.crew-menu__items a {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
</style>
</head>
<body>
<div class="container">
	<!-- 메뉴 -->
	<ul class="crew-menu__items">
		<li>
			<a href="">모임회원</a>
		</li>
		<li>
			<a href="">가입신청</a>
		</li>
	</ul>
	<!-- 모임회원 -->
	<c:forEach var="crewMemberVO" items="${crewMemberList}">
	<c:if test="${crewMemberVO.crewMemberStatus != 0 && crewMemberVO.crewMemberStatus != 4 && crewMemberVO.crewMemberStatus != 5}">
		<a href="" style="text-decoration: none;"><div class="crew-member-item">
			<c:if test="${empty crewMemberVO.memberSaveImg}">
				<box-icon type='solid' name='user-circle'></box-icon>
			</c:if>
			<c:if test="${not empty crewMemberVO.memberSaveImg}">
				<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
			</c:if>
			<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
		</div></a>
	</c:if>
	</c:forEach>
	
	<hr />
	
	<!-- 가입신청 -->
	<c:forEach var="crewMemberVO" items="${crewMemberList}">
	<c:if test="${crewMemberVO.crewMemberStatus == 4}">
		<a href="" style="text-decoration: none;"><div class="crew-member-item">
			<c:if test="${empty crewMemberVO.memberSaveImg}">
				<box-icon type='solid' name='user-circle'></box-icon>
			</c:if>
			<c:if test="${not empty crewMemberVO.memberSaveImg}">
				<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
			</c:if>
			<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
		</div></a>
		<a href="crew?cmd=mng&requestType=approval&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}">가입승인</a>
		<a href="crew?cmd=mng&requestType=reject&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}">가입거절</a>
	</c:if>
	</c:forEach>
</div>
</body>
</html>