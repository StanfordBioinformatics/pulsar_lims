# hi

$ ->

  $(document).on "change", ".batch_item_select_biosample", (event) ->
    event.stopPropagation()
    $row = $(this).closest("form")
    route = "/biosamples/" + $(this).val() + "/select_biosample_libraries"
    $.get route, (responseText,status,jqXHR) ->
      $row.find(".batch_item_select_biosample_library").html("<option value></option>" + responseText)
      $row.find(".batch_item_select_biosample_library").attr("disabled", false)
    

  # User clicks "Add row" button in show view.
  $(".add-batch-item-btn").on "ajax:success", (event,data) ->
    $rows = $(".batch-item-rows")
    $rows.append(data)

  # User clicks the "Create" button in a BatchRow.
  $(document).on "click", ".batch-create-row-btn", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $form =  $(this).closest("form")
    $.post "/batches/" + $("#record_id").text() + "/create_or_update_batch_item", $form.serialize(), (data) ->
      $jqdata = $(data)
      $form.replaceWith($jqdata)
      $jqdata.fadeOut "slow", () -> 
        $(this).fadeIn("slow")

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
