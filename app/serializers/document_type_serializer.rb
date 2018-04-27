class DocumentTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :user_id, :updated_at, :created_at, :updated_at
end
