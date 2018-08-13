// The following code pertains to the show view.

$(function() {
  //Refresh the sequencing_platforms list in the form when the refresh fa-icon is clicked:                           
  $(document).on("click", ".sequencing_request_submitted_by i.refresh", function(event){
    $.get("/users/select_options", function (responseText,status,jqXHR){
      $(".sequencing_request_submitted_by select").html(responseText);
    })
  })

  //Refresh the sequencing_platforms list in the form when the refresh fa-icon is clicked:                           
  $(document).on("click", ".sequencing_request_sequencing_platform i.refresh", function(event){
    $.get("/sequencing_platforms/select_options", function (responseText,status,jqXHR){
      $(".sequencing_request_sequencing_platform select").html(responseText);
    })
  })

  //Refresh the sequencing_centers list in the form when the refresh fa-icon is clicked:                           
  $(document).on("click", ".sequencing_request_sequencing_center i.refresh", function(event){
    $.get("/sequencing_centers/select_options", function (responseText,status,jqXHR){
      $(".sequencing_request_sequencing_center select").html(responseText);
    })
  })
});

//Set up handler for when the user wants to remove a library on the edit page.
$(document).on("click",".remove_library", function(event) {
  $parentSelector = $(this).closest(".sequencing_request_libraries");
  $parentSelector.fadeOut("slow",function() {
    //$parentSelector.remove();
  })
});


$( function() {
  $add_library_btn = $("#add_library");
  $add_scs_plates_btn = $("#add_scs_plates");
  $bl_btns = $(".bl-btns"); //bl means business logic
  $sreq_lib_or_scs_selector = $(".sreq_lib_or_scs_selector"); //container for AJAX response.
  $sreq_plate_selector = $(".sreq_plate_selector"); //container for AJAX response.
})

//Listen for a successful AJAX response
$(document).on("click",".sreq-toggle-up", function(event) {
  //The toggle up btn for the jumbotron that came as part of the AJAX response when one of $bl_btns was clicked. 
  event.stopPropagation();
  $(event.target).closest(".jumbotron").slideUp("fast",function(){ 
    $(this).remove();
    $bl_btns.show();
  })
})

// When the user clicks on the "Add Library" button or the "Add Single Cell Sorting plates" button,
// an AJAX request is fired to get the new form to show from the sequencing_requests controller. 
// Upon a successfull AJAX request, we'll need to hide those buttons and then show the response
// (form) from the server. 
$(document).ajaxSuccess(function(event,jqXHR,ajaxProps) {
  //If the add library button was clicked, append the response to the #added_libraries element
  // and 1) adjust the default label text, 2) Add a remove link, and 3) have the new library selector fade in.
  event.stopPropagation();
  event_target = event.currentTarget.activeElement;
  if ((event_target.id === $add_library_btn.attr("id")) || (event_target.id === $add_scs_plates_btn.attr("id"))) {
    //newContent = jqXHR.responseText;
    //console.log(newContent);
    $bl_btns.hide();
    $sreq_lib_or_scs_selector.html(jqXHR.responseText);
    //$newContent = $(".sequencing_request_libraries");
    $sreq_lib_or_scs_selector.hide().slideDown("fast");

  } 
})

// A handler for onChange events in the SingleCellSorting selector, which is in the form that
// comes from the server after the user clicks on the "Add Single Cell Sorting plates" button.
// When the user selects a SingleCellSorting record, they'll then be presented with a modal popup 
// with one or more plates from that SingleCellSorting, excluding any plates in the selection that are
// currently associated to the SequencingRequest at hand. 
$(document).on("change","#single_cell_sorting_selector", function(event) {
  event.stopPropagation();
  sreq_id = $(this).data("sequencing-request-id")
  val = $("#single_cell_sorting_selector").serialize()
  // Get a selection of plates that on the SingleCellSorting that aren't yet on this SequencingRequest.
  $.get("/sequencing_requests/" + sreq_id + "/select_scs_plates", val, function(responseText,status,jqXHR) {
    //$(this).closest("div").append(responseText);
    $sreq_plate_selector.html(responseText);

    //Disable the plate selection form's input btn until a plate has been selected:
    $("#select_plates_modal input").attr("disabled","disabled");
    $("#select_plates_modal").show();
    $("#sequencing_request_plate_ids").change( function() {
      $("#select_plates_modal input").removeAttr("disabled");
    })
  })
})

/* coffescript 
  $ ->  
  $("#add_library").on "ajax:success", (event,data) ->  
    $("#libraries").append data
*/
