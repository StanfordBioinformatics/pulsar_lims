# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$ ->
  $(document).on "change",".file-reference-data-storage", (event) ->
    data_storage_id = $(this).val()
    $.get "/data_storages/" + data_storage_id + "/get_base_path", (responseText,status,jqXHR) ->
      $(".file-reference-file-path").val(responseText) 
