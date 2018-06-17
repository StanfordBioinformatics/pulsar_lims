json.array!(@biosample_replicates) do |biosample_replicate|
  json.extract! biosample_replicate, :id, :user_id, :upstream_identifier, :biological_replicate_number, :technical_replicate_number, :notes
  json.url biosample_replicate_url(biosample_replicate, format: :json)
end
