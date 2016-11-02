json.array!(@human_targets) do |human_target|
  json.extract! human_target, :id, :encode_identifier, :name
  json.url human_target_url(human_target, format: :json)
end
