// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_nested_form
//= require_tree .


$(document).ready(function() {
	$(".dropdown-button").dropdown({belowOrigin:true});
	$('select').material_select();

	$('.carousel.carousel-slider').carousel({fullWidth: true, padding:200},setTimeout(autoplay, 4500));

	function autoplay() {
		$('.carousel').carousel('next');
		setTimeout(autoplay, 4500);
	}


	// Initialize collapse button
	$(".button-collapse").sideNav();
	// Initialize collapsible (uncomment the line below if you use the dropdown variation)
  	//$('.collapsible').collapsible();
        
});


// Datepicker code
$(function() {
  $(".datepicker").datepicker({
    format: 'mm/dd/YYYY'
  });
});

      