<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listBoard.jsp</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.listcontent {
	border: 2px solid lightgray;
	border-radius : 20px;
	padding: 10px;
	}
	.board-category{
	.listcontent {
	border: 2px solid lightgray;
	border-radius : 20px;
	padding: 5px;
	}



</style>
</head>
<body>
	<div class="container">
	<a href="board?cmd=writeBoard" class="btn btn-primary">게시글 등록</a>
	
	<c:forEach var="boardVO" items="${boardList}">
		<div class="listcontent">
			<span class="board-category">${boardCategoryVO.boardCategoryName}</span>
			<p class="board-title">${boardVO.boardTitle}</p>
			<p class="board-member">${boardVO.memberNo}</p>
			<img class="board-img" src="$pageeContext.request.contextPath}/upload/${boardImgVO.boardImgOriginalImg} alt=""/>
		</div>
	</c:forEach>
	
	</table>

	</div>
</body>
</html>






		<%-- <tr>
			<td>${dto.boardNo}</td>
			<td>${dto.boardTitle}</td>
			<td>${dto.boardContent}</td>
			<td><a href="board?cmd=detailBoard&boardNo=${dto.boardNo}"> ${dto.boardTitle} ${dto.boardContent}</a></td>
			<td>${dto.boardhit}</td>

<%-- 
		<h5>총게시물수 : ${selectTotalCountBoard}</h5>
		<h5>페이지당게시물수 : ${recordPerPage}</h5>
		<h5>총페이지수 : ${totalPage}</h5>
		<h5>현재페이지 : ${currentPage}</h5>
		<h5>시작번호 : ${boardStartNo}</h5>
		<h5>끝번호 : ${boardEndNo}</h5>
		<h5>시작페이지번호 : ${startPage}</h5>
		<h5>끝페이지번호 : ${endPage}</h5>
		<h5>이전페이지존재? : ${isPrev}</h5>
		<h5>다음페이지존재? : ${isNext}</h5> 
		--%>

				<!-- 	 for (int i = startPage; i <= endPage; i++) {
				            if (i == currentPage) { 
				                pageHtml.append("<li class='active'><a href='?cp=").append(i).append("'>").append(i).append("</a></li>"); 
				            } else { 
				                pageHtml.append("<li><a href='?cp=").append(i).append("'>").append(i).append("</a></li>"); 
				            }
				        }
				
				        if (isPrev) { 
				            pageHtml.insert(0, "<li><a href='?cp=" + (startPage - 1) + "'>이전</a></li>"); 
				        }
				
				        if (isNext) { 
				            pageHtml.append("<li><a href='?cp=" + (endPage + 1) + "'>다음</a></li>");
				        }
				
				        req.setAttribute("pageHtml", pageHtml.toString()); -->
	
	
					<%-- <tr>
						<td colspan="4">
							<nav aria-label="Page navigation example">
								<ul class="pagination">
								<!-- 이전 페이지 -->
								<c:if test="${isPrev}">
									<li class="page-item"><a class="page-link" href="board?cmd=listBoard&cp=${currentPage-1}">Previous</a></li>
								</c:if>
								<!-- 페이지 목록 -->
								<c:forEach var="i" begin="${startPage}" end="${endPage}">					
									<li class="page-item"><a class="page-link" href="board?cmd=listBoard&cp=${i}">[${i}]</a></li>
								</c:forEach>
								<!-- 다음 페이지 -->
								<c:if test="${isNext}">
									<li class="page-item"><a class="page-link" href="board?cmd=listBoard&cp=${currentPage+1}">Next</a></li>
								</c:if>
								</ul>
						  	</nav>
						</td>
					</tr> --%>