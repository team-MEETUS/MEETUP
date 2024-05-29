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
	<form action="crewUpdate" method="post" enctype="multipart/form-data" >
		<!-- crewNo 넣기 -->
		<input type="hidden" name="crewNo" value="${crewVO.crewNo}" />
		<p>카테고리</p>
		<!-- 상위 카테고리 -->
		<select name="categoryBigNo" id="categoryBigNo" class="form-select">
            <c:forEach var="categoryBigVO" items="${categoryBigList}">
                <option value="${categoryBigVO.categoryBigNo}" ${categoryBigVO.categoryBigNo == crewVO.categoryBigNo ? 'selected' : ''}>${categoryBigVO.categoryBigName}</option>
            </c:forEach>
        </select>
        <!-- 하위 카테고리 -->
		<select name="categorySmallNo" id="categorySmallNo" class="form-select">
			<!-- <option value="">선택없음</option> -->
			<!-- 상위 카테고리에 따라 유동적으로 변경 -->
			
		</select>
        
        <p>지역</p>
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
		
		<p>모임명</p>
		<input type="text" name="crewName" id="crewName" value="${crewVO.crewName}" /> 최대 25자
		<p>정원</p>
		<input type="text" name="crewMax" id="crewMax" value="${crewVO.crewMax}" /> 명
		<p>설명</p>
		<textarea name="crewContent" id="crewContent" cols="30" rows="10" class="form-control" style="resize: none;">${crewVO.crewContent}</textarea> 최대 2000자 
		<p>대표 이미지</p>
		<img id="formImg" src="upload/${crewVO.crewSaveImg}" alt="" />
		<input type="file" name="crewImg" id="crewImg" value="${crewVO.crewSaveImg}" />
		<p>배너 이미지</p>
		<img id="formBanner" src="upload/${crewVO.crewSaveBanner}" alt="" />
		<input type="file" name="crewBanner" id="crewBanner" value="${crewVO.crewSaveBanner}" />
		
		<input type="submit" value="수정" id="btn" class="btn btn-primary" /> 
	</form>
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
	
	// 이미지 반영
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
	});
	
});
</script>
</body>
</html>
