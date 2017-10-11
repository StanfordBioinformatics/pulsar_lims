#
$ -> 

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


  $(document).on "change", "#data_storage_data_storage_provider_id", (event) -> 
    $.get "/data_storages/customize_for_data_storage_provider", { data_storage_provider_id:  $(event.target).val()}, (responseText,status,jqXHR) ->
      if (responseText == "bucket" )
        hide_project_attrs()
        show_bucket_attrs()    
      else 
        hide_bucket_attrs()
        show_project_attrs()
      
   
