
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
  $("#chipseq_experiment_starting_biosample_id").on "change", () ->
    $.get "/chipseq_experiments/get_wt_control_selection", {starting_biosample_id: $("#chipseq_experiment_starting_biosample_id").val()}, (responseText,status,jqXHR) ->
      $("#chipseq_experiment_wild_type_control_id").closest("div").replaceWith(responseText)

  $("#chipseq-add-rep, #chipseq-add-ctl").on "ajax:success", (event, data) -> 
    $(".bottom-btns").hide()
    $(".bottom-btns").after(data)
