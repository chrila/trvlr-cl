// hide navbar when scrolling down and show it when scrolling up
let prevScrollpos = window.pageYOffset;

window.onscroll = function () {
  let currentScrollPos = window.pageYOffset
  let navbar = document.getElementById("navbar")
  if (prevScrollpos > currentScrollPos) {
    navbar.style.top = "0"
  } else {
    navbar.style.top = navbar.clientHeight * (-1) + "px"
  }
  prevScrollpos = currentScrollPos
}
