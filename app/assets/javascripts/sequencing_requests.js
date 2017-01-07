$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
		if (event.currentTarget.activeElement.id === "add_library") {
			$newContent = $(jqXHR.responseText).hide();
			$librarySelectLabel = $newContent.children("label").first().text("Library");
			$librarySelectLabel.append('<span>  <a class="remove_library fa fa-remove"></a></span>');
			$librarySelectLabel.find(".remove_library").first().click(function(even) {
				$newContent.fadeOut("slow",function() {
					$(this).remove();
				})
			});
			$("#libraries").append($newContent);
			$newContent.fadeIn("slow");
		}
	}
)

/* coffescript equivalent
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
