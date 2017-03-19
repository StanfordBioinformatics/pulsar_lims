json.array!(@crisprs) do |crispr|
  json.extract! crispr, :id, :name, :user_id, :crispr_construct_id, :donor_construct_id, :biosample_id
  json.url crispr_url(crispr, format: :json)
end
