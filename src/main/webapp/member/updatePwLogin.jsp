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
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="memberPw" id="memberPw" />
						<input type="hidden" name="cmd" value="updatePwLoginOk" />
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="변경" />
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>