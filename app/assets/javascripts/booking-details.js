$( document ).on('ready page:load',function(){
	$('#booking_start_date').datepicker({

	})


	$( "#booking_start_date" ).bind('hastext',function () {
		
	  $( "#booking_end_date" ).bind('hastext',function() {
	  		alert( "Handler for .change() called." );
		});
	});
});