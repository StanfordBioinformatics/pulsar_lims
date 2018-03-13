# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the vendors list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".cloning_vector_vendor i.refresh", (event) ->                            
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->                            
      $(".cloning_vector_vendor select").html(responseText) 
