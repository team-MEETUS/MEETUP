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
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/myMenu.css" type="text/css" />
<link rel="stylesheet" href="./css/crew/list.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script>
$(document).ready(function() {
    // 회원탈퇴 버튼 클릭 시 재확인 창 표시
    $('form').submit(function(e) {
        e.preventDefault();

        var form = this; // 현재 폼을 가리키는 this를 form 변수에 저장

        Swal.fire({
            title: "Meetup",
            text: "탈퇴하시겠습니까?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Meetup',
                    text: '처리되었습니다.',
                    icon: 'success'
                });
                
                // 1초 후 폼 제출
                setTimeout(function() {
                    form.submit(); // 여기서 form은 위에서 저장한 현재 폼을 가리킵니다.
                }, 1000); // 1000ms = 1초
            }
        });
        
    });
});
</script>
</head>
<body>
	<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<script src="component/header.js"></script>
	<!-- <section class="subCommon">
		subCommon
		<div class="inner">
			<h2 class="subTitle">마이페이지</h2>
		</div>
	</section> -->
	<!-- Contents -->
	<section class="subContents">
		<div class="inner">
			<div class="member--wrap">
				<div class="member__profile-box">
					<div class="member__profile">
						<span class="member__profile--img" style="background-image: url('upload/${not empty loginMember.memberSaveImg ? loginMember.memberSaveImg : 'profileDefault.png'}');"></span>
						<div class="member__profile--details">
							<strong class="member__profile--name">${loginMember.memberNickname}</strong>
							<p class="member__profile--geo">${GeoVO.geoCity}&nbsp;${GeoVO.geoDistrict}</p>
							<p class="member__profile--birth">${loginMember.memberBirth}&nbsp;·&nbsp;${loginMember.memberGender}</p>
							<p class="member__profile--intro">${loginMember.memberIntro}</p>
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
					<div class="button-container">
					    <button id="showParticipatedCrews">참여한 모임</button>
					    <div class="divider"></div>
					    <button id="showLikedCrews">찜한 모임</button>
					</div>
			</div>
			<!-- 참여한 모임 -->
			<div class="crew-container" id="participatedCrews" style="display:none;">
				<c:forEach var="crewVO" items="${loginMemberCrewList}">
			    	<div class="crew-item">
			        	<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}"><div class="card-crew">
			            	<img class="crew-img" src="upload/${crewVO.crewSaveImg}" onerror="this.onerror=null; this.src='upload/imgDefault.png'" alt="${crewVO.crewName}" />
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
			
			<!-- 찜한 모임 -->
			<div class="crew-container" id="likedCrews" style="display:none;">
				<c:forEach var="crewVO" items="${loginMemberLikeCrewList}">
			    	<div class="crew-item">
			        	<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}"><div class="card-crew">
			        		<img class="crew-img" src="upload/${crewVO.crewSaveImg}" onerror="this.onerror=null; this.src='upload/imgDefault.png'" alt="${crewVO.crewName}" />
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
	
	<script>
		$(document).ready(function() {
		    $('#participatedCrews').show();
	
		    $('#showParticipatedCrews').html('<span>참여한 모임</span>');
		    $('#showLikedCrews').html('<span>찜한 모임</span>');
		    
		    $('#showParticipatedCrews').addClass('active');
	
		    $('#showParticipatedCrews').click(function(e) {
		        e.preventDefault();
		        $('#participatedCrews').show();
		        $('#likedCrews').hide();
		        $('#showParticipatedCrews').addClass('active');
		        $('#showLikedCrews').removeClass('active');
		    });
	
		    $('#showLikedCrews').click(function(e) {
		        e.preventDefault();
		        $('#likedCrews').show();
		        $('#participatedCrews').hide();
		        $('#showParticipatedCrews').removeClass('active');
		        $('#showLikedCrews').addClass('active');
		    });
		});
	</script>
</body>
</html>
