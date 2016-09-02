json.array!(@sequencing_platforms) do |sequencing_platform|
  json.extract! sequencing_platform, :id, :name
  json.url sequencing_platform_url(sequencing_platform, format: :json)
end
