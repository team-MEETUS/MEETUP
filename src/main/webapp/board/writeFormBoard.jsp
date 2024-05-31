<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeFormBoard.jsp</title>
<!-- include libraries(jQuery, bootstrap) -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/board/writeFormBoard.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>

<script>    
   $(document).ready(function() {            
        $('.summernote').summernote({
            height: 300,
			lang:"ko-KR",
			width: 1024, 
			callbacks: {
	            onImageUpload: function(files) {
	                for (let i = 0; i < files.length; i++) {
	                    uploadImage(files[i]);
	                }
	            }
	        }
        });
    });
   
   function uploadImage(file) {
	    const data = new FormData();
	    data.append("file", file);

	    $.ajax({
	        url: 'imageUpload',
	        type: 'POST',
	        data: data,
	        contentType: false,
	        processData: false,
	        dataType: 'json', // 이 부분을 추가하면, jQuery가 응답을 자동으로 JSON으로 파싱합니다.
	        success: function(response) {
	            // JSON.parse() 호출을 제거하고, response 객체를 직접 사용합니다.
	            const url = response.url;
	            $('.summernote').summernote('insertImage', url);
	        },
	        error: function() {
	            alert("이미지 업로드 실패!");
	        }
	    });
	}
</script>
</head>
<body>
<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
	<main>
    <h2 class="board-register">게시글 작성</h2>
	<form action="boardWrite" method="post" enctype="multipart/form-data" class="board-form" >
		<input type="hidden" name="crewNo" value="${crewNo}" /> 
		<input type="hidden" name="memberNo" value="${memberNo}" />
		
		<label class="category-label">카테고리</label>
      	<div class="board-input">	
			<c:if test="${crewMemberVO.crewMemberStatus == 2 || crewMemberVO.crewMemberStatus == 3}">
				<input class="category-btn" type="button"
				name="boardCategoryNo" value="공지사항" data-category-no="1"
				onclick="selectCategory(1)">
			</c:if> 
			<input class="category-btn" type="button" name="boardCategoryNo1" value="가입인사" data-category-no="2"	onclick="selectCategory(2)"> 
			<input class="category-btn" type="button" name="boardCategoryNo2" value="정모후기" data-category-no="3" onclick="selectCategory(3)"> 
			<input class="category-btn" type="button" name="boardCategoryNo3" value="자유" data-category-no="4" onclick="selectCategory(4)"> 
			<input class="category-btn" type="button" name="boardCategoryNo4" value="투표" data-category-no="5" onclick="selectCategory(5)"> 
			<input type="hidden" name="boardCategoryNo" id="selectedCategoryNo" value="" />
		</div>
		
		<label class="category-label">제목</label>
      	<div class="board-input">	
			<input type="text" name="boardTitle" id="boardTitle" class="board-register__boardName-input" />
		</div>
		
		<label class="category-label">내용</label>
        <div class="board-input">
			<textarea class="summernote" name="boardContent" id="" cols="30" rows="10"></textarea>
		</div>
		
		<input class="register-button" type="submit" value="등록" />
		
	</form>
	</main>
	<jsp:include page="../component/footer.jsp"></jsp:include>
</div>
</body>
<script>
    const categoryBtns = document.querySelectorAll('.category-btn');
    const selectedCategoryNoInput = document.getElementById('selectedCategoryNo');

    categoryBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const categoryNo = btn.dataset.categoryNo;
            selectedCategoryNoInput.value = categoryNo;
        });
    });
</script>
</html>