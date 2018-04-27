class CrisprModificationSerializer < ActiveModel::Serializer
  attributes :id :category, :donor_construct_id, :name, :purpose, :upstream_identifier, :created_at, :updated_at
end
