<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeForm.jsp</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/meeting/writeForm.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
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
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<main>
    <h2 class="meeting-register">정모 등록</h2>
	<form id="writeForm" action="meetingUpload" method="post" enctype="multipart/form-data" class="meeting-form" >
		<!-- crewNo 받아오기 -->
		<input type="hidden" name="crewNo" value="${crewNo}" />
		
		<!-- 정모명 -->
		<label class="meeting-label">정모명</label>
		<div class="meeting-input">
			<input type="text" name="meetingName" id="meetingName" class="meeting-register__meetingName-input" placeholder="최대 25자" />
		</div>
		
		<!-- 날짜 -->
		<label class="meeting-label">날짜</label>
		<div class="meeting-input">
			<!-- 캘린더 -->
			<input type="date" name="meetingDate" id="meetingDate" class="meeting-register__meetingDate-input" >
		</div>
		
		<!-- 시간 -->
		<label class="meeting-label">시간</label>
		<div class="form-group">
			<div class="meeting-input">
				<input type="text" name="meetingTime1" id="meetingTime1" class="meeting-register__meetingTime1-input">
				<span>시</span> 
			</div>
			<div class="meeting-input">
				<input type="text" name="meetingTime2" id="meetingTime2" class="meeting-register__meetingTime2-input">
				<span>분</span>
			</div>
		</div>
		
		<!-- 위치 -->
		<label class="meeting-label">위치</label>
		<div class="meeting-input">
			<input type="text" name="meetingLoc" id="meetingLoc" class="meeting-register__meetingLoc-input" />
		</div>
		
		<!-- 비용 -->
		<label class="meeting-label">비용</label>
		<div class="meeting-input">
			<input type="text" name="meetingPrice" id="meetingPrice" class="meeting-register__meetingPrice-input" />
			<span>원</span>
		</div>
		
		<!--  정원 -->
		<label class="meeting-label">정원</label>
		<div class="meeting-input">
			<input type="text" name="meetingMax" id="meetingMax" class="meeting-register__meetingMax-input" />
			<span>명</span>
		</div>
		
		<!-- 이미지 -->
		<p>대표 이미지</p>
		<div class="image-upload meeting-image">
		  <label for="meetingImg" class="image-label">
		    <div class="image-preview" id="imagePreview">
		      <span class="plus-sign">+</span>
		    </div>
		  </label>
		  <input type="file" name="meetingImg" id="meetingImg" class="image-input" accept="image/*" />
		</div>
				
		<!-- <label class="meeting-label">이미지</label>
		<div class="meeting-input">
			<input type="file" name="meetingImg" id="meetingImg" class="meeting-register__meetingImg-input" />
		</div> -->
		
		<input class="register-button" type="submit" value="등록"/>
		 
	</form>
	</main>
	<jsp:include page="../component/footer.jsp"></jsp:include>
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

$(document).ready(function() {
	// 이미지 미리보기 및 삭제
    $('#meetingImg').change(function() {
        var reader = new FileReader();
        var file = this.files[0];
        var previewId = "imagePreview";
        var inputId = $(this).attr('id');
        if (file) {
            reader.onload = function(e) {
                var previewElement = $('#' + previewId);
                previewElement.empty(); // 기존 내용 삭제
                var imgElement = $('<img>').attr('src', e.target.result);
                previewElement.append(imgElement);
                var deleteButton = $('<button>').text('X').addClass('delete-button');
                previewElement.append(deleteButton);

                deleteButton.on('click', function(event) {
                    event.preventDefault(); // 기본 동작을 막음
                    var oldInput = $('#' + inputId);
                    // oldInput의 value를 비움으로써 선택된 파일을 제거
                    oldInput.val('');
                    // 이미지 미리보기 삭제
                    previewElement.empty().append('<span class="plus-sign">+</span>'); // 초기 상태로 복구
                });
            };
            reader.readAsDataURL(file);
        } else {
            $('#' + previewId).empty().append('<span class="plus-sign">+</span>');
        }
    });
});

</script>
</body>
</html>