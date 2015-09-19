$(document).ready(function(){

	var counter = $('.js-select').length;
	$('.js-select').change(function() {
	    $.each($('.js-select'),function(i,e) {
	        var t = $(this);
	        // if (t.val() == undefined || t.val() == '') {
	        //     $('#js-market').fadeOut();
	        //     return;
	        // }
	        // if both are filled in perform the following
	        if (i+1 == counter) {
	            var item_id=$('#market_select').val()
	            var company_id=$("#company_select").val()
	            // Update the buy and Sell Requests.
	            $.ajax({
			      type: 'GET',
			      url: '/update-orders',
			      dataType: 'script',
			      data: { 'item_id' : item_id, 'company_id' : company_id }
			      // beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
			    });
	            
	        }
	    });
	});

	// $('.js-buy-input').change(function() {
	// 	var amount = parseInt($(this).find("[name='amount']").val()
	// 	var price = parseInt($(this).find("[name='price']").val()
	// 	var balance = parseFloat($(this).find("[name='company_balance']").val()
	// 	var max_amount = balance*price
	// 	var max_price = balance*balance

	// 	("[name='amount']").attr('id', 'inputError1');

	// 	$(this).find("[name='amount']").attr('max', max_amount);
	// 	$(this).find("[name='price']").attr('max', max_price);
	// });

	// $('.js-update-buy-value').click(function(){

	// });

});