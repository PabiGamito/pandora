$(document).ready(function(){

// Makes all other dropdowns vanish
  function slideAllUp(obj)
  {
     $(".hideothers").each(function(){
       
       if ($(this)[0] != obj[0])
       {
         $(this).hide(); //perform on all except self.
       }
     })
  }

// Sets active tab (adds class to active tab)
  $('.sidebar-menu li').on('click', function () {

      $(this).siblings().removeClass('clicked');
      $(this).addClass('clicked');


  });
  

$(".hideothers").hide();

// Account dropdown
    $(".slidingDiv_account").hide();
    $(".show_hide_account").show();
    
    $(".show_hide_account").click(function(){
    slideAllUp($(".slidingDiv_account"));
    $(".slidingDiv_account").slideDown();
    });

// Company dropdown
    $(".slidingDiv_company").show();
    $(".show_hide_company").show();
    // $(".hideothers").hide();
    
    $(".show_hide_company").click(function(){
    slideAllUp($(".slidingDiv_company"));
    $(".slidingDiv_company").slideDown();
    });

// Invest dropdown
    $(".slidingDiv_invest").hide();
    $(".show_hide_invest").show();
    // $(".hideothers").hide();
    
    $(".show_hide_invest").click(function(){
    slideAllUp($(".slidingDiv_invest"));
    $(".slidingDiv_invest").slideDown();
    });

  });