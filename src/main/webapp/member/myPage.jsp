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
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/myPage.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>
		<section class="myPage">
			<div class="myPage__box">
				<h2 class="myPage__title">내 정보 수정</h2>
				<form id="memberForm" action="memberUpload" method="post" enctype="multipart/form-data">
					<!-- 데이터입력 항목 -->
					<div class="myPage__form-cnt">
						<div class="myPage__profile">
							<div class="myPage__profile--img-container">
								<span class="myPage__profile--img" style="background-image: url('upload/${not empty loginMember.memberSaveImg ? loginMember.memberSaveImg : 'profileDefault.png'}');"></span>
								<input type="hidden" name="removeImg" id="removeImg" value="false" />
								<span class="remove-img">X</span>
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
							<input type="text" name="memberIntro" value="${loginMember.memberIntro}" maxlength="20" />
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
			
			if (!memberNickname) {
				alert("닉네임은 필수 항목입니다.");
				event.preventDefault();
			} else if (!memberBirth1) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberBirth2) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberBirth3) {
		    	alert("생년월일은 필수 항목입니다.");
		        event.preventDefault();
		    } else if (!memberGender) {
		    	alert("성별을 선택해주세요.");
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
		    var defaultImgUrl = 'upload/profileDefault.png';
		    var profileImgElement = document.querySelector('.myPage__profile--img');
		    var removeImgElement = document.querySelector('.remove-img');
		    var memberImgInput = document.getElementById('memberImg');
		    var removeImgInput = document.getElementById('removeImg');
		    var originalImgUrl = profileImgElement.style.backgroundImage;

		    function updateImageVisibility() {
		        var currentImgUrl = profileImgElement.style.backgroundImage;
		        if (currentImgUrl.includes(defaultImgUrl) || currentImgUrl === 'none') {
		            removeImgElement.classList.add('hidden');
		        } else {
		            removeImgElement.classList.remove('hidden');
		        }
		    }

		    // 초기 이미지 상태에 따라 'x' 표시 보임/숨김 제어
		    updateImageVisibility();

		    // 프로필 이미지 컨테이너 클릭 시
		    document.querySelector('.myPage__profile').addEventListener('click', function(e) {
		        if (e.target.classList.contains('remove-img')) {
		            profileImgElement.style.backgroundImage = "url('" + defaultImgUrl + "')";
		            memberImgInput.value = '';
		            removeImgInput.value = 'true';
		            // 'x' 표시 숨김
		            removeImgElement.classList.add('hidden');
		            return;
		        }
		        memberImgInput.click();
		    });

		    memberImgInput.addEventListener('change', function(e) {
		        if (e.target.files.length > 0) {
		            var reader = new FileReader();
		            reader.onload = function(event) {
		                profileImgElement.style.backgroundImage = 'url(' + event.target.result + ')';
		                // 이미지 변경 시 'x' 표시 보임
		                removeImgElement.classList.remove('hidden');
		                removeImgInput.value = 'false';
		            }
		            reader.readAsDataURL(e.target.files[0]);
		        } else {
		            // 파일 선택 취소 시 원래 이미지로 설정
		            profileImgElement.style.backgroundImage = originalImgUrl;
		            updateImageVisibility();
		        }
		    });
		});
	</script>
</body>
</html>