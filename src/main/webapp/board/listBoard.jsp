<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

	<!-- CSS -->
	<link rel="stylesheet" href="./css/reset.css" type="text/css" />
	<link rel="stylesheet" href="./css/index.css" type="text/css" />
	<link rel="stylesheet" href="./css/header.css" type="text/css" />
	<!-- <link rel="stylesheet" href="./css/board/listBoard.css" type="text/css" /> -->
	<!-- CDN -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
.container {
		width: 1024px;
		margin: 0 auto;
	}
</style>
</head>
<body>
	<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
    <script src="component/header.js"></script>
	<section class="listBoard">
	<div><a href="board?cmd=listBoard">게시판</a></div>
	
	
		<table class="table table-striped">
			<input type="hidden" name="loginMemberNo" id="loginMemberNo"
				   value="${loginMember.memberNo}" />
			<script>
				var crewMemberList = [];
				<c:forEach var="CrewMember" items="${crewMemberList}">
				crewMemberList.push("${CrewMember.memberNo}");
				</c:forEach>
			</script>
			<tr>
				<td><a href="board?cmd=listBoard&crewNo=${crewNo}">전체</a> <c:forEach
						var="BoardCategoryVO" items="${BoardCategoryList}">
						<a href="board?cmd=listBoard&boardCategoryNo=${BoardCategoryVO.boardCategoryNo}&crewNo=${crewNo}">${BoardCategoryVO.boardCategoryName}</a>
					</c:forEach></td>
			</tr>

			<table class="table table-striped">
				<tr>
					<th>게시글 번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="BoardVO" items="${boardList}" varStatus="status">
					<tr>
						<td>${BoardVO.boardNo}</td>
						<td>${memberList[status.index].memberNickname}</td>
						<td><a
							href="board?cmd=detailboard&boardNo=${BoardVO.boardNo}&crewNo=${crewNo}&memberNo=${memberList[status.index].memberNo}"
							class="boardDetail">${BoardVO.boardTitle}</a></td>
						<td>${BoardVO.boardHit}</td>
						<td><fmt:formatDate value="${BoardVO.createdAt}"
								pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5"><a
						href="board?cmd=writeBoard&crewNo=${crewNo}&memberNo=${loginMember.memberNo}"
						class="btn btn-primary boardDetail">등록</a></td>
				</tr>
			</table>

			<div>
				<nav aria-label="Page navigation example">
					<ul class="pagination">
						<c:if test="${isPrev}">
							<li class="page-item"><a
								href="board?cmd=listBoard&cp=${currentPage-1}&crewNo=${crewNo}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>"
								class="page-link"><</a></li>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li class="page-item"><a class="page-link"
								href="board?cmd=listBoard&cp=${i}&crewNo=${crewNo}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>">[${i}]</a>
							</li>
						</c:forEach>

						<c:if test="${isNext}">
							<li class="page-item"><a
								href="board?cmd=listBoard&cp=${currentPage+1}&crewNo=${crewNo}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>"
								class="page-link">></a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</table>
		</section>
	</div>

	<script>
		$(document).ready(function() {
			$(".boardDetail").on("click", function(event) {
				var loginMemberNo = $("#loginMemberNo").val();
				var crewMemberNoList = crewMemberList;
				var isCrewMember = crewMemberNoList.includes(loginMemberNo);
				if (!loginMemberNo || !isCrewMember) {
					event.preventDefault();
					alert('모임 회원만 가능한 기능입니다.');
				}

			});
		});
	</script>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>