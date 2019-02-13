# hi

$ ->

  $(document).on "change", ".chip_batch_item_select_biosample", (event) ->
    event.stopPropagation()
    $row = $(this).closest("form")
    route = "/biosamples/" + $(this).val() + "/select_biosample_libraries"
    $.get route, (responseText,status,jqXHR) ->
      $row.find(".chip_batch_item_select_biosample_library").html("<option value></option>" + responseText)
      $row.find(".chip_batch_item_select_biosample_library").attr("disabled", false)
    

  # User clicks "Add row" button in show view.
  $(".add-chip-batch-item-btn").on "ajax:success", (event,data) ->
    $rows = $(".chip-batch-item-rows")
    $rows.append(data)

  # User clicks the "Create" button in a BatchRow.
  $(document).on "click", ".chip-batch-create-row-btn", (event) ->
    event.preventDefault()
    event.stopPropagation()
    $form =  $(this).closest("form")
    $.post "/chip_batches/" + $("#record_id").text() + "/create_or_update_chip_batch_item", $form.serialize(), (data) ->
      $jqdata = $(data)
      $form.replaceWith($jqdata)
      $jqdata.fadeOut "slow", () -> 
        $(this).fadeIn("slow")

  $(document).on "change", ".chip-batch-item-form div > *", () ->
    $form =  $(this).closest("form")
    if !($form.has("#chip-batch-item-persisted").length > 0)
      return
    $.post "/chip_batches/" + $("#record_id").text() + "/create_or_update_chip_batch_item", $form.serialize(), (data) ->
      $form.replaceWith(data)

  $(document).on "ajax:success", ".chip-batch-remove-item", (event, data) ->
    $form = $(this).closest("form")
    $form.fadeOut()

  #Refresh the library_prototype list in the form when the refresh fa-icon is clicked:
  $(document).on "click", ".chip_batch_library_prototype i.refresh", (event) ->
    $.get "/libraries/select_options", {prototype: true}, (responseText,status,jqXHR) ->
      $(".chip_batch_library_prototype select").html(responseText)
