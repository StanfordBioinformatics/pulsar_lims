# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->                                                                                                   
  #Refresh the vendors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".sequencing_library_prep_kit_vendor i.refresh", (event) ->
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->
      $(".sequencing_library_prep_kit_vendor select").html(responseText)

  #Refresh the documents list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".sequencing_library_prep_kit_documents i.refresh", (event) ->
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".sequencing_library_prep_kit_documents select").html(responseText)


