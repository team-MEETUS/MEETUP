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
						<input type="hidden" name="cmd" value="loginOk" />
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="text" name="memberPw" />
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="로그인" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>