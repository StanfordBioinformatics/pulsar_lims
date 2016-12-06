json.array!(@targets) do |target|
  json.extract! target, :id, :encode_identifier, :name
  json.url target_url(target, format: :json)
end
