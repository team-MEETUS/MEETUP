<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listBoard.jsp</title>

<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/board/listBoard.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>



</head>
<body>
	<div class="container">
		<jsp:include page="../component/header.jsp"></jsp:include>
		<script src="component/header.js"></script>

		<table>
			<input type="hidden" name="loginMemberNo" id="loginMemberNo"
				value="${loginMember.memberNo}" />
			<script>
				var crewMemberList = [];
				<c:forEach var="CrewMember" items="${crewMemberList}">
				crewMemberList.push("${CrewMember.memberNo}");
				</c:forEach>
			</script>
			<tr>


				<!-- 메뉴 -->
				<ul class="crew-menu__items">
					<li><a href="crew?cmd=detail&crewNo=${crewNo}">정보</a></li>
					<li><a href="board?cmd=listBoard&crewNo=${crewVO.crewNo}">게시판</a>
					</li>
					<li><a href="">사진첩</a></li>
					<li><a href="">채팅</a></li>
				</ul>

				<!-- 게시판 카테고리 -->
			<tr>
				<td>
					<div class="category-buttons">
						<a href="board?cmd=listBoard&crewNo=${crewNo}"
							class="category-button">전체</a>
						<c:forEach var="BoardCategoryVO" items="${BoardCategoryList}">
							<a
								href="board?cmd=listBoard&boardCategoryNo=${BoardCategoryVO.boardCategoryNo}&crewNo=${crewNo}"
								class="category-button">
								${BoardCategoryVO.boardCategoryName} </a>
						</c:forEach>
					</div>
				</td>
			</tr>

			<section class="listBoard">
				<table class="mainTable">
					<tr style="display: none;">
						<th>게시글 번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>조회수</th>
						<th>작성일</th>
					</tr>

					<!-- 리스트 본문 -->
					<div class="board-table">
						<c:forEach var="BoardVO" items="${boardList}" varStatus="status">
							<a
								href="board?cmd=detailboard&boardNo=${BoardVO.boardNo}&crewNo=${crewNo}&memberNo=${memberList[status.index].memberNo}">
								<div class="board-row">
									<div class="board--No">${BoardVO.boardNo}</div>
									<img
										src="upload/${not empty memberList[status.index].memberSaveImg ? memberList[status.index].memberSaveImg : 'first.png'}"
										alt="" />
									<div class="board--memberNickname">${memberList[status.index].memberNickname}</div>
									<div class="board--detail">${BoardVO.boardTitle}</div>
									<c:forEach var="BoardCategory" items="${BoardCategoryList}"
										varStatus="status">
										<div class="board--category">
											<c:choose>
												<c:when
													test="${BoardVO.boardCategoryNo == BoardCategory.boardCategoryNo}">
						        ${BoardCategory.boardCategoryName}
						      </c:when>
												<c:otherwise>
													<!-- 아무것도 출력하지 않음 -->
												</c:otherwise>
											</c:choose>
										</div>
									</c:forEach>

									<box-icon class="board--show" name='show'></box-icon>
									<div class="board--hit">${BoardVO.boardHit}</div>
									<div class="board--date">
										<span class="board--date-date"> <fmt:formatDate
												value="${BoardVO.createdAt}" pattern="yyyy년 MM월 dd일" />
										</span>
										<%-- <span class="board--date-time">
							  <fmt:formatDate value="${BoardVO.createdAt}" pattern="HH시 mm분 ss초" />
							</span> --%>

									</div>
								</div>
							</a>
						</c:forEach>
					</div>

					<div>
						<a
							href="board?cmd=writeBoard&crewNo=${crewNo}&memberNo=${loginMember.memberNo}"
							class="WriteGo">등록</a>
					</div>
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

			</section>
		</table>
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