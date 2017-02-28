//Set up handler for when the user wants to remove a library selection
$(document).on("click",".remove_library", function(event) {
	$parentSelector = $(this).closest(".sequencing_request_libraries");
	$parentSelector.fadeOut("slow",function() {
		$parentSelector.remove();
	})
});


//Listen for a successful AJAX response
$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
		//If the add library button was clicked, append the response to the #libraries element
    // and 1) adjust the default label text, 2) Add a remove link, and 3) have the new library selector fade in.
		if (event.currentTarget.activeElement.id === "add_library") {
			//newContent = jqXHR.responseText;
			//console.log(newContent);
			$(".added_libraries").append(jqXHR.responseText);
			$newContent = $(".sequencing_request_libraries").last();
			$newContentLabel = $newContent.children("label").first();
			$newContentLabel.text("Library") //default label set by simple form is Libraries.
			$newContentLabel.append('<span>  <a class="remove_library fa fa-remove"></a></span>');
			//$newContent.hide().fadeIn("slow");
			$newContent.hide().slideDown("fast");
		}
	}
)

/* coffescript 
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
