<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form id="memberForm" action="member" method="post">
			<table>
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="memberPw" id="memberPw" />
						<input type="hidden" name="cmd" value="confirmPwOk" />
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="확인" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
		$("#memberForm").submit(function(event) {
			var memberPw = $("input[name='memberPw']").val();
			
			if (!memberPw) {
				alert("비밀번호를 입력해주세요");
				event.preventDefault();
			}
		});
	</script>
</body>
</html>