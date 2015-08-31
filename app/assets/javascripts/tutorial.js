$(document).ready(function(){
  $(".next").click(function(){
    $(".tutorial-box").hide();
  });

  // Disable all links  
  $('a').on('click', function(e) {
    if (!$(this).hasClass('allowedLink')) {
      e.preventDefault();
    }
  });

  // Changes Submits For Tutorial
  $('#new_company_form').attr('action', '/new-company-tutorial');

  $('.hide_in_tutorial').hide();
  $('#loan_from_bank_form').attr('action', '/new-loan-tutorial');
  $('#amount_input_loan_from_bank_form').attr('max', '25000');

});


// //  Inspired by Jonathan Moreira

// //  http://dribbble.com/shots/1216346-Guided-tour-tooltip

// // code by YoannHELIN http://yoannhelin.fr/

// $(document).ready(function () {
//   var nbP = $('.tutorial-box p').length;
//   var w = parseInt($('.tutorial-box p').css("width"));
//   var max = (nbP - 1) * w;
//   $("ul li[data-num='1']").addClass('active');
//   $('.step span').html('Step 1');
  
//   $('body').on('click','.btn', function(){
//     var margL = parseInt($('.slider-turn').css('margin-left'));
//     var modulo = margL%w;
//     if (-margL < max && modulo == 0) {
//       margL -= w;
   
//       $('.slider-turn').animate({
//         'margin-left':margL
//       },300);
//       $('ul li.active').addClass('true').removeClass('active');
//       var x = -margL/w +1;
//       $('ul li[data-num="'+x+'"]').addClass('active');
//       $('.step span').html("Step "+x);
//     }
//     else  {}
//   });
  
//   $('body').on('click','.close',function(){
//     $('.tutorial-box').animate({
//       'opacity':0
//     },600);
//     $('.tutorial-box').animate({
//       'top':-1200
//     }, {
//       duration: 2300,
//       queue: false
//     });
//     $('.open').animate({
//       'top':'50%'
//     });
//   });
  
//   $('body').on('click','.open',function() {
//     $('.open').animate({
//       'top':-1000
//     });
//     $('.tutorial-box').animate({
//       'opacity':1
//     },400);
//     $('.tutorial-box').animate({
//       'top':'50%'
//     }, {
//       duration: 800,
//       queue: false
//     });
//   });
// });