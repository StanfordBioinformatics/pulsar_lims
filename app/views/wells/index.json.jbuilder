json.array!(@wells) do |well|
  json.extract! well, :id, :user_id, :name, :plate_id, :fail, :comment
  json.url well_url(well, format: :json)
end
