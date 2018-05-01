class TreatmentTermNameSerializer < ActiveModel::Serializer
  attributes :id, :name, :accession, :description, :created_at, :updated_at
end
