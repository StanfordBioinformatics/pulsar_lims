class CloningVectorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :url
  has_one :user
end
