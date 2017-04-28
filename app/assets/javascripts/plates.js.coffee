# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ -> 
  #set the failed wells to red. The .failure class is set on wells where the 'fail' attribute is set to true, and this class
  # is added in the Plate show view. 
  $("td:has(a.failure)").css({"background-color":"red"})
  $("a.failure").css({"color":"black"})

  #The following code is used with the Library show form to support adding multiple barcodes:
  # The div containing all that logic (with calss add_barcodes) is hidden right now since this isn't a necessary feautre; in fact
  # fact its extraneous. But might as well keep the logic around just in case. 
  $bc_submit = $('div.add_barcodes input[type="submit"]')
  $add_paired_barcodes = $("#plate_add_paired_barcodes")
  $add_barcodes = $("#plate_add_barcodes")
  hide_bc_submit = -> 
    if ( $add_barcodes.length == 1 && ! $add_barcodes.val() )
      $bc_submit.attr("disabled","disabled")
    else if ( $add_paired_barcodes.length == 1 && ! $add_paired_barcodes.val())
      $bc_submit.attr("disabled","disabled")
    else
      $bc_submit.attr("disabled",false)
      
  hide_bc_submit()
  $add_paired_barcodes.focus (event) ->
    $bc_submit.attr("disabled",false)
  $add_barcodes.focus (event) ->
    $bc_submit.attr("disabled",false)
  $add_paired_barcodes.blur (event) ->
    hide_bc_submit()
  $add_barcodes.blur (event) ->
    hide_bc_submit()
