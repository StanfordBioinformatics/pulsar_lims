# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->                                                                                                   
  #Refresh the documents list in the form when the refresh fa-icon is clicked:                         
  $(document).on "click", ".atacseq_documents i.refresh", (event) ->                        
    $.get "/documents/select_options", (responseText,status,jqXHR) ->                                  
      $(".atacseq_documents_selector").html(responseText) 

  $("#atacseq-experiment-add-rep").on "ajax:success", (event, data) ->                    
    # Adds div with id 'atacseq-biosample-replicate-selector'. #atacseq-experiment-add-rep can be found both in        
    # the chipseqs and atacseqs show views.                                                            
    tag = this.id                                                                                      
    $(".bottom-btns").hide()                                                                           
    $(".bottom-btns").after(data)                                                                      
    $("#atacseq-biosample-replicate-selector #biosample").on "change", () ->                                   
      biosample_id = $(this).val()                                                                     
      params = {biosample_id: biosample_id}                                                            
      route = "/atacseqs/" + $("#record_id").text() + "/select_biosample_libraries"         
      $.get route, params, (responseText,status,jqXHR) ->                                              
        $("#library_selector").html(responseText)                                                      
        add_tooltip_icon() # Defined in application.js 
