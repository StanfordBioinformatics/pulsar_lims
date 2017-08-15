//Set up handler for when the user wants to remove a library on the edit page.
$(document).on("click",".remove_library", function(event) {
  $parentSelector = $(this).closest(".sequencing_request_libraries");
  $parentSelector.fadeOut("slow",function() {
    $parentSelector.remove();
  })
});


$( function() {
  $add_library_btn = $("#add_library");
  $add_scs_plates_btn = $("#add_scs_plates");
  $bl_btns = $(".bl-btns");
})

//Listen for a successful AJAX response
$(document).on("click",".sreq-toggle-up", function(event) {
  //The toggle up btn for the jumbotron that came as part of the AJAX response when one of $bl_btns was clicked. 
  event.stopPropagation();
  $(event.target).closest(".jumbotron").slideUp("fast").remove();
  $bl_btns.show();
})

$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
    //If the add library button was clicked, append the response to the #added_libraries element
    // and 1) adjust the default label text, 2) Add a remove link, and 3) have the new library selector fade in.
    event.stopPropagation();
    event_target = event.currentTarget.activeElement;
    if ((event_target.id === $add_library_btn.attr("id")) || (event_target.id === $add_scs_plates_btn.attr("id"))) {
      //newContent = jqXHR.responseText;
      //console.log(newContent);
      $bl_btns.hide()
      $bl_btns.after(jqXHR.responseText);
      $newContent = $(".jumbotron").last();
      //$newContent = $(".sequencing_request_libraries");
      $newContent.hide().slideDown("fast");

		} 
    if (event_target.id === $add_scs_plates_btn.attr("id")) {
      $("#single_cell_sorting_selector").on("change", function(event) {
        sreq_id = $(this).data("sequencing-request-id")
        $.get("/sequencing_requests/" + sreq_id + "/select_scs_plates", function(responseText,status,jqXHR) {
          //$(this).closest("div").append(responseText);
          $("#single_cell_sorting_selector").closest("div").append(responseText);
        })
      })
      $newContent = $("#single_cell_sorting_selector");
    }
  }
)

/* coffescript 
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
