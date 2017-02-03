json.array!(@sequencing_results) do |sequencing_result|
  json.extract! sequencing_result, :id, :user_id, :sequencing_request_id, :run_name, :lane, :comment
  json.url sequencing_result_url(sequencing_result, format: :json)
end
