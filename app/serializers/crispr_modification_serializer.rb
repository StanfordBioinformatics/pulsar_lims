class CrisprModificationSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids

  attributes :id, :biosample_id, :category, :donor_construct_id, :name, :notes, :purpose, :created_at, :updated_at, :upstream_identifier

  has_one :user

  has_many :crispr_constructs
  has_many :documents
  has_many :pcr_validations
  has_many :crispr_constructs
end
