class BiosampleTermNameSerializer < ActiveModel::Serializer
  attributes :id, :name, :accession, :description
  has_one :user
  has_one :biosample_ontology
end
