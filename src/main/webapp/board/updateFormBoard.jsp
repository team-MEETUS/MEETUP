<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateFormBoard</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script type="text/javascript" src="../js/summernote-ko-KR.js"></script>
<script>
	$(function() {
		$(".summernote").summernote({
			height:150,
			lang:"ko-KR"
		});
	})
</script>
</head>
<body>
	 <div class="container">
	 	<form action="board" method="get">
	 		<table class="table table-striped">
	 			<tr>
	 				<th>작성자</th>
	 				<th>
	 					<input type="hidden" name="cmd" value="updateOkBoard" />
	 					<input type="hidden" name="boardNo" value="${vo.boardNo}" />
	 				</th>
	 			</tr>
	 			<tr>
	 				<th>제목</th>
	 				<th><input type="text" name="boardTitle" value="${vo.boardTitle}" /></th>
	 			</tr>
	 			<tr>
	 				<th>내용</th>
	 				<td><textarea class="summernote" name="boardContent" id="" cols="30" rows="10" >${vo.boardContent}</textarea></td>
	 			</tr>
	 			<tr>
	 				<td colspan="2">
	 					<a href="board" class="btn btn-success">목록</a>
	 					<input class="btn btn-primary" type="submit" value="수정" />
	 					<input class="btn btn-danger" type="reset" value="초기화" />
	 				</td>
	 			</tr>
	 		</table>
	 	</form>
	 </div>
</body>
</html>