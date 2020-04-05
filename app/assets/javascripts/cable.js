// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);

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
