json.array!(@primers) do |primer|
  json.extract! primer, :id, :user_id, :name, :description, :notes, :direction, :sequence, :melting_temperature, :date_ordered
  json.url primer_url(primer, format: :json)
end
