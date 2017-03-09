json.array!(@barcodes) do |barcode|
  json.extract! barcode, :id, :user_id, :sequencing_library_prep_kit_id, :name, :sequence
  json.url barcode_url(barcode, format: :json)
end
