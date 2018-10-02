# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  #Refresh the documents list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".crispr_modification_documents i.refresh", (event) ->
    $.get "/documents/select_options", (responseText,status,jqXHR) ->
      $(".crispr_documents_selector").html(responseText)

  #Refresh the crispr_constructs list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".crispr_constructs i.refresh", (event) ->
    $.get "/crispr_constructs/select_options", (responseText,status,jqXHR) ->
      $(".crispr_constructs_selector").html(responseText)

  # REFERENCE GENOME LOGIC
  # The user can select a reference genome to specify a modification site. When selecting one, 
  # send an AJAX request to give back a genome build and chromosome selection form. Allow the user
  # to remove the form as well. 
  $genomic_integration_site = $(".genomic_integration_site")

  chromosome_selection = ->
    $.get "/crispr_modifications/select_chromosome_on_reference_genome", $("#reference_genome_id").serialize(), (responseText,status,jqXHR) ->
      $genomic_integration_site.html responseText
      $genomic_integration_site.hide().fadeIn("fast")

  if ($("#reference_genome_id").val())
    chromosome_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the
    # reference_genome may already have been set, but no change event will fire.

  $(document).on "click", "#crispr_modification_select_chromosome .xfade-out", (event) ->
     $("#reference_genome_id").val("")

  # END REFERENCE GENOME LOGIC

  $("#reference_genome_id").change (event) ->
    chromosome_selection()

  $(document).on "click",".remove_crispr_construct", ->
    $parentSelector = $(@).closest("div")
    $parentSelector.fadeOut () ->
      $parentSelector.remove()

  $(document).on "ajax:success", ".select_crispr_construct", (event,data) ->
    $("#added_crispr_constructs").append(data)

