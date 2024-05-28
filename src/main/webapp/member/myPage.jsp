<%@page import="kr.co.meetup.web.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/member/myPage.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<section class="myPage">
			<div class="myPage__box">
				<h2 class="myPage__title">내 정보 수정</h2>
				<form id="memberForm" action="memberUpload" method="post" enctype="multipart/form-data">
					<!-- 데이터입력 항목 -->
					<div class="myPage__form-cnt">
						<div class="myPage__profile">
							<div class="myPage__profile--img-container">
								<span class="myPage__profile--img" style="background-image: url('upload/${not empty loginMember.memberSaveImg ? loginMember.memberSaveImg : 'first.png'}');"></span>
								<input type="hidden" name="removeImg" id="removeImg" value="false" />
								<span class="remove-img">x</span>
							</div>
							<input type="file" name="memberImg" id="memberImg" value="${loginMember.memberSaveImg}" style="display: none;" />
						</div>
						<div class="myPage__input-box">
							<label for="memberNickname">닉네임</label>
							<input type="text" name="memberNickname" value="${loginMember.memberNickname}" />
							<input type="hidden" name="memberNo" value="${loginMember.memberNo}" />
						</div>
						<div class="myPage__input-box">
							<label for="memberIntro">한줄소개</label>
							<input type="text" name="memberIntro" value="${loginMember.memberIntro}" />
						</div>
						<div class="myPage__input-box myPage__input-box--birth">
							<label for="memberBirth">생년월일</label>
							<div class="birth-inputs">
								<input type="text" name="memberBirth1" placeholder="YYYY" oninput="handleInput(this);" maxlength="4" />
								<input type="text" name="memberBirth2" placeholder="MM" oninput="handleInput(this);" maxlength="2" />
								<input type="text" name="memberBirth3" placeholder="DD" oninput="handleInput(this);" maxlength="2" />
							</div>
							<input type="hidden" name="memberBirth" id="memberBirth" value="${loginMember.memberBirth}" />
						</div>
						<div class="myPage__radio-box">
							<label for="memberGender">성별</label><br />
							<input type="radio" name="memberGender" value="남자" ${loginMember.memberGender == '남자' ? 'checked' : ''} />남자
							<input type="radio" name="memberGender" value="여자" ${loginMember.memberGender == '여자' ? 'checked' : ''} />여자
						</div>
						<div class="myPage__select-box">
							<label>관심 지역</label><br />
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
							
							<select name="geoDistrict" id="geoDistrict">
								<option value="${GeoVO.geoDistrict}">${GeoVO.geoDistrict}</option>
								
							</select>
						</div>
					</div>
					<!-- 버튼 -->
					<button type="submit" class="myPage__btn">저장</button>
				</form>
			</div>
		</section>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
	
	<script>
		$(document).ready(function(){
			function loadGeoDistricts(geoCity, selectedGeoDistrict) {
				$.ajax({
					url: 'member?cmd=geoDistricts',
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
		
		function handleInput(element) {
			inputNum(element);
			combineBirthDate();
		}
		
		function inputNum(element) {
		    element.value = element.value.replace(/[^0-9]/gi, "");
		}
		
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
		
		document.addEventListener('DOMContentLoaded', function() {
		    // 프로필 이미지 컨테이너 클릭 시
		    document.querySelector('.myPage__profile').addEventListener('click', function(e) {
		    	if (e.target.classList.contains('remove-img')) {
		            document.querySelector('.myPage__profile--img').style.backgroundImage = '';
		            document.getElementById('memberImg').value = ''; // 파일 입력 필드 초기화
		            document.getElementById('removeImg').value = 'true'; // 이미지 제거 플래그 설정
		         	// 폼 제출 로직 추가
		            // 예: document.getElementById('yourFormId').submit(); 여기서 'yourFormId'는 폼의 id입니다.
		            return;
		        }
		        document.getElementById('memberImg').click(); // 실제 파일 입력 필드를 클릭하는 효과
		    });

		    // 선택된 이미지를 배경으로 설정
		    document.getElementById('memberImg').addEventListener('change', function(e) {
		        var reader = new FileReader();
		        reader.onload = function(e) {
		            document.querySelector('.myPage__profile--img').style.backgroundImage = 'url(' + e.target.result + ')';
		        }
		        reader.readAsDataURL(e.target.files[0]);
		    });
		});
	</script>
</body>
</html>