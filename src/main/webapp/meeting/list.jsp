<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/meeting/list.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	
	<!-- 날짜별 카테고리 -->
	<ul class="meeting-menu_items">
		<%
			java.time.LocalDate LDate = java.time.LocalDate.now();
			java.time.format.DateTimeFormatter fm = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
			
			String fdate = LDate.format(fm);
			
			// 초기값 설정
			String strDate = request.getParameter("date");
			if(strDate == null) {
				strDate = fdate;
			}
		%>
			<c:set var="today" value="<%= strDate %>"/>
			<c:set var="ftoday" value="<%= fdate %>"/>
			<li class="${ftoday eq today ? 'selected' : '' }">
			<a href="meeting?cmd=list&date=<%= LDate.plusDays(0) %>">
				<div class="day-of-week"><%= LDate.plusDays(0).getDayOfWeek().getDisplayName(java.time.format.TextStyle.NARROW,  java.util.Locale.KOREAN) %> </div>
	            <div><%= LDate.plusDays(0).getDayOfMonth() %></div>
           	</a>
           	</li>		
		<%
			for(int i = 1; i < 7; i++) {
		%>
				<c:set var="date" value="<%= LDate.plusDays(i).format(fm) %>"/>
		        <li class="${date eq today ? 'selected' : '' }"><a href="meeting?cmd=list&date=<%= LDate.plusDays(i) %>">
					<div class="day-of-week"><%= LDate.plusDays(i).getDayOfWeek().getDisplayName(java.time.format.TextStyle.NARROW,  java.util.Locale.KOREAN) %> </div>
		            <div><%= LDate.plusDays(i).getDayOfMonth() %></div>
            	</a></li>
		<%  }  %>	
			
	</ul>
	<div class="meeting-container">
		<c:set var="i" value="${1}"/>
		<c:forEach var="meetingVO" items="${meetingList}">
			<c:set var="meetingDate" value="${meetingVO.meetingDate}"/>
			<fmt:formatDate var="pdMeetingDate" value="${meetingDate}" pattern="MM/dd(E) hh:mm"/>
            <div class="meeting-item">
        		<a href="crew?cmd=detail&crewNo=${meetingVO.crewNo}"><div class="card-meeting">
                    <img class="meeting-img" src="upload/${meetingVO.meetingSaveImg}" onerror="this.onerror=null; this.src='upload/imgDefault.png'" alt="${meetingVO.meetingName} 정모 이미지" />
                    <div class="meeting-details">
                        <span class="meeting-category">${meetingVO.categorySmallName != null ? meetingVO.categorySmallName : meetingVO.categoryBigName}</span>
                        <p class="meeting-name" id="meetingName-${crewVO.crewNo}" >${meetingVO.meetingName}</p>
                        <p class="meeting-geo"><p id="crewName-${crewVO.crewNo}" > ${meetingVO.geoDistrict != null ? meetingVO.geoDistrict : meetingVO.geoCity} · ${meetingVO.crewName}</p>
						<p class="meeting-attend">
							<span style="margin-right:10px;">${pdMeetingDate}</span>
							<box-icon style="position:relative; top:7px;" name='group' type='solid' ></box-icon> 
							<span>${meetingVO.meetingAttend}/${meetingVO.meetingMax}</span>
						</p>
                    </div>
                </div></a>
            </div>
            <c:set var="i" value="${i+1}"/>
        </c:forEach>
        <c:if test="${i == 1}">
        	<div class="meeting-item"><a href="crew?cmd=detail&crewNo=${meetingVO.crewNo}"><div class="card-meeting" style="display: none;">1</div></a></div>
        </c:if>
        <c:if test="${i % 2 == 0}">
        	<div class="meeting-item"><a href="crew?cmd=detail&crewNo=${meetingVO.crewNo}"><div class="card-meeting" style="display: none;">1</div></a></div>
        </c:if>
        
        <!-- 페이지 -->
	    <nav aria-label="Page navigation example">
		    <ul class="pagination">
		        <!-- 이전 페이지 -->
		        <c:if test="${isPrev}">
		            <c:if test="${not empty date}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&date=${date}&cp=${startPage - 1}">Previous</a></li>
		            </c:if>
		            <c:if test="${empty date}">
		                <li class="page-item"><a class="page-link" href="crew?cmd=list&cp=${startPage - 1}">Previous</a></li>
		            </c:if>
		        </c:if>
		        <!-- 페이지 목록 -->
		        <c:forEach var="i" begin="${startPage}" end="${endPage}">    
		            <c:choose>
		                <c:when test="${i == currentPage}">
		                    <li class="page-item active"><a class="page-link" >${i}</a></li>
		                </c:when>
		                <c:otherwise>
		                    <c:if test="${not empty date}">
		                        <li class="page-item"><a class="page-link" href="meeting?cmd=list&date=${date}&cp=${i}">${i}</a></li>
		                    </c:if>
		                    <c:if test="${empty date}">
		                        <li class="page-item"><a class="page-link" href="meeting?cmd=list&cp=${i}">${i}</a></li>
		                    </c:if>
		                </c:otherwise>
		            </c:choose>
		        </c:forEach>
		        <!-- 다음 페이지 -->
		        <c:if test="${isNext}">
		            <c:if test="${not empty date}">
		                <li class="page-item"><a class="page-link" href="meeting?cmd=list&date=${date}&cp=${endPage + 1}">Next</a></li>
		            </c:if>
		            <c:if test="${empty date}">
		                <li class="page-item"><a class="page-link" href="meeting?cmd=list&cp=${endPage + 1}">Next</a></li>
		            </c:if>
		        </c:if>
		    </ul>
		</nav>
	</div>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    const maxNameLength = 19; // crewName 최대 글자 수
    const maxIntroLength = 20; // crewIntro 최대 글자 수

    document.querySelectorAll('.meeting-name').forEach(function(element) {
        if (element.textContent.length > maxNameLength) {
            element.textContent = element.textContent.substring(0, maxNameLength) + '...';
        }
    });

    document.querySelectorAll('.crew-crew').forEach(function(element) {
        if (element.textContent.length > maxIntroLength) {
            element.textContent = element.textContent.substring(0, maxIntroLength) + '...';
        }
    });
});

</script>
</body>
</html>