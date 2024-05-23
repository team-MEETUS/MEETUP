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
	.container {
		text-align: center;
	}
	.category {
		justify-content: space-around;
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
		<h2>정모 페이지</h2>
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
		</div>
		
		<a href="meeting?cmd=write" class="btn btn-primary">모임등록</a>
		<br>
		
		<c:forEach var="vo" items="${list}">
			<div class="meetingOne">
				<div>${vo.meetingSaveImg}</div>
				<a href="meeting?cmd=detail&crewNo=${vo.crewNo}">${vo.meetingName}</a>
				<img src="upload/꼬부기.jpg" alt="" />
				
				<div>${vo.meetingDate}</div>
				<div>${vo.meetingAttend}/${vo.meetingMax} </div>
			</div>
		</c:forEach>

	
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