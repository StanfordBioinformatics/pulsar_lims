json.array!(@uberons) do |uberon|
  json.extract! uberon, :id, :name, :accession
  json.url uberon_url(uberon, format: :json)
end
