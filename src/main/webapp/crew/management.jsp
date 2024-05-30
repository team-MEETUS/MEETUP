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
<link rel="stylesheet" href="./css/crew/management.css" type="text/css" />
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
			<button class="crew-menu__btn" id="showCrewMember">모임회원</button>
		</li>
		<li>
			<button class="crew-menu__btn" id="showCrewSignUp">가입신청</button>
		</li>
	</ul>
	
	<!-- 모임회원 -->
	<div class="crew-container" id="CrewMember" >
	<c:forEach var="crewMemberVO" items="${crewMemberList}">
		<!-- 회원멤버만 -->
        <c:if test="${crewMemberVO.crewMemberStatus != 0 && crewMemberVO.crewMemberStatus != 4 && crewMemberVO.crewMemberStatus != 5}">
            <div class="crew-member-item">
                <a href="member?cmd=memberProfile&memberNo=${crewMemberVO.memberNo}" style="text-decoration: none;">
                    <!-- 프로필 -->
                    <img class="crew-member-img" src="upload/${not empty crewMemberVO.memberSaveImg ? crewMemberVO.memberSaveImg : 'profileDefault.png'}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
                    <!-- 닉네임 -->
                    <span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
                    <!-- 뱃지 -->
                    <c:if test="${crewMemberVO.crewMemberStatus eq 3}">
                        <box-icon type='solid' name='star' color='white' class="member-badge-leader"></box-icon>
                    </c:if>
                    <c:if test="${crewMemberVO.crewMemberStatus eq 2}">
                        <box-icon type='solid' name='shield-alt-2' color='white' class="member-badge-admin"></box-icon>
                    </c:if>
                </a>
                <!-- 역할 별 승인버튼 -->
                <div class="crew-actions">
                    <!-- 운영진 -->
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
                </div>
            </div>
        </c:if>
	</c:forEach>
	</div>
	
	<!-- 가입신청 -->
	<div class="crew-container" id="CrewSignUp" style="display:none;">
	<c:forEach var="crewMemberVO" items="${crewMemberList}">
	<c:if test="${crewMemberVO.crewMemberStatus == 4}">
		<div class="crew-member-item">
			<a href="" style="text-decoration: none;">
				<c:if test="${empty crewMemberVO.memberSaveImg}">
					<box-icon type='solid' name='user-circle'></box-icon>
				</c:if>
				<c:if test="${not empty crewMemberVO.memberSaveImg}">
					<img class="crew-member-img" src="upload/${crewMemberVO.memberSaveImg}" alt="${crewMemberVO.memberNickname} 프로필 이미지" />
				</c:if>
				<span class="crew-member-nickname">${crewMemberVO.memberNickname}</span>
				<!-- 뱃지 -->
				<c:if test="${crewMemberVO.crewMemberStatus eq 3}">
				<box-icon type='solid' name='star' color='white' class="member-badge-leader" ></box-icon>
				</c:if>
				<c:if test="${crewMemberVO.crewMemberStatus eq 2}">
				<box-icon type='solid' name='shield-alt-2' color='white' class="member-badge-admin" ></box-icon>
				</c:if>
			</a>
			<!-- 가입신청 승인버튼 -->
	        <div class="crew-actions">
				<a href="crew?cmd=mng&requestType=approval&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님의 가입을 승인하시겠습니까?" >가입승인</a>
				<a href="crew?cmd=mng&requestType=reject&crewNo=${crewNo}&memberNo=${crewMemberVO.memberNo}" class="crew-category" data-message="${crewMemberVO.memberNickname}님의 가입을 거절하시겠습니까?" >가입거절</a>
			</div>
		</div>
	</c:if>
	</c:forEach>
	</div>
	
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

    // 메뉴 버튼 클릭 이벤트
    $(".crew-menu__btn").click(function () {
        $(".crew-menu__btn").removeClass("active"); // 모든 버튼에서 active 클래스 제거
        $(this).addClass("active"); // 클릭된 버튼에 active 클래스 추가

        // 섹션 전환
        var targetId = $(this).attr("id") === "showCrewMember" ? "#CrewMember" : "#CrewSignUp";
        $(".crew-container").hide();
        $(targetId).show();
    });
    
});

//초기 로드시 모임회원 버튼에 active 클래스 추가
$("#showCrewMember").addClass("active");
// 초기 로드시 모임회원 섹션 표시
$("#CrewMember").show();
    

</script>
</body>
</html>