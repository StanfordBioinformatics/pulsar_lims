json.array!(@data_file_types) do |data_file_type|
  json.extract! data_file_type, :id, :user_id, :name, :description
  json.url data_file_type_url(data_file_type, format: :json)
end
