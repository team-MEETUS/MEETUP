<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/signup.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<section class="signup">
			<div class="signup__box">
				<h2 class="signup__title">회원가입</h2>
				<form id="memberForm" action="member" method="post">
					<!-- 데이터입력 항목 -->
					<div class="signup__form-cnt">
						<div class="signup__input-box">
							<label for="memberPhone">핸드폰번호</label>
							<input type="text" name="memberPhone" oninput="inputNum(this)" maxlength="11" />
							<button id="phoneChk">인증하기</button>
							<input type="hidden" name="cmd" value="signupOk" />
						</div>
						<div class="signup__input-box">
							<label for="verifyNumber">인증번호</label>
							<input type="text" name="verifyNumber" oninput="inputNum(this)" maxlength="4" />
							<button id="phoneChk2">인증확인</button>
						</div>
						<div class="signup__input-box">
							<label for="memberPw">비밀번호</label>
							<input type="password" name="memberPw" />
						</div>
						<div class="signup__input-box">
							<label for="memberNickname">닉네임</label>
							<input type="text" name="memberNickname" />
						</div>
						<div class="signup__input-box signup__input-box--birth">
							<label for="memberBirth">생년월일</label>
							<div class="birth-inputs">
								<input type="text" name="memberBirth1" placeholder="YYYY" oninput="handleInput(this);" maxlength="4" />
								<input type="text" name="memberBirth2" placeholder="MM" oninput="handleInput(this);" maxlength="2" />
								<input type="text" name="memberBirth3" placeholder="DD" oninput="handleInput(this);" maxlength="2" />
							</div>
							<input type="hidden" name="memberBirth" id="memberBirth" />
						</div>
						<div class="signup__radio-box">
							<label for="memberGender">성별</label><br />
							<input type="radio" name="memberGender" value="남자" />남자
							<input type="radio" name="memberGender" value="여자" />여자
						</div>
						<div class="signup__select-box">
							<label>관심 지역</label><br />
							<select id="geoCity" name="geoCity">
								<option value="">시/도</option>
								<c:forEach var="geoCity" items="${geoCities}">
									<option value="${geoCity}">${geoCity}</option>
								</c:forEach>
							</select>
							
							<select id="geoDistrict" name="geoDistrict">
								<option value="">군/구</option>
							
							</select>
						</div>
					</div>
					<!-- 버튼 -->
					<button type="submit" class="signup__btn">회원가입</button>
				</form>
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
	
	<script>
		// 인증번호 비교용 변수
		var code = "";
		// 인증확인 하였는지 확인용 변수
		var isVerified = false;
		
		$(document).ready(function(){
			$('#geoCity').change(function(){
				var geoCity = $(this).val();
				$.ajax({
					url: 'member?cmd=geoDistricts',
					type: 'post',
					data: {geoCity: geoCity},
					success: function(data) {
						var select = $('#geoDistrict');
						select.empty();
						data.forEach(function(geoDistrict) {
							var option = $('<option>').text(geoDistrict);
							select.append(option);
						});
					}
				});
			});
		});
		
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
					if(data[0] == "isValidMember") {
						alert("가입된 정보가 있습니다.");
						window.location.href = "member?cmd=login"
					} else {
						alert("인증번호 발송되었습니다.\n인증번호를 입력해주세요.");
						code = data[0];
					}
				}
			})
		});
		
		$("#phoneChk2").click(function(event) {
			event.preventDefault();
			var memberPhone = $("input[name='memberPhone']").val();
			var verifyNumber = $("input[name='verifyNumber']").val();
			
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
			var memberPw = $("input[name='memberPw']").val();
		    var memberNickname = $("input[name='memberNickname']").val();
		    var geoCity = $("#geoCity").val();
		    var geoDistrict = $("#geoDistrict").val();
		    var memberBirth1 = $("input[name='memberBirth1']").val();
		    var memberBirth2 = $("input[name='memberBirth2']").val();
		    var memberBirth3 = $("input[name='memberBirth3']").val();
		    var memberGender = $("input[name='memberGender']:checked").val();
			
			if (!isVerified) {
				alert("인증확인을 먼저 해주세요.");
				event.preventDefault();
				return;
			}
			// 필요한 정보를 모두 입력하였는지 확인용
			if (!memberPw) {
		        alert("비밀번호는 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberNickname) {
		    	alert("닉네임은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberBirth1) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberBirth2) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberBirth3) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberGender) {
		    	alert("성별을 선택해주세요.");
		        event.preventDefault();
		    } else if (geoCity === "") {
		    	alert("관심 지역을 선택해주세요.");
		        event.preventDefault();
		    } else if (geoDistrict === "") {
		    	alert("관심 지역을 선택해주세요.");
		        event.preventDefault();
		    } else {
		    	combineBirthDate();
		    }
		});
		
		function handleInput(element) {
			inputNum(element);
			combineBirthDate();
		}
		
		function inputNum(element) {
		    element.value = element.value.replace(/[^0-9]/gi, "");
		}
		
		function combineBirthDate() {
		    var year = document.getElementsByName("memberBirth1")[0].value;
		    var month = document.getElementsByName("memberBirth2")[0].value;
		    var day = document.getElementsByName("memberBirth3")[0].value;

		    // MM과 DD 형식을 맞추기 위해 필요하면 0을 추가합니다.
		    if (month.length === 1) {
		        month = '0' + month;
		    }
		    if (day.length === 1) {
		        day = '0' + day;
		    }

		    var combinedDate = year + "." + month + "." + day;
		    document.getElementById("memberBirth").value = combinedDate;
		}
	</script>
</body>
</html>