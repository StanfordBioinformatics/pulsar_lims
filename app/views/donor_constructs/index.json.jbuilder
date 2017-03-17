json.array!(@donor_constructs) do |donor_construct|
  json.extract! donor_construct, :id, :name, :user_id, :cloning_vector_id, :vender_id, :vender_product_identifier, :target_id, :description, :insert_sequence, :promoter_id
  json.url donor_construct_url(donor_construct, format: :json)
end
