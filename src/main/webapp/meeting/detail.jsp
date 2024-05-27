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
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-top: 20px;
}

.list {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(3, 1fr);
  grid-gap: 20px;
  width: 100%;
}

.meetingOne {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease;
  display: flex;
  flex-direction: column;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.meetingOne:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.meetingOne img {
  margin-right: 20px;
  max-width: 100px;
  height: auto;
  border-radius: 4px;
  margin-bottom: 10px;
}

.btn {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  gap: 10px;
}

.paging {
  margin-top: 20px;
  width: 100%;
}

.pagination {
  display: flex;
  justify-content: center;
}

.meetingOne .content {
  text-align: left;
  flex-grow: 1;
}
</style>
</head>
<body>
	<h2>모임 상세페이지 하단부분</h2>
	
	<a href="meeting?cmd=write" class="btn btn-primary">정모등록</a>
	
	<div class="container">
		<div class="list">
			<c:forEach var="meetingVO" items="${list}">
				<div class="meetingOne">
					<p>${meetingVO.meetingDate} D-1</p>
					<p>${meetingVO.meetingName}</p>
					<a href="meetingAttend?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${meetingVO.crewNo}" class="btn btn-primary">모임 참석하기</a>
					<a href="meetingExit?memberNo=${MemberVO.memberNo}&meetingNo=${meetingVO.meetingNo}&crewNo=${meetingVO.crewNo}" class="btn btn-primary">모임 나가기</a>
					<br />
					<a href="meeting?cmd=write"></a>
					<img src="upload/${meetingVO.meetingSaveImg}" alt="" />
					
					<div>${meetingVO.meetingDate}</div>
					<div>${meetingVO.meetingPrice}</div>
					<div>참석 ${meetingVO.meetingAttend}/${meetingVO.meetingMax} (${meetingVO.meetingMax-meetingVO.meetingAttend}명남음) </div>
				</div>
				
			</c:forEach>
		</div>
		<br />

		<br />
		
		<div class="paging">
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
		</div>
	</div>
</body>
</html>