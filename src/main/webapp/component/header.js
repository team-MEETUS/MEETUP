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