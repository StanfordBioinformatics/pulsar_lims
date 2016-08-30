json.array!(@isotypes) do |isotype|
  json.extract! isotype, :id, :name
  json.url isotype_url(isotype, format: :json)
end
