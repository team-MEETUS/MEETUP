<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css"  type="text/css" />
<link rel="stylesheet" href="./css/index.css"  type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/swiper.css" type="text/css" />
<link rel="stylesheet" href="./css/crew/list.css" type="text/css" />
<!-- SWIPER -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<!-- CDN -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
<div class="container">
  <jsp:include page="component/header.jsp"></jsp:include>
  <script src="component/header.js"></script>
  <div class="main">
    <div class="swiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="upload/banner1.png" />
        </div>
        <div class="swiper-slide">
          <img src="upload/banner2.png" />
        </div>
        <div class="swiper-slide">
          <img src="upload/banner3.png" />
        </div>
      </div>
      <div class="swiper-pagination"></div>
    </div>
   </div>
   <section class="subContents">
   	<div class="inner">
   		<!-- 로그인 상태 -->
   		<c:if test="${not empty sessionScope.loginMember}">
   			<!-- 참여한 모임 -->
   			<c:if test="${not empty sessionScope.loginMemberCrewList}">
		   		<div class="crew-title">
		   			<h3 class="crew-title-contents">참여한 모임</h3>
		   		</div>
	   		</c:if>
	   		<div class="crew-container">
	   			<c:forEach var="crewVO" items="${loginMemberCrewList}" end="3">
	   				<div class="crew-item">
	   					<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}">
				        	<div class="card-crew">
					            <img class="crew-img" src="upload/${crewVO.crewSaveImg}" alt="${crewVO.crewName}" />
					            <div class="crew-details">
					            	<span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
					                <p class="crew-name">${crewVO.crewName}</p>
					                <p class="crew-intro">${crewVO.crewIntro}</p>
					                <p class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity} · 멤버 ${crewVO.crewAttend}</p>
					            </div>
				        	</div>
				    	</a>
	   				</div>
	   			</c:forEach>
	   		</div>
	   		 <c:if test="${fn:length(loginMemberCrewList) > 4}">
	            <div class="more-list">
	                <a href="member?cmd=myMenu">더보기</a>
	            </div>
	        </c:if>
	        <!-- 인기있는 모임 -->
	        <div class="crew-title">
	   			<h3 class="crew-title-contents">인기있는 모임</h3>
	   		</div>
	   		<div class="crew-container">
	   			<c:forEach var="crewVO" items="${loginPopularCrewList}" end="3">
	   				<div class="crew-item">
	   					<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}">
				        	<div class="card-crew">
					            <img class="crew-img" src="upload/${crewVO.crewSaveImg}" alt="${crewVO.crewName}" />
					            <div class="crew-details">
					            	<span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
					                <p class="crew-name">${crewVO.crewName}</p>
					                <p class="crew-intro">${crewVO.crewIntro}</p>
					                <p class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity} · 멤버 ${crewVO.crewAttend}</p>
					            </div>
				        	</div>
				    	</a>
	   				</div>
	   			</c:forEach>
	   		</div>
	   		<c:if test="${fn:length(loginPopularCrewList) > 4}">
	            <div class="more-list">
	                <a href="crew?cmd=list">더보기</a>
	            </div>
	        </c:if>
	        <!-- 다가오는 정모 -->
	        <div class="crew-title">
	   			<h3 class="crew-title-contents">다가오는 정모</h3>
	   		</div>
	   		<div class="crew-container">
	   			<c:forEach var="meetingVO" items="${loginComingMeetingList}" end="3">
	   				<c:set var="meetingDate" value="${meetingVO.meetingDate}"/>
	   				<fmt:formatDate var="pdMeetingDate" value="${meetingDate}" pattern="MM/dd(E) hh:mm"/>
	   				<div class="crew-item">
	   					<a href="crew?cmd=detail&crewNo=${meetingVO.crewNo}">
	   						<div class="card-crew">
	   							<img class="crew-img" src="upload/${meetingVO.meetingSaveImg}" alt="${meetingVO.meetingName}" />
	   							<div class="crew-details">
	   								<span class="crew-category">${meetingVO.categorySmallName != null ? meetingVO.categorySmallName : meetingVO.categoryBigName}</span>
	   								<p class="crew-name">${meetingVO.meetingName}</p>
	   								<p class="crew-geo">${meetingVO.geoDistrict != null ? meetingVO.geoDistrict : meetingVO.geoCity} · ${meetingVO.crewName}</p>
	   								<p class="meeting-attend">
					                	<span style="margin-right:10px;">${pdMeetingDate}</span>
					                    <box-icon style="position:relative; top:7px;" name='group' type='solid' ></box-icon> 
					                    <span>${meetingVO.meetingAttend}/${meetingVO.meetingMax}</span>
					                </p>
	   							</div>
	   						</div>
	   					</a>
	   				</div>
	   			</c:forEach>
	   		</div>
	   		<c:if test="${fn:length(loginComingMeetingList) > 4}">
	            <div class="more-list">
	                <a href="meeting?cmd=list">더보기</a>
	            </div>
	        </c:if>
   		</c:if>
   		<!-- 비로그인 상태 -->
   		<c:if test="${empty sessionScope.loginMember}">
   			<!-- 인기있는 모임 -->
	        <div class="crew-title">
	   			<h3 class="crew-title-contents">인기있는 모임</h3>
	   		</div>
	   		<div class="crew-container">
	   			<c:forEach var="crewVO" items="${noLoginPopularCrewList}" end="3">
	   				<div class="crew-item">
	   					<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}">
				        	<div class="card-crew">
					            <img class="crew-img" src="upload/${crewVO.crewSaveImg}" alt="${crewVO.crewName}" />
					            <div class="crew-details">
					            	<span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
					                <p class="crew-name">${crewVO.crewName}</p>
					                <p class="crew-intro">${crewVO.crewIntro}</p>
					                <p class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity} · 멤버 ${crewVO.crewAttend}</p>
					            </div>
				        	</div>
				    	</a>
	   				</div>
	   			</c:forEach>
	   		</div>
	   		<c:if test="${fn:length(noLoginPopularCrewList) > 4}">
	            <div class="more-list">
	                <a href="crew?cmd=list">더보기</a>
	            </div>
	        </c:if>
	        <!-- 다가오는 정모 -->
	        <div class="crew-title">
	   			<h3 class="crew-title-contents">다가오는 정모</h3>
	   		</div>
	   		<div class="crew-container">
	   			<c:forEach var="meetingVO" items="${noLoginComingMeetinList}" end="3">
	   				<c:set var="meetingDate" value="${meetingVO.meetingDate}"/>
	   				<fmt:formatDate var="pdMeetingDate" value="${meetingDate}" pattern="MM/dd(E) hh:mm"/>
	   				<div class="crew-item">
	   					<a href="crew?cmd=detail&crewNo=${meetingVO.crewNo}">
	   						<div class="card-crew">
	   							<img class="crew-img" src="upload/${meetingVO.meetingSaveImg}" alt="${meetingVO.meetingName}" />
	   							<div class="crew-details">
	   								<span class="crew-category">${meetingVO.categorySmallName != null ? meetingVO.categorySmallName : meetingVO.categoryBigName}</span>
	   								<p class="crew-name">${meetingVO.meetingName}</p>
	   								<p class="crew-geo">${meetingVO.geoDistrict != null ? meetingVO.geoDistrict : meetingVO.geoCity} · ${meetingVO.crewName}</p>
	   								<p class="meeting-attend">
					                	<span style="margin-right:10px;">${pdMeetingDate}</span>
					                    <box-icon style="position:relative; top:7px;" name='group' type='solid' ></box-icon> 
					                    <span>${meetingVO.meetingAttend}/${meetingVO.meetingMax}</span>
					                </p>
	   							</div>
	   						</div>
	   					</a>
	   				</div>
	   			</c:forEach>
	   		</div>
	   		<c:if test="${fn:length(noLoginComingMeetinList) > 4}">
	            <div class="more-list">
	                <a href="meeting?cmd=list">더보기</a>
	            </div>
	        </c:if>
   		</c:if>
   	</div>
   </section>
</div>
<jsp:include page="component/footer.jsp"></jsp:include>
</body>
<script>
  const swiper = new Swiper(".swiper", {
    // Optional parameters
    direction: "horizontal",
    loop: true,
    
    autoplay: {
        delay: 5000,
      },
      
    speed: 1000,

    // If we need pagination
    pagination: {
      el: ".swiper-pagination",
    },
  });
</script>
</html>