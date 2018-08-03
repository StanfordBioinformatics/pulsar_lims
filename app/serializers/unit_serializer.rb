class UnitSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids

  attributes :id, :name, :created_at, :updated_at

  has_one :user
end
