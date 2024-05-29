<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
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
	/* 모임회원 */
	.crew-member-item {
		display: flex;
		align-items: center;
		margin: 10px;
		width: 100%;
	}
	.crew-member-item a {
	    text-decoration: none;
	}
	.crew-member-img, box-icon[type="solid"][name="user-circle"] {
		width: 50px;
		height: 50px;
		border-radius: 50%;
		margin-right: 20px;
	}
	.crew-member-nickname {
		font-weight: bold;
		line-height: 50px; 
		margin: 0; 
		color: black;
	}
	.crew-category {
		display: inline-block;
		margin: 10px 10px 10px 0;
		border-radius: 20px;
        background-color: #FB9B00;
        padding: 8px;
        font-size: 14px;
        color: white;
	}
</style>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<!-- 메뉴 -->
	<ul class="crew-menu__items">
		<li>
			<a href="">모임회원</a>
		</li>
		<li>
			<a href="">가입신청</a>
		</li>
	</ul>
	
	<c:forEach var="crewMemberVO" items="${crewMemberList}">
		<!-- 회원멤버만 -->
		<c:if test="${crewMemberVO.crewMemberStatus != 0 && crewMemberVO.crewMemberStatus != 4 && crewMemberVO.crewMemberStatus != 5}">
			<a href="member?cmd=memberProfile&memberNo=${crewMemberVO.memberNo}" style="text-decoration: none;"><div class="crew-member-item">
				<c:if test="${empty crewMemberVO.memberSaveImg}">
					<box-icon type='solid' name='user-circle'></box-icon>
				</c:if>
				<c:if test="${not empty crewMemberVO.memberSaveImg}">
					<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
				</c:if>
				<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
			</div></a>
			<!--  운영진 -->
			<c:if test="${crewMemberVO.crewMemberStatus == 2}">
				<!-- 모임장만 가능 -->
				<c:if test="${role eq 'leader'}">
					<a href="crew?cmd=mng&requestType=transfer&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님께 모임장을 양도하시겠습니까?" >모임장양도</a>
				</c:if>
				<!-- 모임장 & 운영진(본인 제외) -->
				<c:if test="${role eq 'leader' || (role eq 'adminMember' && sessionScope.loginMember.memberNo ne crewMemberVO.memberNo)}">
					<a href="crew?cmd=mng&requestType=demote&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님을 일반멤버로 변경 하시겠습니까?" >운영진해제</a>
				</c:if>
			</c:if>
			<!-- 일반회원 -->
			<c:if test="${crewMemberVO.crewMemberStatus == 1}">
				<!-- 모임장만 가능 -->
				<c:if test="${role eq 'leader'}">
					<a href="crew?cmd=mng&requestType=transfer&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님께 모임장을 양도하시겠습니까?" >모임장양도</a>
				</c:if>
				<!-- 모임장 & 운영진 -->
				<a href="crew?cmd=mng&requestType=appoint&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님을 운영진으로 임명하시겠습니까?" >운영진임명</a>
				<a href="crew?cmd=mng&requestType=kick&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님을 강퇴하시겠습니까?" >강퇴</a>
			</c:if>
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
		<a href="crew?cmd=mng&requestType=approval&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" >가입승인</a>
		<a href="crew?cmd=mng&requestType=reject&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" >가입거절</a>
	</c:if>
	</c:forEach>
    <jsp:include page="../component/footer.jsp"></jsp:include>
</div>
<script>
$(document).ready(function () {
    // alert 창
    $('.crew-category').click(function (event) {
        event.preventDefault(); // 기본 동작 막기
        var href = $(this).attr('href'); // href 속성 가져오기
        var message = $(this).data('message'); // data-message 속성 가져오기

        Swal.fire({
            title: "Meetup",
            text: message,
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소'
        }).then((result) => {
        	if (result.isConfirmed) {
        		Swal.fire(
	              'Meetup',
	              '처리되었습니다.',
	              'success'
	            )
	            window.location.href = href; 
	        }
        });
    });
});
</script>
</body>
</html>