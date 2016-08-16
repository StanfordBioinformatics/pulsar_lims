json.array!(@sequence_ontology_terms) do |sequence_ontology_term|
  json.extract! sequence_ontology_term, :id, :name, :accession, :definition
  json.url sequence_ontology_term_url(sequence_ontology_term, format: :json)
end
