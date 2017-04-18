class WellSerializer < ActiveModel::Serializer
  attributes :id, :name, :row, :col, :fail, :comment
  has_one :user
  has_one :plate
  has_one :barcode
  has_one :paired_barcode
end
