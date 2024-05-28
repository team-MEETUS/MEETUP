<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="./css/header.css" type="text/css" />
</head>
<body>
	<header>
        <nav>
          <h1 class="header-logo"><a class="logo-link" href="member">MEETUP</a></h1>
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
        <div class="header-profile">
          <span>${sessionScope.loginMember.memberNickname}</span>
          <c:choose>
		    <c:when test="${not empty sessionScope.loginMember.memberSaveImg}">
		        <img
		            class="profile-image"
		            src="upload/${sessionScope.loginMember.memberSaveImg}"
		        	alt="${sessionScope.loginMember.memberNickname} 프로필"
		    	/>
		    </c:when>
		    <c:otherwise>
		        <img
		            class="profile-image"
		            src="upload/first.png"
		    		alt="${sessionScope.loginMember.memberNickname} 프로필"
		    	/>
		  	</c:otherwise>
		  </c:choose>
          <div class="dropdown-menu">
            <a class="link" href="member?cmd=myMenu">마이페이지</a>
            <a class="link" href="#">내 모임</a>
            <a class="link" href="member?cmd=logout">로그아웃</a>
          </div>
        </div>
        </c:if>
      </header>
</body>
</html>