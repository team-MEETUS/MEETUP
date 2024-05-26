<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
						<input type="hidden" name="cmd" value="loginOk" />
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="memberPw" />
						<input type="hidden" name="memberNotice" id="memberNotice" value="${memberNotice}" />
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" />
						<a href="member?cmd=find">비밀번호 찾기</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
		var isVerified = false;
		
		$("#memberForm").submit(function(event) {
			var memberPhone = $("input[name='memberPhone']").val();
			var memberPw = $("input[name='memberPw']").val();
			
			if(!memberPhone || !memberPw) {
				alert("모든 필드를 입력해주세요.");
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
	</script>
</body>
</html>