<%@page import="java.time.LocalDateTime"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.Instant"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="kr.co.meetup.web.vo.MeetingVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.meetup.web.dao.MeetingDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
h2 {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  color: #333;
  text-align: center;
}

.category {
 width: 100%;
}

.container {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  grid-gap: 20px;
  justify-content: center;
  align-items: center;
}

.meetingOne {
  border: 1px solid #ccc;
  border-radius: 8px;
  padding: 20px;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  align-items: center; /* 수직 중앙 정렬 */
  margin: 10px 0;
}

.meetingOne:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

.meetingOne img {
  max-width: 100px;
  height: auto;
  border-radius: 4px;
  margin-right: 20px;
  float: left;
}

.meetingOne .meetingDate,
.meetingOne .meetingName,
.meetingOne .meetingPrice,
.meetingOne .meetingAttend {
  margin-bottom: 5px;
  font-size: 14px;
  color: #555;
}

.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination .page-item .page-link {
  color: #333;
  background-color: #f5f5f5;
  border: 1px solid #ddd;
  padding: 8px 12px;
  margin: 0 5px;
  border-radius: 4px;
  transition: background-color 0.3s ease;
}

.pagination .page-item.active .page-link {
  color: #fff;
  background-color: #007bff;
  border-color: #007bff;
}

.pagination .page-item .page-link:hover {
  background-color: #e9e9e9;
}
</style>
</head>
<body>
	<h2>정모 페이지</h2>
	<div class="container">
		<br />
		<div class="category">
		<%
 			String[] dayOfWeekArr = {"일", "월", "화", "수", "목", "금", "토"};
			Timestamp today = new Timestamp(System.currentTimeMillis());
			int day = today.getDay();
			int dateOfMonth = today.getDate();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			// 초기값 설정
			String strDate = request.getParameter("date");
			if(strDate == null) {
				strDate = sdf.format(today);
			}
			java.util.Date date = new java.util.Date(today.getTime());
			
			for(int i = 0; i < 7; i++) {
		%>
				<a class="btn" href="meeting?cmd=list&date=<%=new Date(date.getTime() + (1000 * 60 * 60 * 24) * i)%>">		
					<div><%= dateOfMonth + i %></div>
					<div><%= dayOfWeekArr[(day + i) % 7] %></div>
				</a>
		<%
			}
		%>
		<!-- crewNo 받아오기 여기말고 상세페이지에 다시 만들기 -->
<!-- 		<a href="meeting?cmd=write&crewNo=1" class="btn btn-primary">모임등록</a> -->
		</div>
		
		<br />		
		<c:forEach var="meetingVO" items="${list}">
			<div class="meetingOne">
				<div>${meetingVO.meetingSaveImg}</div>
				<a href="meeting?cmd=detail&crewNo=${meetingVO.crewNo}">${meetingVO.meetingName}</a>
				<img src="upload/${meetingVO.meetingSaveImg}" alt="" />
				
				<div>${meetingVO.meetingDate}</div>
				<div>${meetingVO.meetingAttend}/${meetingVO.meetingMax} </div>
			</div>
		</c:forEach>

		<br />
		<div>
			<nav aria-label="Page navigation example">
			 	<ul class="pagination">
			 		<c:if test="${isPrev}">
				    	<li class="page-item"><a href="meeting?cmd=list&date=<%=strDate%>&cp=${currentPage-1}" class="page-link"><</a></li>
				    </c:if>
				    
					<c:forEach var="i" begin="${startPage}" end="${endPage}">
						<li class="page-item"><a class="page-link" href="meeting?cmd=list&date=<%=strDate%>&cp=${i}">[${i}]</a></li>
					</c:forEach>
				    
				    <c:if test="${isNext}">
				    	<li class="page-item"><a href="meeting?cmd=list&date=<%=strDate%>&cp=${currentPage+1}" class="page-link">></a></li>
				    </c:if>
			 	</ul>
			</nav>
		</div>
	</div>
</body>
</html>