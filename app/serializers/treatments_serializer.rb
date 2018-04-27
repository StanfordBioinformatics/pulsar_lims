class TreatmentsSerializer < ActiveModel::Serializer
  attributes :id :concentration, :concentration_unit_id, :description, :duration, :duration_units, :name, :temperature, :treatment_term_name_id, :treatment_type, :upstream_identifier, :created_at, :updated_at
end
