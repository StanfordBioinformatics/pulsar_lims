# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the documents list in the form when the refresh fa-icon is clicked:                         
  $(document).on "click", ".atacseq_documents i.refresh", (event) ->                        
    $.get "/documents/select_options", (responseText,status,jqXHR) ->                                  
      $(".atacseq_documents_selector").html(responseText) 
