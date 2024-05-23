<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.card-crew {
		border: 2px solid lightgray;
		border-radius: 20px;
		padding: 10px;
	}
	.crew-category {
		border-radius: 20px;
		background-color: lightgray;
		padding: 5px;
	}
	.crew-name {
		font-size: 20px;
	}
</style>
</head>
<body>
<div class="container">
	<h2>모임</h2>
	
	<a href="crew?cmd=write" class="btn btn-primary">모임등록</a>
	
	<c:forEach var="crewVO" items="${crewList}">
		<div class="card-crew">
			<span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
			<p class="crew-name">${crewVO.crewName}</p>
			<p class="crew-intro">${crewVO.crewIntro}</p>
			<p class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity} · 멤버 ${crewVO.crewAttend}</p>
			<img class="crew-img" src="${pageContext.request.contextPath}/upload/${crewVO.crewSaveImg}" alt="" />
		</div>
	</c:forEach>
	
</div>
</body>
</html>