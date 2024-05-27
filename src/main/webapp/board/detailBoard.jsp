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

	<!-- 댓글 작성 폼 -->
	<div class="mt-4">
		<h3>댓글 쓰기</h3>
		<form action="board?cmd=addComment" method="post">
			<input type="hidden" name="boardNo" value="${vo.boardNo}">
			<div class="mb-3">
				<label for="commentContent" class="form-label">내용</label>
				<textarea class="form-control" id="commentContent" name="boardCommentContent" rows="3" required></textarea>
			</div>
			<button type="submit" class="btn btn-primary">댓글 달기</button>
		</form>
	</div>

	<!-- 댓글 목록 -->
	<div class="mt-4">
		<h3>댓글 목록</h3>
		<c:forEach var="comment" items="${commentList}">
		  <div class="card mb-3">
		    <div class="card-body">
		      <h5 class="card-title">${comment.memberNickname}</h5>
		      <h6 class="card-subtitle mb-2 text-muted">${comment.createdAt}</h6>
		      <p class="card-text" id="commentContent-${comment.boardCommentNo}">${comment.boardCommentContent}</p>
		      
		      <!-- 수정 폼 -->
		      <form action="board?cmd=updateComment" method="post"">
		        <input type="hidden" name="boardNo" value="${vo.boardNo}">
		        <input type="hidden" name="boardCommentNo" value="${comment.boardCommentNo}">
		        <div class="mb-3">
		          <textarea class="form-control" name="boardCommentContent" rows="3" required>${comment.boardCommentContent}</textarea>
		        </div>
		        <button type="submit" class="btn btn-success">수정 완료</button>
		      </form>
		   <!-- 수정 버튼 -->
			  <button type="button" class="btn btn-primary" onclick="toggleEditForm(${comment.boardCommentNo})">수정</button>
		   
		    </div>
		  </div>
		</c:forEach>
	</div>

	
	</div>
</body>
</html>
