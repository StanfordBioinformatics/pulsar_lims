class DocumentTypeSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids

  attributes :id, :name, :user_id, :updated_at, :created_at
end
