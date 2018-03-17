json.array!(@biosamples) do |biosample|
  json.extract! biosample, :id, :submitter_comments, :lot_identifier, :source_product_identifier, :biosample_term_name, :description, :passage_number, :date_biosample_taken, :upstream_identifier
  json.url biosample_url(biosample, format: :json)
end
