json.array!(@donors) do |donor|
  json.extract! donor, :id, :encode_id, :encode_alias, :string
  json.url donor_url(donor, format: :json)
end
