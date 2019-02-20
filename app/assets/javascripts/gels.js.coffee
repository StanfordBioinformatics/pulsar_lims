# hi

$ ->

  $(".add-gel-lane-btn").on "ajax:success", (event,data) ->
    $lanes = $(".gel-lanes")
    $lanes.append(data)

  $(document).on "click", ".gel-create-lane-btn", (event) -> 
    event.preventDefault()
    event.stopPropagation()
    $form =  $(this).closest("form")
    $.post "/gels/" + $("#record_id").text() + "/create_or_update_gel_lane", $form.serialize(), (data, textStatus, jqXHR) ->
      alert(textStatus)
      $jqdata = $(data)
      $form.html($jqdata.html()) 
      if $jqdata.find(".has-error")
        # Then there was a server-side validation error. 
        $form.addClass("error-row-color")
      else
        $form.addClass("created-row-color")
        setTimeout (-> $form.removeClass("created-row-color")), 1000

  $(document).on "change", ".gel-lane-form div > *", () ->
    $form =  $(this).closest("form")
    if !($form.has("#gel-lane-persisted").length > 0)
      return
    $.post "/gels/" + $("#record_id").text() + "/create_or_update_gel_lane", $form.serialize(), (data) ->
      $form.replaceWith(data)

  $(document).on "ajax:success", ".gel-remove-gel-lane", (event, data) ->
    $form = $(this).closest("form")
    $form.fadeOut()

