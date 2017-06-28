# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> 
  #When the user clicks on the "Add Sorting Biosample" button, append the response from the action (SingleCellSortingController.add_sorting_biosamples) to the show view at the end of the div element with id "sorting_biosample".
  $("#add_sorting_biosample").on "ajax:success", (event,data) ->  
    $("#add_sorting_biosample").replaceWith(data)
