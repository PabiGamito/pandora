$(document).ready(function(){
    
// PANEL DROPDOWN //
    $(".togglable_panel").hide();

    $(".panel_dropdown").click(function(){
        if ($(this).siblings(".togglable_panel").is(":visible")) {
            $(this).siblings(".togglable_panel").fadeOut();
        } else { 
            var company_id=$(this).children(".company_id").val()
            var render=$(this).children(".panel-title").children(".js-panel-name").text()
            $(this).siblings(".togglable_panel").text("Loading...");
            // Update the buy and Sell Requests.
            $.ajax({
                type: 'GET',
                url: '/load-dropdown',
                dataType: 'script',
                data: { 'render' : render, 'company_id' : company_id }
                // beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
            });
            $(this).siblings(".togglable_panel").show();
        };
    });

// Companies Dropdown
    $(".js-company_dropdown").siblings(".togglable_panel").show();
    $(".js-company_dropdown").click(function(){
        $(this).siblings(".togglable_panel").slideToggle();
    });

// Sector Dropdown
    $(".js-sector-dropdown").siblings(".togglable_panel").hide();
    $(".js-sector-dropdown").click(function(){
        $(this).siblings(".togglable_panel").slideToggle();
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

});