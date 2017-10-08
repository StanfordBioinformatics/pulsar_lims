json.array!(@data_storages) do |data_storage|
  json.extract! data_storage, :id, :user_id, :name, :bucket, :project_identifier, :folder_base_path
  json.url data_storage_url(data_storage, format: :json)
end
