json.array!(@donors) do |donor|
  json.extract! donor, :id, :upstream, :name
  json.url donor_url(donor, format: :json)
end
