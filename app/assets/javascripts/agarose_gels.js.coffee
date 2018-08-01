# hi

$ ->

  $(".add-agarose-gel-lane-btn").on "ajax:success", (event,data) ->
    $lanes = $(".agarose-gel-lanes")
    $lanes.append(data)

  $(document).on "click", ".agarose-gel-create-lane-btn", (event) -> 
    event.preventDefault()
    event.stopPropagation()
    $form =  $(this).closest("form")
    $.post "/agarose_gels/" + $("#record_id").text() + "/create_or_update_gel_lane", $form.serialize(), (data) ->
      $form.replaceWith(data) 

  $(document).on "change", ".gel-lane-form div > *", () ->
    $form =  $(this).closest("form")
    if !($form.has("#gel-lane-persisted").length > 0)
      return
    $.post "/agarose_gels/" + $("#record_id").text() + "/create_or_update_gel_lane", $form.serialize(), (data) ->
      $form.replaceWith(data)

  $(document).on "ajax:success", ".agarose-gel-remove-gel-lane", (event, data) ->
    $form = $(this).closest("form")
    $form.fadeOut()
