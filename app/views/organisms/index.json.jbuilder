json.array!(@organisms) do |organism|
  json.extract! organism, :id, :name
  json.url organism_url(organism, format: :json)
end
