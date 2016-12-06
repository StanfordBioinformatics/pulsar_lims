json.array!(@antibodies) do |antibody|
  json.extract! antibody, :id, :organism_id, :vendor_id, :isotype_id, :target_id, :vendor_product_identifier, :vendor_product_url, :lot_identifier, :clonality, :antigen_description, :antigen_sequence
  json.url antibody_url(antibody, format: :json)
end
