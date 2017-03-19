json.array!(@crispr_constructs) do |crispr_construct|
  json.extract! crispr_construct, :id, :name, :user_id, :target_id, :guide_sequence, :cloning_vector_id, :description, :vendor_id, :vendor_product_identifier
  json.url crispr_construct_url(crispr_construct, format: :json)
end
