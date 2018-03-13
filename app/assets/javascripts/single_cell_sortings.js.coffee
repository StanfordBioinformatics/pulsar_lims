# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> 
  #Refresh the starting_biosample list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".single_cell_sorting_starting_biosample i.refresh", (event) ->                
    $.get "/biosamples/select_options", (responseText,status,jqXHR) ->
      $(".single_cell_sorting_starting_biosample select").html(responseText)

  #When the user clicks on the "Add Sorting Biosample" button, append the response from the action (SingleCellSortingController.add_sorting_biosamples) to the show view at the end of the div element with id "sorting_biosample".
  $("#scs_add_sorting_biosample").on "ajax:success", (event,data) ->  
    $("#scs_add_sorting_biosample").after(data)
    $("#scs_add_sorting_biosample").hide()

  $(document).on "click", ".scs-toggle-up-biosample-form", (event) -> 
    event.stopPropagation()
    $(event.target).closest("form").slideUp("fast")
    $("#scs_add_sorting_biosample").show()

  $("#scs_add_plate").on "ajax:success", (event,data) ->  
    $("#scs_add_plate").after(data)
    $("#scs_add_plate").hide()

  $(document).on "click", ".scs-toggle-up-plate-form", (event) -> 
    event.stopPropagation()
    $(event.target).closest("form").slideUp("fast")
    $("#scs_add_plate").show()
