<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css"  type="text/css" />
<link rel="stylesheet" href="./css/index.css"  type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/crew/list.css"  type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
    <!-- 카테고리 -->
    <div class="main">
	    <ul class="ctg-crew__items">
	        <li class="${categoryBigNo == 0 ? 'selected' : ''}" >
	            <a href="crew?cmd=list">
	            	<box-icon class="ctg-crew__icons" name="grid-alt"></box-icon>
	            	전체모임
	            </a>
	        </li>
	        <c:forEach var="categoryBigVO" items="${categoryBigList}">
	        <li class="${categoryBigNo != null && categoryBigNo == categoryBigVO.categoryBigNo ? 'selected' : ''}" >
	            <a href="crew?cmd=list&ctg=${categoryBigVO.categoryBigNo}">
	            	<box-icon class="ctg-crew__icons" name="${categoryBigVO.categoryBigIcon}"></box-icon>
	            	${categoryBigVO.categoryBigName}
	            </a>
	        </li>
	        </c:forEach>
	    </ul>
		
		<!-- 모임등록 버튼 -->
		<c:choose >
		<c:when test="${not empty sessionScope.loginMember}">
			<button class="meeting-button">
	          <a href="crew?cmd=write" class="btn btn-main">모임등록</a>
	        </button>
		</c:when>
		
		<c:otherwise>
			<span aria-hidden="true" class='meeting-button none'></span>
		</c:otherwise>
		
		</c:choose>
		
		<!-- 모임 -->
		<div class="crew-container">
		
	        <c:forEach var="crewVO" items="${crewList}">
	            <div class="crew-item">
	        		<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}"><div class="card-crew">
	                    <img class="crew-img" src="upload/${crewVO.crewSaveImg}" alt="${crewVO.crewName}" onerror="this.onerror=null; this.src='upload/imgDefault.png'" />
	                    <div class="crew-details">
	                        <span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
	                        <p class="crew-name" id="crewName-${crewVO.crewNo}" >${crewVO.crewName}</p>
	                        <p class="crew-intro" id="crewIntro-${crewVO.crewNo}" >${crewVO.crewIntro}</p>
	                        <p class="crew-geo">${crewVO.geoDistrict != null ? crewVO.geoDistrict : crewVO.geoCity} · 멤버 ${crewVO.crewAttend}</p>
	                    </div>
	                </div></a>
	            </div>
	        </c:forEach>
	    </div>
	
	    <!-- 페이지 -->
	    <nav aria-label="Page navigation example">
		    <ul class="pagination">
		        <!-- 이전 페이지 -->
		        <c:if test="${isPrev}">
		            <c:if test="${not empty ctg}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&ctg=${ctg}&cp=${startPage - 1}">Previous</a></li>
		            </c:if>
		            <c:if test="${empty ctg}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&cp=${startPage - 1}">Previous</a></li>
		            </c:if>
		        </c:if>
		        <!-- 페이지 목록 -->
		        <c:forEach var="i" begin="${startPage}" end="${endPage}">    
		            <c:choose>
		                <c:when test="${i == currentPage}">
		                    <li class="page-item active"><a class="page-link" >${i}</a></li>
		                </c:when>
		                <c:otherwise>
		                    <c:if test="${not empty ctg}">
		                        <li class="page-item"><a class="page-link" href="crew?cmd=list&ctg=${ctg}&cp=${i}">${i}</a></li>
		                    </c:if>
		                    <c:if test="${empty ctg}">
		                        <li class="page-item"><a class="page-link" href="crew?cmd=list&cp=${i}">${i}</a></li>
		                    </c:if>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <!-- 다음 페이지 -->
		        <c:if test="${isNext}">
		            <c:if test="${not empty ctg}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&ctg=${ctg}&cp=${endPage + 1}">Next</a></li>
		            </c:if>
		            <c:if test="${empty ctg}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&cp=${endPage + 1}">Next</a></li>
		            </c:if>
		        </c:if>
		    </ul>
		</nav>
	</div>
    <jsp:include page="../component/footer.jsp"></jsp:include>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const maxNameLength = 19; // crewName 최대 글자 수
    const maxIntroLength = 25; // crewIntro 최대 글자 수

    document.querySelectorAll('.crew-name').forEach(function(element) {
        if (element.textContent.length > maxNameLength) {
            element.textContent = element.textContent.substring(0, maxNameLength) + '...';
        }
    });

    document.querySelectorAll('.crew-intro').forEach(function(element) {
        if (element.textContent.length > maxIntroLength) {
            element.textContent = element.textContent.substring(0, maxIntroLength) + '...';
        }
    });
});

</script>
</body>
</html>