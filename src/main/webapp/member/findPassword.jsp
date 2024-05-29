<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/findPassword.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<section class="findPw">
			<div class="findPw__box">
				<h2 class="findPw__title">비밀번호 찾기</h2>
				<form id="memberForm" action="member" method="post">
					<!-- 데이터입력 항목 -->
					<div class="findPw__form-cnt">
						<div class="findPw__input-box">
							<label for="memberPhone">핸드폰번호</label>
							<input type="text" name="memberPhone" oninput="inputNum(this)" maxlength="11" />
							<button id="phoneChk">인증하기</button>
							<input type="hidden" name="cmd" value="updatePwNoLogin" />
						</div>
						<div class="findPw__input-box">
							<label for="verifyNumber">인증번호</label>
							<input type="text" name="verifyNumber" oninput="inputNum(this)" maxlength="4" />
							<button id="phoneChk2">인증확인</button>
						</div>
					</div>
					<!-- 버튼 -->
					<button type="submit" class="findPw__btn">비밀번호 변경</button>
				</form>
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
	
	<script>
		// 인증번호 비교용 변수
		var code = "";
		// 인증확인을 하였는지 확인하는 변수
		var isVerified = false;
		
		$("#phoneChk").click(function(event) {
			event.preventDefault();
			var memberPhone = $("input[name='memberPhone']").val();
			
			if(!memberPhone) {
				alert("핸드폰번호를 입력해주세요.");
				return;
			} else if(memberPhone.length < 11) {
				alert("핸드폰번호는 -없이 11자리");
				return;
			} else if(memberPhone.length > 11) {
				alert("핸드폰번호는 -없이 11자리");
				return;
			}
			
			$.ajax({
				type:"post",
				url: "member?cmd=phoneCheck",
				data: {memberPhone: memberPhone},
				cache: false,
				success:function(data) {
					if (!data[1]) {
						alert("가입된 정보가 없습니다.");
						window.location.href = "member?cmd=signup";
					} else {
						alert("인증번호 발송되었습니다.\n인증번호를 입력해주세요.");
						code = data[1];
					}
				}
			})
		});
		
		$("#phoneChk2").click(function(event) {
			event.preventDefault();
			var memberPhone = $("input[name='memberPhone']").val();
			var verifyNumber = $("input[name='verifyNumber']").val();
			console.log(verifyNumber);
			
			if (code == "") {
				alert("인증하기 후 인증확인을 해주세요.");
			} else if (verifyNumber == code) {
				alert("인증번호 일치");
				$("input[name='memberPhone']").attr("readonly",true);
				$("input[name='verifyNumber']").attr("readonly",true);
				isVerified = true;
			} else {
				alert("인증번호가 일치하지 않습니다.\n확인 후 다시 입력해주세요.");
				$(this).attr("autofocus",true);
			}
		});
		
		$("#memberForm").submit(function(event) {
			if (!isVerified) {
				alert("인증확인을 먼저 해주세요.");
				event.preventDefault();
				return;
			}
		});
		
		function handleInput(element) {
			inputNum(element);
		}
		
		function inputNum(element) {
		    element.value = element.value.replace(/[^0-9]/gi, "");
		}
	</script>
</body>
</html>