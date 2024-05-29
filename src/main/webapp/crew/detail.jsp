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
        text-align: center;
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
	/* 정모 박스 */
	.meetingOne {
	  width: 50%;
	  border: 1px solid #ccc;
	  border-radius: 8px;
	  padding: 20px;
	  text-align: left;
	  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	  display: inline-block;
	  margin: 10px;
	}
	
	.meetingOne>img {
		width: 100px;
		height: 100px;
	}
	
	.meeting-info {
		display: flex;
		font-size: 15px;
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
	        		<a href="crew?cmd=mng&requestType=leave&crewNo=${crewVO.crewNo}&memberNo=${sessionScope.loginMember.memberNo}" class="crew-alert-confirm" data-message="모임을 퇴장하시겠습니까?" >모임퇴장</a>
			</c:when>
			<c:otherwise>
				<a href="crew?cmd=update&crewNo=${crewVO.crewNo}" >수정하기</a>
	        		<a href="crew?cmd=delete&crewNo=${crewVO.crewNo}" class="crew-alert-confirm" data-message="모임을 삭제하시겠습니까?" >삭제하기</a>
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
						<a href="crew?cmd=signup&crewNo=${crewVO.crewNo}" class="btn btn-main crew-alert" data-message="가입신청 되었습니다." >가입신청</a>
					</c:when>
					<c:when test="${role eq 'pendingMember'}">
						<div class="btn btn-main">승인중</div>
					</c:when>
					<c:when test="${role eq 'rejectedMember'}">
						<div class="btn btn-main">승인 거절된 모임입니다</div>
					</c:when>
					<c:when test="${role eq 'kick'}">
						<div class="btn btn-main">강퇴된 모임입니다</div>
					</c:when>
					<c:otherwise>
						<a href="" class="btn btn-main">공유</a>
					</c:otherwise>
				</c:choose>
				<c:if test="${isValidCrewLike eq 0}">
					<c:if test="${empty sessionScope.loginMember}">
						<a href="member?cmd=login" class="crew-alert" data-message="로그인 후 이용 가능합니다." ><box-icon class="like-icon" name='heart' ></box-icon></a>
					</c:if>
					<c:if test="${not empty sessionScope.loginMember}">
						<a href="crew?cmd=like&requestType=add&crewNo=${crewVO.crewNo}" ><box-icon class="like-icon" name='heart' ></box-icon></a>
					</c:if>
				</c:if>
				<c:if test="${isValidCrewLike eq 1}">
					<a href="crew?cmd=like&requestType=delete&crewNo=${crewVO.crewNo}" ><box-icon class="like-icon" name='heart' type='solid' ></box-icon></a>
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
		<p class="meeting-logo">정모</p>
		<c:if test="${role eq 'crewMember' || role eq 'adminMember'}">
			<a href="meeting?cmd=write&crewNo=${crewVO.crewNo}">정모 등록하기</a>
		</c:if>
		
		<div>
		
		<c:forEach var="meetingVO" items="${meetingList}">
				<c:set var="today" value="<%=new java.util.Date() %>"/>
				<fmt:formatDate var="nowDay" value="${today}" pattern="yyyy-MM-dd hh:mm:ss" />
				<fmt:parseDate value="${nowDay}" var="pdToday" pattern="yyyy-MM-dd"/>
				<fmt:parseNumber value="${pdToday.time / (1000*60*60*24)}" integerOnly="true" var="numToday"></fmt:parseNumber>
				
				<c:set var="meetingDate" value="${meetingVO.meetingDate}"/>
				<fmt:parseDate value="${meetingDate}" var="pdMeetingDate" pattern="yyyy-MM-dd"/>
				<fmt:parseNumber value="${pdMeetingDate.time / (1000*60*60*24)}" integerOnly="true" var="numMeetingDate"></fmt:parseNumber>
				
				<div class="meetingOne">
					<div style="display: inline-block">
						<span><fmt:formatDate value="${meetingDate}" pattern="MM/dd (E)"/></span> 
						<span style=color:red>D-${numMeetingDate - numToday}</span>
						<p>${meetingVO.meetingName}</p>
						<c:if test="${role eq 'crewMember' || role eq 'adminMember'}">
						<c:choose>
							<c:when test="${not empty meetingMemberList}">
								<h2>${meetingMemberList[status.index].meetingNo}</h2>
								<h2>${meetingVO.meetingNo}</h2>
									<c:choose>
										<c:when test="${meetingMemberList[status.index].meetingNo eq meetingVO.meetingNo}" >
											<span><a href="meetingExit?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">정모 나가기</a></span>
						        		</c:when>
						        		<c:otherwise>
						        			<span><a href="meetingAttend?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">정모 참석하기</a></span>
						        		</c:otherwise>      	
				        			</c:choose>
			        		</c:when>
			        		<c:otherwise>
			        			<span><a href="meetingAttend?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">정모 참석하기</a></span>
			        		</c:otherwise>
		        		</c:choose>
						</c:if>
					</div>

					<br />
					<div class="meeting-info">
						<img style="width: 100px; height:100px;" src="upload/${meetingVO.meetingSaveImg}" alt="" />
						<div>
							<div>일시 <fmt:formatDate value="${meetingDate}" pattern="MM/dd (E) aa hh:mm "/></div>
							<div>위치 ${meetingVO.meetingLoc}</div>
							<div>비용 ${meetingVO.meetingPrice}원</div>
							<div>참석 ${meetingVO.meetingAttend}/${meetingVO.meetingMax} (${meetingVO.meetingMax-meetingVO.meetingAttend}명남음) </div>
						</div>
					</div>
				</div>
				
				<div >
					<span>
						<c:if test="${meetingMemberList[status.index].meetingNo eq meetingVO.meetingNo}" >
							<a href="" style="text-decoration: none;"><div>
								<c:if test="${empty meetingMemberList[status.index].memberSaveImg}">
									<box-icon type='solid' name='user-circle'></box-icon>
								</c:if>
								<c:if test="${not empty meetingMemberList[status.index].memberSaveImg}">
									<img class="crew-member-img" src="upload/${meetingMemberList[status.index].memberSaveImg}" />
								</c:if>
							</div></a>
						</c:if>
					</span>
				</div>
		</c:forEach>
		</div>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</div>
<script>
// 상단 팝업
document.addEventListener('DOMContentLoaded', function() {
    var infoIcon = document.querySelector('.crew-info-icon');
    var popup = document.querySelector('.edit-delete-popup');
    
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
});

<!-- SweetAlert2 -->
$(document).ready(function () {
	/* 기본 */
	$('.crew-alert').click(function (event) {
        event.preventDefault(); 
        var href = $(this).attr('href'); 
        var message = $(this).data('message'); 

        Swal.fire({
            title: "Meetup",
            text: message,
            icon: 'success',
            timer: 1000, 			// 1초 후에 자동으로 닫히도록 설정
            timerProgressBar: true, // 타이머 진행 바 표시
            didOpen: () => {
                Swal.showLoading()
            },
        }).then(() => {
        	window.location.href = href;
        });
        
        // 1초 후에 페이지 이동
        setTimeout(() => {
            window.location.href = href;
        }, 1000);
    });
	
	/* confirm */
    $('.crew-alert-confirm').click(function (event) {
        event.preventDefault(); 
        var href = $(this).attr('href'); 
        var message = $(this).data('message'); 

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