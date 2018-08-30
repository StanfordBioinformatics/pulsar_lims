class DocumentSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, :content_type, :description, :document_type_id, :is_protocol, :name, :notes, :upstream_identifier, :created_at, :updated_at

  has_one :user
  has_one :document_type
end
