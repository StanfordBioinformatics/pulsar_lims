class TreatmentTermNameSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :name, :accession, :description, :created_at, :updated_at
end
