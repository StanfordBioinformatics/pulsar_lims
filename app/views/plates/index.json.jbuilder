json.array!(@plates) do |plate|
  json.extract! plate, :id, :user_id, :name, :sequencing_library_prep_kit_id, :paired_end, :num_rows, :num_cols, :vendor_id, :vendor_product_identifier
  json.url plate_url(plate, format: :json)
end
