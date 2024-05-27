<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="../css/reset.css"  type="text/css" />
<link rel="stylesheet" href="../css/index.css"  type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
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
	<form action="crewWrite" method="post" enctype="multipart/form-data" >
		<p>카테고리</p>
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
        
        <p>지역</p>
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
		
		<p>모임명</p>
		<input type="text" name="crewName" id="crewName" /> 최대 25자
		<p>정원</p>
		<input type="text" name="crewMax" id="crewMax" placeholder="최대 300" /> 명
		<p>설명</p>
		<textarea name="crewContent" id="crewContent" cols="30" rows="10" class="form-control" style="resize: none;"></textarea> 최대 2000자 
		<p>대표 이미지</p>
		<input type="file" name="crewImg" id="" />
		<p>배너 이미지</p>
		<input type="file" name="crewBanner" id="" />
		
		<input type="submit" value="등록" id="btn" class="btn btn-primary" /> 
	</form>
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
});
</script>
</body>
</html>