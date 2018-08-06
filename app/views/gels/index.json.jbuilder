json.array!(@gels) do |gel|
  json.extract! gel, :id, :percentage, :voltage, :run_date, :notes, :user_id
  json.url gel_url(gel, format: :json)
end
