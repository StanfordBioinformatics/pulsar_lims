json.array!(@units) do |unit|
  json.extract! unit, :id, :name, :user_id
  json.url unit_url(unit, format: :json)
end
