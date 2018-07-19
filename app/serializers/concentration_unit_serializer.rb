class ConcentrationUnitSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids

  attributes :id, :name, :created_at, :updated_at
end
