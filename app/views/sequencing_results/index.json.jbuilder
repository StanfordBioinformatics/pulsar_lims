json.array!(@sequencing_results) do |sequencing_result|
  json.extract! sequencing_result, :id, :sequencing_run_id, :library_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count
  json.url sequencing_result_url(sequencing_result, format: :json)
end
