json.array!(@analyses) do |analysis|
  json.extract! analysis, :id, :user_id, :description
  json.url analysis_url(analysis, format: :json)
end
