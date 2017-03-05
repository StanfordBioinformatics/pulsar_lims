json.array!(@library_fragmentation_methods) do |library_fragmentation_method|
  json.extract! library_fragmentation_method, :id, :user_id, :name, :description
  json.url library_fragmentation_method_url(library_fragmentation_method, format: :json)
end
