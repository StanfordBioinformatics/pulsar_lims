# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the treatment_term_names list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".treatment_treatment_term_name i.refresh", (event) ->                            
    $.get "/treatment_term_names/select_options", (responseText,status,jqXHR) ->                            
      $(".treatment_treatment_term_name select").html(responseText) 

  #Refresh the documents list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".treatment_documents i.refresh", (event) ->                            
    $.get "/documents/select_options", (responseText,status,jqXHR) ->                            
      $(".treatment_documents select").html(responseText) 
