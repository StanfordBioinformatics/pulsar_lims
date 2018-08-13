json.array!(@sequencing_requests) do |sequencing_request|
  json.extract! sequencing_request, :id, :name, :comment, :sequencing_platform_id, :sequencing_center_id
  json.url sequencing_request_url(sequencing_request, format: :json)
end
