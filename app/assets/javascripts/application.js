// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require_tree ../../../vendor/assets/javascripts

$(window).load(function() {
	$('#slider').nivoSlider({
		effect : 'fade', // Specify sets like: 'fold,fade,sliceDown'
		pauseTime : 3000, // How long each slide will show
		startSlide : 0, // Set starting Slide (0 index)
		directionNav : true, // Next & Prev navigation
		controlNav : true, // 1,2,3... navigation
		controlNavThumbs : false, // Use thumbnails for Control Nav
		pauseOnHover : true, // Stop animation while hovering
		manualAdvance : false, // Force manual transitions
		prevText : 'Prev', // Prev directionNav text
		nextText : 'Next', // Next directionNav text
		randomStart : false, // Start on a random slide
	});
});
