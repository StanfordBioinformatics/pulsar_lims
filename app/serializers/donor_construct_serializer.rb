class DonorConstructSerializer < ActiveModel::Serializer
  attributes :id, :name, :vender_product_identifier, :description, :insert_sequence
  has_one :user
  has_one :cloning_vector
  has_one :vender
  has_one :target
  has_one :promoter
end
