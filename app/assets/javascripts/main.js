$(document).ready(function(){
  // Sets active class for sidebar
  var path = window.location.pathname;
  var wSize = $(window).width();
  if(path.substr(path.length - 1) == "/"){
    path = path.substring(0, path.length - 1);
  }
  $("#sidebar a[href='" + path + "']").addClass("active");

// Count Timer
$('.timer').countTo();

if (wSize <= 768) {
  $('#sidebar').hide();
}

//    sidebars toggle
    $("#sidebar_toggle").click(function(){
      if ($("#sidebar").is(":visible")){
        $('#main-content').css({
          'margin-left': '0px'
        });
        $('#sidebar').css({
          'margin-left': '-210px'
        });
        $("#sidebar").hide();
        if (wSize <= 768) {
          $('#main-content').show();
          $("#sidebar").width("210px");
        }
      } else {
        $('#main-content').css({
          'margin-left': '210px'
        });
        $('#sidebar').css({
          'margin-left': '0'
        });
        $("#sidebar").show();
        if (wSize <= 768) {
          $("#sidebar").width("100%");
          $('#main-content').hide();
          $("#sidebar > li").addClass('center');
        }
      }
    });

// Toggle Items if using small screen
    $(function() {
        function responsiveView() {
            var wSize = $(window).width();
            if (wSize <= 768) {
                $('#main-content').css({
                  'margin-left': '0px'
                });
                $('#sidebar').css({
                  'margin-left': '-210px'
                });
                

                $('.force-hidden-xm').hide();
                $('.show-sm').show(); //Toggles logout icon in navbar
                $('nav').height("10px");
            }

            if (wSize > 768) {
                $('#main-content').css({
                  'margin-left': '210px'
                });
                $('#sidebar').css({
                  'margin-left': '0'
                });

                $('.force-hidden-sm').show();
                $('.show-sm').hide();
            }
        }
        $(window).on('load', responsiveView);
        $(window).on('resize', responsiveView);
    });

    // For scrolling text on navbar
    var marquee = $('div.marquee');
    marquee.each(function() {
        var mar = $(this),indent = mar.width();
        mar.marquee = function() {
            indent--;
            mar.css('text-indent',indent);
            if (indent < -1 * mar.children('div.marquee-text').width()) {
                indent = mar.width();
            }
        };
        mar.data('interval',setInterval(mar.marquee,1000/60));
    });

    // $('.fa-bars').on('click', function() {
    //     if ($('#sidebar').is(":visible") === true) {
    //         $('#main-content').css({
    //             'margin-left': '0px'
    //         });
    //         $('#sidebar').css({
    //             'margin-left': '-210px'
    //         });
    //         $('#sidebar > ul').hide();
    //         $("#container").addClass("sidebar-closed");
    //     } else {
    //         $('#main-content').css({
    //             'margin-left': '210px'
    //         });
    //         $('#sidebar > ul').show();
    //         $('#sidebar').css({
    //             'margin-left': '0'
    //         });
    //         $("#container").removeClass("sidebar-closed");
    //     }
    // });

// // Makes all other dropdowns vanish
//   // function slideAllUp(obj)
//   // {
//   //    $(".hideothers").each(function(){
       
//   //      if ($(this)[0] != obj[0])
//   //      {
//   //        $(this).hide(); //perform on all except self.
//   //      }
//   //    })
//   // }

// // // Sets active tab (adds class to active tab)
// //   $('.sidebar-menu li').on('click', function () {

// //       $(this).siblings().removeClass('clicked');
// //       $(this).addClass('clicked');


// //   });
  

// // $(".hideothers").hide();

// // // Account dropdown
// //     $(".slidingDiv_account").hide();
// //     $(".show_hide_account").show();
    
// //     $(".show_hide_account").click(function(){
// //     slideAllUp($(".slidingDiv_account"));
// //     $(".slidingDiv_account").slideDown();
// //     });

// // // Company dropdown
// //     $(".slidingDiv_company").show();
// //     $(".show_hide_company").show();
// //     // $(".hideothers").hide();
    
// //     $(".show_hide_company").click(function(){
// //     slideAllUp($(".slidingDiv_company"));
// //     $(".slidingDiv_company").slideDown();
// //     });

// // // Invest dropdown
// //     $(".slidingDiv_invest").hide();
// //     $(".show_hide_invest").show();
// //     // $(".hideothers").hide();
    
// //     $(".show_hide_invest").click(function(){
// //     slideAllUp($(".slidingDiv_invest"));
// //     $(".slidingDiv_invest").slideDown();
// //     });  

    // For Notifications
function closeMessage(el) {
  el.addClass('is-hidden');
}

$('.js-messageClose').on('click', function(e) {
  closeMessage($(this).closest('.Message'));
});

$('#js-helpMe').on('click', function(e) {
  alert('Help you we will, young padawan');
  closeMessage($(this).closest('.Message'));
});

$('#js-authMe').on('click', function(e) {
  alert('Okelidokeli, requesting data transfer.');
  closeMessage($(this).closest('.Message'));
});

$('#js-showMe').on('click', function(e) {
  alert("You're off to our help section. See you later!");
  closeMessage($(this).closest('.Message'));
});

  setTimeout(function() {
    closeMessage($('#js-timer'));
  }, 5000);

});


