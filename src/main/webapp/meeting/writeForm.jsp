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
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/summernote-ko-KR.js"></script>
<!-- input에 오늘날짜 기본값으로 넣기 -->
<script type="text/javascript">
	window.onload = function() {
		today = new Date();
		today = today.toISOString().slice(0, 10);
		console.log("today >>>> " + today);
		meetingDate = document.getElementById("meetingDate");
		meetingDate.value = today;
	}
</script>
</head>
<body>
	<h1>정모 등록</h1>
	<div class="container">
		<form action="upload.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="crewNo" value="${crewNo}" />
			<input type="hidden" name="memberNo" value="${memberNo}" />
			<table class="table table-striped">
				<tr>
					<th>정모명</th>
					<td colspan="2"><input type="text" name="meetingName" /></td>
				</tr>
				<tr>
					<th>정모날짜</th>
					<!-- 캘린더 띄우기 -->
					<td colspan="2"><input type="date" name="meetingDay"></td>
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
				<!-- 이미지 받아오기 -->
				<tr>
					<th>정모 메인 이미지</th>
					<td colspan="2"><input type="file" name="meetingImg"/></td>
				</tr>
				<tr>
					<td colspan="4">
						<a class="btn btn-success" type="button" href="meeting?cmd=list">목록으로 돌아가기</a> 
						<input class="btn btn-primary" type="submit" value="정모 생성하기" /> 
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>