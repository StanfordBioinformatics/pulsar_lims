//Set up handler for when the user wants to remove a library on the edit page.
$(document).on("click",".remove_library", function(event) {
  $parentSelector = $(this).closest(".sequencing_request_libraries");
  $parentSelector.fadeOut("slow",function() {
    $parentSelector.remove();
  })
});


$( function() {
  $add_library_btn = $("#add_library");
  $add_sequencing_run_btn = $("#add_sequencing_run")
})

//Listen for a successful AJAX response
$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
    //If the add library button was clicked, append the response to the #added_libraries element
    // and 1) adjust the default label text, 2) Add a remove link, and 3) have the new library selector fade in.
    if (event.currentTarget.activeElement.id === $add_library_btn.attr("id")) {
      //newContent = jqXHR.responseText;
      //console.log(newContent);
      $add_library_btn.hide()
      if ($add_sequencing_run_btn.length == 1) {
        $add_sequencing_run_btn.hide();
      }
      $(".added_libraries").append(jqXHR.responseText);
      $newContent = $(".sequencing_request_libraries");
      $newContentLabel = $newContent.children("label").first();
      $newContentLabel.text("Library") //default label set by simple form is Libraries.
      //$newContentLabel.append('<span>  <a class="remove_library fa fa-remove"></a></span>');
      //$newContent.hide().fadeIn("slow");
      $newContent.hide().slideDown("fast");
      $(".sreq-toggle-up-library-form").on("click",function(event) { 
        event.stopPropagation();
        $(this).closest(".jumbotron").slideUp("fast");
        $add_library_btn.show();
        if ($add_sequencing_run_btn.length == 1) {
          $add_sequencing_run_btn.show();
        }
      })
    }
  }
)

/* coffescript 
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
