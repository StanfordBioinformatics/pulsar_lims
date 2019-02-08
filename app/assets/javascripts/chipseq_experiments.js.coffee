
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  #Refresh the documents list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".chipseq_experiment_documents i.refresh", (event) ->
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".chipseq_documents_selector").html(responseText)

  #Refresh the targets list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".chipseq_experiment_target i.refresh", (event) ->
    $.get "/targets/select_options", (responseText,status,jqXHR) ->
      $(".chipseq_experiment_target select").html(responseText)

  #Get a selection for choosing the wild type control based on the value chosen for the starting_biosample.
  $("#chipseq_experiment_chipseq_starting_biosample_ids").on "change", () ->
    $.get "/chipseq_experiments/get_wt_control_selection", {starting_biosample_id: $("#chipseq_experiment_chipseq_starting_biosample_ids").val()[0]}, (responseText,status,jqXHR) ->
      $("#chipseq_experiment_wild_type_control_id").closest("div").replaceWith(responseText)

  # Trigger change for above since the user might have opened the record in edit mode. If no change
  # event is triggered here, then the wt control input will be disabled. 
  $("#chipseq_experiment_chipseq_starting_biosample_ids").change()

  $("#chipseq-add-ctl").on "click", (event) ->
    if $(event.target).attr("disabled") == "disabled"
      # Then user hasn't selected any experimental replicates yet from which the controls are made.
      event.preventDefault()
      event.stopPropagation()

  $("#chipseq-add-rep, #chipseq-add-ctl").on "ajax:success", (event, data) -> 
    tag = this.id
    $(".bottom-btns").hide()
    $(".bottom-btns").after(data)
    $("#biosample").on "change", () -> 
      biosample_id = $(this).val()
      params = {biosample_id: biosample_id}
      if tag == "chipseq-add-ctl"
        params.control = true
      route = "/chipseq_experiments/" + $("#record_id").text() + "/select_biosample_libraries"
      $.get route, params, (responseText,status,jqXHR) ->
        $("#library_selector").html(responseText)
        add_tooltip_icon() # Defined in application.js
