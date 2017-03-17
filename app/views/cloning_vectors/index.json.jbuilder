json.array!(@cloning_vectors) do |cloning_vector|
  json.extract! cloning_vector, :id, :user_id, :name, :description, :url
  json.url cloning_vector_url(cloning_vector, format: :json)
end
