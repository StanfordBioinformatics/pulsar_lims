class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :description, :document_type_id, :is_protocol, :upstream_identifier
end
