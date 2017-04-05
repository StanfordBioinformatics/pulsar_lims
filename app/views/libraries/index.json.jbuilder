json.array!(@libraries) do |library|
  json.extract! library, :id, :nucleic_acid_term_id, :biosample_id, :vendor_id, :lot_identifier, :vendor_product_identifier, :size_range, :strand_specific
  json.url library_url(library, format: :json)
end
