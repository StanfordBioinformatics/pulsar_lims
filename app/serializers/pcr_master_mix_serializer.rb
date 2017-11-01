class PcrMasterMixSerializer < ActiveModel::Serializer
  attributes :id, :name, :vendor_product_identifier, :vendor_product_url
  has_one :user
  has_one :vendor
end
