json.array!(@file_references) do |file_reference|
  json.extract! file_reference, :id, :user_id, :data_storage_id, :file_path, :fileid
  json.url file_reference_url(file_reference, format: :json)
end
