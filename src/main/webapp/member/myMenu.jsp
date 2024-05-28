<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이메뉴</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/member/myMenu.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
	    // 회원탈퇴 click하면 재확인용 창 나오게함
	    $('form').submit(function(e) {
	        e.preventDefault();

	        var confirmResult = confirm("정말 삭제하시겠습니까?");
	        
	        if (confirmResult) {
	            this.submit();
	        }
	        
	    });
	});
</script>
</head>
<body>
	<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<section class="subCommon">
		<!-- subCommon -->
		<div class="inner">
			<h2 class="subTitle">마이페이지</h2>
		</div>
	</section>
	<!-- Contents -->
	<section class="subContents">
		<div class="inner">
			<div class="member--wrap">
				<div class="member__profile-box">
					<div class="member__profile">
						<span class="member__profile--img" style="background-image: url('upload/${not empty loginMember.memberSaveImg ? loginMember.memberSaveImg : 'first.png'}');"></span>
						<div class="member__profile--details">
							<strong class="member__profile--name">${loginMember.memberNickname}</strong>
							<p class="member__profile--birth">${loginMember.memberBirth}</p>
							<p class="member__profile--gender">${loginMember.memberGender}</p>
							<p class="member__profile--geo">${GeoVO.geoCity}&nbsp;${GeoVO.geoDistrict}</p>
						</div>
					</div>
					<div class="member__profile--actions">
						<a href="member?cmd=update"><button class="member__profile--mod">내 정보 수정</button></a>
						<a href="member?cmd=confirmPw"><button class="member__profile--mod">비밀번호 변경</button></a>
						<form action="member?cmd=delete" method="post">
							<input type="hidden" name="memberNo" value="${loginMember.memberNo}" />
							<button class="member__profile--mod" type="submit">회원탈퇴</button>
						</form>
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
