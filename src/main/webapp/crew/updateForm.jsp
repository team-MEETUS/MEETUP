<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/crew/writeForm.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script>
	window.onload = function() {
		let btn = document.getElementById("btn");
		
		// 유효성 검사
		btn.onclick = function(event) {
			let frm = document.forms[0];
			
			if (frm.categoryBigNo.value == '') {
				alert("카테고리를 선택하세요");
				frm.categoryBigNo.focus();
				event.preventDefault();
				return;
			}
			
			if (frm.geoCity.value == '') {
				alert("지역을 선택하세요");
				frm.geoCity.focus();
				event.preventDefault();
				return;
			}

			if (frm.crewName.value.trim() == '') {
				alert("모임명을 입력하세요");
				frm.crewName.focus();
				event.preventDefault();
				return;
			}

			if (frm.crewName.value.length > 25) {
				alert("모임명은 최대 25자까지 입력 가능합니다");
				frm.crewName.focus();
				event.preventDefault();
				return;
			}

			if (frm.crewMax.value.trim() == '' || isNaN(frm.crewMax.value) || frm.crewMax.value <= 0 || frm.crewMax.value > 300) {
				alert("정원을 올바르게 입력하세요 (1~300)");
				frm.crewMax.focus();
				event.preventDefault();
				return;
			}

			if (frm.crewContent.value.trim() == '') {
				alert("설명을 입력하세요");
				frm.crewContent.focus();
				event.preventDefault();
				return;
			}

			if (frm.crewContent.value.length > 2000) {
				alert("설명은 최대 2000자까지 입력 가능합니다");
				frm.crewContent.focus();
				event.preventDefault();
				return;
			}
		}
	}
</script>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<main>
    <h2 class="meeting-register">모임 수정</h2>
	<form action="crewUpdate" method="post" enctype="multipart/form-data" class="meeting-form" >
		<!-- crewNo 넣기 -->
		<input type="hidden" name="crewNo" value="${crewVO.crewNo}" />
		
		<!-- 카테고리 -->
		<label class="category-label" aria-label="카테고리">카테고리</label>
		<div class="form-group">
			<select name="categoryBigNo" id="categoryBigNo" class="form-select">
	            <c:forEach var="categoryBigVO" items="${categoryBigList}">
	                <option value="${categoryBigVO.categoryBigNo}" ${categoryBigVO.categoryBigNo == crewVO.categoryBigNo ? 'selected' : ''}>${categoryBigVO.categoryBigName}</option>
	            </c:forEach>
	        </select>
	        <!-- 하위 카테고리 -->
			<select name="categorySmallNo" id="categorySmallNo" class="form-select">
				<!-- 상위 카테고리에 따라 유동적으로 변경 -->
			</select>
        </div>
        
        <!-- 지역 -->
        <label class="category-label">지역</label>
      	<div class="form-group">
	        <!-- 상위 지역 -->
	        <select id="geoCity" name="geoCity" class="form-select">
				<c:forEach var="geoCity" items="${geoList}">
					<c:if test="${geoCity == GeoVO.geoCity}">
						<option value="${geoCity}" selected>${geoCity}</option>
					</c:if>
					<c:if test="${geoCity != GeoVO.geoCity}">
						<option value="${geoCity}">${geoCity}</option>
					</c:if>
				</c:forEach>
			</select>
	 		<!-- 하위 지역 -->
	        <select id="geoDistrict" name="geoDistrict" class="form-select">
				<option value="${GeoVO.geoDistrict}">${GeoVO.geoDistrict}</option>
				<!-- 상위 지역에 따라 유동적으로 변경 -->
			</select>
		</div>
		
		<label class="category-label">모임명</label>
      	<div class="meeting-input">	
			<input class="meeting-register__crewName-input" type="text" name="crewName" id="crewName" value="${crewVO.crewName}" placeholder="최대 25자" />
		</div>
		
		<label class="category-label">정원</label>
		<div class="meeting-input">
			<input class="meeting-register__crewMax-input" type="text" name="crewMax" id="crewMax" value="${crewVO.crewMax}" placeholder="최대 300" />
			<span>명</span>
		</div>
		
		<label class="category-label">설명</label>
        <div class="meeting-input">
			<textarea class="meeting-register__crewContent-textarea" name="crewContent" id="crewContent" cols="80" rows="30" placeholder="최대 2000자" >${crewVO.crewContent}</textarea>
		</div>
		
		<p>대표 이미지</p>
		<div class="image-upload main-image">
		  <label for="crewImg" class="image-label">
		    <div class="image-preview" id="imagePreview" data-img-src="upload/${crewVO.crewSaveImg}">
		      <span class="plus-sign">+</span>
		    </div>
		  </label>
		  <input type="file" name="crewImg" id="crewImg" class="image-input" accept="image/*" />
		  <input type="hidden" name="crewImgDeleted" id="crewImgDeleted" value="false" />
		</div>
		
		<p>배너 이미지</p>
		<div class="image-upload banner-image">
		  <label for="crewBanner" class="image-label">
		    <div class="image-preview" id="bannerPreview" data-img-src="upload/${crewVO.crewSaveBanner}">
		      <span class="plus-sign">+</span>
		    </div>
		  </label>
		  <input type="file" name="crewBanner" id="crewBanner" class="image-input" accept="image/*" />
		  <input type="hidden" name="crewBannerDeleted" id="crewBannerDeleted" value="false" />
		</div>
		
		<!-- 버튼 -->
		<button class="register-button" type="submit" id="btn" class="btn btn-primary" >등록</button>
		
	</form>
	</main>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</div>
<script>
$(document).ready(function() {
	// JSON 문자열을 JavaScript 객체로 변환
	var categorySmallMap = JSON.parse('${categorySmallMapJson}');
	var selectedCategoryBigNo = '${crewVO.categoryBigNo}';
	var selectedCategorySmallNo = '${crewVO.categorySmallNo}';
	
	function loadCategorySmallOptions(selectedBigNo, selectedSmallNo) {
        var categorySmallSelect = $('#categorySmallNo');
        categorySmallSelect.empty();
        categorySmallSelect.append('<option value="">선택없음</option>');

        if(categorySmallMap[selectedBigNo]){
            categorySmallMap[selectedBigNo].forEach(function(categorySmall){
                var option = $('<option>').val(categorySmall.categorySmallNo).text(categorySmall.categorySmallName);
                if (categorySmall.categorySmallNo == selectedSmallNo) {
                    option.prop('selected', true);
                }
                categorySmallSelect.append(option);
            });
        }
    }

	// 초기 로드 시 첫번째 상위 카테고리에 맞는 하위 카테고리 불러오기
    if (selectedCategoryBigNo) {
        loadCategorySmallOptions(selectedCategoryBigNo, selectedCategorySmallNo);
    }

	// 카테고리 변경 시 하위 카테고리 로드
    $('#categoryBigNo').change(function(){
    	var selectedBigNo = $(this).val();
        loadCategorySmallOptions(selectedBigNo, null);
    });
	
    // 지역 
	$('#geoCity').change(function(){
		var geoCity = $(this).val();
		$.ajax({
			url: 'member?cmd=geoDistricts',
			type: 'post',
			data: {geoCity: geoCity},
			success: function(data) {
				var select = $('#geoDistrict');
				select.empty();
				data.forEach(function(geoDistrict) {
					var option = $('<option>').text(geoDistrict).val(geoDistrict);
					select.append(option);
				});
			}
		});
	});
	
	// 지역 불러오기 함수
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

	// 초기 로드 시 선택된 geoCity에 맞는 geoDistrict 불러오기
	var initialGeoCity = $('#geoCity').val();
	var initialGeoDistrict = "${GeoVO.geoDistrict}";
	if (initialGeoCity) {
		loadGeoDistricts(initialGeoCity, initialGeoDistrict);
	}

	// geoCity 변경 시 geoDistrict 불러오기
	$('#geoCity').change(function(){
		var geoCity = $(this).val();
		loadGeoDistricts(geoCity, null); // 시/도가 변경된 경우 군/구는 선택되지 않도록 null 전달
	});
	
	/* // 이미지 반영
	$('#crewImg').change(function() {
		var file = this.files[0];
		if(file) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#formImg').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
		}
	});
	$('#crewBanner').change(function() {
		var file = this.files[0];
		if(file) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#formBanner').attr('src', e.target.result);
			}
			reader.readAsDataURL(file);
		}
	}); */
	
	$(document).ready(function() {
		  addDeleteButtonToExistingImages();

		  $('#crewImg, #crewBanner').change(function() {
		    var reader = new FileReader();
		    var file = this.files[0];
		    var previewId = $(this).attr('id') === 'crewImg' ? 'imagePreview' : 'bannerPreview';
		    var inputId = $(this).attr('id');
		    var previewElement = $('#' + previewId);
		    var plusSign = previewElement.find('.plus-sign');

		    if (file) {
		      reader.onload = function(e) {
		        previewElement.empty(); // 기존 내용 삭제
		        var imgElement = $('<img>').attr('src', e.target.result);
		        previewElement.append(imgElement);
		        addDeleteButton(previewElement, inputId, plusSign);
		        plusSign.hide(); // 이미지가 로드되면 plus-sign 숨기기
		        $('#' + inputId + 'Deleted').val('false'); // 파일이 선택되었으므로 hidden input 필드 값 업데이트
		      };
		      reader.readAsDataURL(file);
		    } else {
		      resetPreview(previewElement, plusSign); // 파일이 선택되지 않았을 때 초기 상태로 복구
		    }
		  });

		  function addDeleteButtonToExistingImages() {
		    $('.image-preview').each(function() {
		      var previewElement = $(this);
		      var inputId = previewElement.closest('.image-upload').find('.image-input').attr('id');
		      var plusSign = previewElement.find('.plus-sign');
		      var imgSrc = previewElement.data('img-src'); // 예시로 data-img-src를 사용해 이미지 src를 가져옵니다. 실제 사용 시에는 적절한 방법으로 이미지 경로를 가져와야 합니다.

		      if (imgSrc && imgSrc !== 'upload/') { // 이미지 경로가 있는 경우
		        var imgElement = $('<img>').attr('src', imgSrc);
		        previewElement.empty().append(imgElement); // 기존 내용을 삭제하고 새 이미지를 추가
		        addDeleteButton(previewElement, inputId, plusSign); // 이미지가 있으면 삭제 버튼 추가 및 plus-sign 숨기기
		        plusSign.hide();
		      } else { // 이미지 경로가 없는 경우
		        resetPreview(previewElement, plusSign); // 초기 상태로 복구하여 plus-sign 표시
		      }
		    });
		  }

		  function addDeleteButton(previewElement, inputId, plusSign) {
		    var deleteButton = $('<button>').text('X').addClass('delete-button');
		    previewElement.append(deleteButton);

		    deleteButton.on('click', function(event) {
		      event.preventDefault();
		      resetPreview(previewElement, plusSign); // 미리보기 초기화
		      $('#' + inputId).val(null); // 파일 입력 값 초기화
		      $('#' + inputId + 'Deleted').val('true'); // hidden input 필드 값 업데이트
		    });
		  }

		  function resetPreview(previewElement, plusSign) {
		    previewElement.empty(); // 미리보기 요소 비우기
		    plusSign.show(); // plus-sign을 다시 표시
		    previewElement.append(plusSign); // plus-sign을 미리보기 요소에 추가
		  }
		});
	
});
</script>
</body>
</html>
