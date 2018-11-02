# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->                                                                                                   

  #Refresh the documents list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".immunoblot_documents i.refresh", (event) ->                      
    $.get "/documents/select_options", (responseText,status,jqXHR) ->                            
      $(".immunoblot_documents select").html(responseText)  

  #Refresh the primary_antibody list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".immunoblot_primary_antibody i.refresh", (event) ->                      
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->                            
      $(".immunoblot_primary_antibody select").html(responseText)  

  #Refresh the primary_antibody list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".immunoblot_primary_antibody i.refresh", (event) ->                      
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->                            
      $(".immunoblot_primary_antibody select").html(responseText)  

  #Refresh the secondary_antibody list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".immunoblot_secondary_antibody i.refresh", (event) ->                      
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->                            
      $(".immunoblot_secondary_antibody select").html(responseText)  

  #Refresh the secondary_antibody_concentration_units list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".immunoblot_secondary_antibody_concentration_units i.refresh", (event) ->                      
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->                            
      $(".immunoblot_secondary_antibody_concentration_units select").html(responseText)  

  $("#immunoblot-select-gel").on "ajax:success", (event, data) ->
    event.preventDefault()
    event.stopPropagation()
    $(this).closest($(".xfade-in")).after(data)
    $(this).closest($(".xfade-in")).hide()

  $(document).on "click", "#immunoblot_set_gel", (event, data) ->
    event.preventDefault()
    event.stopPropagation()
    gel_id = $("#select_pcr_gel").val()
    if not gel_id
        return
    $.ajax({
      data: {gel: {immunoblot_id: $("#record_id").text()}},
      dataType: "json",
      url: "/gels/" + gel_id,
      type: "PUT",
      success: (result) -> 
        window.location.href = "/immunoblots/" + $("#record_id").text() 
    })
      
