class TreatmentSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, :concentration, :description, :duration, :duration_units, :name, :notes, :temperature_celsius, :treatment_type, :upstream_identifier, :created_at, :updated_at

  has_one :concentration_unit
  has_one :treatment_term_name
  has_many :documents
  #has_any :biosamples #Don't do this since the biosample serializer already specifies the relationship. 
  # Otherwise, this will beget recursive loop that will eventually kill the server. 
  
end
