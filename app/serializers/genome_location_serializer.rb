class GenomeLocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :start, :end
  has_one :user
  has_one :chromosome
end
