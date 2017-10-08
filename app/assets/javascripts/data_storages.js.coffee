$ -> 
  $("#data_storage_project_identifier").closest("div").hide()

  $(document).on "change", "#data_storage_data_storage_provider_id", (event) -> 
    $.get "/data_storages/customize_for_data_storage_provider", { data_storage_provider_id:  $(event.target).val()}, (responseText,status,jqXHR) ->
      alert(responseText)

    
   
