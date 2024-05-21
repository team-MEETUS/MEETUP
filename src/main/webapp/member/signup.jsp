<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form action="member" method="post">
			<table>
				<tr>
					<th>핸드폰번호</th>
					<td>
						<input type="text" name="memberPhone" />
						<input type="hidden" name="cmd" value="signupOk" />
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="text" name="memberPw" />
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
						<input type="text" name="geoCity" />
					</td>
				</tr>
				
				<tr>
				
					<th>군/구</th>
					<td>
						<input type="text" name="geoDistrict" />
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
</body>
</html>