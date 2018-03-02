json.array!(@treatments) do |treatment|
  json.extract! treatment, :id, :user_id, :treatment_term_name_id, :name, :description, :treatment_type, :concentration, :concentration_unit_id, :duration, :duration_units, :temperature
  json.url treatment_url(treatment, format: :json)
end
