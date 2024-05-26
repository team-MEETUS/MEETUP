<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailBoard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
	<h2>상세보기</h2>
	<table class="table table-striped">
		<tr>
			<th>카테고리</th>
		      <c:choose>
		            <c:when test="${vo.boardCategoryNo == 1}">공지사항</c:when>
		            <c:when test="${vo.boardCategoryNo == 2}">가입인사</c:when>
		            <c:when test="${vo.boardCategoryNo == 3}">정모후기</c:when>
		            <c:when test="${vo.boardCategoryNo == 4}">자유</c:when>
		            <c:when test="${vo.boardCategoryNo == 5}">투표</c:when>
		            <c:otherwise>${vo.boardCategoryNo}</c:otherwise>
		        </c:choose>
			<th>조회수</th>
			<td>${vo.boardHit}</td>
			<th>작성일시</th>
			<td>${vo.createdAt}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="5">${vo.boardTitle}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="5">${vo.boardContent}</td>
		</tr>
		<tr>
			<td colspan="6">
				<a href="board" class="btn btn-primary">목록</a>
				<a href="board?cmd=updateBoard&bno=${vo.boardNo}" class="btn btn-success">수정</a>
				<a href="board?cmd=deleteBoard&bno=${vo.boardNo}" class="btn btn-danger">삭제</a>
			</td>
		</tr>
	</table>
	</div>
</body>
</html>