<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeFormBoard.jsp</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- <link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript" src="../js/summernote-ko-KR.js"></script> -->
<!-- <script>
	$(document).ready(function() {
		$(".summernote").summernote({
			height : 150,
			lang : "ko-KR",
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {
					for (var i = files.length - 1; i >= 0; i--) {
						sendFile(files[i], editor);
					}
				}
			}
		});
	});

	function sendFile(file, editor) {
		var form_data = new FormData();
		form_data.append("file", file);

		$.ajax({
			data : form_data,
			type : "POST",
			url : "/boardImgSaveImgImg",
			cache : false,
			dataType : "JSON",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				// 이미지 업로드 성공 시 Summernote에 이미지 삽입
				$(editor).summernote("insertImage", data.url, data.originName);

				// 이미지 파일명을 옵션으로 추가
				$("#thumbnailPath").append(
						"<option value=" + data.url + ">"
								+ data.boardImgOriginalImg + "</option>");
			}
		});
	}
</script> -->

<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th {
	display: block;
	text-align: left;
}

td {
	display: block;
	width: 100%;
}

td .btn {
	display: inline-block;
	margin-right: 10px;
}

.button-container {
	width: 100%;
	text-align: right;
}

.button-container .btn {
	width: 100%;
}

.input-container {
	width: 100%;
}

.input-container input {
	width: 100%;
}
</style>
</head>
<body>
	<h1>게시글 작성</h1>

	<div class="container">
		<form action="board?cmd=writeOkBoard" method="post">
			<input type="hidden" name="crewNo" value="${crewNo}" />
			<input type="hidden" name="memberNo" value="${memberNo}" />
			<table class="table table-nonbordered">
				<tr>
				
					<th>카테고리</th>
						<td>
							<c:if test="${crewMemberVO.crewMemberStatus == 2 || crewMemberVO.crewMemberStatus == 3}">
							<input class="btn btn-success category-btn" type="button" name="boardCategoryName1" value="공지사항" data-category-no="1">
							</c:if>
			                <input class="btn btn-success category-btn" type="button" name="boardCategoryName2" value="가입인사" data-category-no="2">
			                <input class="btn btn-success category-btn" type="button" name="boardCategoryName3" value="정모후기" data-category-no="3">
			                <input class="btn btn-success category-btn" type="button" name="boardCategoryName4" value="자유" data-category-no="4">
			                <input class="btn btn-success category-btn" type="button" name="boardCategoryName5" value="투표" data-category-no="5">
			                <input type="hidden" name="boardCategoryNo" id="selectedCategoryNo" value="" />
						</td>

					<th>제목</th>
						<td class="input-container"><input type="text" name="boardTitle" /></td>
					</tr>

				<tr>
					<th>내용</th>
						<td><textarea name="boardContent" id="" cols="30" rows="10"></textarea></td>
				</tr>
				<tr>
					<td class="button-container">
					<input class="btn btn-primary" type="submit" value="등록" /></td>
				</tr>
			</table>
		</form>
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