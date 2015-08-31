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