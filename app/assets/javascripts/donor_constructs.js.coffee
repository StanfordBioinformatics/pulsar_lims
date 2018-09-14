#

$ ->
  #Refresh the cloning_vectors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".donor_construct_cloning_vector i.refresh", (event) ->
    $.get "/cloning_vectors/select_options", (responseText,status,jqXHR) ->
      $(".donor_construct_cloning_vector select").html(responseText)

  #Refresh the documents list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".donor_construct_documents i.refresh", (event) ->
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".donor_construct_documents select").html(responseText)

  #Refresh the targets list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".donor_construct_target i.refresh", (event) ->
    $.get "/targets/select_options", (responseText,status,jqXHR) ->
      $(".donor_construct_target select").html(responseText)

  #Refresh the vendors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".donor_construct_vendor i.refresh", (event) ->
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->
      $(".donor_construct_vendor select").html(responseText)

