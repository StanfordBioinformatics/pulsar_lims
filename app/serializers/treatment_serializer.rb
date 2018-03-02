class TreatmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :treatment_type, :concentration, :duration, :duration_units, :temperature
  has_one :user
  has_one :treatment_term_name
  has_one :concentration_unit
end
