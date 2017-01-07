$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
		if (event.currentTarget.activeElement.id === "add_library") {
			$("#libraries").append(jqXHR.responseText);
		}
	}
)

/* coffescript equivalent
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
