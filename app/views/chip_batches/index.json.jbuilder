json.array!(@chip_batches) do |chip_batch|
  json.extract! chip_batch, :id, :user_id, :crosslinking_method, :date
  json.url chip_batch_url(chip_batch, format: :json)
end
