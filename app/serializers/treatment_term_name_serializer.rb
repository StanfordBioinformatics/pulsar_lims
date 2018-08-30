class TreatmentTermNameSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, :name, :accession, :description, :created_at, :updated_at
end
