$(document).ready(function(){

$(".js-togglable_panel").hide();

$(".panel_dropdown").click(function(){
    $(this).siblings(".js-togglable_panel").toggle();
});


// ----- POPUPS ----- //
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

        $(".cd-popup-container").append( createMessage(message, postLink) );
        $(".cd-popup-container form").append("<input type='hidden' name='employee_id' value='" + employeeID + "'>");
    });

    $(".cd-popup-container").on('click', '.submit', function(event){
        $('form').submit();
        event.preventDefault(); //Cancel default behaviour of anchor
    });

    //Employement Ad
    $('.popup6').on('click', function() {

        var companyID = $(this).siblings('.js-company-id').text();

        $(".cd-popup-container").append(
        "<p><h3><b>Place Employement Ad</b></h3></p>" +
        "<form class='center' action='/employement-ad' method='post' accept-charset='utf-8' style='width: 75%;'>" +
        "<select name='category' class='form-control' required>" +
        "<option value='' disabled selected>Chose the Targetted Employee Category</option>" +
        "<option value='1'>1</option>" +
        "<option value='2'>2</option>" +
        "<option value='3'>3</option>" +
        "</select>" +
        "<input id='amount' class='form-control' type='number' step='1' min= '1' max='1000' name='amount' placeholder='Amount of Employees Wanted' required><br><br>" +
        "<b>Price:<b> <span id='price'>0</span>$ <br><br>" +
        "<input type='hidden' name='company_id' value='" + companyID + "'>" +
        "<button class='btn btn-primary' type='submit'>Place Ad</button><br><br>" +
        "</form>" +
        "<a class='cd-popup-close popup-close img-replace'>Close</a>");

        $(".cd-popup-container form").css("margin-top", "-50px");

    // Updates Price Live
        // grab the values from the form:
        var getPrice = function () {

        // get form values:
        var _employees = parseInt($('form > select').find(":selected").val(), 10);
        var _amount = parseInt($('form > #amount').val(), 10);

        // check values are defined:
        if (_employees && _amount) {
            return _amount * 250 * _employees;
        } else {
            // what you wish to show if nothing is selected, change to null if you want to hide the price:
            return 0;
        }
        };

        // bind events to update the price when something changes:
        $('form > select').on('change', function () {
            var _newPrice = getPrice();
            // update form price:
            if (_newPrice) $('#price').text(_newPrice);
        });

        $('form > #amount').on('change', function () {
            var _newPrice = getPrice();
            // update form price:
            if (_newPrice) $('#price').text(_newPrice);
        });

    });

    $(".cd-popup-container").on('click', '.submit', function(event){
        $('form').submit();
        event.preventDefault(); //Cancel default behaviour of anchor
    });

});