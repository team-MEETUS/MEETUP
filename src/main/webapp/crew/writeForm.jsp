<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <h2 class="meeting-register">모임 등록</h2>
	<form action="crewWrite" method="post" enctype="multipart/form-data" class="meeting-form" >
		<!-- 카테고리 -->
		<label class="category-label" aria-label="카테고리">카테고리</label>
		<div class="form-group">
			<!-- 상위 카테고리 -->
			<select name="categoryBigNo" id="categoryBigNo" class="form-select">
	            <c:forEach var="categoryBigVO" items="${categoryBigList}">
	                <option value="${categoryBigVO.categoryBigNo}">${categoryBigVO.categoryBigName}</option>
	            </c:forEach>
	        </select>
	        <!-- 하위 카테고리 -->
			<select name="categorySmallNo" id="categorySmallNo" class="form-select">
				<option value="">선택없음</option>
				<!-- 상위 카테고리에 따라 유동적으로 변경 -->
			</select>
		</div>
        
        <!-- 지역 -->
        <label class="category-label">지역</label>
      	<div class="form-group">
	        <!-- 상위 지역 -->
	        <select id="geoCity" name="geoCity" class="form-select">
				<option value="">시/도</option>
				<c:forEach var="geoCity" items="${geoList}">
					<option value="${geoCity}">${geoCity}</option>
				</c:forEach>
			</select>
	 		<!-- 하위 지역 -->
	        <select id="geoDistrict" name="geoDistrict" class="form-select">
				<option value="">군/구</option>
				<!-- 상위 지역에 따라 유동적으로 변경 -->
			</select>
		</div>
		
		<label class="category-label">모임명</label>
      	<div class="meeting-input">	
			<input type="text" name="crewName" id="crewName" class="meeting-register__crewName-input" placeholder="최대 25자" />
		</div>
		
		<label class="category-label">정원</label>
		<div class="meeting-input">
		  <input class="meeting-register__crewMax-input" type="text" name="crewMax" id="crewMax" placeholder="최대 300" />
		  <span>명</span>
		</div>
      
		<label class="category-label">설명</label>
		<textarea class="meeting-register__crewContent-textarea" name="crewContent" id="crewContent" cols="30" rows="10" placeholder="최대 2000자" ></textarea>
		
		<p>대표 이미지</p>
		<div class="image-upload main-image">
		  <label for="crewImg" class="image-label">
		    <div class="image-preview" id="imagePreview">
		      <span class="plus-sign">+</span>
		    </div>
		  </label>
		  <input type="file" name="crewImg" id="crewImg" class="image-input" accept="image/*" />
		</div>
		
		<p>배너 이미지</p>
		<div class="image-upload banner-image">
		  <label for="crewBanner" class="image-label">
		    <div class="image-preview" id="bannerPreview">
		      <span class="plus-sign">+</span>
		    </div>
		  </label>
		  <input type="file" name="crewBanner" id="crewBanner" class="image-input" accept="image/*" />
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
	
	// 카테고리
    $('#categoryBigNo').change(function(){
    	var selectedBigNo = $(this).val();
        var categorySmallSelect = $('#categorySmallNo');
        categorySmallSelect.empty();
        categorySmallSelect.append('<option value="">선택없음</option>');

        if(categorySmallMap[selectedBigNo]){
            categorySmallMap[selectedBigNo].forEach(function(categorySmall){
                categorySmallSelect.append('<option value="'+categorySmall.categorySmallNo+'">'+categorySmall.categorySmallName+'</option>');
            });
        }
    });
	
	// 초기 로드 시 첫번째 상위 카테고리에 맞는 하위 카테고리 불러오기
	$('#categoryBigNo').trigger('change');
    
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
					var option = $('<option>').text(geoDistrict);
					select.append(option);
				});
			}
		});
	});
    
	// 이미지 미리보기 및 삭제
    $('#crewImg, #crewBanner').change(function() {
        var reader = new FileReader();
        var file = this.files[0];
        var previewId = $(this).attr('id') === 'crewImg' ? 'imagePreview' : 'bannerPreview';
        var inputId = $(this).attr('id');
        if (file) {
            reader.onload = function(e) {
                var previewElement = $('#' + previewId);
                previewElement.empty(); // 기존 내용 삭제
                var imgElement = $('<img>').attr('src', e.target.result);
                previewElement.append(imgElement);
                var deleteButton = $('<button>').text('X').addClass('delete-button');
                previewElement.append(deleteButton);

                deleteButton.on('click', function(event) {
                    event.preventDefault(); // 기본 동작을 막음
                    var oldInput = $('#' + inputId);
                    // oldInput의 value를 비움으로써 선택된 파일을 제거
                    oldInput.val('');
                    // 이미지 미리보기 삭제
                    previewElement.empty().append('<span class="plus-sign">+</span>'); // 초기 상태로 복구
                });
            };
            reader.readAsDataURL(file);
        } else {
            $('#' + previewId).empty().append('<span class="plus-sign">+</span>');
        }
    });

});

</script>
</body>
</html>