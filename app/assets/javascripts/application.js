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
//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require materialize-form
//= require vue
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require_tree .

//= require chartkick

// @import "materialize";
// @import "https://fonts.googleapis.com/icon?family=Material+Icons";

// Sticky footer js
// Thanks to Charles Smith for this -- http://foundation.zurb.com/forum/posts/629-sticky-footer
$(window).bind("load", function () {
  var footer = $("#footer");
  var pos = footer.position();
  var height = $(window).height();
  height = height - pos.top;
  height = height - footer.height();
  if (height > 0) {
      footer.css({
          'margin-top': height + 'px'
      });
  }
});

// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3700).fadeOut();
   });
});

// Carousel function
$(document).ready(function(){
  $('.carousel').carousel();
});

// Best in place functionality
$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
  var hash = window.location.hash;
  if (hash == "#refresh") {
    $( "#crimeAlert" ).removeClass( "hide" )
  }
});

// Search submit on enter
$(document).ready(function() {
  function submitForm() {
    document.getElementById("search").submit();
  }
  document.onkeydown = function () {
    if (window.event.keyCode == '13') {
        submitForm();
    }
  }
});


// Or with jQuery
$('.dropdown-trigger').dropdown();

// Tooltip
$(document).ready(function(){
  $('.tooltipped').tooltip();
});


// Toggle Crime
$('.crimeStatus').click(function(){
  window.location =   window.location.href.replace(window.location.hash,"") + "#refresh";
  window.location.reload();
});

// Toggle Crime
$('.unitStatus').click(function(){
  window.location =   window.location.href.replace(window.location.hash,"") + "#refresh";
  window.location.reload();
});

// Toggle Crime
$('.officerStatus').click(function(){
  window.location =   window.location.href.replace(window.location.hash,"") + "#refresh";
  window.location.reload();
});

