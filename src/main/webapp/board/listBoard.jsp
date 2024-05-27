<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>


</style>
</head>
<body>
	<div class="container">
		<table class="table table-striped">
			<input type="hidden" name="loginMember" id="loginMember" value="${loginMember.memberNo}" />
			<c:forEach var="CrewMemberVO" items="${crewMemberList}">
				<input type="hidden" name="CrewMember" value="${CrewMemberVO.memberNo}" />
			</c:forEach>
			<tr>
				<td>
					<a href="board?cmd=listBoard&crewNo=${boardCrewNo}">전체</a>
					<c:forEach var="BoardCategoryVO" items="${BoardCategoryList}">
						<a href="board?cmd=listBoard&boardCategoryNo=${BoardCategoryVO.boardCategoryNo}&crewNo=${boardCrewNo}">${BoardCategoryVO.boardCategoryName}</a>
					</c:forEach>
				</td>
			</tr>

			<table class="table table-striped">
				<tr>
					<th>게시글 번호</th>
					<th>회원 번호</th>
					<th>제목</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				<c:forEach var="BoardVO" items="${boardList}" varStatus="status">
					<tr>
						<td>${BoardVO.boardNo}</td>
						<td>${memberList[status.index].memberNickname}</td>
						<td>
							<a href="board?cmd=detailboard&boardNo=${BoardVO.boardNo}&crewNo=${boardCrewNo}" class="boardDetail" data-crewMemberNo="${CrewMemberVO.memberNo}">${BoardVO.boardTitle}</a>
						</td>
						<td>${BoardVO.boardHit}</td>
						<td><fmt:formatDate value="${BoardVO.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:forEach>
				<tr>
					<td colspan="5">
						<a href="board?cmd=writeBoard" class="btn btn-primary">등록</a>
					</td>
				</tr>
			</table>
			
			<div>
				<nav aria-label="Page navigation example">
				 	<ul class="pagination">
				 		<c:if test="${isPrev}">
					    	<li class="page-item">
					    		<a href="board?cmd=listBoard&cp=${currentPage-1}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>" class="page-link"><</a>
					    	</li>
					    </c:if>
					    
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li class="page-item">
								<a class="page-link" href="board?cmd=listBoard&cp=${i}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>">[${i}]</a>
							</li>
						</c:forEach>
					    
					    <c:if test="${isNext}">
					    	<li class="page-item">
					    		<a href="board?cmd=listBoard&cp=${currentPage+1}<c:if test="${boardCategoryNo != null}">&boardCategoryNo=${boardCategoryNo}</c:if>" class="page-link">></a>
							</li>
					    </c:if>
				 	</ul>
				</nav>
			</div>
		</table>
	</div>
	
	<script>
		$(document).ready(function() {
			$(".boardDetail").on("click", function(event) {
				var loginMember = $("#loginMember").val();
				var crewMemberNo = $(this).data('crewMemberNo');
				if (!loginMember) {
					event.preventDefault();
					alert('모임 회원만 볼 수 있습니다.');
				}
				
				if (loginMemberNo != crewMemberNo) {
		            event.preventDefault();
		            alert('모임 회원만 볼 수 있습니다.');
		        }
			});
		});
	</script>
</body>
</html>


