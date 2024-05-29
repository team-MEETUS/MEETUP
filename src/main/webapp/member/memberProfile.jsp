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
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<section class="subCommon">
			<!-- subCommon -->
			<div class="inner">
				<h2 class="subTitle">${otherMember.memberNickname} 프로필</h2>
			</div>
		</section>
		<section class="subContents">
			<div class="inner">
				<div class="memberProfile--wrap">
					<div class="memberProfile__profile-box">
						<div class="memberProfile__profile">
							<span class="memberProfile__profile--img" style="background-image: url('upload/${not empty otherMember.memberSaveImg ? otherMember.memberSaveImg : 'first.png'}');"></span>
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
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>