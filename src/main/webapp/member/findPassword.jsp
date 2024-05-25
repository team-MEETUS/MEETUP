<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form id="memberForm" action="member" method="post">
			<table>
				<tr>
					<th>핸드폰번호</th>
					<td>
						<input type="text" name="memberPhone" />
						<button id="phoneChk">인증하기</button>
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
					<td colspan="2">
						<input type="hidden" name="cmd" value="updatePwNoLogin" />
						<input type="submit" value="비밀번호 변경" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
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
					console.log(data);
					alert("인증번호 발송되었습니다.\n인증번호를 입력해주세요.");
					code = data[1];
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
			if (!isVerified) {
				alert("인증확인을 먼저 해주세요.");
				event.preventDefault();
			}
		});
	</script>
</body>
</html>