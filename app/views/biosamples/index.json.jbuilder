json.array!(@biosamples) do |biosample|
  json.extract! biosample, :id, :submitter_comments, :lot_identifier, :source_product_identifier, :biosample_term_name, :description, :passage_number, :culture_harvest_date, :encid
  json.url biosample_url(biosample, format: :json)
end
