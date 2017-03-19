class CrisprSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_one :crispr_construct
  has_one :donor_construct
  has_one :biosample
end
