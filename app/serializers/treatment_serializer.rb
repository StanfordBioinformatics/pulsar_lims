class TreatmentSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :concentration, :description, :duration, :duration_units, :name, :temperature_celsius, :treatment_type, :upstream_identifier, :created_at, :updated_at

  has_one :concentration_unit
  has_one :treatment_term_name
  has_many :biosamples
  has_many :documents
  
end
