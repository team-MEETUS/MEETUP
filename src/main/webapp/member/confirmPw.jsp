<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css" type="text/css" />
<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/header.css" type="text/css" />
<link rel="stylesheet" href="./css/member/confirmPw.css" type="text/css" />
<!-- CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
    <div class="container">
        <jsp:include page="../component/header.jsp"></jsp:include>
        <script src="component/header.js"></script>
        <section class="confirmPw">
            <div class="confirmPw__box">
                <!-- Form -->
                <form id="memberForm" action="member" method="post">
                    <!-- 데이터입력 항목 -->
                    <div class="confirmPw__form-cnt">
                        <div class="confirmPw__input-box">
                            <label for="memberPw">비밀번호 확인</label>
                            <div class="confirmPw__input-group">
                                <input type="password" name="memberPw" id="memberPw" />
                                <button class="confirmPw__btn" type="submit">확인</button>
                            </div>
                            <input type="hidden" name="cmd" value="confirmPwOk" />
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <jsp:include page="../component/footer.jsp"></jsp:include>
    
    <script>
        $("#memberForm").submit(function(event) {
            var memberPw = $("input[name='memberPw']").val();
            
            if (!memberPw) {
                alert("비밀번호를 입력해주세요");
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
