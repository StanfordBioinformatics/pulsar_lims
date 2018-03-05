json.array!(@targets) do |target|
  json.extract! target, :id, :upstream, :name
  json.url target_url(target, format: :json)
end
