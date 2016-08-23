json.array!(@human_donors) do |human_donor|
  json.extract! human_donor, :id, :encode_id, :encode_alias, :string
  json.url human_donor_url(human_donor, format: :json)
end
