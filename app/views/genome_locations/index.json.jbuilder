json.array!(@genome_locations) do |genome_location|
  json.extract! genome_location, :id, :user_id, :chromosome_id, :start, :end
  json.url genome_location_url(genome_location, format: :json)
end
