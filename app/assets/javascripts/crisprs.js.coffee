# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> 
  $genomic_integration_site = $(".genomic_integration_site")

  chromosome_selection = ->  
    $.get "/crisprs/select_chromosome_on_reference_genome", $("#reference_genome_id").serialize(), (responseText,status,jqXHR) ->
      $genomic_integration_site.html responseText
      $genomic_integration_site.hide().fadeIn("fast")

  if ($("#reference_genome_id").val())
    chromosome_selection()
    #set when page loads to, because if the _form.html.erb refreshed with a validation error, the 
    # reference_genome may already have been set, but no change event will fire.


  $("#reference_genome_id").change (event) ->
    chromosome_selection()

  $(document).on "click",".remove_crispr_construct", ->  
    $parentSelector = $(@).closest("div")
    $parentSelector.fadeOut () -> 
      $parentSelector.remove()

  $(document).on "ajax:success", ".select_crispr_construct", (event,data) ->
    $("#added_crispr_constructs").append(data)
