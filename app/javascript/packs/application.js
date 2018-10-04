/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

function addImage() {
  const newImage = document.querySelector(".preloader");
  newImage.classList.add("preloader-hidden");
}

function hideLoader() {
  const newImage = document.querySelector(".preloader-barinomi");
  newImage.classList.add("preloader-hidden");
}

setTimeout(addImage, 3000);

document.querySelector(".logo-wording").addEventListener("mouseenter", (event) => {
      document.querySelector(".logo-wording").classList.add("transform-active");
    });
document.querySelector(".logo-wording").addEventListener("mouseleave", (event) => {
      document.querySelector(".logo-wording").classList.remove("transform-active");
    });

document.getElementById("launch-engine").addEventListener("click", (event) => {
  document.querySelectorAll(".response-api").forEach((element) => { element.classList.toggle("response-api");
  })
  document.querySelector(".preloader-barinomi").classList.remove("preloader-hidden");
  setTimeout(hideLoader, 2000);
  document.querySelector(".description-base").classList.add("preloader-hidden");
});

$(document).ready(function() {
    $("body").tooltip({ selector: '[data-toggle=tooltip]' });
});
