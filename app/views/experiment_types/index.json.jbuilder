json.array!(@experiment_types) do |experiment_type|
  json.extract! experiment_type, :id, :name
  json.url experiment_type_url(experiment_type, format: :json)
end
