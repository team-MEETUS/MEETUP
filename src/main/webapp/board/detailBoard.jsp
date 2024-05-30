<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<fmt:setLocale value="ko_KR" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listBoard.jsp</title>

<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/board/detailBoard.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
    <div class="container">
        <jsp:include page="../component/header.jsp"></jsp:include>
        <script src="component/header.js"></script>

        <input type="hidden" name="loginMemberNo" id="loginMemberNo"
            value="${loginMember.memberNo}" />
        <script>
            var crewMemberList = [];
            <c:forEach var="CrewMember" items="${crewMemberList}">
                crewMemberList.push("${CrewMember.memberNo}");
            </c:forEach>
        </script>

        <!-- 메뉴 -->
        <ul class="crew-menu__items">
            <li><a href="crew?cmd=detail&crewNo=${crewNo}">정보</a></li>
            <li><a href="board?cmd=listBoard&crewNo=${crewVO.crewNo}">게시판</a></li>
            <li><a href="">사진첩</a></li>
            <li><a href="">채팅</a></li>
        </ul>

        <section class="board-main">
            <!-- 게시글 본문 -->
            <div class="board-titleSection">
                <div class="board--Title">${BoardVO.boardTitle}</div>
                <div class="board--memberNickname">${memberList[status.index].memberNickname}</div>
                <div class="board-label">카테고리</div>
                <c:choose>
                    <c:when test="${vo.boardCategoryNo == 1}">공지사항</c:when>
                    <c:when test="${vo.boardCategoryNo == 2}">가입인사</c:when>
                    <c:when test="${vo.boardCategoryNo == 3}">정모후기</c:when>
                    <c:when test="${vo.boardCategoryNo == 4}">자유</c:when>
                    <c:when test="${vo.boardCategoryNo == 5}">투표</c:when>
                    <c:otherwise>${vo.boardCategoryNo}</c:otherwise>
                </c:choose>
                <span class="board-date">
                    <fmt:formatDate value="${BoardVO.createdAt}" pattern="yyyy년 MM월 dd일" /></span>
                <span class="board-time">
                    <fmt:formatDate value="${BoardVO.createdAt}" pattern="HH시 mm분 ss초" /></span>
                <div class="board-hit">
                    <box-icon name='show'></box-icon>
                    ${BoardVO.boardHit}
                </div>
            </div>

            <div class="board-Content">${BoardVO.boardContent}</div>

            <!-- 게시글 목록/수정/삭제 버튼 -->
            <div class="board-listBoard">
                <a href="board?cmd=listBoard&crewNo=${crewNo}">목록</a>
            </div>

            <div class="board-updateBoard">
                <c:if test="${loginMember.memberNo == vo.memberNo}">
                    <!-- 수정 버튼 -->
                    <a href="board?cmd=updateBoard&bno=${vo.boardNo}&crewNo=${crewNo}">수정</a>

                    <!-- 삭제 버튼 -->
                    <form action="board?cmd=deleteBoard" method="post" class="deleteBoard" style="display: inline;">
                        <input type="hidden" name="boardNo" value="${vo.boardNo}" />
                        <input type="hidden" name="crewNo" value="${vo.crewNo}" />
                        <input type="hidden" name="memberNo" value="${vo.memberNo}" />
                        <button type="submit" class="btn btn-danger">삭제</button>
                    </form>
                </c:if>
            </div>
        </section>

        <!-- 댓글 목록 -->
        <div class="comment-section">
            <h3>댓글 목록</h3>
            <c:forEach var="comment" items="${commentList}" varStatus="status">
                <div class="comment-card">
                    <div class="comment-body">
                        <h5 class="comment-author">${commentAuthorMap[comment.boardCommentNo].memberNickname}</h5>
                        <h6 class="comment-date">${comment.createdAt}</h6>
                        <p class="comment-text" id="commentContent-${comment.boardCommentNo}">${comment.boardCommentContent}</p>
                        <form id="editForm-${comment.boardCommentNo}" action="board?cmd=updateComment" method="post" style="display: none;">
                            <input type="hidden" name="boardNo" value="${vo.boardNo}">
                            <input type="hidden" name="crewNo" value="${vo.crewNo}">
                            <input type="hidden" name="boardCommentNo" value="${comment.boardCommentNo}">
                            <div class="form-group">
                                <textarea name="boardCommentContent" rows="3" required>${comment.boardCommentContent}</textarea>
                            </div>
                            <button type="submit">수정 완료</button>
                        </form>
                        <c:if test="${writerList[status.index].memberNo == loginMember.memberNo}">
                            <input type="hidden" name="boardNo" value="${vo.boardNo}">
                            <input type="hidden" name="crewNo" value="${vo.crewNo}">
                            <input type="hidden" name="boardCommentNo" value="${comment.boardCommentNo}">
                            <button type="button" onclick="showEditForm(${comment.boardCommentNo})">수정</button>
                            <form action="board?cmd=deleteComment" method="post" class="deleteComment" style="display: inline;">
                                <input type="hidden" name="boardNo" value="${vo.boardNo}">
                                <input type="hidden" name="crewNo" value="${vo.crewNo}">
                                <input type="hidden" name="boardCommentNo" value="${comment.boardCommentNo}">
                                <button type="submit">삭제</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 댓글 쓰기 -->
        <div class="board-commentWrite">
            <form action="board?cmd=addComment" method="post">
                <input type="hidden" name="boardNo" value="${vo.boardNo}">
                <input type="hidden" name="crewNo" value="${vo.crewNo}">
                <input type="hidden" name="loginMemberNo" id="loginMemberNo" value="${loginMember.memberNo}" />
                <div class="board-commentContent">
                    <textarea name="boardCommentContent" rows="3" required></textarea>
                </div>

                <button type="submit">댓글 달기</button>
            </form>
        </div>

        <script>
            $(document).ready(function() {
                $('.deleteBoard').submit(function(e) {
                    e.preventDefault();
                    if (confirm("정말 삭제하시겠습니까?")) {
                        this.submit();
                    }
                });
                $('.deleteComment').submit(function(e) {
                    e.preventDefault();
                    if (confirm("정말 삭제하시겠습니까?")) {
                        this.submit();
                    }
                });
            });

            function showEditForm(commentId) {
                $('#editForm-' + commentId).show();
                $('#commentContent-' + commentId).hide();
            }
        </script>
    </div>
    <jsp:include page="../component/footer.jsp"></jsp:include>
</body>
</html>
