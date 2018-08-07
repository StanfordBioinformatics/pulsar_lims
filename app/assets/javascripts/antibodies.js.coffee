# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  #Refresh the antibody_purifications list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".antibody_antibody_purifications i.refresh", (event) ->
    $.get "/antibody_purifications/select_options", (responseText,status,jqXHR) ->
      alert(responseText)
      $(".antibody_antibody_purifications select").html(responseText)

  #Refresh the vendors list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".antibody_vendor i.refresh", (event) ->
    $.get "/vendors/select_options", (responseText,status,jqXHR) ->
      $(".antibody_vendor select").html(responseText)

  #Refresh the isotypes list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".antibody_isotype i.refresh", (event) ->
    $.get "/isotypes/select_options", (responseText,status,jqXHR) ->
      $(".antibody_isotype select").html(responseText)

  #Refresh the targets list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".antibody_target i.refresh", (event) ->
    $.get "/targets/select_options", (responseText,status,jqXHR) ->
      $(".antibody_target select").html(responseText)

  #Refresh the secondary_antibody_concentration_units list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".antibody_concentration_units i.refresh", (event) ->
    $.get "/antibodies/select_options", (responseText,status,jqXHR) ->
      $(".antibody_concentration_units select").html(responseText)
