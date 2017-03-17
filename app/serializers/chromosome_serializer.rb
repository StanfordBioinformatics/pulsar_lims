class ChromosomeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_one :reference_genome
end
