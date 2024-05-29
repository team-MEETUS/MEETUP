<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeForm.jsp</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- input에 오늘날짜 기본값으로 넣기 -->
<script type="text/javascript">
	window.onload = function() {
		today = new Date();
		today = today.toISOString().slice(0, 10);
		meetingDate = document.getElementById("meetingDate");
		meetingDate.value = today;
	}
</script>
</head>
<body>
	<h1>정모 등록</h1>
	<div class="container">
		<form id="writeForm" action="meetingUpload" method="post" enctype="multipart/form-data">
												<!-- crewNo 받아오기 -->
			<input type="hidden" name="crewNo" value="${crewNo}" />
			<table class="table table-striped">
				<tr>
					<th>정모명</th>
					<td colspan="2"><input type="text" name="meetingName" /></td>
				</tr>
				<tr>
					<th>정모날짜</th>
					<!-- 캘린더 띄우기 -->
					<td colspan="2"><input type="date" name="meetingDate" id="meetingDate"></td>
				</tr>
				<tr>
					<th>정모시간</th>
					<td><input type="text" name="meetingTime1"> 시</td>
					<td><input type="text" name="meetingTime2"> 분</td>
				</tr>
				<tr>
					<th>정모위치</th>
					<td colspan="2"><input type="text" name="meetingLoc" /></td>
				</tr>
				<tr>
					<th>비용</th>
					<td colspan="2"><input type="text" name="meetingPrice" /></td>
				</tr>
				<tr>
					<th>정원</th>
					<td colspan="2"><input type="text" name="meetingMax" /></td>
				</tr>
				<tr>
					<th>정모 메인 이미지</th>
					<td colspan="2"><input type="file" name="meetingImg"/></td>
				</tr>
				<tr>
					<td colspan="4">
						<a class="btn btn-success" type="button" href="meeting?cmd=list">목록으로 돌아가기</a> 
						<input class="btn btn-primary" type="submit" value="정모 생성하기"/> 
					</td>
				</tr>
			</table>
		</form>
	</div>
	
	<script>
		$("#writeForm").submit(function(event) {
			let meetingName = $("input[name='meetingName']").val();
		    let date = $("input[name='meetingDate']").val();
		    let meetingTime1 = $("input[name='meetingTime1']").val();
		    let meetingTime2 = $("input[name='meetingTime2']").val();
		    let meetingLoc = $("input[name='meetingLoc']").val();
		    let meetingPrice = $("input[name='meetingPrice']").val();
		    let meetingMax = $("input[name='meetingMax']").val();
		    let meetingImg = $("input[name='meetingImg']").val();
		    
		    let meetingDate = new Date(date);
		    let today = new Date();
		    let yesterday = new Date(today);
		    yesterday.setDate(today.getDate() - 1);
		    let hour = Number(meetingTime1);
			let minute = Number(meetingTime2);
			
			if (!meetingName) {
				alert("정모명을 입력해주세요.");
		        event.preventDefault();
			} else if (meetingDate <= yesterday) {
				alert("정모날짜는 오늘보다 빠를 수 없습니다.\n날짜를 다시 입력해주세요.");
		        event.preventDefault();
			} else if(hour > 23 || hour < 1) {
				alert("제대로된 시간을 입력해주세요")
				event.preventDefault();
			} else if(!minute && minute != 0) {
				alert("제대로된 분을 입력해주세요")
				event.preventDefault();
			} else if(minute > 59 || minute < 0) {
				alert("제대로된 분을 입력해주세요")
				event.preventDefault();
			} else if(isNaN(meetingTime1)) {
				alert("정모시간은 숫자만 입력 가능합니다");
				event.preventDefault();
			} else if(isNaN(meetingTime2)) {
				alert("정모시간은 숫자만 입력 가능합니다");
				event.preventDefault();
			} else if (!meetingLoc) {
				alert("정모위치를 입력해주세요.");
		        event.preventDefault();
			} else if (!meetingPrice) {
				alert("비용을 입력해주세요.");
		        event.preventDefault();
			} else if(isNaN(meetingPrice)) {
				alert("비용은 숫자만 입력 가능합니다");
				event.preventDefault();
			} else if (!meetingMax) {
				alert("정원을 입력해주세요.");
		        event.preventDefault();
			} else if(isNaN(meetingMax)) {
				alert("정원은 숫자만 입력 가능합니다");
				event.preventDefault();
			} else if(!meetingTime1) {
				alert("시간을 입력해주세요");
				event.preventDefault();
			} else if(!meetingTime2) {
				alert("분을 입력해주세요");
				event.preventDefault();
			}
			
			if(!meetingImg) {
				$("input[name='meetingImg']").val("images.jpg");
			}
		});

	</script>
</body>
</html>