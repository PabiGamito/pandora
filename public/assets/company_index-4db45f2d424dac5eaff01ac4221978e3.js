$(document).ready(function(){$(".togglable_panel").hide(),$(".panel_dropdown").click(function(){if($(this).siblings(".togglable_panel").is(":visible"))$(this).siblings(".togglable_panel").fadeOut();else{var l=$(this).children(".company_id").val(),i=$(this).children(".panel-title").children(".js-panel-name").text();$(this).siblings(".togglable_panel").text("Loading..."),$.ajax({type:"GET",url:"/load-dropdown",dataType:"script",data:{render:i,company_id:l}}),$(this).siblings(".togglable_panel").show()}}),$(".js-company_dropdown").siblings(".togglable_panel").show(),$(".js-company_dropdown").click(function(){$(this).siblings(".togglable_panel").slideToggle()}),$(".js-sector-dropdown").siblings(".togglable_panel").hide(),$(".js-sector-dropdown").click(function(){$(this).siblings(".togglable_panel").slideToggle()})});