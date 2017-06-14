

$ -> 
  $("#show_api_key").on "ajax:success", (event,data) ->  
    orig = $("#show_api_key").detach()
    #.detach() doesn't remove event handlers like .html() or .replaceWith() does.
    $("#api_key").html(data)

    $("#hide_api_key").click (event,data) ->  
      event.preventDefault()
      $("#api_key").html(orig)
