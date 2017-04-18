class PlateSerializer < ActiveModel::Serializer
  attributes :id, :name, :paired_end, :num_rows, :num_cols, :vendor_product_identifier
  has_one :user
  has_one :sequencing_library_prep_kit
  has_one :vendor
end
