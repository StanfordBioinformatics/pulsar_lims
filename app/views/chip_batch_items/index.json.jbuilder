json.array!(@chip_batch_items) do |chip_batch_item|
  json.extract! chip_batch_item, :id, :user_id, :chip_batch_id, :biosample_id, :concentration, :notes
  json.url chip_batch_item_url(chip_batch_item, format: :json)
end
