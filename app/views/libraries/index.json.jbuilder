json.array!(@libraries) do |library|
  json.extract! library, :id, :sequence_ontology_term_id, :biosample_id, :antibody_id, :vendor_id, :lot_identifier, :vendor_product_identifier, :size_range, :strand_specificity
  json.url library_url(library, format: :json)
end
