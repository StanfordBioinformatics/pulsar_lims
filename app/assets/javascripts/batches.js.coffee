# hi

$ ->

  $(document).on "change", ".batch_item_select_biosample", (event) ->
    event.stopPropagation()
    $row = $(this).closest("form")
    route = "/biosamples/" + $(this).val() + "/select_biosample_libraries"
    $.get route, (responseText,status,jqXHR) ->
      $row.find(".batch_item_select_biosample_library").html("<option value></option>" + responseText)
      $row.find(".batch_item_select_biosample_library").attr("disabled", false)
    

  # User clicks "Add row" button in show view to add new batch_item.
  $(".add-batch-item-btn").on "ajax:success", (event,data) ->
    $rows = $(".batch-item-rows")
    $rows.append(data)


  # User clicks on the Create button in a batch_item row.
  $(document).on "ajax:success", ".batch-item-form", (event, data) ->
    $jqdata = $(data)
    $form = $(this)
    $form.html($jqdata.html())
    $form.addClass("created-row-color")
    setTimeout (-> $form.removeClass("created-row-color")), 1000

  # User clicks on button to create library from Batch's prototype library
  $(document).on "click", "#batch-item-create-library-btn", (event) ->
    batch_item_id = $(this).data("batch-item-id")
    $.post "/batch_items/" + batch_item_id + "/create_library_from_prototype", () -> 
      $.get "/batches/" + $("#record_id").text() + "/refresh_batch_item_row", {batch_item_id: batch_item_id}, (data) ->
        $("#batch-item-create-library-btn").closest("form").replaceWith(data)
      

  $(document).on "change", ".batch-item-form div > *", () ->
    $form =  $(this).closest("form")
    if !($form.has("#batch-item-persisted").length > 0)
      return
    $.post "/batches/" + $("#record_id").text() + "/create_or_update_batch_item", $form.serialize(), (data) ->
      $form.replaceWith(data)

  $(document).on "ajax:success", ".batch-remove-item", (event, data) ->
    $form = $(this).closest("form")
    $form.fadeOut()

  #Refresh the library_prototype list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".batch_library_prototype i.refresh", (event) ->
    $.get "/libraries/select_options", {prototype: true}, (responseText,status,jqXHR) ->
      $(".batch_library_prototype select").html(responseText)
