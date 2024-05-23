<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form action="member" method="post">
			<table>
				<tr>
					<th>핸드폰번호</th>
					<td>
						<input type="text" name="memberPhone" />
						<button id="phoneChk">인증하기</button>
						<input type="hidden" name="cmd" value="signupOk" />
					</td>
				</tr>
				
				<tr>
					<th>인증번호</th>
					<td>
						<input type="text" name="verifyNumber" />
						<button id="phoneChk2">인증확인</button>
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="memberPw" />
					</td>
				</tr>
				
				<tr>
					<th>닉네임</th>
					<td>
						<input type="text" name="memberNickname" />
					</td>
				</tr>
				
				<tr>
					<th>시/도</th>
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
				
					<th>군/구</th>
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
		var code = "";
		
		$(document).ready(function(){
			$('#geoCity').change(function(){
				var geoCity = $(this).val();
				$.ajax({
					url: '/meetup/member?cmd=geoDistricts',
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
			}
			
			$.ajax({
				type:"post",
				url: "member?cmd=phoneCheck",
				data: {memberPhone: memberPhone},
				cache: false,
				success:function(data) {
					if(data == "isValidMember") {
						alert("가입된 정보가 있습니다.");
						window.location.href = "member?cmd=login"
					} else {
						alert("인증번호 발송되었습니다.\n인증번호를 입력해주세요.");
						code = data;
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
				$("input[name='memberPhone']").attr("disabled",true);
				$("input[name='verifyNumber']").attr("disabled",true);
			} else {
				alert("인증번호가 일치하지 않습니다.\n확인 후 다시 입력해주세요.");
				$(this).attr("autofocus",true);
			}
		});
	</script>
</body>
</html>