<%@page import="kr.co.meetup.web.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div>
		<form id="memberForm" action="memberUpload" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<th>프로필 사진</th>
					<td>
						<img id="profileImg" src="upload/${loginMember.memberSaveImg}" alt="" />
						<input type="file" name="memberImg" id="memberImg" value="${loginMember.memberSaveImg}" />
					</td>
				</tr>
				
				<tr>
					<th>닉네임(필수)</th>
					<td>
						<input type="text" name="memberNickname" value="${loginMember.memberNickname}" />
						<input type="hidden" name="memberNo" value="${loginMember.memberNo}" />
					</td>
				</tr>
				
				<tr>
					<th>한줄소개</th>
					<td>
						<input type="text" name="memberIntro" value="${loginMember.memberIntro}" />
					</td>
				</tr>
				
				<tr>
					<th>생년월일(필수)</th>
					<td>
				        <input type="text" name="memberBirth1" placeholder="YYYY" oninput="inputNum(this); combineBirthDate();" />
				        <input type="text" name="memberBirth2" placeholder="MM" oninput="inputNum(this); combineBirthDate();" />
				        <input type="text" name="memberBirth3" placeholder="DD" oninput="inputNum(this); combineBirthDate();" />
				        <input type="hidden" name="memberBirth" id="memberBirth" value="${loginMember.memberBirth}" />
				    </td>
				</tr>
				
				<tr>
					<th>성별(필수)</th>
					<td>
						<input type="radio" name="memberGender" value="남자" ${loginMember.memberGender == '남자' ? 'checked' : ''} />남자
						<input type="radio" name="memberGender" value="여자" ${loginMember.memberGender == '여자' ? 'checked' : ''} />여자
					</td>
				</tr>
				
				<tr>
					<th>시/도(필수)</th>
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
			
			$('#memberImg').change(function() {
				var file = this.files[0];
				if(file) {
					var reader = new FileReader();
					reader.onload = function(e) {
						$('#profileImg').attr('src', e.target.result);
					}
					reader.readAsDataURL(file);
				}
			});
		});
		
		$("#memberForm").submit(function(event) {
			var memberNickname = $("input[name='memberNickname']").val();
			var memberBirth1 = $("input[name='memberBirth1']").val();
		    var memberBirth2 = $("input[name='memberBirth2']").val();
		    var memberBirth3 = $("input[name='memberBirth3']").val();
		    var memberGender = $("input[name='memberGender']:checked").val();
			
			if (!memberNickname || !memberBirth1 || !memberBirth2 || !memberBirth3 || !memberGender) {
				alert("필수 항목을 모두 입력해주세요.");
				event.preventDefault();
			} else {
				combineBirthDate();
			}
		});
		
		document.addEventListener("DOMContentLoaded", function() {
		    var birthDate = document.getElementById("memberBirth").value;
		    if (birthDate) {
		        var birthParts = birthDate.split('.');
		        if (birthParts.length === 3) {
		            document.getElementsByName("memberBirth1")[0].value = birthParts[0];
		            document.getElementsByName("memberBirth2")[0].value = birthParts[1];
		            document.getElementsByName("memberBirth3")[0].value = birthParts[2];
		        }
		    }
		});

		function combineBirthDate() {
		    var year = document.getElementsByName("memberBirth1")[0].value;
		    var month = document.getElementsByName("memberBirth2")[0].value;
		    var day = document.getElementsByName("memberBirth3")[0].value;

		    if (month.length === 1) {
		        month = '0' + month;
		    }
		    if (day.length === 1) {
		        day = '0' + day;
		    }

		    var combinedDate = year + "." + month + "." + day;
		    document.getElementById("memberBirth").value = combinedDate;
		}
	</script>
</body>
</html>