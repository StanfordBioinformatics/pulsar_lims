# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->  

  #The following is for the show view.

  $merged_file_btn = null
  $td = null

  $(document).on "click", '.analysis-add-merged-file[disabled]', (event,data) ->
    event.preventDefault()
    event.stopPropagation()
    

  $(document).on "ajax:success", ".analysis-add-merged-file", (event,data) ->
    event.stopPropagation()
    $merged_file_btn = $(this) #set global var
    $td = $(this).closest("td")
    $td.css("width","100%")
    $(this).after(data)
    $(this).hide()
    $(".analysis-add-merged-file").attr("disabled","disabled")

  $(document).on "click",".toggle-up-merged-file-form", (event) ->
    #Don't nest this handler within the one above, or else it will be
    # potentially added multiple times - once for each time the user clicks on
    # any of the links having class .analysis-add-merged-file.
    $(".merged-file-form-fields").slideUp () ->
      $(".merged-file-form-fields").remove()
      $td.css("width","initial")
      $(".analysis-add-merged-file").removeAttr("disabled").show()

