class TreatmentTermNameSerializer < ActiveModel::Serializer
  attributes :id, :name, :accession, :description
  has_one :user
end
