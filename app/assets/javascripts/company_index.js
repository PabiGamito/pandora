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
            $('.cd-popup-container').empty();
        }
    });
    //close popup when clicking the esc keyboard button
    $(document).keyup(function(event){
        if(event.which=='27'){
            $('.cd-popup').removeClass('is-visible');
            $('.cd-popup-container').empty();
        }
    });


    // Popup Content
    var popupContent = ''
    function createMessage(msg,pl) {
        return [
            "<p>" + msg + "</p>",
            "<form action='" + pl + "' method='post' accept-charset='utf-8'>",
                "<ul class='cd-buttons no_margin'>",
                    "<li><a class='submit'>Yes</a></li>",
                    "<li><a class='popup-close'>No</a></li>",
                "</ul>",
            "</form>",
            "<a class='cd-popup-close popup-close img-replace'>Close</a>"
        ].join('');
    }

    //Accept Employement Request
    $('.popup1').on('click', function() {
        var employeeName = $(this).siblings('.js-employee-name').text();
        var employeeID = $(this).siblings('.js-employee-id').text();
        var message = "Are you sure you want to hire <b>" + employeeName + "</b>?"
        var postLink = "/hire-employee"
        
        createMessage();

        $(".cd-popup-container").append( createMessage(message, postLink) );
        $(".cd-popup-container form").append("<input type='hidden' name='employee_id' value='" + employeeID + "'>");
    });

    $(".cd-popup-container").on('click', '.submit', function(event){
        $('form').submit();
        event.preventDefault(); //Cancel default behaviour of anchor
    });

    //Decline Employement Request
    $('.popup2').on('click', function() {
        var employeeName = $(this).siblings('.js-employee-name').text();
        var employeeID = $(this).siblings('.js-employee-id').text();
        var message = "Are you sure you want to decline <b>" + employeeName + "'s</b> employement request?<br><br>This can not be undone."
        var postLink = "/decline-employee"
        
        createMessage();

        $(".cd-popup-container").append( createMessage(message, postLink) );
        $(".cd-popup-container form").append("<input type='hidden' name='employee_id' value='" + employeeID + "'>");
    });

    $(".cd-popup-container").on('click', '.submit', function(event){
        $('form').submit();
        event.preventDefault(); //Cancel default behaviour of anchor
    });

    //Give a Raise to Employe
    $(".popup3").click(function(){
        $(".cd-popup-container").prepend();
    });

    //Give a Pay Cut to Employe
    $(".popup4").click(function(){
        $(".cd-popup-container").prepend();
    });

    //Fire Employe
    $('.popup5').on('click', function() {
        var employeeName = $(this).siblings('.js-employee-name').text();
        var employeeID = $(this).siblings('.js-employee-id').text();
        var message = "Are you sure you want to fire <b>" + employeeName + "</b>?<br><br>This can not be undone."
        var postLink = "/fire-employee"
        
        createMessage();

        $(".cd-popup-container").append( createMessage(message, postLink) );
        $(".cd-popup-container form").append("<input type='hidden' name='employee_id' value='" + employeeID + "'>");
    });

    $(".cd-popup-container").on('click', '.submit', function(event){
        $('form').submit();
        event.preventDefault(); //Cancel default behaviour of anchor
    });

});