# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->                                                                                                   
  #Refresh the data_file_types list in the form when the refresh fa-icon is clicked:                   
  $(document).on "click", ".file_reference_data_file_type i.refresh", (event) ->                            
    $.get "/data_file_types/select_options", (responseText,status,jqXHR) ->                            
      $(".file_reference_data_file_type select").html(responseText) 

  $(document).on "change",".file-reference-data-storage", (event) ->
    data_storage_id = $(this).val()
    $.get "/data_storages/" + data_storage_id + "/get_base_path", (responseText,status,jqXHR) ->
      $(".file-reference-file-path").val(responseText) 
