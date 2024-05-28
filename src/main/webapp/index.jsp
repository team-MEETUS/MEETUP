<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>MEETUP</title>
<!-- CSS -->
<link rel="stylesheet" href="./css/reset.css"  type="text/css" />
<link rel="stylesheet" href="./css/index.css"  type="text/css" />
<link rel="stylesheet" href="./css/swiper.css" type="text/css" />
<!-- SWIPER -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<!-- CDN -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->
<script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</head>
<body>
<div class="container">
  <jsp:include page="component/header.jsp"></jsp:include>
    <div class="swiper">
      <div class="swiper-wrapper">
        <div class="swiper-slide">
          <img src="https://placehold.co/600x400" />
        </div>
        <div class="swiper-slide">
          <img src="https://placehold.co/500x300" />
        </div>
        <div class="swiper-slide">
          <img src="https://placehold.co/400x400" />
        </div>
      </div>
      <div class="swiper-pagination"></div>
    </div>
</div>
<jsp:include page="component/footer.jsp"></jsp:include>
</body>
<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const profile = document.querySelector(".header-profile");
	    const dropdownMenu = document.querySelector(".dropdown-menu");
	    profile.addEventListener("click", function (event) {
	      event.stopPropagation();
	      dropdownMenu.style.display =
	        dropdownMenu.style.display === "block" ? "none" : "block";
	    });
	    document.addEventListener("click", function () {
	      if (dropdownMenu.style.display === "block") {
	        dropdownMenu.style.display = "none";
	      }
	    });
	  });

  const swiper = new Swiper(".swiper", {
    // Optional parameters
    direction: "horizontal",
    loop: true,

    // If we need pagination
    pagination: {
      el: ".swiper-pagination",
    },
  });
</script>
</html>