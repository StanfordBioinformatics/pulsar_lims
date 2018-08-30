class DocumentTypeSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, :name, :user_id, :updated_at, :created_at

  has_one :user
end
