<%@page import="kr.co.meetup.web.vo.MeetingVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
	.container {
		text-align: center;
	}
	.meetingOne {
		border: 1px solid black;
		width : 30%;
		display: inline-block;
	}
</style>
</head>

<body>
	<div class="container">
		<h2>모임 상세페이지 하단부분</h2>
		<c:forEach var="vo" items="${list}">
			<div class="meetingOne">
				<div>${vo.meetingDate} D-1</div>
				<div>${vo.meetingName}</div>
				<a href="meeting?cmd=write"></a>
				<div>${vo.meetingSaveImg} image</div>
				
				<div>${vo.meetingDate}</div>
				<div>${vo.meetingPrice}</div>
				<div>참석 ${vo.meetingAttend}/${vo.meetingMax} (${vo.meetingMax}-${vo.meetingAttend}명남음) </div>
			</div>
		</c:forEach>
		<tr>
			<td colspan="4">
				<nav aria-label="Page navigation example">
				 	<ul class="pagination">
				 		<c:if test="${isPrev}">
					    	<li class="page-item"><a href="meeting?cmd=detail&crewNo=${crewNo}&cp=${currentPage-1}" class="page-link"><</a></li>
					    </c:if>
					    
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<li class="page-item"><a class="page-link" href="meeting?cmd=detail&crewNo=${crewNo}&cp=${i}">[${i}]</a></li>
						</c:forEach>
					    
					    <c:if test="${isNext}">
					    	<li class="page-item"><a href="meeting?cmd=detail&crewNo=${crewNo}&cp=${currentPage+1}" class="page-link">></a></li>
					    </c:if>
				 	</ul>
				</nav>
			</td>
		</tr>
	</div>
</body>
</html>