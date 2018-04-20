# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #Refresh the part_of_biosample list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_part_of_biosample i.refresh", (event) -> 
    $.get "/biosamples/select_options", (responseText,status,jqXHR) ->
      $(".biosample_part_of_biosample select").html(responseText)

  #Refresh the pooled_from_biosamples list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_pooled_from_biosamples i.refresh", (event) -> 
    $.get "/biosamples/select_options", (responseText,status,jqXHR) ->
      $(".biosample_pooled_from_biosamples select").html(responseText)

  #Refresh the nih_institutional_certification (Document) list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_nih_institutional_certification i.refresh", (event) -> 
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".biosample_nih_institutional_certification select").html(responseText)

  #Refresh the biosample_types list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_biosample_type i.refresh", (event) -> 
    $.get "/biosample_types/select_options", (responseText,status,jqXHR) ->
      $(".biosample_type_selector").html(responseText)

  #Refresh the biosample_term_names list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_biosample_term_name i.refresh", (event) -> 
    $.get "/biosample_term_names/select_options", (responseText,status,jqXHR) ->
      $(".biosample_term_name_selector").html(responseText)

  #Refresh the documents list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_documents i.refresh", (event) -> 
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".biosample_documents_selector").html(responseText)

  #Refresh the donors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_donor i.refresh", (event) -> 
    $.get "/donors/select_options", (responseText,status,jqXHR) ->
      $(".biosample_donor select").html(responseText)

  #Refresh the treatmentslist in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_treatments i.refresh", (event) -> 
    $.get "/treatments/select_options", (responseText,status,jqXHR) ->
      $(".biosample_treatments_selector").html(responseText)

  #Refresh the vendors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".biosample_vendor i.refresh", (event) -> 
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->
      $(".biosample_vendor select").html(responseText)

  load_biosample_term_name_selection = -> 
    if $(".biosample_type_selector").val()
      $.get "/biosamples/select_biosample_term_name", {biosample_term_name_selector: $(".biosample_term_name_selector").val(), biosample_type_selector: $(".biosample_type_selector").val()}, (responseText,status,jqXHR) ->
        $(".biosample_term_name_selector option").remove()
        $(".biosample_term_name_selector").append(responseText)

  #use event delegation (see jQuery in Action 3rd ed., p. 154 on "event delegation").
  $(document).on "change", ".biosample_type_selector", (event) -> 
    # $(document).change "#biosample_biosample_type_id", (event) -> 
    # Note that using the CoffeeScript syntax (commented-out line above) for event delegation doesn't work, as any change events (i.e. selecting a document) cause the event below to fire.
    event.stopPropagation()
    load_biosample_term_name_selection()
  load_biosample_term_name_selection()

  $("#biosample_add_crispr_modification",document).on "ajax:success", (event,data) -> 
    $("#biosample_add_crispr_modification").fadeOut "fast", () ->
      $("#biosample_crispr_modification_form").html(data).hide()
      $(".select_crispr_construct",document).click()
      $("#biosample_crispr_modification_form").show()

  $(document).on "click", ".biosample-toggle-up_add_crispr_form", (event) ->  
    event.stopPropagation()
    $(".jumbotron-select-crispr").slideUp "fast", () ->
      $("#biosample_add_crispr_modification", document).show()
