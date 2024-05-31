<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detailBoard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/board/detailBoard.css" type="text/css" />
</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
	    <script src="component/header.js"></script>
	    <!-- 메뉴 -->
	    <ul class="crew-menu__items">
			<li><a href="crew?cmd=detail&crewNo=${crewNo}">정보</a></li>
			<li><a href="board?cmd=listBoard&crewNo=${crewNo}">게시판</a></li>
			<li><a href="">사진첩</a></li>
			<li><a href="">채팅</a></li>
		</ul>
    
    	<section class="subContents">
    		<div class="inner">
    			<!-- 제목 -->
    			<div class="detail-board">
    				<h3 class="subTitle">${vo.boardTitle}</h3>
    			</div>
    			<!-- 회원 정보 -->
    			<div class="detail-board-member">
    				<div class="writer">
	    				<img src="upload/${not empty boardMemberVO.memberSaveImg ? boardMemberVO.memberSaveImg : 'profileDefault.png'}" alt="" />
	    				<span class="writer-nickname">${boardMemberVO.memberNickname}</span>
	    				<span class="writer-category">
	    					<c:choose>
								<c:when test="${vo.boardCategoryNo == 1}">공지사항|</c:when>
								<c:when test="${vo.boardCategoryNo == 2}">가입인사|</c:when>
								<c:when test="${vo.boardCategoryNo == 3}">정모후기|</c:when>
								<c:when test="${vo.boardCategoryNo == 4}">자유|</c:when>
								<c:when test="${vo.boardCategoryNo == 5}">투표|</c:when>
								<c:otherwise>${vo.boardCategoryNo}</c:otherwise>
							</c:choose>
							<fmt:formatDate value="${vo.createdAt}" pattern="yyyy년 MM월 dd일 a HH:mm" />
	    				</span>
    				</div>
    			</div>
    			<hr />
    			<div class="detail-board-content">
    				${vo.boardContent}
    			</div>
    			<hr />
    		</div>
    	</section>
		<!-- <h2>상세보기</h2> -->
		<%-- <table class="table table-striped">
			<tr>
				<td colspan="6"><a href="board?cmd=listBoard&crewNo=${crewNo}"
					class="btn btn-primary">목록</a> <!-- 게시글 수정 --> <c:if
						test="${loginMember.memberNo == vo.memberNo}">
						<a href="board?cmd=updateBoard&bno=${vo.boardNo}&crewNo=${crewNo}"
							class="btn btn-success">수정</a>
						<!-- 게시글 삭제 -->
						<form action="board?cmd=deleteBoard" method="post"
							  class="deleteBoard">
							<input type="hidden" name="boardNo" value="${vo.boardNo}" /> <input
								type="hidden" name="crewNo" value="${vo.crewNo}"> <input
								type="hidden" name="memberNo" value="${vo.memberNo}">
							<button type="submit" class="btn btn-danger">삭제</button>
						</form>
					</c:if></td>
			</tr>
		</table>
		<div class="mt-4">
			<h3>댓글 쓰기</h3>
			<form action="board?cmd=addComment" method="post">
				<input type="hidden" name="boardNo" value="${vo.boardNo}">
				<input type="hidden" name="crewNo" value="${vo.crewNo}">
				<input type="hidden" name="loginMemberNo" id="loginMemberNo"
					   value="${loginMember.memberNo}" />
				<div class="mb-3">
					<label for="commentContent" class="form-label">내용</label>
					<textarea class="form-control" id="commentContent"
						      name="boardCommentContent" rows="3" required></textarea>
				</div>
				<button type="submit" class="btn btn-primary">댓글 달기</button>
			</form>
		</div>
		<div class="mt-4">
			<h3>댓글 목록</h3>
			<c:forEach var="comment" items="${commentList}" varStatus="status">
				<div class="card mb-3">
					<div class="card-body">
						<h5 class="card-title">${commentAuthorMap[comment.boardCommentNo].memberNickname}</h5>
						<h6 class="card-subtitle mb-2 text-muted">${comment.createdAt}</h6>
						<p class="card-text" id="commentContent-${comment.boardCommentNo}">${comment.boardCommentContent}</p>
						<!-- 댓글 수정 창 -->
						<form id="editForm-${comment.boardCommentNo}"
							action="board?cmd=updateComment" method="post"
							style="display: none;">
							<input type="hidden" name="boardNo" value="${vo.boardNo}">
							<input type="hidden" name="crewNo" value="${vo.crewNo}">
							<input type="hidden" name="boardCommentNo"
								   value="${comment.boardCommentNo}">
							<div class="mb-3">
								<textarea class="form-control" name="boardCommentContent"
									rows="3" required>${comment.boardCommentContent}</textarea>
							</div>
							<button type="submit" class="btn btn-success">수정 완료</button>
						</form>
						<!-- 댓글 수정 버튼 -->
						<c:if
							test="${writerList[status.index].memberNo == loginMember.memberNo}">
							<input type="hidden" name="boardNo" value="${vo.boardNo}">
							<input type="hidden" name="crewNo" value="${vo.crewNo}">
							<input type="hidden" name="boardCommentNo"
								   value="${comment.boardCommentNo}">
							<button type="button" class="btn btn-primary"
								   onclick="showEditForm(${comment.boardCommentNo})">수정</button>
							<!-- 댓글 삭제 버튼 -->
							<form action="board?cmd=deleteComment" method="post"
								class="deleteComment">
								<input type="hidden" name="boardNo" value="${vo.boardNo}">
								<input type="hidden" name="crewNo" value="${vo.crewNo}">
								<input type="hidden" name="boardCommentNo"
									   value="${comment.boardCommentNo}">
								<button type="submit" class="btn btn-danger">삭제</button>
							</form>
						</c:if>
					</div>
				</div>
			</c:forEach> --%>
		</div>
		<script>
	$(document).ready(function() {
	    // 게시글 삭제 버튼 클릭 시
	    $('.deleteBoard').submit(function(e) {
	        e.preventDefault();
	        var confirmResult = confirm("정말 삭제하시겠습니까?");
	        if (confirmResult) {
	            this.submit();
	        }
	    });
	    // 댓글 삭제 버튼 클릭 시
	    $('.deleteComment').submit(function(e) {
	        e.preventDefault();
	        var confirmResult = confirm("정말 삭제하시겠습니까?");
	        if (confirmResult) {
	            this.submit();
	        }
	    });
	});
	function showEditForm(commentId) {
	    var editForm = $('#editForm-' + commentId);
	    editForm.show();
	    $('#commentContent-' + commentId).hide();
	}
	</script>
</body>
</html>