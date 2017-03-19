class CrisprConstructSerializer < ActiveModel::Serializer
  attributes :id, :name, :guide_sequence, :description, :vendor_product_identifier
  has_one :user
  has_one :target
  has_one :cloning_vector
  has_one :vendor
end
