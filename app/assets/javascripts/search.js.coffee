# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ -> 
  $(document).on "ajax:success", "#search-form, nav.pagination", (event, data) ->
    #total = $(data).find(".index-view-total")
    #table = $(data)[2] # There is <header> at index 0, and a text node at index 1.
    #$(".index-view-total").html(total)
    #$("#rendered-content table.index").html(table)
    $("#rendered-content").html(data)
    $(".model-definition").hide()
