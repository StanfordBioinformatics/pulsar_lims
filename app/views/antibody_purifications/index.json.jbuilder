json.array!(@antibody_purifications) do |antibody_purification|
  json.extract! antibody_purification, :id, :name
  json.url antibody_purification_url(antibody_purification, format: :json)
end
