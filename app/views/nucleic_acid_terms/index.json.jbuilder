json.array!(@nucleic_acid_terms) do |nucleic_acid_term|
  json.extract! nucleic_acid_term, :id, :name, :accession, :definition
  json.url nucleic_acid_term_url(nucleic_acid_term, format: :json)
end
