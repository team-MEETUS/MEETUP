<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
	    // 폼 제출 이벤트를 처리합니다.
	    $('form').submit(function(e) {
	        e.preventDefault();

	        var confirmResult = confirm("정말 삭제하시겠습니까?");
	        
	        if (confirmResult) {
	            this.submit();
	        }
	        
	    });
	});
</script>
</head>
<body>
	<div>
		<form action="member" method="post">
			<table>
				<tr>
					<td>
						<a href="member?cmd=update">내 정보 수정</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<input type="hidden" name="memberNo" value="${MemberVO.memberNo}" />
						<input type="hidden" name="cmd" value="delete" />
						<input type="submit" value="회원탈퇴" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	
</body>
</html>