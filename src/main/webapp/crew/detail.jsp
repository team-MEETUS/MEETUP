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
<link rel="stylesheet" href="./css/crew/detail.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
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
			<a href="" class="crew-alert" data-message="업데이트중" >사진첩</a>
		</li>
		<li>
			<a href="" class="crew-alert" data-message="업데이트중" >채팅</a>
		</li>
	</ul>
	
	<!-- 배너 -->
	<div class="crew-banner-container">
		<img class="crew-banner" src="./upload/${crewVO.crewSaveBanner}" alt="${crewVO.crewName}" onerror="this.onerror=null; this.src='upload/bannerDefault.png'" />
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
			<div class="crew-btn-like" style="display: flex;">
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
				<!-- 찜 -->
				<c:if test="${isValidCrewLike eq 0}">
					<c:if test="${empty sessionScope.loginMember}">
						<a href="member?cmd=login" class="crew-alert" data-message="로그인 후 이용 가능합니다." ><box-icon class="like-icon" name='heart' ></box-icon></a>
					</c:if>
					<c:if test="${not empty sessionScope.loginMember}">
						<a href="crew?cmd=like&requestType=add&crewNo=${crewVO.crewNo}" ><box-icon color='var(--orange-4)' class="like-icon" name='heart' ></box-icon></a>
					</c:if>
				</c:if>
				<c:if test="${isValidCrewLike eq 1}">
					<a href="crew?cmd=like&requestType=delete&crewNo=${crewVO.crewNo}" ><box-icon color='var(--orange-4)' class="like-icon" name='heart' type='solid' ></box-icon></a>
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
			<div class="crew-member-list">
			<c:forEach var="crewMemberVO" items="${crewMemberList}">
			<c:if test="${crewMemberVO.crewMemberStatus != 0 && crewMemberVO.crewMemberStatus != 4 && crewMemberVO.crewMemberStatus != 5}">
				<a href="member?cmd=memberProfile&memberNo=${crewMemberVO.memberNo}" style="text-decoration: none;"><div class="crew-member-item">
					<!-- 프로필 -->
					<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" onerror="this.onerror=null; this.src='upload/profileDefault.png'" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
					<!-- 닉네임 -->
					<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
					<!-- 뱃지 -->
					<c:if test="${crewMemberVO.crewMemberStatus eq 3}">
					<box-icon type='solid' name='star' color='white' class="member-badge-leader" ></box-icon>
					</c:if>
					<c:if test="${crewMemberVO.crewMemberStatus eq 2}">
					<box-icon type='solid' name='shield-alt-2' color='white' class="member-badge-admin" ></box-icon>
					</c:if>
				</div></a>
			</c:if>
			</c:forEach>
			</div>
		</div>
	</div>
	<hr />
	
	<!-- 정모 -->
	<div class="meeting-container">
		<div class="meeting-head">
			<p class="meeting-logo">정기모임</p>
			<div>
				<c:if test="${role eq 'leader' || role eq 'adminMember'}">
					<a class="meeting-insert-btn" href="meeting?cmd=write&crewNo=${crewVO.crewNo}">정모등록</a>
				</c:if>
			</div>
		</div>
		
		<div class="meeting-card-container">
		<c:forEach var="meetingVO" items="${meetingList}" varStatus="meetingStatus">
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
			<c:set var="meetingDDay" value="D-${numMeetingDate - numToday}"></c:set>
			<div class="meetingOne">
				<div style="display: inline-block">
					<div class="meeting-header">
						<div class="meeting-date" >
							<span style="margin-right: 10px;"><fmt:formatDate value="${meetingDate}" pattern="MM/dd (E)"/></span>
							<c:choose>
								<c:when test="${meetingDDay eq 'D-0'}">
									<span style=color:red>오늘</span>
								</c:when>
								<c:otherwise>
									<span style=color:red>${meetingDDay}</span>
								</c:otherwise>
							</c:choose> 
													
						</div>
						<p class="meeting-name">${meetingVO.meetingName}</p>					
					</div>
					<c:if test="${role eq 'crewMember' || role eq 'adminMember' || role eq 'leader'}">
					<c:choose>
						<c:when test="${not empty meetingMemberList}">
							<c:choose>
								<c:when test="${isMeetingMember && meetingVO.memberNo eq MemberVO.memberNo}">
									<span><a class="meeting-attendExit-btn crew-alert-confirm" data-message="정모를 삭제하시겠습니까?" href="meetingDelete?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">삭제</a></span>
								</c:when>
								<c:when test="${isMeetingMember}">
									<span><a class="meeting-attendExit-btn crew-alert" data-message="${meetingVO.meetingName} 정모에서 나갔습니다." href="meetingExit?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">취소</a></span>
				        		</c:when>
				        		<c:otherwise>
				        			<span><a class="meeting-attendExit-btn crew-alert" data-message="${meetingVO.meetingName} 정모에 참석했습니다." href="meetingAttend?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">참석</a></span>
				        		</c:otherwise>      	
		        			</c:choose>
		        		</c:when>
		        		<c:otherwise>
		        			<span><a class="meeting-attendExit-btn crew-alert" data-message="${meetingVO.meetingName} 정모에 참석했습니다." href="meetingAttend?meetingNo=${meetingVO.meetingNo}&crewNo=${crewVO.crewNo}">참석</a></span>
		        		</c:otherwise>
	        		</c:choose>
					</c:if>
				</div>

				<br />
				<div class="meeting-info">
					<img src="upload/${meetingVO.meetingSaveImg}" onerror="this.onerror=null; this.src='upload/imgDefault.png'" alt="${meetingVO.meetingName} 이미지 }" />
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
				<span onclick="openModal(${meetingVO.meetingNo}, event)" style="cursor:pointer;">
					<c:forEach var="meetingMemberVO" items="${meetingMemberList}" varStatus="meetingMemberStatus">
						<!--  표시 가능한 유저 -->
						<c:if test="${meetingMemberVO.meetingNo == meetingVO.meetingNo && i < 7}" >
							<a style="text-decoration: none;"><span>
							<img class="meeting-member-img" src="upload/${meetingMemberVO.memberSaveImg}" onerror="this.onerror=null; this.src='upload/profileDefault.png'" alt="${meetingMemberVO.memberSaveImg} 프로필 이미지" />
							</span></a>
							<c:set var="i" value="${i+1}"/>
						</c:if>
						<!-- 표시 가능한 마지막 유저 -->
						<c:if test="${meetingMemberVO.meetingNo == meetingVO.meetingNo && i == 7}" >
							<a style="text-decoration: none;"><span>
							<img class="meeting-member-img" src="upload/${meetingMemberVO.memberSaveImg}" onerror="this.onerror=null; this.src='upload/profileDefault.png'" alt="${meetingMemberVO.memberSaveImg} 프로필 이미지" />
							</span></a>
							<c:set var="i" value="${i+1}"/>
						</c:if>
						<!-- 더보기 아이콘 삽입 -->
						<c:if test="${i > 7}" >
						<a class="list-icon" style="text-decoration: none; "><span>
							<box-icon class="crew-member-img" color='var(--gray-9)' name='dots-horizontal-rounded'></box-icon>
						</span></a>
						</c:if>
					</c:forEach>
				</span>
				
				<!-- 모달 내용 -->
				<div id="modal${meetingVO.meetingNo}" class="modal" >
					<div class="modal-content">
						<p class="crew-member">모임 멤버 (${meetingVO.meetingAttend})</p>
						<c:forEach var="meetingMemberVO" items="${meetingMemberList}">
							<c:if test="${meetingMemberVO.meetingNo eq meetingVO.meetingNo}">
								<a href="member?cmd=memberProfile&memberNo=${meetingMemberVO.memberNo}" style="text-decoration: none;"><div class="crew-member-item">
									<img class="crew-member-img" src="upload/${meetingMemberVO.memberSaveImg}" onerror="this.onerror=null; this.src='upload/profileDefault.png'" alt="${meetingMemberVO.memberNickname} 프로필 이미지" />
									<span class="crew-member-nickname">${meetingMemberVO.memberNickname}</span>
								</div></a>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
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
         var popupRect = popup.getBoundingClientRect();
         var iconLeft = infoIcon.offsetLeft;
         var iconTop = infoIcon.offsetTop;
         var iconWidth = infoIcon.offsetWidth;
         // 팝업 위치 설정 (아이콘 옆에 뜨도록)
         popup.style.left = (iconLeft + iconWidth) + 'px';
         popup.style.top = iconTop + 'px';
        
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
        }, 100);
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

// 모달 열기
function openModal(meetingNo, event) {
  var modal = document.getElementById('modal' + meetingNo);
  var modalContent = modal.querySelector('.modal-content');
  
  // Set the position of the modal content
  modalContent.style.top = event.clientY + 'px';
  modalContent.style.left = event.clientX + 'px';
  
  modal.style.display = "block";
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
	var modals = document.getElementsByClassName('modal');
	for (var i = 0; i < modals.length; i++) {
		if (event.target == modals[i]) {
			modals[i].style.display = "none";
		}
	}
}
</script>
</body>
</html>