json.array!(@biosample_term_names) do |biosample_term_name|
  json.extract! biosample_term_name, :id, :user_id, :name, :accession, :biosample_ontology_id, :description
  json.url biosample_term_name_url(biosample_term_name, format: :json)
end
