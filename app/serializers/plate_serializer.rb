class PlateSerializer < ActiveModel::Serializer
  attributes :id, :name,  :num_rows, :num_cols, :vendor_product_identifier
  has_one :user
  has_one :vendor
end
