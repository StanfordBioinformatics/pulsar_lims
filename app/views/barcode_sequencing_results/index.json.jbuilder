json.array!(@barcode_sequencing_results) do |barcode_sequencing_result|
  json.extract! barcode_sequencing_result, :id, :name, :sequencing_result_id, :library_id, :comment, :read1_uri, :read2_uri, :read1_count, :read2_count
  json.url barcode_sequencing_result_url(barcode_sequencing_result, format: :json)
end
