

$ -> 
  $("#show_api_key").on "ajax:success", (event,data) ->  
    $("#show_api_key").replaceWith(data)
