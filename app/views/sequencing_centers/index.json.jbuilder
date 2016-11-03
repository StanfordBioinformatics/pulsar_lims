json.array!(@sequencing_centers) do |sequencing_center|
  json.extract! sequencing_center, :id, :name, :address
  json.url sequencing_center_url(sequencing_center, format: :json)
end
