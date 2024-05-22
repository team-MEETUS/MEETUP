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
						<select id="step1" name="geoCity">
							<option value="">시/도</option>
							<c:forEach var="city" items="${geoCities}">
								<option value="${city}">${city}</option>
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
		$(document).ready(function(){
			$('#geoCity').change(function(){
				var geoCity = $(this).val();
				$.ajax({
					url: '/geoDistricts',
					type: 'get',
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
	</script>
</body>
</html>