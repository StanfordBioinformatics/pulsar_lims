json.array!(@paired_barcodes) do |paired_barcode|
  json.extract! paired_barcode, :id, :name, :user_id, :index1_id, :index2_id, :sequencing_library_prep_kit_id
  json.url paired_barcode_url(paired_barcode, format: :json)
end
