// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui

//= require bootstrap-sprockets
//= require autocomplete

//= require turbolinks

$( document ).on('ready page:load',function(){

	var unavailableDates = $('#unavailable_dates').data('unavailable-date');

	function unavailable(date) {
		var currentDate = date.getDate();
		var currentMonth = date.getMonth() + 1;
		if (currentDate < 10) { currentDate = '0' + currentDate; }
		if (currentMonth < 10 ) { currentMonth = '0' + currentMonth; }

        dmy = currentDate + "-" + currentMonth + "-" + date.getFullYear();
       	// debugger
       	// #.inArray(a,b) returns -1 when it doesn't find a match
        if ($.inArray(dmy, unavailableDates) == -1) {
            return [true, ""];
        } else {
            return [false, "", "Unavailable"];
        }
    }

    $('#booking_start_date').datepicker({ 
    	minDate: 0,
    	dateFormat: "dd-mm-yy",
    	beforeShowDay: unavailable,
    	onSelect: function(date) {
    		// Use the option() method to change options for individual instances.
    		// the mindate of 'end_date' become the date selected by 'start_date'
    		$('#booking_end_date').datepicker('option','minDate',date);
    	}
    });
    $('#booking_end_date').datepicker({
    	dateFormat: "dd-mm-yy",
    	beforeShowDay: unavailable,
    });
});
