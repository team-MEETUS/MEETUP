<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listBoard.jsp</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style>


</style>
</head>
<body>
	<div class="container">
		<table class="table table-striped">
			<tr>
				<td>
					<a href="board?cmd=listBoard">전체</a>
					<c:forEach var="BoardCategoryVO"
						items="${BoardCategoryList}">
						<a
							href="board?cmd=listBoard&boardCategoryNo=${BoardCategoryVO.boardCategoryNo}">${BoardCategoryVO.boardCategoryName}</a>
					</c:forEach></td>
			</tr>

			<table class="table table-striped">
				<tr>
					<th>게시글 번호</th>
					<th>회원 번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="BoardVO" items="${boardList}">
					<tr>
						<td>${BoardVO.boardNo}</td>
						<td>${BoardVO.memberNo}</td>
						<td><a
							href="board?cmd=detailboard&boardNo=${BoardVO.boardNo}">${BoardVO.boardTitle}</a></td>
						<td>${BoardVO.boardHit}</td>
						<td>${BoardVO.createdAt}</td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5"><a href="board?cmd=writeBoard"
						class="btn btn-primary">등록</a></td>
				</tr>
			</table>
			
			<div>
			<nav aria-label="Page navigation example">
			 	<ul class="pagination">
			 		<c:if test="${isPrev}">
				    	<li class="page-item"><a href="board?cmd=listBoard&cp=${currentPage-1}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>" class="page-link"><</a></li>
				    </c:if>
				    
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<li class="page-item"><a class="page-link" href="board?cmd=listBoard&cp=${i}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>">[${i}]</a></li>
					</c:forEach>
				    
				    <c:if test="${isNext}">
				    	<li class="page-item"><a
								href="board?cmd=listBoard&cp=${currentPage+1}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>"
								class="page-link">></a></li>
				    </c:if>
			 	</ul>
			</nav>
		</div>
			
	</div>
</body>
<script>

function getQueryParam(param) {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(param);
}

function checkAndShowAlert() {
    var msgParam = getQueryParam('msg');
    if (msgParam !== null) {
        alert('모임 회원에게만 공개됩니다.');
    }
}

window.onload = checkAndShowAlert;
</script>
</html>


