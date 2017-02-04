json.array!(@library_sequencing_results) do |library_sequencing_result|
  json.extract! library_sequencing_result, :id, :name, :sequencing_result_id, :library_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count
  json.url library_sequencing_result_url(library_sequencing_result, format: :json)
end
