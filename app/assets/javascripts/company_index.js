$(document).ready(function(){

// ---- UPGRADES DROPDOWN ---- //
    $(".upgrades_panel").hide();

    $(".show_hide_upgrades").click(function(){
    $(".upgrades_panel").slideToggle();
    }); 

    // $(".show_hide_upgrades").mouseover(
    //   function() {
    //     $(".upgrades_panel").slideDown();
    //   }, 
    //   function() {
    //     $(".upgrades_panel").slideUp();
    //   }
    // );
    
    // Progress Bar
    

// ---- EMPLOYE DROPDOWN ---- //
    $(".employes_panel").hide();
    
    $(".show_hide_employes").click(function(){
    $(".employes_panel").slideToggle();
    });

    // Employement request dropdown
    $(".employement_request_panel").hide();
    
    $(".show_hide_employement_request").click(function(){
    $(".employement_request_panel").slideToggle();
    });

    // Employe list dropdown
    $(".employes_list_panel").hide();;
    
    $(".show_hide_employes_list").click(function(){
    $(".employes_list_panel").slideToggle();
    });

// ---- STOCK DROPDOWN ---- //
    $(".stock_panel").hide();
    
    $(".show_hide_stocks").click(function(){
    $(".stock_panel").slideToggle();
    });

// ---- PROFIT AND LOSS DROPDOWN ---- //
    $(".profit_and_loss_panel").hide();

    $(".show_hide_profit_and_loss").click(function(){
    $(".profit_and_loss_panel").slideToggle();
    }); 

});