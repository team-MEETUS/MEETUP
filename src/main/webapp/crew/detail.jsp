<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css"  type="text/css" />
<link rel="stylesheet" href="./css/index.css"  type="text/css" />
<!-- CDN -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
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
		width: 100%;
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
	
	/* 정모 */
	.meetingOne-container {
		width: 500px;
		display: inline-block;
	}
	.meeting-header {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: -30px;
	}
	
	.meeting-header>div {
		margin-bottom: 10px;
	}
	
	.meetingOne {
	  width: 380px;
	  border: 1px solid #ccc;
	  border-radius: 20px;
	  padding: 20px 40px;
	  text-align: left;
	  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	  display: inline-block;
	  margin: 10px;
	  background-color: rgb(230, 230, 230);
	  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
	  transition: box-shadow 0.3s ease; /* 부드러운 전환 효과 추가 */
	  line-height: 20px;
	}
	
	.meetingOne:hover {
	    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 호버 시 더 진한 그림자 */
	}
	
	.meeting-info>img {
		width: 160px;
		height: 120px;
	}
	
	.meeting-info {
		display: flex;
		font-size: 17px;
	}
	
	.meeting-info>div>div {
		margin: 7px 7px;
	}
	
	.meeting-icon {
		margin-left: 10px;
		position: relative; /* 상대 위치 설정 */
    	display: inline-block; /* 내부 요소들을 인라인 블록으로 설정 */
	}
	
	.meeting-icon>span>a {
		width: 30px;
		height: 30px;
	}
	
	.list-icon {
		position: absolute; /* 절대 위치 설정으로 다른 요소 위에 올라가게 함 */
	    top: 0; /* 상단에서 0px의 위치에 배치 */
	    left: 355px; /* 왼쪽에서 0px의 위치에 배치 */
	    z-index: 1; /* 다른 요소보다 위에 오게 설정 */
	}
	
	.meeting-icon-img {
	    position: relative; /* 상대 위치 설정 */
    	z-index: 0; /* 기본적으로 이 요소가 더 아래에 위치하도록 설정 */
	}
	
	.meeting-icon>span>a:nth-child(7)>span>img {
		opacity: 0.5; /* 투명도 설정 (0 완전 투명, 1 완전 불투명) */
	}
	.meeting-icon>span>a:nth-child(7)>span>box-icon {
		opacity: 0.5; /* 투명도 설정 (0 완전 투명, 1 완전 불투명) */
	}
	.meeting-insert-btn{
        border-radius: 15px;
        background-color: #FB9B00;
        padding: 10px;
        display: inline-block;
        margin: 15px 0;
        color: white;
        position: relative;
        left: 930px;
        bottom: 45px;
	}
	.meeting-attendExit-btn {
		width: 50px;
		text-align: center;
        border-radius: 15px;
        background-color: #FB9B00;
        padding: 10px;
        display: inline-block;
        color: white;
        position: relative;
        left: 309px;
        bottom: 20px;
	}
</style>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>	
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
		<img class="crew-banner" src="./upload/${crewVO.crewSaveBanner}" alt="${crewVO.crewName}" />
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
	        		<a href="crew?cmd=mng&requestType=leave&crewNo=${crewVO.crewNo}&memberNo=${sessionScope.loginMember.memberNo}">모임퇴장</a>
			</c:when>
			<c:otherwise>
				<a href="crew?cmd=update&crewNo=${crewVO.crewNo}">수정하기</a>
	        		<a href="crew?cmd=delete&crewNo=${crewVO.crewNo}">삭제하기</a>
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
				<c:if test="${isValidCrewLike eq 0}">
					<c:if test="${empty sessionScope.loginMember}">
						<a href="member?cmd=login"><box-icon class="like-icon" name='heart' ></box-icon></a>
					</c:if>
					<c:if test="${not empty sessionScope.loginMember}">
						<a href="crew?cmd=like&requestType=add&crewNo=${crewVO.crewNo}"><box-icon class="like-icon" name='heart' ></box-icon></a>
					</c:if>
				</c:if>
				<c:if test="${isValidCrewLike eq 1}">
					<a href="crew?cmd=like&requestType=delete&crewNo=${crewVO.crewNo}"><box-icon class="like-icon" name='heart' type='solid' ></box-icon></a>
				</c:if>
			</div>
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
			</c:if>
			</c:forEach>
		</div>
	</div>
	<hr />
	
	<!-- 정모 -->
	<div class="meeting-container">
		<p class="meeting-logo">정기모임</p>
		<p>
		<c:if test="${role eq 'leader' || role eq 'adminMember'}">
			<a class="meeting-insert-btn" href="meeting?cmd=write&crewNo=${crewVO.crewNo}">정모 등록하기</a>
		</c:if>
		</p>
		
		<c:forEach var="meetingVO" items="${meetingList}">
		<div class="meetingOne-container">
			<!-- 오늘 날짜 생성 및 데이터 가공 -->
			<c:set var="today" value="<%=new java.util.Date() %>"/>
			<fmt:formatDate var="nowDay" value="${today}" pattern="yyyy-MM-dd hh:mm:ss" />
			<fmt:parseDate value="${nowDay}" var="pdToday" pattern="yyyy-MM-dd"/>
			<fmt:parseNumber value="${pdToday.time / (1000*60*60*24)}" integerOnly="true" var="numToday"></fmt:parseNumber>
			
			<!-- meetingDate 데이터 가공 -->
			<c:set var="meetingDate" value="${meetingVO.meetingDate}"/>
			<fmt:parseDate value="${meetingDate}" var="pdMeetingDate" pattern="yyyy-MM-dd"/>
			<fmt:parseNumber value="${pdMeetingDate.time / (1000*60*60*24)}" integerOnly="true" var="numMeetingDate"></fmt:parseNumber>
			
			<c:set var="isMeetingMember" value="false" />
			
			<!-- 정모와 정모참여 정모no가 같은지 확인, 정모에 참여한 멤버가 로그인한 유저인지 확인 -->
			<c:forEach var="meetingMemberVO" items="${meetingMemberList}">
				<c:if test="${meetingMemberVO.memberNo == MemberVO.memberNo && meetingVO.meetingNo eq meetingMemberVO.meetingNo}">
						<c:set var="isMeetingMember" value="true" />
				</c:if>
			</c:forEach>
			
			<!-- for문을 돌면서 정모정보를 계속 뿌려주는 div -->
			<div class="meetingOne">
				<div style="display: inline-block">
					<div class="meeting-header">
						<div>
							<span style="margin-right: 10px;"><fmt:formatDate value="${meetingDate}" pattern="MM/dd (E)"/></span> 
							<span style=color:red>D-${numMeetingDate - numToday}</span>						
						</div>
						<p>${meetingVO.meetingName}</p>					
					</div>
					<c:if test="${role eq 'crewMember' || role eq 'adminMember' || role eq 'leader'}">
					<c:choose>
						<c:when test="${not empty meetingMemberList}">
							<c:choose>
								<c:when test="${isMeetingMember && meetingVO.memberNo eq MemberVO.memberNo}">
									<span><a class="meeting-attendExit-btn" href="meetingDelete?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">삭제</a></span>
								</c:when>
								<c:when test="${isMeetingMember}">
									<span><a class="meeting-attendExit-btn" href="meetingExit?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">나가기</a></span>
				        		</c:when>
				        		<c:otherwise>
				        			<span><a class="meeting-attendExit-btn" href="meetingAttend?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">참석</a></span>
				        		</c:otherwise>      	
		        			</c:choose>
		        		</c:when>
		        		<c:otherwise>
		        			<span><a class="meeting-attendExit-btn" href="meetingAttend?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">참석</a></span>
		        		</c:otherwise>
	        		</c:choose>
					</c:if>
				</div>

				<br />
				<div class="meeting-info">
					<img src="upload/${meetingVO.meetingSaveImg}" alt="" />
					<div>
						<div>일시 <fmt:formatDate value="${meetingDate}" pattern="MM/dd (E) aa hh:mm "/></div>
						<div>위치 ${meetingVO.meetingLoc}</div>
						<c:set var="won" value="원"/>
						<div>비용 ${meetingVO.meetingPrice == 0 ? '없음' : meetingVO.meetingPrice += won}</div>
						<div>참석 ${meetingVO.meetingAttend}/${meetingVO.meetingMax} (${meetingVO.meetingMax-meetingVO.meetingAttend}자리 남음) </div>
					</div>
				</div>
			</div>
			
			<c:set var="i" value="${1}"/>
			
			<div class="meeting-icon">
			<!-- 박스 밑의 사용자 이미지아이콘 띄우기 -->
				<span>
					<c:forEach var="meetingMemberVO" items="${meetingMemberList}" varStatus="meetingMemberStatus">
						<c:if test="${meetingMemberVO.meetingNo == meetingVO.meetingNo && i <= 7}" >
							<a href="" style="text-decoration: none;"><span>
							<c:if test="${empty meetingMemberVO.memberSaveImg}">
								<box-icon type='solid' name='user-circle' style="margin-right: 5px;"></box-icon>
							</c:if>
							<c:if test="${not empty meetingMemberVO.memberSaveImg}">
								<img class="crew-member-img" src="upload/${meetingMemberVO.memberSaveImg}" style="margin-right: 5px;" />
							</c:if>
							</span></a>
							
							<c:set var="i" value="${i+1}"/>
						</c:if>
					</c:forEach>
					<c:if test="${i == 8}">
						<a href="" class="list-icon" style="text-decoration: none; ">
							<box-icon class="crew-member-img" name='dots-horizontal-rounded'></box-icon>
						</a>
					</c:if>
				</span>
			</div>
		</div>
		</c:forEach>
		
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
	<jsp:include page="../component/footer.jsp"></jsp:include>
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