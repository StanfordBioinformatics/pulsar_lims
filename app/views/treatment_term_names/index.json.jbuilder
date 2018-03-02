json.array!(@treatment_term_names) do |treatment_term_name|
  json.extract! treatment_term_name, :id, :user_id, :name, :accession, :description
  json.url treatment_term_name_url(treatment_term_name, format: :json)
end
