# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the vendors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_master_mix_vendor i.refresh", (event) ->
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->
      $(".pcr_master_mix_vendor select").html(responseText)
