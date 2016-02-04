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

    var showTable = function(){
      if($("#booking_start_date").val() !== "" && $("#booking_end_date").val() !== ""){
        var startDt = $("#booking_start_date").val().split(/\-|\s/)  ;
        var endDt = $("#booking_end_date").val().split(/\-|\s/) ;

        var startDate = new Date(startDt.reverse().join('/'));
        var endDate = new Date(endDt.reverse().join('/'));

        var diff = (endDate - startDate) / 1000 / 60 / 60 / 24;
        var total = $("#price-per-night").data("price-per-night") * diff;
        var serviceCharge = total * 0.1 ;
        var totalCharge = total + serviceCharge;

        // debugger
        $("#no_of_days").html(diff);
        $("#total").html("RM " + total);
        $("#service-charge").html("RM " + serviceCharge);
        $("#total-charge").html("RM " + totalCharge);
        $("#booking-details").show();
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
        showTable();
      }
    });

    $('#booking_end_date').datepicker({  

      dateFormat: "dd-mm-yy",
      beforeShowDay: unavailable,
      

      onSelect: function(date) {
        $('#booking_end_date').val();
        showTable();
      }
    });


});