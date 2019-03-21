#

$ ->
  #Refresh the pcr_master_mixes list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_biosample i.refresh", (event) ->
    $.get "/biosamples/select_options", {direction: "forward"}, (responseText,status,jqXHR) ->
      $(".pcr_biosample select").html(responseText)

  #Refresh the pcr_master_mixes list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_forward_primer i.refresh", (event) ->
    $.get "/primers/select_options", {direction: "forward"}, (responseText,status,jqXHR) ->
      $(".pcr_forward_primer select").html(responseText)

  #Refresh the pcr_master_mixes list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_reverse_primer i.refresh", (event) ->
    $.get "/primers/select_options", {direction: "reverse"}, (responseText,status,jqXHR) ->
      $(".pcr_reverse_primer select").html(responseText)

  #Refresh the pcr_master_mixes list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_pcr_master_mix i.refresh", (event) ->
    $.get "/pcr_master_mixes/select_options", (responseText,status,jqXHR) ->
      $(".pcr_pcr_master_mix select").html(responseText)

  #Refresh the crispr_modificatins list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".pcr_crispr_modification i.refresh", (event) ->
    $.get "/crispr_modifications/select_options", (responseText,status,jqXHR) ->
      $(".pcr_crispr_modification select").html(responseText)


  #### The following is for the show view.
  # Here, the user clicks on the select button to add an existing Immunoblot. That resuls in an aja
  # request that gives back a select_tag for choosing a Immunoblot.
   $("#pcr-select-gel").on "ajax:success", (event, data) ->
     event.preventDefault()
     event.stopPropagation()
     $(this).closest($(".xfade-in")).after(data)
     $(this).closest($(".xfade-in")).hide()
 
  # When the user selects a Immunoblot and clicks on the submit button, that sends an ajax PUT request to
  # the update action of the Immunoblot so that it can set the foreign key pointing to the PCR. Once that is
  # done, a redirct back to the show page of the PCR occurrs.
   $(document).on "click", "#pcr_set_gel", (event, data) ->
     event.preventDefault()
     event.stopPropagation()
     gel_id = $("#select_pcr_gel").val()
     if not gel_id
         return
     $.ajax({
       data: {gel: {pcr_id: $("#record_id").text()}},
       dataType: "json",
       url: "/gels/" + gel_id,
       type: "PUT",
       success: (result) ->
         window.location.href = "/pcrs/" + $("#record_id").text()
     })
   ####
