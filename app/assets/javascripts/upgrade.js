// Live Progress Bar
$(document).ready(function(){


function secondsToString(seconds)

{

var numdays = Math.floor(seconds / 86400);

var numhours = Math.floor((seconds % 86400) / 3600);

var numminutes = Math.floor(((seconds % 86400) % 3600) / 60);

var numseconds = ((seconds % 86400) % 3600) % 60;

var time = ""

if(numdays!=0){
    time += (numdays + " days ");
}else if (numhours!=0){
    time += (numhours + " hours ");
}else if (numminutes!=0){
    time += (numminutes + " minutes ");
}else if (numseconds!=0){
    time += (numseconds + " seconds");
}

return time

}


if (typeof i === "undefined") {

var timeLeft = parseInt($(".js-upgrade-time-left").val())
var totalTime = parseInt($(".js-upgrade-time").val())
var percentage_per_second = 100/totalTime

    $(function() {
        i = 100-((timeLeft*100)/totalTime);
        var myInterval = setInterval(function() {
            $(".progress-bar").attr("aria-valuenow",i);
            $(".progress-bar").width(i + '%');
            // var secondsLeft = parseInt((100-i)*totalTime))
            var true_time_left = secondsToString(parseInt((((100-i)*totalTime)/100)))
            $("#timeleft").text("will be done in " + (true_time_left));
            if (parseInt(i) == 100) {
                $(".progress").hide();
                $("#timeleft").text("is done!");
                // clearInterval(myInterval);
            }
            i+=percentage_per_second;
        }     
        ,1000);
    });
}



// ----- POPUPS ----- //

    //Accept Employement Request
    $('.js-upgrade').on('click', function() {
        var upgradeName = $(this).children(".js-upgrade-name").val()
        if (confirm("Start the " + upgradeName + " upgrade?") == true) {
            var upgrade = $(this).children(".js-upgrade-value").val()
            var level = $(this).children(".js-upgrade-level").val()
            var company_id = $(this).children(".js-upgrade-company-id").val()
            $.ajax({
                type: 'POST',
                url: '/upgrade',
                dataType: 'script',
                data: { 'level' : level, 'upgrade' : upgrade, 'company_id' : company_id},
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
            });
        }
    });


// Posts with Ajax
// $(".js-upgrade").click(function(){
//     
// });

});
    