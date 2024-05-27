<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form action="member" method="post">
			<h2>${otherMember.memberNickname}의 프로필</h2>
			<table>
				<tr>
					<th>프로필사진</th>
					<td>
						<c:if test="${not empty otherMember.memberSaveImg}">
							<img id="profileImg" src="upload/${otherMember.memberSaveImg}" alt="" />
						</c:if>
						<c:if test="${empty otherMember.memberSaveImg}">
							<img id="profileImg" src="upload/first.png" alt="" />
						</c:if>
					</td>
				</tr>
				
				<tr>
					<th>닉네임</th>
					<td>
						${otherMember.memberNickname}
					</td>
				</tr>
				
				<tr>
					<th>생년월일</th>
					<td>
						${otherMember.memberBirth}
					</td>
				</tr>
				
				<tr>
					<th>성별</th>
					<td>
						${otherMember.memberGender}
					</td>
				</tr>
				
				<tr>
					<th>지역</th>
					<td>
						${GeoVO.geoCity}&nbsp;${GeoVO.geoDistrict}
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<a href="member">메인으로</a>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>