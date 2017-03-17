json.array!(@construct_tags) do |construct_tag|
  json.extract! construct_tag, :id, :user_id, :name, :description
  json.url construct_tag_url(construct_tag, format: :json)
end
