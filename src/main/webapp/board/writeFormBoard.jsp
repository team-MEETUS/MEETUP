<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript" src="../js/summernote-ko-KR.js"></script>
<script>
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
			url : "/boardImgSaveImg",
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
						"<option value=" + data.url + ">" + data.boardImgOriginalImg + "</option>");
			}
		});
	}
</script>

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
<!-- jsp - action - xml -->
</head>
<body>
	<div class="container">
		<form action="board" method="post" enctype="multipart/form-data">
			<input type="hidden" name="cmd" value="writeOkBoard" />
			<table class="table table-nonbordered">

				<tr>
					<h3>게시글 등록</h3>

					<th>카테고리</th>
					<td><input class="btn btn-success" type="button"
						name="boardCategoryName" value="공지사항" />
						<input class="btn btn-success" type="button" name="boardCategoryName" value="가입인사" />
						<input class="btn btn-success" type="button" name="boardCategoryName" value="정모후기" />
						<input class="btn btn-success" type="button" name="boardCategoryName" value="자유" /></td>
				</tr>

				<th>제목</th>
					<th class="input-container">
					<input type="text" name="boardTitle" /></th>
				</tr>


				<tr>
					<th>설명</th>
					<td><textarea class="summernote" name="boardContent" id="" cols="30" rows="10"></textarea></td>
				</tr>
				<tr>
					<td class="button-container">
					<input class="btn btn-primary" type="submit" value="등록" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>