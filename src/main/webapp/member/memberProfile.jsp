<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/memberProfile.css" type="text/css" />
<link rel="stylesheet" href="./css/crew/list.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<%-- <section class="subCommon">
			<!-- subCommon -->
			<div class="inner">
				<h2 class="subTitle">${otherMember.memberNickname} 프로필</h2>
			</div>
		</section> --%>
		<section class="subContents">
			<div class="inner">
				<div class="memberProfile--wrap">
					<div class="memberProfile__profile-box">
						<div class="memberProfile__profile">
							<span class="memberProfile__profile--img" style="background-image: url('upload/${not empty otherMember.memberSaveImg ? otherMember.memberSaveImg : 'profileDefault.png'}');"></span>
							<div class="memberProfile__profile--details">
								<strong class="memberProfile__profile--name">${otherMember.memberNickname}</strong>
								<p class="memberProfile__profile--geo">${GeoVO.geoCity}&nbsp;${GeoVO.geoDistrict}</p>
								<p class="memberProfile__profile--birth">${otherMember.memberBirth}&nbsp;·&nbsp;${otherMember.memberGender}</p>
								<p class="memberProfile__profile--intro">${otherMember.memberIntro}</p>
							</div>
						</div>
					</div>
					<hr />
				</div>
				<div class="crew-title">
					<h3 class="crew-title-contents">참여한 모임</h3>
				</div>
				<!-- 참여한 모임 -->
				<div class="crew-container" id="participatedCrews">
					<c:forEach var="crewVO" items="${memberProfileCrewList}">
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
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>