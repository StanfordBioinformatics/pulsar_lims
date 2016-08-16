json.array!(@biosample_types) do |biosample_type|
  json.extract! biosample_type, :id, :name
  json.url biosample_type_url(biosample_type, format: :json)
end
