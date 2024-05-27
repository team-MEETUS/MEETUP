<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form id="memberForm" action="member" method="post">
			<table>
				<tr>
					<th>핸드폰번호(필수)</th>
					<td>
						<input type="text" name="memberPhone" oninput="inputNum(this)" />
						<button id="phoneChk">인증하기</button>
						<input type="hidden" name="cmd" value="signupOk" />
					</td>
				</tr>
				
				<tr>
					<th>인증번호(필수)</th>
					<td>
						<input type="text" name="verifyNumber" oninput="inputNum(this)" />
						<button id="phoneChk2">인증확인</button>
					</td>
				</tr>
				
				<tr>
					<th>비밀번호(필수)</th>
					<td>
						<input type="password" name="memberPw" />
					</td>
				</tr>
				
				<tr>
					<th>닉네임(필수)</th>
					<td>
						<input type="text" name="memberNickname" />
					</td>
				</tr>
				
				<tr>
					<th>생년월일(필수)</th>
					<td>
						<input type="text" name="memberBirth1" placeholder="YYYY" oninput="inputNum(this) combineBirthDate();" />
						<input type="text" name="memberBirth2" placeholder="MM" oninput="inputNum(this) combineBirthDate();" />
						<input type="text" name="memberBirth3" placeholder="DD" oninput="inputNum(this) combineBirthDate();" />
						<input type="hidden" name="memberBirth" id="memberBirth" />
					</td>
				</tr>
				
				<tr>
					<th>성별(필수)</th>
					<td>
						<input type="radio" name="memberGender" value="남자" />남자
						<input type="radio" name="memberGender" value="여자" />여자
					</td>
				</tr>
				
				<tr>
					<th>시/도(필수)</th>
					<td>
						<select id="geoCity" name="geoCity">
							<option value="">시/도</option>
							<c:forEach var="geoCity" items="${geoCities}">
								<option value="${geoCity}">${geoCity}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
				
					<th>군/구(필수)</th>
					<td>
						<select id="geoDistrict" name="geoDistrict">
							<option value="">군/구</option>
							
						</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="회원가입" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
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
			if (!memberPw || !memberNickname || geoCity === "" || geoDistrict === "" || !memberBirth1 || !memberBirth2 || !memberBirth3 || !memberGender) {
		        alert("필수 항목을 모두 입력해주세요.");
		        event.preventDefault();
		    } else {
		    	combineBirthDate();
		    }
		});
		
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