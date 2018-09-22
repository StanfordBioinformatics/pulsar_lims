#
$ -> 

  #Refresh the data_storage list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".file_reference_data_storage i.refresh", (event) ->
    $.get "/data_storages/select_options", (responseText,status,jqXHR) ->
      $(".file_reference_data_storage select").html(responseText)

  show_bucket_attrs = () -> 
    if $(".bucket-attrs label .required-marker").length == 0 #don't add more than once
      $(".bucket-attrs label").prepend('<abbr class="required-marker" title="required">*</abbr>&nbsp')
    $(".bucket-attrs").fadeIn()

  hide_bucket_attrs = () ->
    $(".bucket-attrs").fadeOut()

  show_project_attrs = () -> 
    $(".project-attrs").fadeIn()

  hide_project_attrs = () ->
    $(".project-attrs").fadeOut()

  hide_bucket_attrs()
  hide_project_attrs()

  additional_fields = -> 
    $.get "/data_storages/customize_for_data_storage_provider", { data_storage_provider_id:  $("#ds_data_storage_provider").val()}, (responseText,status,jqXHR) ->
      if (responseText == "bucket" )
        hide_project_attrs()
        show_bucket_attrs()    
      else 
        hide_bucket_attrs()
        show_project_attrs()

  if $("#ds_data_storage_provider").val()
    additional_fields()

  $(document).on "change", "#ds_data_storage_provider", additional_fields
