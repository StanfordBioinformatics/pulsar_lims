$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
		if (event.currentTarget.activeElement.id === "add_library") {
//			newContent = jqXHR.responseText;
//			console.log(newContent);
			$libraries = $("#libraries");
			$libraries.append(jqXHR.responseText);
			$newContent = $libraries.find(".sequencing_request_libraries").last();
			$newContentLabel = $newContent.children("label").first()
			$newContentLabel.text("Library")
			$newContentLabel.append('<span>  <a class="remove_library fa fa-remove"></a></span>');
			$libraries.on("click",".remove_library", function(event) {
				$parentSelector = $(this).closest(".sequencing_request_libraries");
				$parentSelector.fadeOut("slow",function() {
					$parentSelector.remove();
				})
			});
			$newContent.hide().fadeIn("slow");
		}
	}
)

/* coffescript equivalent
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
