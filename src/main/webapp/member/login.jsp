<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/login.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<section class="login">
			<div class="login__box">
				<!-- Logo -->
				<div class="login__logo">
					<h1 class="header-logo"><a href="member">MEETUP</a></h1>
				</div>
				<!-- Form -->
				<form id="memberForm" action="member" method="post">
					<!-- 데이터입력 항목 -->
					<div class="login__form-cnt">
						<div class="login__input-box">
							<label for="memberPhone">핸드폰번호</label>
							<input type="text" name="memberPhone" oninput="inputNum(this)" maxlength="11" />
							<input type="hidden" name="memberNotice" id="memberNotice" value="${memberNotice}" />
						</div>
						<div class="login__input-box">
							<label for="memberPw">비밀번호</label>
							<input type="password" name="memberPw" />
							<input type="hidden" name="cmd" value="loginOk" />
						</div>
					</div>
					<div class="login__btn-box">
						<!-- 버튼 -->
						<button class="login__btn" type="submit">로그인</button>
						<ul class="login__menu">
							<li>
								<a href="member?cmd=find">비밀번호 찾기</a>
							</li>
							<li>
								<a href="member?cmd=signup">회원가입</a>
							</li>
						</ul>
					</div>
				</form>
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
	
	<script>
		var isVerified = false;
		
		$("#memberForm").submit(function(event) {
			var memberPhone = $("input[name='memberPhone']").val();
			var memberPw = $("input[name='memberPw']").val();
			
			if(!memberPhone) {
				alert("핸드폰번호를 입력해주세요.");
		        event.preventDefault();
			} else if (!memberPw) {
				alert("비밀번호를 입력해주세요.");
		        event.preventDefault();
			}
		});
	
		window.onload = function() {
	        var memberNotice = document.getElementById('memberNotice').value;
	        if(memberNotice === 'deleteMember') {
	            alert("탈퇴 처리된 회원입니다.");
	        } else if(memberNotice == 'warningMember') {
	        	alert("정지 처리된 회원입니다.");
	        }
	    }
		
		function inputNum(element) {
		    element.value = element.value.replace(/[^0-9]/gi, "");
		}
	</script>
</body>
</html>

