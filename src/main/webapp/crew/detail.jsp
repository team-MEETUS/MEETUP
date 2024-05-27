<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		margin: 0 15px;
	}
	.crew-menu__items a {
		text-decoration: none;
		color: black;
		font-weight: bold;
	}
	/* 모임 배너 이미지 */
	.crew-banner-container {
		width: 100%;
	}
	.crew-banner {
		width: 100%;
		height: 300px;
		border-radius: 8px;
	}
    /* 지역 & 카테고리 & 아이콘 */
	.crew-info {
		display: flex;
		justify-content: space-between;
		width: 100%;
		margin-top: 10px;
	}
	.crew-geo, .crew-category {
		display: inline-block;
		margin: 10px 10px 10px 0;
		border-radius: 20px;
        background-color: #FB9B00;
        padding: 8px;
        font-size: 14px;
        color: white;
	}
	.crew-info-left {
		display: flex;
	}
	.crew-info-icon {
		width: 37px;
		height: 37px;
		padding: 8px;
		cursor: pointer;
	}
	/* 모임정보 & 모임멤버 섹션 */
	.crew-container {
		display: flex;
		flex-direction: row;
		margin-bottom: 50px;
		height: 500px;
	}
	.left-section {
        flex: 3;
        margin-right: 20px;
    }
    .right-section {
        flex: 1; 
        background-color: #e6e6e6;
        border-radius: 20px;
        padding: 10px;
    }
    /* 모임정보 */
	.crew-name {
		font-size: 2em;
		font-weight: bold;
	}
	.crew-content {
		margin-top: 10px;
		margin-bottom: 20px;
		height: 370px;
	}
	.btn-main {
		margin-right: 15px;
        background-color: #FB9B00;
        padding: 8px;
        font-size: 14px;
        width: 650px;
        color: white;
	}
	.like-icon {
		height: 30px;
		width: 30px;
	}
	/* 모임멤버 */
	.crew-member-wrap {
		display: flex;
		justify-content: space-between;
		width: 100%;
		margin-top: 10px;
	}
	.crew-member {
		width: 50%;
		font-weight: bold;
		margin-bottom: 20px;
		display: flex;
	}
	.member-management-wrap {
		display: flex;
	}
	.group-icon member-management {
		display: inline-block;
	}
	.member-management {
		color: black;
	}
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
	.meeting-container {
		margin-top: 50px;
	}
	.meeting-logo {
		font-size: 2em;
		font-weight: bold;
	}
	/* 수정 및 삭제 팝업 */
	.edit-delete-popup {
		display: none; 
		position: absolute;
		background-color: white;
		border: 1px solid #ccc;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		padding: 10px;
		z-index: 1000;
	}
	.edit-delete-popup a {
		display: block;
		text-decoration: none;
		color: black;
		margin-bottom: 5px;
	}
	/* 모달 */
	/* .modal {
		display: none; 
	    position: absolute;
	    top:0;
	    left: 0;
	    width: 100%;
	    height: 100vh;
	    overflow: hidden;
	    background: rgba(0,0,0,0.5);
	}
	.modal .modal_popup {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    padding: 20px;
	    background: #ffffff;
	    border-radius: 20px;
	}
	.modal .modal_popup .close_btn {
	    display: block;
	    padding: 10px 20px;
	    background-color: rgb(116, 0, 0);
	    border: none;
	    border-radius: 5px;
	    color: #fff;s
	    cursor: pointer;
	    transition: box-shadow 0.2s;
	} */
</style>
</head>
<body>
<div class="container">
	<!-- 메뉴 -->
	<ul class="crew-menu__items">
		<li>
			<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}">정보</a>
		</li>
		<li>
			<a href="board?cmd=listBoard&crewNo=${crewVO.crewNo}">게시판</a>
		</li>
		<li>
			<a href="">사진첩</a>
		</li>
		<li>
			<a href="">채팅</a>
		</li>
	</ul>
	
	<!-- 배너 -->
	<div class="crew-banner-container">
		<img class="crew-banner" src="upload/${crewVO.crewSaveBanner}" alt="${crewVO.crewName}" />
	</div>
	<!-- 지역 & 카테고리 & 아이콘 -->
	<div class="crew-info">
		<div class="crew-info-left">
			<span class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity}</span>
			<span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
		</div>
		<box-icon class="crew-info-icon" name='dots-vertical-rounded'></box-icon>
		<div class="edit-delete-popup">
			<c:choose>
			<c:when test="${role eq 'guest' || role eq 'member' || role eq 'pendingMember' || role eq 'rejectedMember' || role eq 'kick'}">
				<a href="#">신고하기</a>
			</c:when>
	        <c:when test="${role eq 'crewMember' || role eq 'adminMember'}">
				<a href="#">신고하기</a>
	        		<a href="#">모임퇴장</a>
			</c:when>
			<c:otherwise>
				<a href="#">수정하기</a>
	        		<a href="#">삭제하기</a>
			</c:otherwise>
			</c:choose>
	    </div>
	</div>
	<!-- 모임 -->
	<div class="crew-container">
		<div class="left-section">
			<p class="crew-name">${crewVO.crewName}</p>
			<p class="crew-content">${formattedContent}</p>
			<!-- 버튼&찜 -->
			<div style="display: flex; margin-bottom: 20px;">
				<c:choose>
					<c:when test="${role eq 'guest'}">
						<a href="member?cmd=login" class="btn btn-main">로그인하고 모임 가입하기</a>
					</c:when>
					<c:when test="${role eq 'member'}">
						<a href="crew?cmd=signup&crewNo=${crewVO.crewNo}" class="btn btn-main">가입신청</a>
					</c:when>
					<c:when test="${role eq 'pendingMember'}">
						<a href="" class="btn btn-main">승인중</a>
					</c:when>
					<c:when test="${role eq 'rejectedMember'}">
						<a href="" class="btn btn-main">승인 거절</a>
					</c:when>
					<c:when test="${role eq 'kick'}">
						<a href="" class="btn btn-main">강퇴된 모임</a>
					</c:when>
					<c:otherwise>
						<a href="" class="btn btn-main">공유하기</a>
					</c:otherwise>
				</c:choose>
				<box-icon class="like-icon" name='heart' ></box-icon>
			</div>
			<!-- <box-icon name='heart' type='solid' ></box-icon> -->
		</div>
		<!-- 모임 멤버 -->
		<div class="right-section">
			<div class="crew-member-wrap">
				<p class="crew-member">모임 멤버 (${crewVO.crewAttend})</p>
				<c:if test="${role eq 'leader' or role eq 'adminMember'}">
					<a href="crew?cmd=mnglist&crewNo=${crewVO.crewNo}" style="text-decoration: none;"><div class="member-management-wrap">
						<box-icon class="group-icon" type='solid' name='group'></box-icon>
						<p class="member-management">관리</p>
					</div></a>
				</c:if>
			</div>
			<c:forEach var="crewMemberVO" items="${crewMemberList}">
			<c:if test="${crewMemberVO.crewMemberStatus != 4}">
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
		</div>
	</div>
	<hr />
	<!-- 정모 -->
	<div class="meeting-container">
		<p class="meeting-logo">정모</p>
	</div>
	<!--모달 팝업-->
	<%-- <div class="modal">
	    <div class="modal_popup">
	        <h3>멤버관리</h3>
	        <c:forEach var="crewMemberVO" items="${crewMemberList}">
			<c:if test="${crewMemberVO.crewMemberStatus != 4}">
				<a href="" style="text-decoration: none;"><div class="crew-member-item">
					<c:if test="${empty crewMemberVO.memberSaveImg}">
						<box-icon type='solid' name='user-circle'></box-icon>
					</c:if>
					<c:if test="${not empty crewMemberVO.memberSaveImg}">
						<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
					</c:if>
					<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
					<c:if test="${crewMemberVO.crewMemberStatus == 4}">
						<a href="">승인</a>
						<a href="">거절</a>
 					</c:if>
				</div></a>
			</c:if>
			</c:forEach>
	        <button type="button" class="close_btn">닫기</button>
	    </div>
	</div> --%>
</div>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var infoIcon = document.querySelector('.crew-info-icon');
    var popup = document.querySelector('.edit-delete-popup');
    
    /* var memberManagementWrap = document.querySelector('.member-management-wrap');
    var modal = document.querySelector('.modal');
    var closeBtn = document.querySelector('.close_btn'); */
    
    // 팝업
    infoIcon.addEventListener('click', function(event) {
        var iconRect = infoIcon.getBoundingClientRect();
        var popupRect = popup.getBoundingClientRect();
        
        // 팝업 위치 설정 (아이콘 옆에 뜨도록)
        popup.style.left = iconRect.right + 'px';
        popup.style.top = iconRect.top + 'px';
        
        // 팝업 표시/숨김 토글
        if (popup.style.display === "none" || popup.style.display === "") {
            popup.style.display = "block";
        } else {
            popup.style.display = "none";
        }
    });

    // 클릭 시 팝업을 숨기기 위한 이벤트 리스너 추가
    document.addEventListener('click', function(event) {
        if (!popup.contains(event.target) && event.target !== infoIcon) {
            popup.style.display = 'none';
        }
    });
    
    
 	/* // 모달 띄우기
    memberManagementWrap.addEventListener('click', function(event) {
        modal.style.display = 'block';
        event.stopPropagation(); // 이벤트 전파 막기
    });

    // 모달 닫기
    closeBtn.addEventListener('click', function(event) {
        modal.style.display = 'none';
    });

    // 클릭 시 모달을 숨기기 위한 이벤트 리스너 추가
    document.addEventListener('click', function(event) {
        if (!popup.contains(event.target) && event.target !== infoIcon) {
            popup.style.display = 'none';
        }
    });

    // 모달 클릭 시 이벤트 전파 막기
    modal.addEventListener('click', function(event) {
        event.stopPropagation();
    }); */

});
</script>
</body>
</html>

</body>
</html>