<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script>
	$(document).ready(function() {
		// 카테고리 
        $('#categoryBigNo').change(function() {
            var selectedBigNo = $(this).val();
            $('.categorySmallOptions').hide();
            $('#categorySmallNo_' + selectedBigNo).show();
        });

        // 초기 로드 시 첫 번째 카테고리 대에 맞는 카테고리 소를 표시
        $('#categoryBigNo').trigger('change');
        
        // 지역 
        $('#geoCity').change(function() {
            var selectedCity = $(this).val();
            $('.geoDistrictOptions').hide();
            $('#geoDistrict_' + selectedCity).show();
        });

        // 초기 로드 시 첫 번째 시에 맞는 구를 표시
        $('#geoCity').trigger('change');
    });
</script>
</head>
<body>
<div class="container">
	<form action="crew" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="cmd" value="writeOk" /> 
		<p>카테고리</p>
		<!-- 상위 카테고리 -->
		<select name="categoryBigNo" id="categoryBigNo" class="form-select">
            <c:forEach var="categoryBigVO" items="${categoryBigList}">
                <option value="${categoryBigVO.categoryBigNo}">${categoryBigVO.categoryBigName}</option>
            </c:forEach>
        </select>
        <!-- 하위 카테고리 -->
        <c:forEach var="categoryBigVO" items="${categoryBigList}">
            <select name="categorySmallNo" id="categorySmallNo_${categoryBigVO.categoryBigNo}" class="form-select categorySmallOptions" style="display: none;">
                <c:forEach var="categorySmallVO" items="${categorySmallMap[categoryBigVO.categoryBigNo]}">
                    <option value="${categorySmallVO.categorySmallNo}">${categorySmallVO.categorySmallName}</option>
                </c:forEach>
            </select>
        </c:forEach>
        <p>지역</p>
        <!-- 상위 지역 -->
        <select name="geoCity" id="geoCity" class="form-select">
            <c:forEach var="geo" items="${geoList}" varStatus="status">
                <c:if test="${status.first}">
                    <option value="${geo.geoCity}">${geo.geoCity}</option>
                </c:if>
                <c:if test="${!status.first && geo.geoCity != geoList[status.index - 1].geoCity}">
                    <option value="${geo.geoCity}">${geo.geoCity}</option>
                </c:if>
            </c:forEach>
        </select>
 		<!-- 하위 지역 -->
        <c:forEach var="geoCity" items="${geoMap.keySet()}">
            <select name="geoDistrict" id="geoDistrict_${geoCity}" class="form-select geoDistrictOptions" style="display: none;">
                <c:forEach var="geo" items="${geoMap[geoCity]}">
                    <option value="${geo.geoDistrict}">${geo.geoDistrict}</option>
                </c:forEach>
            </select>
        </c:forEach>
		
		<p>모임명</p>
		<input type="text" name="crewName" id="crewName" /> 최대 25자
		<p>정원</p>
		<input type="text" name="crewMax" id="crewMax" placeholder="최대 300" /> 명
		<p>설명</p>
		<textarea name="crewContent" id="crewContent" cols="30" rows="10"></textarea> 최대 2000자 
		<p>대표 이미지</p>
		<input type="file" name="crewImg" id="" />
		<p>배너 이미지</p>
		<input type="file" name="crewBanner" id="" />
		
		<input type="submit" value="등록" class="btn btn-primary" />
	</form>
</div>
</body>
</html>