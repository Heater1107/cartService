// header_category.js

document.addEventListener("DOMContentLoaded", function () {
  const menuItems = document.querySelectorAll(".menuInner > li");

  menuItems.forEach(function (item) {
    const depth2 = item.querySelector(".depth2");

    item.addEventListener("mouseenter", function () {
      if (depth2) {
        depth2.style.display = "block";
      }
    });

    item.addEventListener("mouseleave", function () {
      if (depth2) {
        depth2.style.display = "none";
      }
    });
  });
});