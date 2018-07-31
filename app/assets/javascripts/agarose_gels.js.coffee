# hi

$ ->

  $(".add-agarose-gel-lane-btn").on "ajax:success", (event,data) ->
    $lanes = $(".agarose-gel-lanes")
    $lanes.after(data)

#  $(".agarose-gel-create-lane-btn").on "ajax:success", (event,data) ->
#  $(document).on "ajax:success", (event,data) ->
#    alert(event.target.id);
#    alert("howdy there");
#    #$(this).closest("form").replaceWith(data);


  $(document).on "click", ".agarose-gel-create-lane-btn", (event) -> 
    alert("yep")
    event.preventDefault()
    event.stopPropagation()
    $form =  $(this).closest("form")
    $.post "/agarose_gels/" + $("#record_id").text() + "/create_gel_lane", $form.serialize(), (data) ->
      $form.replaceWith(data) 
