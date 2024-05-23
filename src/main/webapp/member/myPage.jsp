<%@page import="kr.co.meetup.web.vo.MemberVO"%>
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
					<th>닉네임</th>
					<td>
						<input type="text" name="memberNickname" value="${MemberVO.memberNickname}" />
						<input type="hidden" name="cmd" value="updateOk" />
					</td>
				</tr>
				
				<tr>
					<th>한줄소개</th>
					<td>
						<input type="text" name="memberIntro" value="${MemberVO.memberIntro}" />
					</td>
				</tr>
				
				<tr>
					<th>시/도</th>
					<td>
						<select name="geoCity" id="geoCity">
							
							<c:forEach var="geoCity" items="${geoCities}">
								<c:if test="${geoCity == GeoVO.geoCity}">
									<option value="${geoCity}" selected>${geoCity}</option>
								</c:if>
								<c:if test="${geoCity != GeoVO.geoCity}">
									<option value="${geoCity}">${geoCity}</option>
								</c:if>
							</c:forEach>
						</select>
					</td>
				</tr>
				
				<tr>
					<th>군/구</th>
					<td>
						<select name="geoDistrict" id="geoDistrict">
							<option value="${GeoVO.geoDistrict}">${GeoVO.geoDistrict}</option>
							
						</select>
					</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="submit" value="수정" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
		$(document).ready(function(){
			function loadGeoDistricts(geoCity, selectedGeoDistrict) {
				$.ajax({
					url: '/meetup/member?cmd=geoDistricts',
					type: 'post',
					data: {geoCity: geoCity},
					success: function(data) {
						var select = $('#geoDistrict');
						select.empty();
						data.forEach(function(geoDistrict) {
							var option = $('<option>').text(geoDistrict).val(geoDistrict);
							if (geoDistrict === selectedGeoDistrict) {
								option.prop('selected', true);
							}
							select.append(option);
						});
					}
				});
			}
	
			var initialGeoCity = $('#geoCity').val();
			var initialGeoDistrict = "${GeoVO.geoDistrict}";
			if (initialGeoCity) {
				loadGeoDistricts(initialGeoCity, initialGeoDistrict);
			}
	
			$('#geoCity').change(function(){
				var geoCity = $(this).val();
				loadGeoDistricts(geoCity, null); // 시/도가 변경된 경우 군/구는 선택되지 않도록 null 전달
			});
		});
	</script>
</body>
</html>