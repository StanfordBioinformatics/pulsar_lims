# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->  

  $(document).on("click",".remove_construct_tag", -> 
    $parentSelector = $(@).closest(".donor_construct_construct_tags")
    $parentSelector.fadeOut("fast")
    $parentSelector.remove()
  )

  $("#add_construct_tag").on "ajax:success", (event,data) ->  
    $("#added_construct_tags").append(data)
    #this appends a form with id donor_construct_construct_tags
    $newContentLabel = $(".donor_construct_construct_tags").last().children("label").first()
    $newContentLabel.text("Construct Tag") #default label set by simple form is Construct Tags.
    $newContentLabel.append('<span>  <a class="remove_construct_tag fa fa-remove"></a></span>')
    #this appends a form with id donor_construct_construct_tags
    $(".donor_construct_construct_tags").last().hide().fadeIn("fast")
