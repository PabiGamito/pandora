$(document).ready(function(){
// ---- UPGRADES DROPDOWN ---- //
    $(".upgrades_panel").hide();

    $(".show_hide_upgrades").click(function(){
    $(".upgrades_panel").slideToggle();
    }); 
    

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

// Live Progress Bar

    $(function() {
        i = 0;
        var myInterval = setInterval(function() {
            $(".progress-bar").attr("aria-valuenow",i);
            $(".progress-bar").width(i + '%');
            $("#timeleft").html((100-i) + "s");
            if (i == 100) {
                $(".progress").hide();
                $("#timeleft").html("Upgrade Name Complete!");
                clearInterval(myInterval);
            }
            i++;
        }     
        ,1000);
    });

// POPUPS
    //open popup
    $('.cd-popup-trigger').on('click', function(event){
        event.preventDefault();
        $('.cd-popup').addClass('is-visible');
    });
    
    //close popup
    $('.cd-popup').on('click', function(event){
        if( $(event.target).is('.popup-close') || $(event.target).is('.cd-popup') ) {
            event.preventDefault();
            $(this).removeClass('is-visible');
        }
    });
    //close popup when clicking the esc keyboard button
    $(document).keyup(function(event){
        if(event.which=='27'){
            $('.cd-popup').removeClass('is-visible');
        }
    });

    //POPUP Content
    //Accept Employement Request
    $("#popup1").click(function(){
        $(".cd-popup-container").prepend(
        "<p>Are you sure you want to decline this employement request?</p>
        <form id="accept_employe" action="/accept_employe" method="post" accept-charset="utf-8">
            <ul class="cd-buttons no_margin">
                <li><a href="javascript:{}" onclick="document.getElementById('accept_employe').submit();">Yes</a></li>
                <li><a class="popup-close">No</a></li>
            </ul>
        </form>"
        );
    });

    //Decline Employement Request
    $("#popup2").click(function(){
        $(".cd-popup-container").prepend(
        "<p>Are you sure you want to discharge this employe?</p>
        <form id="accept_employe" action="/accept_employe" method="post" accept-charset="utf-8">
            <ul class="cd-buttons no_margin">
                <li><a href="javascript:{}" onclick="document.getElementById('accept_employe').submit();">Yes</a></li>
                <li><a class="popup-close">No</a></li>
            </ul>
        </form>"
        );
    });

    //Give a Raise to Employe
    $("#popup2").click(function(){
        $(".cd-popup-container").prepend(
        "<p>Are you sure you want to discharge this employe?</p>
        <form id="accept_employe" action="/accept_employe" method="post" accept-charset="utf-8">
            <ul class="cd-buttons no_margin">
                <li><a href="javascript:{}" onclick="document.getElementById('accept_employe').submit();">Yes</a></li>
                <li><a class="popup-close">No</a></li>
            </ul>
        </form>"
        );
    });

});