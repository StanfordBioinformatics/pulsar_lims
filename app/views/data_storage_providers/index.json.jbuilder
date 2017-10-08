json.array!(@data_storage_providers) do |data_storage_provider|
  json.extract! data_storage_provider, :id, :user_id, :name
  json.url data_storage_provider_url(data_storage_provider, format: :json)
end
