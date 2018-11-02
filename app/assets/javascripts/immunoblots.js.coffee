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

 #### The following is for the show view.
 # Here, the user clicks on the select button to add an existing Immunoblot. That resuls in an aja
 # request that gives back a select_tag for choosing a Immunoblot.
  $("#immunoblot-select-gel").on "ajax:success", (event, data) ->
    event.preventDefault()
    event.stopPropagation()
    $(this).closest($(".xfade-in")).after(data)
    $(this).closest($(".xfade-in")).hide()

 # When the user selects a Immunoblot and clicks on the submit button, that sends an ajax PUT request to
 # the update action of the Immunoblot so that it can set the foreign key pointing to the PCR. Once that is
 # done, a redirct back to the show page of the PCR occurrs.
  $(document).on "click", "#immunoblot_set_gel", (event, data) ->
    event.preventDefault()
    event.stopPropagation()
    gel_id = $("#select_immunoblot_gel").val()
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
  ####

