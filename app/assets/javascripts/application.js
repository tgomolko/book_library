// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require activestorage
//= require jquery
//= require control
//= require_tree .

$(document).ready (function () {
   $(document).on("mouseenter", ".dropdown", function(){
    $(this).toggleClass("is-active");
  });
});

$(document).ready (function () {
   $(document).on("mouseleave", ".dropdown", function(){
    $(this).toggleClass("is-active");
  });
});

$(document).ready(function() {
  $(".navbar-burger").click(function() {
    $(".navbar-burger").toggleClass("is-active");
    $(".navbar-menu").toggleClass("is-active");
  });
});

$(document).ready(function() {
  $("#add").click(function() {
    $("#add-card").toggleClass("active");
  });
});

$(document).ready (function () {
   $(document).on("click", "#del", function(){
    $(".modal").toggleClass("is-active");
  });
});

$(document).ready (function () {
   $(document).on("click", ".modal-background", function(){
    $(".modal").toggleClass("is-active");
  });
});

$(document).ready(function () {
  $(document).keydown(function(e){
    if(e.keyCode == 27) {
      $(".modal").toggleClass("is-active");
    }
  });
});
