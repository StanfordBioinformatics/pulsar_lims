class ConcentrationUnitSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :name, :created_at, :updated_at
end
