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
				<td><c:forEach var="BoardCategoryVO"
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
	</div>
</body>
</html>


