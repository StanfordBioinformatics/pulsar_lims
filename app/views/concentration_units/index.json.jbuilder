json.array!(@concentration_units) do |concentration_unit|
  json.extract! concentration_unit, :id, :name, :user_id
  json.url concentration_unit_url(concentration_unit, format: :json)
end
