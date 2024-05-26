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
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<style>
	/* 카테고리 */
	.ctg-crew__items {
		list-style: none;
		display: flex;
		justify-content: center;
		padding: 0;
		margin: 20px 0;
	}
	.ctg-crew__items li {
		margin: 0 80px;
		text-align: center;
	}
	.ctg-crew__items li a {
		text-decoration: none;
		color: black;
		display: block;
	}
	.ctg-crew__icons {
		display: block;
		margin: 5px auto;
		text-align: center;
	}
	/* 등록 버튼 */
	.d-flex {
		margin: 20px 0;
	}
	/* 모임 */
	.card-crew {
	    border-radius: 20px;
	    padding: 10px;
	    display: flex;
	    margin-bottom: 20px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
	    transition: box-shadow 0.3s ease; /* 부드러운 전환 효과 추가 */
	    line-height: 20px;
	}
	.card-crew:hover {
	    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* 호버 시 더 진한 그림자 */
	}
    .crew-img {
        width: 150px;
        height: 150px;
        border-radius: 10px;
        margin-right: 20px;
        object-fit: cover;
    }
    .crew-details {
        flex-grow: 1;
    }
    .crew-category {
        border-radius: 20px;
        background-color: #FB9B00;
        padding: 8px;
        display: inline-block;
        margin: 10px 0;
        font-size: 14px;
        color: white;
        fo
    }
    .crew-name {
        font-size: 22px;
        margin-bottom: 10px;
    }
    .crew-intro, .crew-geo {
        margin-bottom: 5px;
    }
    .crew-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
    .crew-item {
        flex: 0 0 calc(50% - 10px); /* 50% 너비에 간격을 위한 여유를 줌 */
        box-sizing: border-box;
        margin-bottom: 20px;
    }
    .crew-item a {
		text-decoration: none;
		color: black;
		display: block;
	}
	/* 등록 버튼 */
	.btn-main {
        border-radius: 20px;
        background-color: #FB9B00;
        padding: 10px;
        display: inline-block;
        margin-bottom: 10px;
        color: white;
	}
	/* 페이지 */
    .pagination {
        display: flex;
        justify-content: center;
        padding-left: 0;
        list-style: none;
    }
    /* .page-item {
        flex-grow: 1;
        display: flex;
        justify-content: center;
    }
    .page-link {
        border: 1px solid #dee2e6;
        padding: 0.375rem 0.75rem;
        margin-left: -1px;
        line-height: 1.25;
        color: #007bff;
        text-decoration: none;
        background-color: #fff;
    }
    .page-item.active .page-link {
        z-index: 3;
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
    } */
</style>
</head>
<body>
<div class="container">
	
    <!-- 카테고리 -->
    <ul class="ctg-crew__items">
        <li>
            <a href="crew?cmd=list">
            	<box-icon class="ctg-crew__icons" name="grid-alt"></box-icon>
            	전체상품
            </a>
        </li>
        <c:forEach var="categoryBigVO" items="${categoryBigList}">
        <li>
            <a href="crew?cmd=list&ctg=${categoryBigVO.categoryBigNo}">
            	<box-icon class="ctg-crew__icons" name="${categoryBigVO.categoryBigIcon}"></box-icon>
            	${categoryBigVO.categoryBigName}
            </a>
        </li>
        </c:forEach>
    </ul>
	
	<!-- 모임등록 버튼 -->
	<c:if test="${not empty sessionScope.loginMember}">
		<div class="d-flex justify-content-end">
			<a href="crew?cmd=write" class="btn btn-main">모임등록</a>
		</div>
	</c:if>
	
	<!-- 모임 -->
	<div class="crew-container">
        <c:forEach var="crewVO" items="${crewList}">
            <div class="crew-item">
        		<a href="crew?cmd=detail&crewNo=${crewVO.crewNo}"><div class="card-crew">
                    <img class="crew-img" src="upload/${crewVO.crewSaveImg}" alt="${crewVO.crewName}" />
                    <div class="crew-details">
                        <span class="crew-category">${crewVO.categorySmallName != null ? crewVO.categorySmallName : crewVO.categoryBigName}</span>
                        <p class="crew-name">${crewVO.crewName}</p>
                        <p class="crew-intro">${crewVO.crewIntro}</p>
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
</body>
</html>