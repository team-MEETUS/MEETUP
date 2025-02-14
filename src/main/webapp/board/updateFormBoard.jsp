<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateFormBoard.jsp</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/board/updatdFormBoard.css" type="text/css" />
<!-- CDN -->
<script src="component/header.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>

<!-- include summernote css/js -->
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<script>    
   $(document).ready(function() {            
        $('.summernote').summernote({
            height: 150,
			lang:"ko-KR"
        });
    });
   </script>
	<!-- CSS -->
	<link rel="stylesheet" href="./css/reset.css" type="text/css" />
	<link rel="stylesheet" href="./css/index.css" type="text/css" />
	<link rel="stylesheet" href="./css/header.css" type="text/css" />
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
	<h1>게시글 수정</h1>

	<div class="container">
	<jsp:include page="../component/header.jsp"></jsp:include>
    <script src="component/header.js"></script>
		<form action="boardUpdate" method="post" enctype="multipart/form-data">
			<input type="text" name="crewNo" value="${crewNo}" /> <input
				type="hidden" name="boardNo" value="${boardNo}" /> <input
				type="hidden" name="memberNo" value="${memberNo}" />
			<table class="table table-striped">
				<tr>
					<th>카테고리</th>
					<td><c:if
							test="${crewMemberVO.crewMemberStatus == 2 || crewMemberVO.crewMemberStatus == 3}">
							<input class="btn btn-success category-btn" type="button" 
								   name="boardCategoryNo" value="공지사항" data-category-no="1"
								onclick="selectCategory(1)">
						</c:if> <input class="btn btn-success category-btn" type="button"
								name="boardCategoryNo1" value="가입인사" data-category-no="2"
								onclick="selectCategory(2)">
								<input class="btn btn-success category-btn" type="button"
								name="boardCategoryNo2" value="정모후기" data-category-no="3"
								onclick="selectCategory(3)">
								<input class="btn btn-success category-btn" type="button"
								name="boardCategoryNo3" value="자유" data-category-no="4"
								onclick="selectCategory(4)">
								<input class="btn btn-success category-btn" type="button"
								name="boardCategoryNo4" value="투표" data-category-no="5"
								onclick="selectCategory(5)">
								<input type="hidden" name="boardCategoryNo" id="selectedCategoryNo" value="" /></td>

					<th>제목</th>
					<td class="input-container"><input type="text"
						name="boardTitle" /></td>
				</tr>

				<tr>
					<th>내용</th>
					<td><textarea class="summernote" name="boardContent" id=""
							cols="30" rows="10"></textarea></td>
				</tr>


				<tr>
					<td colspan="6"><a href="board?cmd=listBoard&crewNo=${crewNo}"
						class="btn btn-primary">목록</a> <c:if
							test="${loginMember.memberNo == vo.memberNo}">
							<button type="submit">수정</button>
						</c:if> <c:if test="${loginMember.memberNo == vo.memberNo}">
							<button type="button" class="btn btn-danger"
								onclick="deleteBoard(${vo.boardNo})">삭제</button>
						</c:if></td>
				</tr>
			</table>
		</form>
	</div>
</body>
<script>  
   function boardUpdate(crewNo) {
	   location.href = "board?cmd=boardUpdate&bno=${vo.boardNo}&crewNo=${vo.crewNo}";
	 }
</script>
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
<script>

	function deleteBoard(button){
		if (confirm("삭제하시겠습니까?")){
			window.location.href = 'board?cmd=deleteBoard&bno=${vo.boardNo}';
		}
	}

</script>
</html>