<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header>
	<nav>
		<h1 class="header-logo"><a class="logo-link" href="main">MEETUP</a></h1>
		<div class="header-link">
			<a href="crew?cmd=list">모임</a>
			<a href="meeting?cmd=list">정모</a>
			<a href="crew?cmd=list">플레이스</a>
		</div>
	</nav>
	<!-- 로그인 전 -->
	<c:if test="${empty sessionScope.loginMember}">
		<div class="header-auth">
			<a href="member?cmd=login">로그인</a>
			<a href="member?cmd=signup">회원가입</a>
		</div>
	</c:if>

	<!-- 로그인 후 -->
	<c:if test="${not empty sessionScope.loginMember}">
	<div class="header-container">
		<div class="header-address">
			<box-icon name='map' type='solid' ></box-icon>
			
			<c:if test="${not empty sessionScope.loginMemberGeo.geoDistrict }">
				<a href="member?cmd=update&memberNo=${sessionScope.loginMember.memberNo}"><span>${sessionScope.loginMemberGeo.geoDistrict}</span></a>
			</c:if>
			<c:if test="${empty sessionScope.loginMemberGeo.geoDistrict}">
				<a href="member?cmd=update&memberNo=${sessionScope.loginMember.memberNo}"><span>${sessionScope.loginMemberGeo.geoCity}</span></a>
			</c:if>
		</div>
		<div class="header-profile">
			<div class="header-account">
				<span class="header-profile-nickname">${sessionScope.loginMember.memberNickname}</span>
				<img class="profile-image" src="upload/${sessionScope.loginMember.memberSaveImg}" onerror="this.onerror=null; this.src='upload/profileDefault.png'" alt="${sessionScope.loginMember.memberNickname} 프로필" />
				<div class="dropdown-menu">
					<a class="link" href="member?cmd=myMenu">마이페이지</a>
					<a class="link" href="#">내 모임</a>
					<a class="link" href="member?cmd=logout">로그아웃</a>
				</div>
			</div>
		</div>
	</div>
	</c:if>
</header>