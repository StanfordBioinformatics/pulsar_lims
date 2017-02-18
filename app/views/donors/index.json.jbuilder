json.array!(@donors) do |donor|
  json.extract! donor, :id, :encode_identifier, :name
  json.url donor_url(donor, format: :json)
end
