$(document).ready(function() {

// Count Timer
$('.timer').countTo();

$(function() {
    $('.banner').unslider({
    speed: 500,               //  The speed to animate each slide (in milliseconds)
    delay: 5000,              //  The delay between slide animations (in milliseconds)
    complete: function() {},  //  A function that gets called after every slide animation
    keys: true,               //  Enable keyboard (left, right) arrow shortcuts
    dots: true,               //  Display dot navigation
    fluid: false              //  Support responsive design. May break non-responsive designs
    });
});

// Toggle Items if using small screen
    $(function() {
        function responsiveView() {
            var wSize = $(window).width();
            if (wSize <= 768) {
                $('.banner').hide();
                $('.sm-active').show();
            }

            if (wSize > 768) {
                $('.banner').show();
                $('.sm-active').hide();
            }
        }
        $(window).on('load', responsiveView);
        $(window).on('resize', responsiveView);
    });
 
});